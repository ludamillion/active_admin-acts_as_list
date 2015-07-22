$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin/acts_as_list/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin-acts_as_list"
  s.version     = ActiveAdmin::ActsAsList::VERSION
  s.authors     = ["Luke Inglis"]
  s.email       = ["ld.inglis@gmail.com"]
  s.summary     = "Provides sortable_columns helper in active admin resource definitions."
  s.description = "Provides sortable_columns helper in active admin resource definitions."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # Documentation
  s.add_development_dependency "yard"
  s.add_development_dependency "thin"
end
