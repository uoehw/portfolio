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
