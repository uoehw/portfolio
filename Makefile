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
	@$(foreach cat,$(CATEGORIES), \
	    mkdir -p $(cat); \
		$(MAKE) -s create DIR="$(cat)" NAMES="$($(shell echo $(cat) | tr a-z A-Z))";)

create:
	@cd $(DIR) && \
	$(foreach name,$(NAMES), \
		npm create vue@latest $(name) '--' --default && \
    	echo -e "<script setup></script>\n\n<template></template>\n\n<style scoped></style>" > $(name)/src/App.vue && \
     	rm -r $(name)/src/assets/logo.svg $(name)/src/components/*;)
