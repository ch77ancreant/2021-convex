clear;

A = [1 3;1 -3;-1 0];
b = [0.1;0.1;0.1];
c = [1;2];

cvx_begin
        variable x(2,1)
        minimize( c.'*x - sum_log(-A*x+b) )
cvx_end