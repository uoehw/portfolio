export const filters = ["All", "Categories"];

export function performFilter(data, filter) {
  switch (filter) {
    case "Categories":
      return data.categories;
    default: // all by default
      return data.templates;
  }
}
