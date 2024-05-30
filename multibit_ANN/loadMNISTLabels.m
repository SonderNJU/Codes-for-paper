function labels = loadMNISTLabels(filename,i)
%loadMNISTLabels returns a [number of MNIST images]x1 matrix containing
%the labels for the MNIST images
%example
%labels=loadMNISTLabels('C:\Users\cjwan\OneDrive\Important code\MNIST\MNIST data\train-labels-idx1-ubyte\train-labels-idx1-ubyte',100);


fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);
 
magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);
 
numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
 
labels = fread(fp, inf, 'unsigned char');
if nargin==1;
    i=numLabels;
end
 labels=labels(1:i);
%assert(size(labels,1) == numLabels, 'Mismatch in label count');
 
fclose(fp);
