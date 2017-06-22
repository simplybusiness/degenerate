with import <nixpkgs> {};
let sourceFilesOnly = path: type:
    !((baseNameOf path == "vendor") ||
      (baseNameOf path == "log")); in
stdenv.mkDerivation {
  name = "a-ruby-env";
  version = "0.0.1";
  src = builtins.filterSource sourceFilesOnly ./.;
  buildInputs = [ ruby_2_3_3 sqlite.dev gcc nodejs openssl
                  libxslt.dev libxml2.dev coreutils bundix
		 ] ;
  GEM_HOME = "vendor/gems";
  shellHook = ''
    PATH=vendor/gems/bin:$PATH
  '';
}
