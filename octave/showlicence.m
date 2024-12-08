## Print licence information on screen
##
## Usage: licence(p_mod)
##
## p_mod ... run mode, <str>
##
## Run modes:
##   p_mod = "w": print warranty disclaimer on screen
##   p_mod = "c": print copyright notice on screen
##
## OctODESolver is a simple analysis program to solve the ODE of the damped mass-spring oscillator in 1D space and time-domain.
## Copyright (C) 2024 Jakob Harden (Graz University of Technology)
##
## This file is part of OctODESolver.
##
##    OctODESolver is free software: you can redistribute it and/or modify
##    it under the terms of the GNU Affero General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    OctODESolver is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU Affero General Public License for more details.
##
##    You should have received a copy of the GNU Affero General Public License
##    along with OctODESolver.  If not, see <https://www.gnu.org/licenses/>.
##
## Author information:
##   email:    office@jakobharden.at
##   ORCID:    https://orcid.org/0000-0002-5752-1785
##   LinkedIn: https://www.linkedin.com/in/jakobharden/
##
function showlicence(p_mod)
  
  ## check arguments
  if (nargin < 1)
    p_mod = 'c';
  endif
  
  switch (p_mod)
    case {"w", "W"}
      ## this text is a copy from the AGPL warranty disclaimer (section 15 and 16).
      disp("Licence terms and conditions section 15 and 16 (see also file COPYING)");
      disp("  ");
      disp("15. Disclaimer of Warranty.");
      disp("  THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY");
      disp("  APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT");
      disp("  HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM \"AS IS\" WITHOUT WARRANTY");
      disp("  OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,");
      disp("  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR");
      disp("  PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM");
      disp("  IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF");
      disp("  ALL NECESSARY SERVICING, REPAIR OR CORRECTION.");
      disp("  ");
      disp("16. Limitation of Liability.");
      disp("  IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING");
      disp("  WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS");
      disp("  THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY");
      disp("  GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE");
      disp("  USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF");
      disp("  DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD");
      disp("  PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),");
      disp("  EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF");
      disp("  SUCH DAMAGES.");
      disp("  ");
      disp("  The file COPYING contains the complete licence terms and conditions.");
      disp("  ");
    case {"c", "C"}
      ## this text is a copy of the AGPL license information.
      disp("  OctODESolver is free software: you can redistribute it and/or modify");
      disp("  it under the terms of the GNU General Public License as published by");
      disp("  the Free Software Foundation, either version 3 of the License, or");
      disp("  (at your option) any later version.");
      disp("  ");
      disp("  OctODESolver is distributed in the hope that it will be useful,");
      disp("  but WITHOUT ANY WARRANTY; without even the implied warranty of");
      disp("  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the");
      disp("  GNU General Public License for more details.");
      disp("  ");
      disp("  You should have received a copy of the GNU General Public License");
      disp("  along with OctODESolver.  If not, see <http://www.gnu.org/licenses/>.");
      disp("  ");
      disp("  The file LICENSE contains the complete licence terms and conditions.");
      disp("  ");
    otherwise
      help showlicence;
      error('Unknown runmode: %s', p_mod);
  endswitch

endfunction
