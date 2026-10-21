% Demonstrate the pseudo-random number generators rand, randn and rng
% Generates 10,000 trial values from RAND (uniform on (0,1)) and from
% RANDN (standard normal: mean 0, standard deviation 1) and plots their
% histograms, normalized to compare with the theoretical probability
% density functions. Then generates 2 sets of 5,000 trial values from
% RANDN, setting the same seed with RNG before each set, and checks
% whether the values repeat.

% Daniel Rodriguez, September 2026

%% Parameters
nTrials = 10000;        % Number of trial values for the histograms
nSetTrials = 5000;      % Number of trial values in each seeded set
seedVal = 67;           % Seed for the pseudo-random number generator

%% Generate trial values from rand and randn
uniformVals = rand(1, nTrials);     % Uniform on (0,1)
normalVals = randn(1, nTrials);     % Standard normal

%% Plot the histograms with the theoretical densities
figure;
subplot(2, 1, 1);
histogram(uniformVals, 'Normalization', 'pdf');
hold on;
plot([0, 1], [1, 1], 'r', 'LineWidth', 2);     % Uniform pdf = 1 on (0,1)
hold off;
xlabel('Value');
ylabel('Probability density');
title(['rand: ', num2str(nTrials), ' trial values']);
legend('Histogram', 'Uniform pdf');

subplot(2, 1, 2);
histogram(normalVals, 'Normalization', 'pdf');
hold on;
xVals = linspace(-4, 4, 200);
normalPdf = exp(-xVals.^2/2)/sqrt(2*pi);      % Standard normal pdf
plot(xVals, normalPdf, 'r', 'LineWidth', 2);
hold off;
xlabel('Value');
ylabel('Probability density');
title(['randn: ', num2str(nTrials), ' trial values']);
legend('Histogram', 'Normal pdf');

%% Generate 2 sets from randn with the same seed
rng(seedVal);                       % Set the seed
firstSet = randn(1, nSetTrials);
rng(seedVal);                       % Set the same seed again
secondSet = randn(1, nSetTrials);

% A third set without resetting the seed, for comparison
thirdSet = randn(1, nSetTrials);

%% Compare the sets
disp(['Same seed: sets identical? ', ...
      mat2str(isequal(firstSet, secondSet))]);
disp(['Same seed: max |difference| = ', ...
      num2str(max(abs(firstSet - secondSet)))]);
disp(['Seed not reset: sets identical? ', ...
      mat2str(isequal(firstSet, thirdSet))]);
disp('First 5 values of each set:');
disp(['  Set 1: ', num2str(firstSet(1:5), '%9.4f')]);
disp(['  Set 2: ', num2str(secondSet(1:5), '%9.4f')]);
disp(['  Set 3: ', num2str(thirdSet(1:5), '%9.4f')]);

%% Plot the sets against each other
figure;
subplot(1, 2, 1);
plot(firstSet, secondSet, '.');
xlabel('Set 1 values');
ylabel('Set 2 values');
title('Same seed: points on the line y = x');
axis equal;

subplot(1, 2, 2);
plot(firstSet, thirdSet, '.');
xlabel('Set 1 values');
ylabel('Set 3 values');
title('Seed not reset: no relation');
axis equal;
