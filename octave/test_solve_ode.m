## Test Octave ODE solver
##
## Usage: test_solve_ode()
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
function test_solve_ode()
  
  ## test 1: homogeneous ODE, damped mass-spring oszillator
  ## BC, t=0: u=1, v=0
  ndt = 300;
  dt = 0.1;
  m = 1;
  c = 1;
  k = 0.5;
  par = [ndt, dt, m, k, c];
  bc0 = [1, 0];
  rhs = zeros(ndt, 1);
  eq = 'dmso'; # damped mass-spring oszillator
  stp = 'euler'; # explicit Euler method
  [u1, v1, a1] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'ab2'; # Adams-Bashforth method
  [u2, v2, a2] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk2'; # Runge-Kutta two-step
  [u3, v3, a3] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk4'; # Runge-Kutta four-step
  [u4, v4, a4] = solve_ode(eq, stp, par, rhs, bc0);
  tit = sprintf('Homogeneous ODE, u_0 = %d, v_0 = %d', bc0);
  tid = 1;
  plot_results(u1, u2, u3, u4, rhs, tit, 1, tid);
  plot_results(v1, v2, v3, v4, rhs, tit, 2, tid);
  plot_results(a1, a2, a3, a4, rhs, tit, 3, tid);
  
  ## test 2: homogeneous ODE, damped mass-spring oszillator
  ## BC, t=0: u=0, v=1
  ndt = 300;
  dt = 0.1;
  m = 1;
  c = 1;
  k = 0.5;
  par = [ndt, dt, m, k, c];
  bc0 = [0, 1];
  rhs = zeros(ndt, 1);
  eq = 'dmso'; # damped mass-spring oszillator
  stp = 'euler'; # explicit Euler method
  [u1, v1, a1] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'ab2'; # Adams-Bashforth method
  [u2, v2, a2] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk2'; # Runge-Kutta two-step
  [u3, v3, a3] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk4'; # Runge-Kutta four-step
  [u4, v4, a4] = solve_ode(eq, stp, par, rhs, bc0);
  tit = sprintf('Homogeneous ODE, u_0 = %d, v_0 = %d', bc0);
  tid = 2;
  plot_results(u1, u2, u3, u4, rhs, tit, 1, tid);
  plot_results(v1, v2, v3, v4, rhs, tit, 2, tid);
  plot_results(a1, a2, a3, a4, rhs, tit, 3, tid);
  
  ## test 3: inhomogeneous ODE, damped mass-spring oszillator
  ## BC, t=0: u=0, v=0
  ndt = 300;
  dt = 0.1;
  m = 1;
  c = 1;
  k = 0.5;
  par = [ndt, dt, m, k, c];
  bc0 = [0, 0];
  xx = linspace(0, 1, ndt);
  tt = xx * 8 * pi;
  rhs = sin(tt) .* exp(-5 * xx);
  rhs = rhs / max(rhs);
  eq = 'dmso'; # damped mass-spring oszillator
  stp = 'euler'; # explicit Euler method
  [u1, v1, a1] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'ab2'; # Adams-Bashforth method
  [u2, v2, a2] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk2'; # Runge-Kutta two-step
  [u3, v3, a3] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk4'; # Runge-Kutta four-step
  [u4, v4, a4] = solve_ode(eq, stp, par, rhs, bc0);
  tit = 'Inhomogeneous ODE: u_0 = 0, v_0 = 0, RHS = sin(t*8*pi)*exp(-5*t)';
  tid = 3;
  plot_results(u1, u2, u3, u4, rhs, tit, 1, tid);
  plot_results(v1, v2, v3, v4, rhs, tit, 2, tid);
  plot_results(a1, a2, a3, a4, rhs, tit, 3, tid);
  
  ## test 4: inhomogeneous ODE, damped mass-spring oszillator
  ## BC, t=0: u=0, v=0
  ndt = 300;
  dt = 0.1;
  m = 1;
  c = 1;
  k = 0.5;
  par = [ndt, dt, m, k, c];
  bc0 = [0, 0];
  xx = linspace(0, 1, ndt);
  tt = xx * 8 * pi;
  rhs = sin(tt) .* exp(-5 * xx) .* (1 - exp(-12 * xx));
  rhs = rhs / max(rhs);
  eq = 'dmso'; # damped mass-spring oszillator
  stp = 'euler'; # explicit Euler method
  [u1, v1, a1] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'ab2'; # Adams-Bashforth method
  [u2, v2, a2] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk2'; # Runge-Kutta two-step
  [u3, v3, a3] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk4'; # Runge-Kutta four-step
  [u4, v4, a4] = solve_ode(eq, stp, par, rhs, bc0);
  tit = 'Inhomogeneous ODE: u_0 = 0, v_0 = 0, RHS = sin(t*8*pi)*exp(-5*t)*(1-exp(-12*t))';
  tid = 4;
  plot_results(u1, u2, u3, u4, rhs, tit, 1, tid);
  plot_results(v1, v2, v3, v4, rhs, tit, 2, tid);
  plot_results(a1, a2, a3, a4, rhs, tit, 3, tid);
  
  ## test 5: inhomogeneous ODE, damped mass-spring oszillator
  ## BC, t=0: u=0, v=0
  ndt = 300;
  dt = 0.1;
  m = 1;
  c = 1;
  k = 0.5;
  par = [ndt, dt, m, k, c];
  bc0 = [0, 0];
  xx = linspace(0, 1, ndt);
  rhs = exp(-8 * xx) .* (1 - exp(-12 * xx));
  rhs = rhs / max(rhs);
  eq = 'dmso'; # damped mass-spring oszillator
  stp = 'euler'; # explicit Euler method
  [u1, v1, a1] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'ab2'; # Adams-Bashforth method
  [u2, v2, a2] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk2'; # Runge-Kutta two-step
  [u3, v3, a3] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk4'; # Runge-Kutta four-step
  [u4, v4, a4] = solve_ode(eq, stp, par, rhs, bc0);
  tit = 'Inhomogeneous ODE: u_0 = 0, v_0 = 0, RHS = exp(-8*t)*(1-exp(-12*t))';
  tid = 5;
  plot_results(u1, u2, u3, u4, rhs, tit, 1, tid);
  plot_results(v1, v2, v3, v4, rhs, tit, 2, tid);
  plot_results(a1, a2, a3, a4, rhs, tit, 3, tid);
  
  ## test 6: homogeneous ODE, mass-spring oszillator
  ## BC, t=0: u=1, v=0
  ndt = 300;
  dt = 0.1;
  m = 1;
  c = 1;
  par = [ndt, dt, m, c];
  bc0 = [1, 0];
  rhs = zeros(ndt, 1);
  eq = 'mso'; # mass-spring oszillator
  stp = 'euler'; # explicit Euler method
  [u1, v1, a1] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'ab2'; # Adams-Bashforth method
  [u2, v2, a2] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk2'; # Runge-Kutta two-step
  [u3, v3, a3] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk4'; # Runge-Kutta four-step
  [u4, v4, a4] = solve_ode(eq, stp, par, rhs, bc0);
  tit = sprintf('Homogeneous ODE, u_0 = %d, v_0 = %d', bc0);
  tid = 6;
  plot_results(u1, u2, u3, u4, rhs, tit, 1, tid);
  plot_results(v1, v2, v3, v4, rhs, tit, 2, tid);
  plot_results(a1, a2, a3, a4, rhs, tit, 3, tid);
  
  ## test 7: homogeneous ODE, mass-spring oszillator
  ## BC, t=0: u=0, v=1
  ndt = 300;
  dt = 0.1;
  m = 1;
  c = 1;
  par = [ndt, dt, m, c];
  bc0 = [0, 1];
  rhs = zeros(ndt, 1);
  eq = 'mso'; # mass-spring oszillator
  stp = 'euler'; # explicit Euler method
  [u1, v1, a1] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'ab2'; # Adams-Bashforth method
  [u2, v2, a2] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk2'; # Runge-Kutta two-step
  [u3, v3, a3] = solve_ode(eq, stp, par, rhs, bc0);
  stp = 'rk4'; # Runge-Kutta four-step
  [u4, v4, a4] = solve_ode(eq, stp, par, rhs, bc0);
  tit = sprintf('Homogeneous ODE, u_0 = %d, v_0 = %d', bc0);
  tid = 7;
  plot_results(u1, u2, u3, u4, rhs, tit, 1, tid);
  plot_results(v1, v2, v3, v4, rhs, tit, 2, tid);
  plot_results(a1, a2, a3, a4, rhs, tit, 3, tid);
  
endfunction


function plot_results(p_x1, p_x2, p_x3, p_x4, p_rhs, p_tit, p_rtp, p_tid)
  
  ## switch result type
  switch (p_rtp)
    case 1
      ## displacement u
      rpfx = 'u';
      lbl = 'displacement u [m]';
    case 2
      ## velocity v
      rpfx = 'v';
      lbl = 'velocity v [m/sec]';
    case 3
      ## acceleration a
      rpfx = 'a';
      lbl = 'acceleration a [m/sec^2]';
  endswitch
  
  ## plot functions
  fh = figure('position', [100, 100, 800, 800/1.62]);
  grid on;
  hold on;
  plot(p_rhs, ';RHS;', 'linewidth', 2, 'color', [0.5, 0.5, 0.5]);
  plot(p_x1, ';Euler;');
  plot(p_x2, ';Adams-Bashforth;');
  plot(p_x3, ';Runge-Kutta 2;');
  plot(p_x4, ';Runge-Kutta 4;');
  hold off;
  title(sprintf('%s', p_tit));
  xlabel('time step [n]');
  ylabel(lbl);
  legend('location', 'eastoutside', 'box', 'off')
  annotation('textbox', [0, 0, 20, 0.1], ...
    'string', 'CC BY-4.0 Jakob Harden (Graz University of Technology)', 'fontsize', 8, 'linestyle', 'none');
  
  ## save figure
  fextpng = 'png';
  fextfig = 'ofig';
  ofnpng = sprintf('test_%d_%s.%s', p_tid, rpfx, fextpng);
  ofnfig = sprintf('test_%d_%s.%s', p_tid, rpfx, fextfig);
  ofppng = fullfile('.', 'results', 'test_solve_ode', ofnpng);
  ofpfig = fullfile('.', 'results', 'test_solve_ode', ofnfig);
  saveas(fh, ofppng, fextpng);
  hgsave(fh, ofpfig, '-binary');
  close(fh);
  
endfunction
