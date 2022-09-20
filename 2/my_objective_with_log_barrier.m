function [f, g, H] = my_objective_with_log_barrier(x, t)

P1 = [2 1;1 2]; P2 = [2 0;0 3]; P3 = [2 -1;-1 3];
y1 = [1;0];     y2 = [-1;2];    y3 = [-1;-2];    r1 = 0; r2 = 1; r3 = -1;

x_tilde = [x(1);x(2)];
f1 = 0.5 * (x_tilde - y1).' * P1 * (x_tilde - y1) + r1 - x(3);
f2 = 0.5 * (x_tilde - y2).' * P2 * (x_tilde - y2) + r2 - x(3);
f3 = 0.5 * (x_tilde - y3).' * P3 * (x_tilde - y3) + r3 - x(3);

f = t * x(3) - log(-f1) - log(-f2) - log(-f3);

g = zeros(3, 1);
g(1) = P1(1, :) * (x_tilde - y1) / (-f1) + P2(1, :) * (x_tilde - y2) / (-f2) + P3(1, :) * (x_tilde - y3) / (-f3);
g(2) = P1(2, :) * (x_tilde - y1) / (-f1) + P2(2, :) * (x_tilde - y2) / (-f2) + P3(2, :) * (x_tilde - y3) / (-f3);
g(3) = t + 1 / f1 + 1 / f2 + 1 / f3;

H = zeros(3, 3);
H(1,1) = (P1(1, :) * (x_tilde - y1))^2 / f1^2 + (P2(1, :) * (x_tilde - y2))^2 / f2^2 + (P3(1, :) * (x_tilde - y3))^2 / f3^2 ...
        + P1(1, 1) / (-f1) + P2(1, 1) / (-f2) + P3(1, 1) / (-f3);
H(2,2) = (P1(2, :) * (x_tilde - y1))^2 / f1^2 + (P2(2, :) * (x_tilde - y2))^2 / f2^2 + (P3(2, :) * (x_tilde - y3))^2 / f3^2 ...
        + P1(2, 2) / (-f1) + P2(2, 2) / (-f2) + P3(2, 2) / (-f3);
H(1,2) = ((P1(1, :) * (x_tilde - y1)) * (P1(2, :) * (x_tilde - y1))) / f1^2 + ...
         ((P2(1, :) * (x_tilde - y2)) * (P2(2, :) * (x_tilde - y2))) / f2^2 + ...
         ((P3(1, :) * (x_tilde - y3)) * (P3(2, :) * (x_tilde - y3))) / f3^2 + ...
         P1(1, 2) / (-f1) + P2(1, 2) / (-f2) + P3(1, 2) / (-f3);
H(1,3) = (-P1(1, :) * (x_tilde - y1)) / f1^2 - P2(1, :) * (x_tilde - y2) / f2^2 - P3(1, :) * (x_tilde - y3) / f3^2;
H(2,3) = (-P1(2, :) * (x_tilde - y1)) / f1^2 - P2(2, :) * (x_tilde - y2) / f2^2 - P3(2, :) * (x_tilde - y3) / f3^2;
H(2,1) = H(1,2);
H(3,1) = H(1,3);
H(3,2) = H(2,3);
H(3,3) = 1 / f1^2 + 1 / f2^2 + 1 / f3^2;    

end
    
 
