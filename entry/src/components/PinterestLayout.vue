<script setup>
import { onMounted, onUnmounted, ref } from "vue";

const props = defineProps({
  data: Array,
  // number of columns in the layout, if not set or set to 0 the column number
  // will be determine automatically
  column: Number,
  // the observation timeout for executing resize change, by default 300ms
  changeTimeout: Number,
  // the gap between child, by default 10px
  gap: Number,
  // round corner, by default no round corner is applied
  round: Number,
});

const container = ref(null);
let columnWith = ref(0);
let resizeObserver = null;

const autoColumnCalc = (width) => {
  return Math.ceil(width / 280);
};

const onResize = (entries) => {
  let columnCount = props.column;
  const gap = props.gap ?? 10;
  for (let entry of entries) {
    if (entry.contentBoxSize) {
      if (
        props.column === 0 ||
        props.column === undefined ||
        props.column === null
      ) {
        columnCount = autoColumnCalc(entry.contentRect.width);
      }
      const gapSize = (columnCount + 1) * gap;
      columnWith.value = (entry.contentRect.width - gapSize) / columnCount;
    }
  }

  if (columnWith.value) {
    let columnRange = 0;
    let topDistance = Array(columnCount).fill(0);
    for (const child of container.value.children) {
      const range = columnRange % columnCount;
      const left = gap * (range + 1) + range * columnWith.value;
      const top = gap + topDistance[range];

      child.style.left = left + "px";
      child.style.top = top + "px";

      topDistance[range] += gap + child.offsetHeight;

      columnRange++;
    }
  }
};

// throttling reduce the number of frequence calculate if the drag resize
// happen that cause jank on animation
const throttling = ((fn) => {
  let timeoutId;
  return function (...args) {
    clearTimeout(timeoutId);

    timeoutId = setTimeout(() => {
      fn?.apply(this, args);
    }, props.changeTimeout ?? 300);
  };
})(onResize);

onMounted(() => {
  resizeObserver = new ResizeObserver(throttling);
  if (container.value) {
    resizeObserver.observe(container.value);
  }
});

onUnmounted(() => {
  resizeObserver?.disconnect(); // Important: Clean up the observer
});
</script>

<template>
  <div class="layout">
    <div ref="container" class="scroll-container">
      <div
        class="layout-item"
        :style="{
          width: columnWith + 'px',
          borderRadius: (props.round ?? 0) + 'px',
        }"
        v-for="(item, index) in props.data"
        v-bind:key="item.id"
      >
        <slot :item="item" :index="index"></slot>
      </div>
    </div>
  </div>
</template>

<style scoped>
div.layout {
  position: relative;
  height: 98vh;
  overflow: hidden;
}

div.scroll-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow-y: scroll;
  scrollbar-width: thin;
  scrollbar-color: transparent transparent;
}

div.layout-item {
  position: absolute;
  overflow: hidden;
}
</style>
