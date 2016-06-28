; Compute TM modes of a rectangular strip waveguide. 

; define parameters which can easily be changed on the command-line
; (e.g.: mpb w=0.5 pcbook-fig3-1.ctl)

(define-param w 0.4) ; Si width (um)

(define-param eps 12) ; dielectric constant

; Define the computational cell.  We'll make x the propagation direction.
; the other cell sizes should be big enough so that the boundaries are
; far away from the mode field.

(define-param sc-y 4) ; supercell width (um)

(set! geometry-lattice (make lattice (size 1 sc-y no-size)))

; define the 2d blocks for the strip and substrate
(set! geometry
      (list
       (make block (size 1 w 0) (center 0 0 0) (material (make dielectric (epsilon eps))))))

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
(set-param! num-bands 1)

; compute num-bands lowest frequencies as a function of k. Also display
; "parities", i.e. whether the mode is symmetric or anti-symmetric
; through the y=0 plane.
(run-tm-yeven)
(run-tm-yodd)

