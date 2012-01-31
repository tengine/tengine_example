# -*- coding: utf-8 -*-

require 'tengine_job'

# [jn0004]
#               |-->[j2]-->
#               |         |
# [S1]-->[j1]-->          |-->[j4]-->[E1]
#               |-->[j3]-->
#                     _________finally________
#                    {                        }
#                    {[S2]-->[jn0004_f]-->[E2]}
#                    {________________________}
#                     
jobnet("jn0004", :instance_name => "test_server1", :credential_name => "test_credential1") do
  boot_jobs("j1")
  job("j1", "$HOME/0004_retry_one_layer.sh", :to => ["j2", "j3"])
  job("j2", "$HOME/0004_retry_one_layer.sh", :to => "j4")
  job("j3", "$HOME/0004_retry_one_layer.sh", :to => "j4")
  job("j4", "$HOME/0004_retry_one_layer.sh")
  finally do
    job("jn0004_f", "$HOME/0004_retry_one_layer.sh")
  end
end
