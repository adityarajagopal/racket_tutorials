#lang typed/racket

(provide read-syntax)

(: datum? (-> Any Boolean))
(define (datum? x) (or (list? x) (symbol? x)))

(: format-datum (-> Datum Any * (U Datum Void)))
(define (format-datum datumTemplate . vals)
  (unless (datum? datumTemplate) (raise-argument-error 'format-datums "datum?" datumTemplate))
  (apply format (format "~a" datumTemplate) vals))

(: format-datums (-> Datum (Listof Any) (Listof Datum)))
(define (format-datums datumTemplate . valsLst)
  (unless (datum? datumTemplate) (raise-argument-error 'format-datums "datum?" datumTemplate))
  (map (lambda vals (apply format-datum datumTemplate vals)) valsLst))

(displayln (format-datums '(handle ~a) (list "zzz" "yyy")))
  
; (: read-syntax (-> Any Input-Port Syntax))
; (define (read-syntax path port)
;   (let* 
;     (;[srcLines (port->lines port)]
;      [srcDatums (format-datum '(handle ~a) "zzz")]
;      [moduleDatum `(module stacker racket ,srcDatums)])
;     (datum->syntax #f moduleDatum)))

