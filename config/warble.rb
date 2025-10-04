# Workaround for JRuby 9.3+ new_ostruct_member issue
# See: https://github.com/jruby/warbler/issues/452
class Warbler::Traits::War::WebxmlOpenStruct
  def new_ostruct_member(name)
    send(:new_ostruct_member!, name)
  end
end

Warbler::Config.new do |config|
  config.gem_dependencies = true
  config.war_name = "hello_world"

  # Include necessary files
  config.includes = FileList["app.rb", "config.ru"]

  # Ensure gems are bundled
  config.bundle_without = []
end
