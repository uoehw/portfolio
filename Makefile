CATEGORIES = ecommerces \
			entertainments \
			newsandmedias \
			socialmedias \
			educationals \
			blogs \
			forums

ECOMMERCES = camstore pixmart lystore bugmart emart

ENTERTAINMENTS = camflix paravid

NEWSANDMEDIAS = camnews flunews

SOCIALMEDIAS = cambook camtube

EDUCATIONALS = camlession angkorclass

BLOGS = tilo makrath

FORUMS = redflag loklak

creates:
	$(foreach cat,$(CATEGORIES), \
	    mkdir -p $(cat); \
		$(MAKE) -s create DIR="$(cat)" NAMES="$($(shell echo $(cat) | tr a-z A-Z))";)

create:
	@cd $(DIR) && \
	$(foreach name,$(NAMES), \
		npm create vue@latest $(name) '--' --default && \
		echo -e "<script setup></script>\n\n<template></template>\n\n<style scoped></style>" > $(name)/src/App.vue && \
     	rm -r $(name)/src/assets/logo.svg $(name)/src/components/* && \
        cd $(name) && npm install && cd ..;)

releases: release-template release-entry

release-entry:
	@cd entry && \
		npm run build && \
		rm -rf ../uoehw-portfolio.github.io/assets && \
		rm -f ../uoehw-portfolio.github.io/index.html && \
		mv -f dist/* ../uoehw-portfolio.github.io

release-template:
	@mkdir -p uoehw-portfolio.github.io/categories
	$(foreach cat,$(CATEGORIES), \
		mkdir -p entry/public/assets/preview/$(cat) && \
	    mkdir -p uoehw-portfolio.github.io/categories/$(cat) && \
	    $(MAKE) -s release DIR="$(cat)" NAMES="$($(shell echo $(cat) | tr a-z A-Z))";)

release:
	@cd $(DIR) && \
	$(foreach name,$(NAMES), \
		cd $(name) && \
	    npm run build && \
		mkdir -p ../../entry/public/assets/preview/$(DIR)/$(name) && \
		mkdir -p ../../uoehw-portfolio.github.io/categories/$(DIR)/$(name) && \
		rm -rf ../../uoehw-portfolio.github.io/categories/$(DIR)/$(name)/* && \
    	mv -f dist/* ../../uoehw-portfolio.github.io/categories/$(DIR)/$(name) && \
        cd ..;)

serve:
	@node serve.js
