identification division.
program-id. themistake.
data division.
      working-storage section.
      01 ray-origin.
       05 origin-x pic s9(5)v9(5) value +0.
       05 origin-y pic s9(5)v9(5) value +0.                         
       05 origin-z pic s9(5)v9(5) value +0.                                     
procedure division.
       compute origin-x = origin-x + 1.0
       display "Hello, World" origin-x
       stop run.                                                        
