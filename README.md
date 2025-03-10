# Portfolio

Create a portfolio website using Github static hosting.

1. Create a repository name `portfolio` in your personal Github account or use any name.

2. Clone the repository and change into newly created directory `portfolio` or your chosen name

3. Follow [Github Document](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site)
   to create a Githup Page. Make sure to create repository with README file otherwise the following step will failed.
   In case you forget to include read me, github provide a simple way to create README which appear on your empty
   repository. For this toturial we're using an organization name `uoehw`.

4. Add `uoehw.github.io` as git submodule to the repository with the following command
   `git submodule add https://github.com/uoehw/uoehw.github.io.git`. Make sure to change the
   url according your own repository.

![overview](assets/diagram.jpeg "Overview Process")

## Create an Entry Page

1. Create a directory name `entry` and change working directory into newly created directory `entry`

2. Generate a Vue3 project `npm create vue@latest .` then run `npm install`

3. Clean up your project. Mostly remove a default created component etc...

## Create Template Directory

The Ideal project structure would be:

```
- Root(portfolio)
|__ entry
|__ blogs
   |__ blog1
   |__ blog2
|__ ecommerces
   |__ alibaba
   |__ amazon
   |__ lazada
   |__ shopee
|__ socialmedias
```

The `blogs`, `ecommerces` or `socialmedias` is representing type of web development templates. The subfolder
of each of them should be the template of individual Vue3 projects.

We start with a simple blogs. Make sure your working directory is in `portfolio` folder.

1. Create a blogs templates `mkdir -p blogs/blog1`

2. Create a Vue3 project for `blog1` temaplate `npm create vue@latest blogs/blog1`

3. Install dependency `(cd blogs/blog1/ && npm install)`

4. Make some change to `blogs/blog1/src/App.vue` file to ensure the different between `entry` and `blogs/blog1`

5. Update `vite.config.js` to include new configuration with following code

   ```javascript
   export default defineConfig({
     plugins: [vue(), vueDevTools()],
     resolve: {
       alias: {
         "@": fileURLToPath(new URL("./src", import.meta.url)),
       },
     },
     // New configuration
     base:
       process.env.NODE_ENV === "production"
         ? "" // or '.' for production
         : "/",
   });
   ````

6. Build the `blog1` template `(cd blogs/blog1/ && npm run build)`

7. Create template directory in `entry` with following command `mkdir -p entry/public/blogs/blog1`

8. Copy `blog1` build to `entry/public/blogs/blog1` with following command `cp -r blogs/blog1/dist/* entry/public/blogs/blog1/`

## Build and Release Welcome Page

1. Build entry with the following command `(cd entry/ && npm run build)`

2. Copy dist file to `uoehw.github.io` with the following command `cp -r entry/dist/* uoehw.github.io/`
