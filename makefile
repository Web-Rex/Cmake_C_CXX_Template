init:
	rd /s /q build
	mkdir build

init-debug:
	cmake -S . -B ./build -G Ninja -DCMAKE_BUILD_TYPE=Debug
	cmake --build ./build

init-run:
	./build/src/template.exe
