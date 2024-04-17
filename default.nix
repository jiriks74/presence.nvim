let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  packages = with pkgs; [
    # Choose the build tools that you need
    act
    luacheck
    stylua
  ];
}
