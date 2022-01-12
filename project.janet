(declare-project
 :name "hooker"
 :description "a hooker"
 :dependencies ["https://github.com/janet-lang/circlet.git"
                "https://github.com/janet-lang/json"
                "https://github.com/joy-framework/joy"])

(declare-executable
 :name "hooker"
 :entry "main.janet")
