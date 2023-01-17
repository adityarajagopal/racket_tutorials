#lang typed/racket

(provide read-syntax)

(: datum? : Any -> Boolean)
(define (datum? x) (or (list? x) (symbol? x)))
 
(: string->datum : String -> Any)
(define (string->datum s) 
  (read (open-input-string (format "(~a)" s))))
 
(: format-datum : Datum String * -> Any)
(define (format-datum datumTemplate . vals)
  (string->datum (apply format (format "~a" datumTemplate) vals)))

(: format-datums : Datum (Listof String) (Listof String) * -> (Listof Any))
(define (format-datums datumTemplate v1 . valsLst)
  (apply map (lambda [v : String *] (apply format-datum datumTemplate v)) v1 valsLst))

(: read-syntax : Any Input-Port -> (Syntaxof Any))
(define (read-syntax path port)
  (let* 
    ([srcLines (port->lines port)]
     [srcDatums (format-datums '(handle ~a) srcLines)]
     [moduleDatum `(module stacker racket ,@srcDatums)])
    (datum->syntax #f moduleDatum)))


