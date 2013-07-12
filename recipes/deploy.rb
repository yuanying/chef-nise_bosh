include_recipe "nise_bosh"

ruby_path   = File.join(node[:nise_bosh][:ruby][:prefix_path])
bundle_path = File.join(ruby_path, 'bin', 'bundle')
bosh_path   = File.join(ruby_path, 'bin', 'bosh')

git node.nise_bosh.release.dir do
  repository node.nise_bosh.release.repository
  revision node.nise_bosh.release.revision
  enable_submodules true
  action :sync
end

bash "Bundle install for Nise-BOSH" do
  cwd node.nise_bosh.dir
  code <<-EOH
  #{bundle_path} install
  EOH
end

bash "Init Nise-BOSH environment" do
  code <<-EOH
  # stemcell_builder/stages/bosh_users/apply.sh
  if [ `cat /etc/passwd | cut -f1 -d ":" | grep "^vcap$" -c` -eq 0 ]; then
      addgroup --system admin
      adduser --disabled-password --gecos Ubuntu vcap

      for grp in admin adm audio cdrom dialout floppy video plugdev dip
      do
          adduser vcap $grp
      done
  else
      echo "User vcap exists already, skippking adduser..."
  fi
  EOH
end

bash "Create relase" do
  cwd node.nise_bosh.release.dir
  code <<-EOH
  #{bosh_path} create release #{node.nise_bosh.release.dir}/releases/#{node.nise_bosh.release.version}
  EOH
  not_if { ::File.exist?("#{node.nise_bosh.release.dir}/releases/#{node.nise_bosh.release.version}.tgz") }
end

if node[:nise_bosh][:deploy][:job]
  manifest_path = "/tmp/deploy-manifest.yml"
  require 'yaml'
  file manifest_path do
    content node.nise_bosh.deploy.manifest.to_yaml.split("\n").map{|line| line.gsub(/\!ruby\/.*$/, '')}.join("\n")
  end

  bash "Deploy... with Nise-BOSH" do
    cwd node.nise_bosh.dir
    code <<-EOH
    #{bundle_path} exec #{ruby_path}/bin/ruby ./bin/nise-bosh -y #{node.nise_bosh.release.dir} #{manifest_path} #{node.nise_bosh.deploy.job}
    EOH
  end
end
