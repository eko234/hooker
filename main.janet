(import argparse :prefix "")
(import spork/rpc)

(def argparse-params
  [``
   Hooker is a cli application mainly used to automate deployment,
   it takes as arguments paths of scripts
   ``
   "command" {:kind :option
              :required true
              :short "c"
              :help "Command to run"}
   "host" {:kind :option
           :required true
           :short "h"
           :help "host to connect to"}
   "port" {:kind :option
           :required true
           :short "p"
           :help "port to connect to"}])

# (let [res (argparse ;argparse-params)]
#   (unless res
#     (os/exit 1))
#   (pp res))

(rpc/server
 {:ls (fn [self]
        (let 
          [procc (os/spawn ["ls"] :p {:in :pipe :out :pipe :err :pipe})
           out (:read (procc :out) :all)
           err (:read (procc :err) :all)
           _   (:wait procc)]
          {:out out
           :err err
           :return-code (procc :return-code)}))
  :eval (fn [self x]
           (print :Nopi) :OK)})

(def {:ls ls} (rpc/client))
(pp (ls :x))









## SERVER
(rpc/server
 "localhost"
 8080
 {:salute (fn [name]
            (string "hello " name))})

## CLIENT
(def {:salute salute} (rpc/client "localhost" 8080))
(def result (salute "amiguito"))
(print result) # => "hello amiguito"









`
I can make an rpc that also uses an http client to publish its
ip instead of doing that web socket bullfuckery
`

(defn main [& args]
  (print :hello))
