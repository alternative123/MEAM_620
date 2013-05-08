function [pos, phi, phi_d, vel, acc, vects, total_t] = diamond(t)

%You fill this in!

speed = 0.1;
total_t = 1 / speed;

if t > total_t
    pos = [1 0 0];
    vel = [0, 0, 0];
    acc = [0, 0, 0];
    vects = zeros(3);
    phi = 0;
    phi_d = 0;
    return;
end


phi = 0;
phi_d = 0;
% x = [0; 0; 0; 0];
% y = [0; 2 * sind(45); 0; -2 * sind(45)];
% z = [0; 2 * cosd(45); 4 * cosd(45); 2 * cosd(45)];
% points = [x, y, z];

kx = [ 0,  0,    0, 0, 0,   0;...
	2, -5, 10/3, 0, 0,   0;...
	2, -5, 10/3, 0, 0, 1/3;...
	2, -5, 10/3, 0, 0, 2/3];

ky = [  6*2^(1/2), -15*2^(1/2),  10*2^(1/2), 0, 0,        0;...
	-6*2^(1/2),  15*2^(1/2), -10*2^(1/2), 0, 0,  2^(1/2);...
	-6*2^(1/2),  15*2^(1/2), -10*2^(1/2), 0, 0,        0;...
	6*2^(1/2), -15*2^(1/2),  10*2^(1/2), 0, 0, -2^(1/2)];

kz = [  6*2^(1/2), -15*2^(1/2),  10*2^(1/2), 0, 0,         0;...
	6*2^(1/2), -15*2^(1/2),  10*2^(1/2), 0, 0,   2^(1/2);...
	-6*2^(1/2),  15*2^(1/2), -10*2^(1/2), 0, 0, 2*2^(1/2);...
	-6*2^(1/2),  15*2^(1/2), -10*2^(1/2), 0, 0,   2^(1/2)];

idx = floor(t / 2.5) + 1;
if idx <= 0
    idx = 1;
end

local_t = t * 4 / total_t - (idx - 1);

p = [local_t^5, local_t^4, local_t^3, local_t^2, local_t^1, 1];
v = [5*local_t^4, 4*local_t^3, 3*local_t^2, 2*local_t, 1, 0];
a = [20*local_t^3, 12*local_t^2, 6*local_t, 2, 0, 0];

x = sum(kx(idx, :) .* p);
y = sum(ky(idx, :) .* p);
z = sum(kz(idx, :) .* p);

xd = sum(kx(idx, :) .* v);
yd = sum(ky(idx, :) .* v);
zd = sum(kz(idx, :) .* v);

xdd = sum(kx(idx, :) .* a);
ydd = sum(ky(idx, :) .* a);
zdd = sum(kz(idx, :) .* a);

pos = [x, y, z];
vel = [xd, yd, zd];
acc = [xdd, ydd, zdd];

% if t <= total_t/4
% %     pos = [0, 2 * sind(45),  2 * cosd(45)]
%     t = t * 4 / total_t;
%     pos = points(2, :) * t;
%     vel = points(2, :);
%     acc = [0, 0, 0];
%     phi = 0;
%     phi_d = 0;
% elseif t > total_t/4 && t <= total_t/2
%     t = (t - total_t/4) * 4 / total_t;
%     pos = points(2, :) + (points(3, :) - points(2, :)) * t;
%     vel = (points(3, :) - points(2, :));
%     acc = [0, 0, 0];
%     phi = 0;
%     phi_d = 0;
% elseif t > total_t/2 && t <= total_t/4*3
%     t = (t - total_t/2) * 4 / total_t;
%     pos = points(3, :) + (points(4, :) - points(3, :)) * t;
%     vel = (points(4, :) - points(3, :));
%     acc = [0, 0, 0];
%     phi = 0;
%     phi_d = 0;
% elseif t > total_t/4*3 && t <= total_t
%     t = (t - total_t/4*3) * 4 / total_t;
%     pos = points(4, :) + (points(1, :) - points(4, :)) * t;
%     vel = (points(1, :) - points(4, :));
%     acc = [0, 0, 0];
%     phi = 0;
%     phi_d = 0;
% else
%     pos = [0, 0, 0];
%     vel = [0, 0, 0];
%     acc = [0, 0, 0];
%     phi = 0;
%     phi_d = 0;
% end

vect_t = vel / norm(vel);
vect_n = acc / norm(acc);
vect_b = cross(vect_t, vect_n);
vects = [vect_t; vect_n; vect_b];
end