name              "nise_bosh"
maintainer        "O.yuanying"
maintainer_email  "yuan-chef@fraction.jp"
license           "Apache 2.0"
description       "Managing Nise-BOSH"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "nise_bosh", "Install Nise-BOSH."

%w{ ubuntu }.each do |os|
  supports os
end

