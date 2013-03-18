require 'rake/testtask'

# this enables us to run all tests by running 'rake test'
Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/*_spec.rb']
  t.verbose = true
end
