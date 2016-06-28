;apl 105 2014
;Bending of em waves in all-diel particle array wgs
;figure 2 (c) reproduce

(define-param eps 16) ; dielectric constant


(define-param h 0.8) ;  thickness/height
(define-param r 0.8) ; radius 
(define-param sc-y 8) ; supercell width
(define-param sc-z 8) ; supercell width

(set! geometry-lattice (make lattice (size 1 sc-y sc-z))) ; 3d cell

(set! geometry
      (list     (make cylinder 
		(center 0 0 0) (radius r) (height h) (axis 1 0 0) (material (make dielectric (epsilon eps) ) )    )))


; The k (i.e. beta, i.e. propagation constant) points to look at, in
; units of 2*pi/um.  We'll look at num-k points from k-min to k-max.
(define-param num-k 48)
(define-param k-min 0)
(define-param k-max 0.5)
(set! k-points (interpolate num-k (list (vector3 k-min) (vector3 k-max))))
(set-param! resolution (vector3 32 16 16))

; Increase this to see more modes.  (The guided ones are the ones below the
; light line, i.e. those with frequencies < kmag / 1, where kmag
; is the corresponding column in the output if you grep for "freqs:".)
(set-param! num-bands 1)

(begin-time
 "total time for both TE and TM bands: "

(run-yeven-zeven)
(run-yeven-zodd)
(run-yodd-zeven)
(run-yodd-zodd)

)

(display-eigensolver-stats)

