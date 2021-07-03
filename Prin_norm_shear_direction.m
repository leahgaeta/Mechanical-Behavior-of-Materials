% Finds the principal normal stresses, principal shear stresses, and the
% maximum normal and shear stresses in MPa. Also finds the direction
% cosines by solving the eigenvalue problem
% Leah T Gaeta

clear
clc

% Enter the given data in the stress tensor (all stresses MPa)
sigma_x = 150;
sigma_y = 300;
sigma_z = -20;
tau_xy = 0;
tau_yx = tau_xy;
tau_yz = 0;
tau_zy = tau_yz;
tau_zx = 0;
tau_xz = tau_zx;
stress = [sigma_x, tau_yx, tau_zx;...
    tau_xy, sigma_y, tau_zy;...
    tau_xz, tau_yz, sigma_z];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find principal normal stresses & principal shear stresses

% Invariants
I_1 = trace(stress);
I_2 = (1/2) * ((trace(stress))^2 - trace(stress^2));
I_3 = det(stress);
% Note that can also use eig() command such as below
% [V, D] = eig(stress) then sort(diag(D), 'descend') to get principal norm.

% Coefficients of the cubic equation for the state of stress
% Principal normal stresses
C = [1, -I_1, I_2, -I_3];
r = sort(roots(C), 'descend');
fprintf('\nThe principal normal stresses (MPa) are:\n')
disp(r)

% Principal shear stresses
t = [abs(r(2) - r(3))/2; abs(r(1) - r(3))/2; abs(r(1) - r(2))/2];
fprintf('\nThe principal shear stresses (MPa) are:\n')
disp(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find maximum normal stress and maximum shear stress
fprintf('\nThe maximum normal stress is %.2f MPa\n', max(r))
fprintf('The maximum shear stress is %.2f MPa\n', max(t))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find direction cosines for each principal normal stress axis
[V, D] = eig(stress);
fprintf('\nThe direction cosines in order l, m, n for sigma_1 are:\n') 
disp(flip(V(:,3)))
fprintf('\nThe direction cosines in order l, m, n for sigma_2 are:\n')
disp(flip(V(:,2)))
fprintf('\nThe direction cosines in order l, m, n for sigma_3 are:\n')
disp(flip(V(:,1)))