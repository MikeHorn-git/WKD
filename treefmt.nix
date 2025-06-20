{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs.clang-format.enable = true;
  programs.mdformat.enable = true;
  programs.nixfmt.enable = true;
  programs.rubocop.enable = true;
}
