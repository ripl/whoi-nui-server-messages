ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PART=patch
PROJECT_NAME=whoi-nlu-server-messages

all:

new-dist:
	$(MAKE) clean bump-upload

bump-upload:
	$(MAKE) test bump upload

bump:
	bumpversion ${PART}

upload:
	git push --tags
	git push
	$(MAKE) clean
	$(MAKE) build
	twine upload dist/*

build:
	python3 setup.py sdist

install:
	python3 setup.py install --record files.txt

clean:
	rm -rf dist/ build/ ${PROJECT_NAME}.egg-info/ MANIFEST

uninstall:
	xargs rm -rf < files.txt

format:
	yapf -r -i -p -vv ${ROOT_DIR}
