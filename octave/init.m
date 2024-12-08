## Initialize program environment
##
## Usage: init()
##
## OctODESolver is a simple analysis program to solve ordinary differential equations in 1D space.
## Copyright (C) 2024 Jakob Harden
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
function init()
  
  ## load packages
  pkg load signal;
  pkg load video;
  
  ## init result directories
  dn_results = 'results';
  sdn_results = {'test_solve_ode'};
  fp_results = fullfile('.', dn_results);
  if (exist(fp_results, 'dir') != 7)
    mkdir(fp_results);
  endif
  for i = 1 : length(sdn_results)
    sdn = sdn_results{i};
    sdfp = fullfile(fp_results, sdn);
    if (exist(sdfp, 'dir') != 7)
      mkdir(sdfp);
    endif
  endfor
  
  ## print copyright notice on screen
  disp('OctODESOlver is a simple analysis program to solve ordinary differential equations in 1D space.');
  disp('OctODESOlver  Copyright (C) 2024  Jakob Harden');
  disp('  This program comes with ABSOLUTELY NO WARRANTY; for details type showlicence("w").');
  disp('  This is free software, and you are welcome to redistribute it');
  disp('  under certain conditions; type showlicence("c") for details.');
  
endfunction
