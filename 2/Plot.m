clear; close all;


mt1 = [3, 0.1500, 0.0075, 3.75e-4, 1.875e-5, 9.375e-7, 4.6875e-8, 2.34375e-9];
l1 = [5, 11, 17, 23, 29, 35, 41, 47];

mt2 = [3, 0.0015, 7.5e-7, 3.75e-10];
l2 = [5, 15, 24, 34];

mt3 = [3, 1.5e-4, 7.5e-9, ];
l3 = [5, 18, 28];

stairs(l1, mt1, 'Linewidth', 1)
hold on
stairs(l2, mt2, 'Linewidth', 1)
stairs(l3, mt3, 'Linewidth', 1)
set(gca,'YScale','log')
xlabel('Newton iterations','interpreter','latex')
ylabel('$m/t$','interpreter','latex')
legend('$\mu=20$','$\mu=2000$','$\mu=20000$','interpreter','latex')
grid on

