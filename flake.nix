
{
  description = "Worldcup trivia website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # config.allowUnfree = true;
        };

        python = pkgs.python311; # change if needed
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "worldcup-country-trivia";
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = [ pkgs.mdbook ];
          buildPhase = "mdbook build";
          installPhase = "cp -r book $out";
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [
            python
            pkgs.uv
            pkgs.git
            pkgs.curl
            pkgs.zsh
            pkgs.mdbook
          ];

          shellHook = ''
            echo "Python dev environment with uv"
            echo "Python: $(python --version)"
            echo "uv: $(uv --version)"

            # Optional: auto-create venv if not present
            if [ ! -d ".venv" ]; then
              echo "Creating virtual environment with uv..."
              uv venv
            fi

            source .venv/bin/activate
            exec zsh
          '';
        };
      });
}

