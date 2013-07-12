
default[:nise_bosh][:repository]        = "https://github.com/nttlabs/nise_bosh.git"
default[:nise_bosh][:revision]          = "HEAD"
default[:nise_bosh][:dir]               = "/vcap/nise_bosh"

default[:nise_bosh][:release][:dir]         = "/vcap/release"
default[:nise_bosh][:release][:repository]  = "https://github.com/cloudfoundry/cf-release.git"
default[:nise_bosh][:release][:revision]    = "HEAD"
default[:nise_bosh][:release][:version]     = "cf-release-132"

default[:nise_bosh][:deploy][:job]          = nil
default[:nise_bosh][:deploy][:manifest]     = {}
# default[:nise_bosh][:deploy]
