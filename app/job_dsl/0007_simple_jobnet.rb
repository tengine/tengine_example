require 'tengine_job'

jobnet("rjn0007", :server_name => "test_server1", :credential_name => "test_credential1") do
  auto_sequence
  job("j11", "$HOME/tengine_job_test.sh 30 j11")
  job("j12", "$HOME/tengine_job_test.sh 30 j12")
end
