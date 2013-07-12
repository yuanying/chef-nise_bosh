include_recipe "nise_bosh"

git node.nise_bosh.release.dir do
  repository node.nise_bosh.release.repository
  revision node.nise_bosh.release.revision
  enable_submodules true
  action :sync
end
