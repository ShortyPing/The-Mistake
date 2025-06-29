identification division.
program-id. themistake.

environment division.
input-output section.
file-control.
       select out-file assign to "output.ppm"
       organization is line sequential.

data division.
      
      file section.
      fd out-file.
      01 out-rec pic x(400000).
      
      working-storage section.
      01 ray-origin.
       05 origin-x pic s9(5)v9(5) value +0.
       05 origin-y pic s9(5)v9(5) value +0.                         
       05 origin-z pic s9(5)v9(5) value +0.                             
      01 ray-direction.
       05 dir-x pic s9(5)v9(5) value +0.
       05 dir-y pic s9(5)v9(5) value +0.
       05 dir-z pic s9(5)v9(5) value +0.
      01 sphere-center.
       05 sphere-x pic s9(5)v9(5) value +0.
       05 sphere-y pic s9(5)v9(5) value +0.
       05 sphere-z pic s9(5)v9(5) value +5.
      01 sphere-radius pic s9(5)v9(5) value 1.


       01 dx pic s9(5).
       01 dy pic s9(5).
       01 dist2 pic s9(5).
       01 rad2 pic s9(5).

       01 ocx PIC S9(5)V9(5).
       01 ocy PIC S9(5)V9(5).
       01 ocz PIC S9(5)V9(5).
       01 SA   PIC S9(5)V9(5).
       01 SB   PIC S9(5)V9(5).
       01 SC   PIC S9(5)V9(5).
       01 DISCRIMINANT PIC S9(5)V9(5).
       01 T-HIT PIC S9(5)V9(5).


              

      01 T pic s9(5)v9(5).
      01 width pic 9(3) value 200.
      01 height pic 9(3) value 200.     


      01 X pic 9(3).
      01 Y pic 9(3).
      01 Z pic 9(3).        
      01 r pic 9(3).
      01 g pic 9(3).
      01 b pic 9(3).      

      01 shade pic 9(3).      


      01 hit-x PIC S9(5)V9(5).
       01 hit-y PIC S9(5)V9(5).
       01 hit-z PIC S9(5)V9(5).
       
       01 nx PIC S9(5)V9(5).    *> normal x
       01 ny PIC S9(5)V9(5).    *> normal y
       01 nz PIC S9(5)V9(5).    *> normal z
       
       01 lx PIC S9(5)V9(5) VALUE +0.577. *> light direction x              
       01 ly PIC S9(5)V9(5) VALUE +0.577. *> light direction y
       01 lz PIC S9(5)V9(5) VALUE -0.577. *> light coming straight at sphere
       
       01 brightness PIC S9(5)V9(5).                
procedure division.
       open output out-file
       move "P3" to out-rec
       write out-rec
       move "200 200" to out-rec
       write out-rec
       move "255" to out-rec
       write out-rec
       compute rad2 = 50 * 50
       perform varying y from 1 by 1 until y > height
           perform varying x from 1 by 1 until x > width
               compute dir-x = (x - 100) / 100
               compute dir-y = (y - 100) / 100
               compute dir-z = 1

               move 0 to origin-x
               move 0 to origin-y
               move 0 to origin-z

               compute ocx = origin-x - sphere-x
               compute ocy = origin-y - sphere-y
               compute ocz = origin-z - sphere-z


               compute SA = (dir-x * dir-x) + (dir-y * dir-y) + (dir-z * dir-z)
               compute SB = 2 * ((dir-x * ocx) + (dir-y * ocy) + (dir-z * ocz))
               compute SC = (ocx * ocx) + (ocy * ocy) + (ocz * ocz) - (sphere-radius * sphere-radius)
               compute DISCRIMINANT = (SB * SB) - (4 * SA * SC)         

               if DISCRIMINANT >= 0
                   compute t-hit = (-SB - FUNCTION SQRT(DISCRIMINANT)) / (2 * SA)


                   compute hit-x = origin-x + (t-hit * dir-x)
                   compute hit-y = origin-y + (t-hit * dir-y)
                   compute hit-z = origin-z + (t-hit * dir-z)

                   compute nx = (hit-x - sphere-x) / sphere-radius
                   compute ny = (hit-y - sphere-y) / sphere-radius
                   compute nz = (hit-z - sphere-z) / sphere-radius
               
                   
                   compute brightness = (nx * lx) + (ny * ly) + (nz * lz)


                   if brightness < 0
                       move 0 to brightness
                   end-if          

                   compute r = 255 * brightness                                        
                   move 0 to g
                   move 0 to b
               else
                   move 0 to r
                   move 0 to g
                   move 255 to b
               end-if
           
               string r delimited by size
                   " " delimited by size
                   g delimited by size
                   " " delimited by size
                   b delimited by size
               into out-rec
               write out-rec
           end-perform
       end-perform
       close out-file
       stop run.             
check-hit.
       compute T = (dir-x * sphere-x) + (dir-y * sphere-y) + (dir-z * sphere-z).                                             
