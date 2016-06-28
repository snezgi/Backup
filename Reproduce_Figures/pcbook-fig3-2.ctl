; Compute band structure for a square lattice of dielectric rods
; in air.

; Define various parameters with define-param so that they are
; settable from the command-line (with mpb <param>=<value>):

(define-param eps 12) ; dielectric constant

(define-param w 0.4) ; Si width 

(define-param sc-y 2) ; supercell width

(set! geometry-lattice (make lattice (size 1 sc-y no-size))) ; 2d cell

(set! geometry
      (list
       (make block (size w w 0) (center 0 0 0) (material (make dielectric (epsilon eps))))))
      
; The k (i.e. beta, i.e. propagation constant) points to look at, in
; units of 2*pi/um.  We'll look at num-k points from k-min to k-max.
(define-param num-k 12)
(define-param k-min 0)
(define-param k-max 1)
(set! k-points (interpolate num-k (list (vector3 k-min) (vector3 k-max))))

(set-param! resolution 32) ; 

; Increase this to see more modes.  (The guided ones are the ones below the
; light line, i.e. those with frequencies < kmag / 1, where kmag
; is the corresponding column in the output if you grep for "freqs:".)
(set-param! num-bands 4)

; compute num-bands lowest frequencies as a function of k. Also display
; "parities", i.e. whether the mode is symmetric or anti-symmetric
; through the y=0 plane.
(run-tm-yeven)
(run-tm-yodd)
