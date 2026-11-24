clear; clc;

% Physical parameters
g    = 9.81;
m_0  = 200;
L    = 1.5;
J_xx = 50;
J_yy = 50;
J_zz = 10;
I_g  = 0.5;

% State vector: x = [x, vx, y, vy, z, vz, phi, wx, theta, wy, psi, wz]'
A = zeros(12, 12);
A(1, 2)   = 1;
A(2, 9)   = g;      % +g * theta
A(3, 4)   = 1;
A(4, 7)   = -g;     % -g * phi
A(5, 6)   = 1;
A(7, 8)   = 1;
A(9, 10)  = 1;
A(11, 12) = 1;

% Input vector: u = [dT; delta_1; delta_2; dw_g]
% delta_1: orthogonal gimbal angle in x-z plane (pitch)
% delta_2: orthogonal gimbal angle in y-z plane (roll)
B = zeros(12, 4);
B(6, 1)  = 1 / m_0;               % Vertical thrust perturbation (dT)
B(2, 2)  = g;                     % F_tx / m_0 = g * delta_1
B(10, 2) = -(m_0 * g * L) / J_yy; % Pitch torque / J_yy
B(4, 3)  = g;                     % F_ty / m_0 = g * delta_2
B(8, 3)  = (m_0 * g * L) / J_xx;  % Roll torque / J_xx
B(12, 4) = I_g / J_zz;            % Reaction wheel acceleration

% Verify full controllability (rankCo = 12)
rankCo = rank(ctrb(A, B))

% LQR Design
Q = diag([0.5, 0.5, 0.5, 0.5, 1, 1, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2]);
R = diag([1e-3, 10, 10, 1]); % Penalize thrust in N vs angles in rad
K = lqr(A, B, Q, R);
%% Example: Compute nonlinear actuator commands from a state error
x_current = [1; 0; -0.5; 0; 2; 0; 0.05; 0; -0.05; 0; 0; 0];
x_target  = zeros(12, 1);

u = -K * (x_current - x_target);
dT      = u(1);
delta_1 = u(2);
delta_2 = u(3);
dw_g    = u(4);

% Total thrust and spherical gimbal angles (delta, beta)
T_total = m_0 * g + dT;
[delta, beta] = orthogonalToSpherical(delta_1, delta_2);

fprintf('T = %.2f N, delta = %.2f deg, beta = %.2f deg, dw_g = %.2f rad/s^2\n', ...
    T_total, rad2deg(delta), rad2deg(beta), dw_g);

%% Helper Function: Orthogonal (delta_1, delta_2) -> Spherical (delta, beta)
function [delta, beta] = orthogonalToSpherical(delta_1, delta_2)
% Clamp sin^2 sum to <= 1 to avoid complex numbers for large commands
s1 = sin(delta_1);
s2 = sin(delta_2);
s_mag = min(1.0, hypot(s1, s2));

delta = asin(s_mag);
beta  = atan2(s2, s1);
end