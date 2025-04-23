{
  inputs = {
    nixpkgs.url = "git+file:///home/scvalex/repo/infra/nix-channel/nixpkgs";
  };

  outputs =
    { self, nixpkgs }:
    let
      overlays = [ ];
      pkgs = import nixpkgs {
        inherit overlays;
        system = "x86_64-linux";
        config = {
          permittedInsecurePackages = [
            "olm-3.2.16"
          ];
        };
      };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          asciidoc
          cmake
          lmdbxx
          pkg-config
          boost
          cmark
          coeurl
          curl
          kdsingleapplication
          libevent
          libsecret
          lmdb
          mtxclient
          nlohmann_json
          olm
          qt6Packages.qtbase
          qt6Packages.qtimageformats
          qt6Packages.qtkeychain
          qt6Packages.qtmultimedia
          qt6Packages.qttools
          qt6Packages.qtwayland
          re2
          spdlog

          # this is for the shellhook portion
          qt6.wrapQtAppsHook
          makeWrapper
          bashInteractive
        ];

        cmakeFlags = [
          "-DCOMPILE_QML=ON" # see https://github.com/Nheko-Reborn/nheko/issues/389
        ];
        NIXPKGS_ALLOW_INSECURE = "1";

        # set the environment variables that Qt apps expect
        shellHook = ''
          bashdir=$(mktemp -d)
          makeWrapper "$(type -p fish)" "$bashdir/fish" "''${qtWrapperArgs[@]}"
          exec "$bashdir/fish"
        '';
      };
    };
}
