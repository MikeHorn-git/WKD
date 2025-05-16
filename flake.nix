{
  description = "Windows Kernel development";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      devShells.x86_64-linux.lint = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.clang
          pkgs.mdl
          pkgs.nixfmt-classic
          pkgs.powershell
          pkgs.rubocop
          pkgs.statix
        ];

        shellHook = ''
          clang-format -i fuzzer/fuzzer.c
          mdl README.md
          nixfmt flake.nix
          statix check flake.nix
          pwsh -NoProfile -Command "Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser -AllowClobber"
          pwsh -NoProfile -Command "Invoke-ScriptAnalyzer ."
          rubocop -A Vagrantfile
        '';
      };
    };
}
