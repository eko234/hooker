(print "mierda ijueputa")

(defn getls
  "gets ls from bin dir" []
  (try
   (do
     (def proc (os/spawn ["ls"] :p {:in :pipe :out :pipe :err :pipe}))
     (def result 
       [(:read (proc :out) :all)
        (:read (proc :err) :all)])
     (:wait proc)
     result)
  ([err] [err])))

(pp (getls))
