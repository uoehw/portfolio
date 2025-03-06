# Using Github As Static Web Hosting Portfolio

The structure of Vue project:

```
- Root
|___ entry
|___ ecommerces
|___ entertainments
|___ newsandmedias
|___ socialmedias
|___ educationals
|___ blogs
|___ forums
```

Each of sub folder contains multiple templates of its kind except `Entry` which is use as `Main`
entry point to all templates.

To create profile run the command `make creates`. Notes that the command only tested on linux operating
system. You may create this project manually on other operating system.

Also `entry` is not include, the `entry` directory is a Vue entry point or home page that provide link
to other Vue project that we create via the command `make creates`.

## Create a static page repository on Github

More information follow [github](https://pages.github.com/) instruction pages.

1. From top right corner click on a `plus` drop down button
2. Click `New repository`
3. Change owner if neededd
4. Enter `uoehw-portfolio.github.io` in the repository name. Note: you change `uoehw-portfolio` according to
   your need such as personal name or business name or project name.
5. Make sure the repository is `Public` and not `Private`
7. Make sure to add a README file
6. Click `create`

Finally we can clone the newly created repository as gitsubmodule of current git repository.

```shell
git submodule add https://github.com/uoehw/uoehw-portfolio.github.io.git
```

## Generate JSON Data From Sample Vue3 App

We've multiple Vue3 apps/projects for each categories. The idea is from the entry we should has a list where each
list item contain a link that direct or navigate the user to each Vue3 projects. It's cumbersome, to manually add
the new sample project or app to the entry therefore we create a script that produce a json data to each Apps. The
json data should consist of:

1. Relative URL to the sample page
2. Has a URL to the page's preview
3. Has the name and category name

```json
[
  {
    name: "shopify",
    category: "ecommerce",
    thumbnail: "/assets/preview/ecommerce/shopify.jpeg",
    page: "/ecommerce/shopify"
  }
]
```

Install puppeteer

```shell
npm install puppeteer
```
