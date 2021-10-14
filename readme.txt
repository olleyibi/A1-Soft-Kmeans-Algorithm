Implement the soft K-means algorithm for two Gaussians, each with 
a diagonal covariance matrix, and update the mean and responsibilities 
for each Gaussian


To find the appropriate diagonal covariance matrix, note that the 
simplest choice:

E = [1 0
     0 1]
is not a good choice because the data in old faithful.dat has a range of
3.5 along one dimension, and 53 along the other. The squared ratio of these
ranges is (53=3:5)2  229. The variance along each dimension of the data
should therefore maintain this ratio. A choice given by,

E = [0.1 0
      0  22.9]

is one possibility. Please feel free to experiment with other possibilities that
also maintain a ratio of sigma^r^2 = sigma^2 = 229.