default:
    just --choose

configure:
    cmake -S. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
    cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Debug -DCOMPILE_QML=ON

build:
    cmake --build build
    # wrapQtApp ./build/nheko
