# -*- coding: utf-8 -*-

require 'tengine_job'

# finallyを追加する
# [jn0006]
#          __________________________[jn1]____________________________        ______________[jn2]_____________________________________
#         {          __________[jn11]_______________                  }     {                 _____________[jn22]____________         }
#         {         {                               }                 }     {                {                              }         } 
#  [S1]-->{ [S2]--> { [S3]-->[j111]-->[j112]-->[E3] } -->[j12]-->[E2] } --> { [S6]-->[j21]-->{ [S7]-->[j221]-->[j222]-->[E7]} -->[E6] } -->[E1] 
#         {         {                               }                 }     {                {                              }         }
#         {         {   _______finally_______       }                 }     {                {  _________finally_______     }         }
#         {         {  {[S4]-->[jn11_f]-->[E4]}     }                 }     {                {  {[S8]-->[jn22_f]-->[E8]}    }         }
#         {         {_______________________________}                 }     {                {______________________________}         }
#         {                                                           }     {                                                         }
#         {                                   _______finally_______   }     {                               _______finally_______     }
#         {                                  {[S5]-->[jn1_f]-->[E5]}  }     {                             {[S9]-->[jn2_f]-->[E9]}     }
#         {___________________________________________________________}     {_________________________________________________________}
#
#                                                                                           _______finally_______
#                                                                                          {[S10]-->[jn_f]-->[E10]}
#
jobnet("jn0006", :instance_name => "test_server1", :credential_name => "test_credential1") do
  boot_jobs("jn1")
  jobnet("jn1", :to => "jn2") do
   boot_jobs("jn11")
   jobnet("jn11", :to => "j12") do
     boot_jobs("j111")
     job("j111", "$HOME/0006_retry_three_layer.sh",:to => "j112")
     job("j112", "$HOME/0006_retry_three_layer.sh" )
     finally do
       job("jn11_f","$HOME/0006_retry_three_layer.sh")
     end
   end
   job("j12", "$HOME/0006_retry_three_layer.sh")    
   finally do
     job("jn1_f","$HOME/0006_retry_three_layer.sh")
   end
  end
  jobnet("jn2") do
   boot_jobs("j21")
   job("j21", "$HOME/0006_retry_three_layer.sh", :to => "jn22")    
   jobnet("jn22") do
     boot_jobs("j221")
     job("j221", "$HOME/0006_retry_three_layer.sh",:to => "j222")
     job("j222", "$HOME/0006_retry_three_layer.sh" )
     finally do
       job("jn22_f","$HOME/0006_retry_three_layer.sh")
     end
   end
   finally do
     job("jn2_f","$HOME/0006_retry_three_layer.sh")
   end
  end
  finally do 
    job("jn_f","$HOME/0006_retry_three_layer.sh")
  end
end
