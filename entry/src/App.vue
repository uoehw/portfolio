<script setup>
import { onMounted, ref, watch } from "vue";
import PersonalInfo from "./components/PersonalInfo.vue";
import PinterestLayout from "./components/PinterestLayout.vue";
import FilterSelection from "./components/FilterSelection.vue";
import { performFilter, filters } from "./filter";

const selected = ref("All");
const data = ref({});

const fetchData = async () => {
  try {
    const response = await fetch("/data.json");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const jsonData = await response.json();
    data.value.orginal = jsonData;
    data.value.filtered = performFilter(jsonData, selected.value);
  } catch {
    // Clear data on error
    data.value.orginal = {};
    data.value.filtered = [];
  }
};

onMounted(() => {
  fetchData();
  watch(selected, () => {
    data.value.filtered = performFilter(data.value.orginal, selected.value);
  });
});
</script>

<template>
  <header>
    <div class="wrapper">
      <PersonalInfo />
      <FilterSelection :sorts="filters" v-model="selected" />
    </div>
  </header>

  <main>
    <PinterestLayout :data="data.filtered" :gap="32" :column="2" :round="8">
      <template v-slot="slotProp">
        <div
          style="background: coral"
          :style="{ height: slotProp.item.height }"
        >
          {{ slotProp.item.text }} {{ slotProp.index }}
        </div>
      </template>
    </PinterestLayout>
  </main>
</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}
</style>
