function [f, g, H] = my_objective(x, A, b, c)

D = zeros(size(A, 1), 1);
for k = 1:size(A, 1)
    D(k) = -A(k,:)*x + b(k);
end

f = c.'* x - sum(log(D));

g = zeros(size(c, 1), 1);
for i = 1:size(c, 1)
    g(i) = c(i) + sum(A(:,i) ./ D);
end

H(1,1) = sum(A(:,1).^2 ./ (D.^2));
H(2,2) = sum(A(:,2).^2 ./ (D.^2));
H(1,2) = sum((A(:,1).*A(:,2)) ./ (D.^2));
H(2,1) = H(1,2);

end



