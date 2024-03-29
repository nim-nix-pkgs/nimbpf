{
  description = ''libbpf for nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimbpf-master".dir   = "master";
  inputs."nimbpf-master".owner = "nim-nix-pkgs";
  inputs."nimbpf-master".ref   = "master";
  inputs."nimbpf-master".repo  = "nimbpf";
  inputs."nimbpf-master".type  = "github";
  inputs."nimbpf-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimbpf-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}