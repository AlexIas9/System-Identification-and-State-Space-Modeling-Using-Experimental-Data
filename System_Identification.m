% ============================================================
% System Identification and State-Space Modeling Using Experimental Data
% ============================================================

% Date experimentale: timp (t), intrare (u), iesire (y)
t = system(:,1);
u = system(:,2);
y = system(:,3);

% Graficul datelor experimentale
figure;
plot(t, u, t, y);
title('Date experimentale');
legend('u = Intrare', 'y = Ieșire');
xlabel('Timp');
ylabel('Amplitudine');
hold on;

% Indicii necesari pentru calculul parametriilor
i1 = 217;
i2 = 214;
i3 = 206;
i4 = 209;

% Calculul factorului de proportionalitate K
K = mean(y(1:1000)) / mean(u(1:1000));

% Modulul de rezonanță
M_r = 1.4546;

% Factorul de amortizare
zeta = 0.3723;

% Calculul perioadei de rezonanta
i5 = 147;
i6 = 156;
Tr = (t(i6) - t(i5)) * 2; % perioada de rezonanta

% Pulsatia de rezonanta
wr = 2 * pi / Tr;

% Pulsatia naturala
Wn = wr / sqrt(1 - 2 * zeta^2);

% ============================================================
% Modelarea sistemului în spațiul stărilor
% ============================================================
A = [0, 1; 
    -Wn^2, -2*zeta*Wn];
B = [0; K*Wn^2];
C = [1, 0];
D = [0];

% Sistemul de stări
sys = ss(A, B, C, D);

% Simularea răspunsului sistemului
ysim = lsim(sys, u, t, [y(1), (y(2) - y(1)) / (t(2) - t(1))]);
plot(t, ysim, 'g');
hold on;

% Calculul erorilor
J = 1 / sqrt(length(y)) * norm(y - ysim);
empn = norm(y - ysim) / norm(y - mean(y)) * 100; % eroarea medie patratica normalizata

% ============================================================
% Modelul în funcție de transfer și analiza Bode
% ============================================================
H = tf(K * Wn^2, [1, 2*zeta*Wn, Wn^2]);
figure;
bode(H);

% ============================================================
% Testul de autocorelatie - Metoda ARMAX și n4sid
% ============================================================
Te = t(2) - t(1); % perioada de esantionare
date = iddata(y, u, Te);

% n4sid
Hn4sid = n4sid(date, 1:15);
figure;
compare(date, Hn4sid);
title('n4sid');
legend('Date observate', 'n4sid');

figure;
resid(date, Hn4sid);
title('n4sid Reziduuri');
legend('Reziduuri');

% ARMAX
Harmax = armax(date, [2, 1, 1, 1]);
figure;
compare(date, Harmax);
title('ARMAX');
legend('Date observate', 'ARMAX');

figure;
resid(date, Harmax);
title('ARMAX Reziduuri');
legend('Reziduuri');

% Functia de transfer pentru modelul ARMAX
H = tf(Harmax);
Hc = d2c(H, 'zoh');

minreal(Hc)
zpk(Hc)

% ============================================================
% Estimare folosind metoda PEM
% ============================================================
Hpem = pem(date, Harmax);
figure;
compare(date, Hpem);
title('ARMAX - PEM');
legend('Date observate', 'ARMAX');

figure;
resid(date, Hpem);
title('ARMAX - PEM Reziduuri');
legend('Reziduuri');

% ============================================================
% Testul de intercorelatie - Metoda IV4
% ============================================================
Hiv4 = iv4(date, [2, 1, 1]);
figure;
compare(date, Hiv4);
title('IV4');
legend('Date observate', 'IV4');

figure;
resid(date, Hiv4);
title('IV4 Reziduuri');
legend('Reziduuri');
