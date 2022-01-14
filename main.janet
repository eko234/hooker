(import argparse :prefix "")
(import spork/rpc)

(def argparse-params
  [``
   Hooker is a cli application mainly used to automate deployment
   and handling of applications, it is best used
   for specific projects, exposing an rpc to be used remotely or
   locally (i know, i know...), so if you want to handle different
   projects the recommended way is to spawn multiple servers
   ``
   "as" {:kind :option
         :required true
         :short "r"
         :help "run as <server|client>"}
   "key" {:kind :option
          :required true
          :short "k"
          :help "key for authorization"}
   "host" {:kind :option
           :required true
           :short "h"
           :help "host to connect to"}
   "port" {:kind :option
           :required true
           :short "p"
           :help "port to connect to"}])


(def procc-store @{})
(defn init-server []
  (rpc/server
    {:runR (fn [self command &opt wait]
             (let
               [procc (os/spawn [command] :p {:in :pipe :out :pipe :err :pipe})
                out (when wait (:read (procc :out) :all))
                err (when wait (:read (procc :err) :all))
                _ (when wait (:wait procc))
                pid (procc :pid)
                res {:out out
                     :err err
                     :return-code (when wait (procc :return-code))
                     :pid pid}]
               (put procc-store pid procc)
               res))

     :killR (fn [self pid]
              (if-let [p (get procc-store pid)]
                (do
                  #Check for return code status, depending on how the proc 
                  #was called wait or slay
                  (os/proc-kill p)
                  :KILLED)
                (do :NOT_FOUND)))}))

(defn do-client
  [cmd & args]
  (if-let [funcs (rpc/client)
           func  (funcs cmd)]
    (func ;args)))

# (def {:runR runR :killR killR} (rpc/client))
# (def {:pid pid} (runR :x))
# (ev/sleep 2)
# (pp procc-store)


(defn main [& args]
  (let [res (argparse ;argparse-params)]
    (match :as
      :server (do :serving)
      :client (do :clienting)
      _ (do :shrug))))
