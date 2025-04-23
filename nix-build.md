nix develop --impure git+file:///home/scvalex/repo/infra/nix-channel/nixpkgs#nheko
cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Debug -DCOMPILE_QML=ON
cmake --build build
wrapQtApp ./build/nheko
