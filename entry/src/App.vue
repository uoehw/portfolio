<script setup>
import PersonalInfo from "./components/PersonalInfo.vue";
import PinterestLayout from "./components/PinterestLayout.vue";

const randomHeight = (max, min) => {
  const g = parseInt(max * Math.random());
  return (min ?? 100) + g + "px";
};

const templates = Array(14)
  .fill({})
  .map((v, i) => {
    return {
      id: i + 1,
      text: i + 1 + "",
      height: randomHeight(120, 190),
    };
  });
</script>

<template>
  <header>
    <div class="wrapper">
      <PersonalInfo />
    </div>
  </header>

  <main>
    <PinterestLayout :data="templates" :gap="32" :column="2" :round="8">
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
