clear
close all
clc
tic
%% uncomment in the case of new traning images
%% Load Image Information from Database Directory
ImageDatabasetrain = imageSet('data','recursive');

%% Extract skeleton descriptor for training set 
trainingFeatures=[];
featureCount = 1;
for i=1:size(ImageDatabasetrain,2)
    for j = 1:ImageDatabasetrain(i).Count
        trainingFeatures(featureCount,:) = boxcountbw(read(ImageDatabasetrain(i),j),0.3);
        trainingLabel{featureCount} = ImageDatabasetrain(i).Description;    
        featureCount = featureCount + 1;
    end
    personIndex{i} = ImageDatabasetrain(i).Description;
end

for pp=1:size(trainingFeatures,1)
    if strcmp(trainingLabel{pp},ImageDatabasetrain(1,1).Description  )
        lable(pp)=0;
    else
        lable(pp)=1;
    end
end
%% Just for neural network
label1(1,:)=lable;
for i=1:size(trainingFeatures,1)
   if lable(i)==0
       label1(2,i)=1;
   else
       label1(2,i)=0;
   end
end
tabl=[lable',trainingFeatures];
tabl=array2table(tabl);
nninput=trainingFeatures';
nntarget=label1;
% save fetureLableBoxcountbw trainingFeatures trainingLabel tabl lable nninput nntarget
out = myNeuralNetworkFunction(nninput,nntarget);
toc
