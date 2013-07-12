

directory ::File.dirname(node.nise_bosh.dir) do
  recursive true
end

git node.nise_bosh.dir do
  repository node.nise_bosh.repository
  revision node.nise_bosh.revision
  action :sync
end

ruby_path = File.join(node[:nise_bosh][:ruby][:prefix_path])
gem_path  = File.join(ruby_path. 'bin', 'gem')
# FIX FOR CF_RELEASE
  bosh_gems_source = "https://s3.amazonaws.com/bosh-jenkins-gems/"
  bash "Added gems source: #{bosh_gems_source}" do
    code <<-EOH
    #{gem_path} source -a #{bosh_gems_source}
    EOH
    not_if { `#{gem_path} source`include?(bosh_gems_source) }
  end
# 

gem_package "bosh_cli" do
  gem_binary gem_path
  version "~> 1.5.0"
end



