#lang info
(define collection "color-schemes")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/color-schemes.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(pomervic))

(define framework:color-schemes
  '(#hash(
          (colors .((framework:syntax-color:scheme:symbol 
                     #(153 255 66))
                    (framework:syntax-color:scheme:keyword 
                     #(49 217 255) 'italic)
                    (framework:syntax-color:scheme:comment 
                     #(199 199 199) 'italic)
                    (framework:syntax-color:scheme:string 
                     #(255 133 69))
                    (framework:syntax-color:scheme:text 
                     #(255 158 0))
                    (framework:syntax-color:scheme:constant 
                     #(255 107 0))
                    (framework:syntax-color:scheme:hash-colon-keyword 
                     #(255 117 255))
                    (framework:syntax-color:scheme:parenthesis 
                     #(255 255 255))
                    (framework:syntax-color:scheme:error 
                     #(255 0 0))
                    (framework:syntax-color:scheme:other
                     #(240 240 240))))
          (name . "C4PO")
          (white-on-black-base? . #t))))
