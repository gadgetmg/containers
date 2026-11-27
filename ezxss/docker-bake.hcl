target "default" {
  name = "ezxss-${replace(version, ".", "-")}"
  matrix = {
    version = [ "master", "4.0", "4.1", "4.2", "4.3" ]
  }
  args = {
    VERSION = version
  }
  tags = [
    "ghcr.io/gadgetmg/ezxss:${version}",
    equal("4.3", version) ? "ghcr.io/gadgetmg/ezxss:latest": ""
  ]
}
