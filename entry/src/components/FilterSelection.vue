<script setup>
import { computed, useTemplateRef, ref, onMounted } from "vue";

const props = defineProps({
  sorts: Array,
});

// two-way binding
const selected = defineModel({ required: true });

// active li element
const activeLi = ref(null);

// reference to all li element
const liRefs = useTemplateRef("items");

// when li is selected
const filterSelect = (item, index) => {
  selected.value = item;
  activeLi.value = liRefs.value[index];
};

const ulStyle = computed(() => {
  if (activeLi.value) {
    return {
      "--active-bg-width": `${activeLi.value.offsetWidth}px`,
      "--active-bg-left": `${activeLi.value.offsetLeft}px`,
    };
  } else {
    return {
      "--active-bg-width": "0px",
      "--active-bg-left": "0px",
    };
  }
});

// onMounted set the value which trigger `ulStyle` to re-evaluated
onMounted(() => {
  const index = liRefs.value.findIndex((ele) =>
    ele.classList.contains("active"),
  );
  selected.value = props.sorts[index];
  activeLi.value = liRefs.value[index];
});
</script>

<template>
  <ul :style="ulStyle">
    <li
      v-for="(item, index) in props.sorts"
      :key="item"
      :class="{ active: selected === item }"
      ref="items"
      @click="filterSelect(item, index)"
    >
      {{ item }}
    </li>
  </ul>
</template>

<style scoped>
ul {
  position: relative;
  display: flex;
  margin-top: 46px;
  padding-inline-start: 0px;
  background-color: dimgrey;
  border-radius: 22px;
  overlay: hidden;
  --active-bg-width: 0px;
  --active-bg-left: 0px;
}

ul li {
  font-weight: 700;
  display: inline;
  padding: 12px 28px 12px 28px;
  cursor: pointer;
  color: white;
  z-index: 2;
}

ul::before {
  border-radius: 22px;
  content: "";
  position: absolute;
  top: 0;
  left: var(--active-bg-left);
  width: var(--active-bg-width);
  height: 100%;
  background-color: teal;
  transition: left 0.2s ease-in-out;
  z-index: 1;
}
</style>
