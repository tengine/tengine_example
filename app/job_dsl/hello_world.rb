require 'tengine_job'

jobnet("root_jobnet", server_name: "localhost", credential_name: "ssh_pk") do
  path = File.expand_path("../tengine_job_test.sh", __FILE__)
  job("j1", "#{path} 10 j1")
  job("j2", "#{path} 10 j2")
end
