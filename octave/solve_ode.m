## Solve ordinary differential equation of second order in 1D space (time step integration)
##
## Usage: [r_u, r_v, r_a] = solve_ode(p_etp, p_stp, p_par, p_rhs, p_bc0)
##
## p_etp ... equation type, <str>
## p_stp ... solver type, <str>
## p_par ... equation parameter array, [<dbl>]
## p_rhs ... right-hand-side of inhomogeneous equation [n x 1], [<dbl>]
## p_bc0 ... boundary conditions for t = 0, [<dbl>]
## r_u   ... return: displacement array u(t) [ndt x 1], [<dbl>]
## r_v   ... return: velocity array v(t) [ndt x 1], [<dbl>]
## r_a   ... return: acceleration array a(t) [ndt x 1], [<dbl>]
##
## Equation types:
##   p_etp = 'dmso': damped mass-spring oszillator, elliptic ODE, m * d^2/dt^2 u + k * d/dt u + c * u = 0
##   p_etp = 'mso':  mass-spring oszillator, elliptic ODE, m * d^2/dt^2 u + c * u = 0
##
## Solver types:
##   p_stp = 'euler': Euler method, explicit
##   p_stp = 'ab2': Adams-Bashforth method, two-step, explicit
##   p_stp = 'rk2': Runge-Kutta method, two-step, explicit
##   p_stp = 'rk4': Runge-Kutta method, four-step, explicit
##
## Parameters:
##   p_etp = 'dmso': p_par = [ndt, dt, m, k, c]
##   p_etp = 'mso':  p_par = [ndt, dt, m, c]
##
## Boundary conditions:
##   p_bc0 = [u0, v0] ... p_etp = 'dmso' or 'mso'
##
## Notes:
##   ndt ... number of time steps
##    dt ... time step width
##     m ... mass
##     k ... damping constant, velocity-proportional
##     c ... spring constant, stiffness
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
function [r_u, r_v, r_a] = solve_ode(p_etp, p_stp, p_par, p_rhs, p_bc0)
  
  ## switch ODE type
  switch (p_etp)
    case 'dmso'
      ## damped mass-spring oszillator
      [r_u, r_v, r_a] = solve_dmso(p_stp, p_par, p_rhs, p_bc0);
    case 'mso'
      ## mass-spring oszillator
      par = zeros(size(p_par));
      par(1) = p_par(1);
      par(2) = p_par(2);
      par(3) = p_par(3);
      par(4) = 0;
      par(5) = p_par(4);
      [r_u, r_v, r_a] = solve_dmso(p_stp, par, p_rhs, p_bc0);
    otherwise
      error('ODE type not implemented yet! etp = %s', p_etp);
  endswitch
  
endfunction


function [r_u, r_v, r_a] = solve_dmso(p_stp, p_par, p_rhs, p_bc0)
  ## Solve ODE for the damped mass-spring oszillator
  ##
  ## p_stp ... solver type, <str>
  ## p_par ... equation parameter array, [<dbl>]
  ## p_rhs ... right-hand-side of inhomogeneous equation [n x 1], [<dbl>]
  ## p_bc0 ... boundary conditions for t = 0, [u0, v0], [<dbl>]
  ## r_u   ... return: displacement array u [ndt x 1], [<dbl>]
  ## r_v   ... return: velocity array u [ndt x 1], [<dbl>]
  ## r_a   ... return: acceleration array u [ndt x 1], [<dbl>]
  
  ## number of time steps
  ndt = p_par(1);
  
  ## time step width
  dt = p_par(2);
  
  ## mass
  m = p_par(3);
  
  ## damping constant
  k = p_par(4);
  
  ## spring constant
  c = p_par(5);
  
  ## calculation values (equation constants divided by the mass)
  km = k / m;
  cm = c / m;
  rhsm = p_rhs / m;
  
  ## displacement u
  ## velocity, v = d/dt u
  ## acceleration, a = d^2/dt^2 u
  uu = zeros(ndt, 1);
  vv = uu;
  aa = uu;
  
  ## initial values, IVP
  uu(1) = p_bc0(1);
  vv(1) = p_bc0(2);
  
  ## switch solver
  ## solve: m * d^2/dt^2 u + k * d/dt u + c * u = f(t) = rhs(t)
  ## => m*a + k*v + c*u = f(t)
  ## => a = d/dt v = (f - k*v - c*u) / m
  ## => dv = dt * (f - k*v - c*u) / m
  ## v(i) = v(i-1) + dv
  switch (p_stp)
    case 'euler'
      ## explicit Euler method
      for i = 2 : ndt
        ## estimate velocity increment
        rhs1 = rhsm(i-1);
        u1 = uu(i-1);
        v1 = vv(i-1);
        k1 = eval_dmso(km, cm, u1, v1, rhs1);
        ## update results
        [uu(i), vv(i), aa(i)] = update_uva(dt, k1, u1, v1);
      endfor
    case 'ab2'
      ## Adams-Bashforth method, two-step, explicit
      ## init step, Euler
      rhs1 = rhsm(1);
      u1 = uu(1);
      v1 = vv(1);
      k1 = eval_dmso(km, cm, u1, v1, rhs1);
      [uu(2), vv(2), aa(2)] = update_uva(dt, k1, u1, v1);
      ## other steps
      for i = 3 : ndt
        ## evaluate function
        k1 = eval_dmso(km, cm, uu(i-1), vv(i-1), rhsm(i-1));
        k2 = eval_dmso(km, cm, uu(i-2), vv(i-2), rhsm(i-2));
        k12 = 1 / 2 * (3 * k1 - k2);
        ## update results
        [uu(i), vv(i), aa(i)] = update_uva(dt, k12, uu(i-1), vv(i-1));
      endfor
    case 'rk2'
      ## Runge-Kutta, 2nd order, explicit (midpoint method)
      for i = 2 : ndt
        ## interval startpoint
        rhs1 = rhsm(i-1);
        u1 = uu(i-1);
        v1 = vv(i-1);
        k1 = eval_dmso(km, cm, u1, v1, rhs1);
        dv = dt * k1;
        ## interval midpoint
        rhs2 = 0.5 * (rhsm(i) + rhsm(i-1));
        v2 = v1 + 0.5 * dv;
        u2 = u1 + 0.5 * dt * v2;
        k2 = eval_dmso(km, cm, u2, v2, rhs2);
        ## update results
        [uu(i), vv(i), aa(i)] = update_uva(dt, k2, u1, v1);
      endfor
    case 'rk4'
      ## Runge-Kutta, 4th order, explicit
      for i = 2 : ndt
        ## k1, interval startpoint
        rhs1 = rhsm(i-1);
        v1 = vv(i-1);
        u1 = uu(i-1);
        k1 = eval_dmso(km, cm, u1, v1, rhs1);
        ## k2, interval midpoint
        rhs2 = 0.5 * (rhsm(i) + rhsm(i-1));
        v2 = v1 + 0.5 * dt * k1;
        u2 = u1 + 0.5 * dt * v2;
        k2 = eval_dmso(km, cm, u2, v2, rhs2);
        ## k3, interval midpoint
        rhs3 = rhs2;
        v3 = v1 + 0.5 * dt * k2;
        u3 = u1 + 0.5 * dt * v3;
        k3 = eval_dmso(km, cm, u3, v3, rhs3);
        ## k4, interval endpoint
        rhs4 = rhsm(i);
        v4 = v1 + dt * k3;
        u4 = u1 + dt * v4;
        k4 = eval_dmso(km, cm, u4, v4, rhs4);
        ## k1234, combined slope
        k1234 = 1 / 6 * (k1 + 2 * k2 + 2 * k3 + k4);
        ## update results
        [uu(i), vv(i), aa(i)] = update_uva(dt, k1234, u1, v1);
      endfor
    otherwise
      error('Solver type not implemented yet! stp = %s', p_stp);
  endswitch
  
  ## return values
  r_u = uu;
  r_v = vv;
  r_a = aa;
  
endfunction


function [r_k] = eval_dmso(p_km, p_cm, p_u, p_v, p_r)
  ## Evaluate differential equation of damped mass spring oszillator
  ##
  ## Note that the value returned is an acceleration, it is the slope of the velocity function
  ##
  ## p_km ... k/m, <dbl>
  ## p_cm ... c/m, <dbl>
  ## p_u  ... displacement, <dbl>
  ## p_v  ... velocity, <dbl>
  ## p_r  ... right-hand-side, <dbl>
  ## r_k  ... slope of velocity function, <dbl>
  
  r_k = p_r - p_cm * p_u - p_km * p_v;
  
endfunction


function [r_u2, r_v2, r_a2] = update_uva(p_dt, p_k1, p_u1, p_v1)
  ## Update displacement, velocity and acceleration (evaluate current step)
  ##
  ## p_dt ... time increment, <dbl>
  ## p_k1 ... slope for velocity increment, <dbl>
  ## p_u1 ... displacement of previous step, <dbl>
  ## p_v1 ... velocity of previous step, <dbl>
  ## r_u2 ... displacement of current step, <dbl>
  ## r_v2 ... velocity of current step, <dbl>
  ## r_a2 ... acceleration of current step, <dbl>
  
  ## velocity increment
  dv = p_dt * p_k1;
  
  ## update velocity
  r_v2 = p_v1 + dv;
  
  ## update displacement
  r_u2 = p_u1 + p_dt * p_v1;
  
  ## update acceleration
  r_a2 = dv / p_dt;
  
endfunction
