cbuilddir=${HOME}/.cache/cmake.build
build_dir:=$(shell mkdir -p $(cbuilddir); \
					 if [ ! -e build ]; then \
					 ln -sf `mktemp -d -p $(cbuilddir)` build; \
					 fi; \
					 echo ./build)
curdir:=$(shell pwd)

debug:
	test -e $(build_dir)
	cmake -B $(shell realpath $(build_dir)) -DMODULE_DEBUG=1 -DCMAKE_BUILD_TYPE=RELEASE
	cmake --build $(build_dir) -v
	$(build_dir)/helloworld

clean:
	rm -Rf ./build/*

deepclean:
	rm -Rf $(shell realpath $(build_dir))
	rm -Rf $(build_dir)

