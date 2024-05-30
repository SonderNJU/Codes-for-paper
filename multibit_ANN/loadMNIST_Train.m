function [images,labels]=loadMNIST_Train(N);

images=loadMNISTImages('E:\multibit_ANN\train-images-idx3-ubyte\train-images.idx3-ubyte',N);
labels=loadMNISTLabels('E:\multibit_ANN\train-labels-idx1-ubyte\train-labels.idx1-ubyte',N);

end
