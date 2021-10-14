clc
clear all
close all


data = dlmread('old_faithful.dat','\t',26,0);
data = data(:,2:3);


centroid = [randperm(floor(max(data(:,1))),2)' randperm(floor(max(data(:,2))),2)'];
h1 = scatter(data(:, 1), data(:, 2),'cyan');axis square; box on
h2 = plot(centroid(:, 1), centroid(:, 2), 'ksq','markersize',10);
xlabel('eruption duration (min)'); ylabel('time to next eruption (min)')
hold on


for i=1:20
    pause(1)
    delete(h1);
    delete(h2);
    c_respp = centroid_c_respponsibility(data, centroid);
    h1 = scatter(data(:, 1), data(:, 2), 'cyan');axis square; box on; 
    h2 = plot(centroid(:, 1), centroid(:, 2), 'ksq','markersize',10);
    uistack(h1, 'bottom');
    centroid = data_assign(data, centroid, c_respp);
end
centroid



function c_resp=centroid_c_respponsibility(data, centroid)
[clust, ~] = size(centroid);
[num_points, ~] = size(data);
b = -1; % The beta value
c_resp = zeros(clust, num_points);

for i=1:clust
    c_resp(i, :) = exp(b*vecnorm((data-centroid(i, :))'));
end
c_resp = c_resp./sum(c_resp); % Column-wise normalisation
end


function centroidter=data_assign(data, centroid, c_respponsibility)
[clust, dim] = size(centroid);
[num_points, ~] = size(data);
centroidter = zeros(clust, dim);
total_c_resp = sum(c_respponsibility');
for i=1:clust
    centroid_new = zeros(1, dim);
    for j=1:num_points
        centroid_new = centroid_new + data(j, :).*c_respponsibility(i, j);
    end
    centroidter(i, :) = centroid_new./total_c_resp(1, i);
end
end