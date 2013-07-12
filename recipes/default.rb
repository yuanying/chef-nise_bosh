

directory ::File.dirname(node.nise_bosh.dir) do
  recursive true
end

git node.nise_bosh.dir do
  repository node.nise_bosh.repository
  revision node.nise_bosh.revision
  action :sync
end

ruby_path = File.join(node[:nise_bosh][:ruby][:prefix_path])
gem_path  = File.join(ruby_path, 'bin', 'gem')
gem_package "bosh_cli" do
  gem_binary gem_path
  source "https://s3.amazonaws.com/bosh-jenkins-gems/"
  # source "https://s3.amazonaws.com/bosh-jenkins-gems/gems/bosh_cli-1.5.0.pre.694.gem"
  version "~> 1.5.0.pre"
  # options "--pre"
end



