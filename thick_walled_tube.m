% Finds the maximum shear stress experienced in a thick-walled tube
% A thick-walled tube has closed ends and is loaded with an internal
% pressure of 80 MPa and a torque of 15 kNm. The inner and outer diameters
% are 60 and 80 mm, respectively.

% Givens
p = 80 * 10^6; % Pa
T = 15 * 10^3; % Nm
r1 = 0.06/2; % m
r2= 0.08/2; % m

% Define R -- radius variation from the inner to outer diameter
R = linspace(r1, r2);

% Stress in x-direction
sigma_x = (p * r1^2)/(r2^2 - r1^2);

% Radial Stress
sigma_r = -sigma_x * ((r2^2./R.^2) - 1);

% Tangential Stress
sigma_t = sigma_x * ((r2^2./R.^2) + 1);

% Shear due to torsion
tau_tx = 2*T.*R./(pi * (r2^4 - r1^4));

% Find Principal Stresses
sigma_1 = ((sigma_t + sigma_x)/2) + sqrt(((sigma_t - sigma_x)/2).^2 + tau_tx.^2);
sigma_2 = ((sigma_t + sigma_x)/2) - sqrt(((sigma_t - sigma_x)/2).^2 + tau_tx.^2);
sigma_3 = sigma_r;

% Find Max Shear Stress in Tube
tau_max = zeros(1, length(R)); % Pre-allocate for efficiency
tau_1 = abs(sigma_2 - sigma_3)./2;
tau_2 = abs(sigma_1 - sigma_3)./2;
tau_3 = abs(sigma_1 - sigma_2)./2;
for i = 1:length(R)
    tau_max(i) = max([tau_1(i), tau_2(i), tau_3(i)]);
end

% Plots
figure(1)
plot(R * 1000, tau_max * 10^-6, 'b-')
title('Variations of \tau_{max} and \tau_{tx} due to Torsion')
xlabel('Radius (mm)')
ylabel('Stress (MPa)')
hold on
plot(R * 1000, tau_tx * 10^-6, 'c-')
legend('\tau_{max}', '\tau_{tx}', 'location', 'northeast')
hold off

figure(2)
plot(R * 1000, sigma_r * 10^-6, 'r-')
title('Variations of \sigma_r, \sigma_t, and \sigma_x due to Pressure.')
xlabel('Radius (mm)')
ylabel('Stress (MPa)')
hold on
plot(R * 1000, sigma_t * 10^-6, 'b-')
hold on
plot(R * 1000, ones(1, length(R)) .* sigma_x .* 10^-6, 'color', [0 0.5 0])
legend('\sigma_r', '\sigma_t', '\sigma_x', 'location', 'northeast')
hold off

% Other
max_shear = max(tau_max) * 10^-6; % MPa
fprintf('\nThe maximum shear experienced is %.2f\n', max_shear)