libs := lodash frp

all: build/code.js build/libs.js build/index.html build/style.css

watch:
	make
	fswatch-run src "make changed"

changed:
	make
	./reload

node_modules: package.json
	npm install

build:
	mkdir -p build

build/index.html: index.html | build
	ln -s ../index.html build

build/style.css: style.css | build
	ln -s ../style.css build

build/code.js: src/* | build
	browserify -o $@ $(addprefix -x , $(libs)) src/main.js

build/libs.js: node_modules | build
	browserify -o $@ $(addprefix -r , $(libs))
