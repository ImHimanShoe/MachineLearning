#!/usr/bin/env Rscript
# your code must have this first line.

# Train code for logistic regression part goes here

args <- commandArgs(trailingOnly = TRUE)

file_name <- args[1]
modeltheta <- args[2]
file_name  = "H:/R workspace/assnmt2/files1/input2.csv";
modeltheta = "sol2.txt";
input <- read.table(file_name,header = FALSE,sep = ",")
mat <- as.matrix(input);
dimn = dim(mat)
m = dimn[1]
n = dimn[2]-1
y = mat[,n+1]
mat = mat[,-(n+1)]
x = t(t(mat));

##################create more feature here if want 
#for(j in 1:n){
#}
#dimn = dim(x)
#m = dimn[1]
#n = dimn[2]
#-----------------------------------------------------#

#calculating number of classes
max = 0;
for(i in y){
  if(i>max){
    max =i;
  }
}


#calculating til for all example 
til = matrix(1:max*m,m,max)
til[,] = 0;
h = NROW(y)
for(p in 1:h){
  yi = y[p]
  til[p,yi] = 1;
}
#initializing theta
classes = max;
feature = n
#count occurnce 






theta = matrix(1:max*n,classes,feature)
##########################7 rows x   54 column
theta[,] = 0;
theta2 = theta;
example = 1;
alpha = .000001;
for(a in 1:classes){
for(example in 1:3000)
{
  denom = 0
  num= 0;
  #seeme = 1:classes;
  #for(c in 1:classes){
   # seeme[c]  =t(theta[c,])%*%x[example,]
    #denom = denom + 2.72^(seeme[c])
  #}
    #seeme2 = t(theta[a,])%*%x[example,]; #can also be taken from the seeme[a]
    num = 2.72^(t(theta[a,])%*%x[example,])
    prob = num/1+num
    for(b in 1:feature){
      #b=b+1;
      gradient = x[example,b]*(til[example,a]-prob)
      theta2[a,b] = theta[a,b] + alpha*gradient;
    }
    theta = theta2;
  
  #theta3 = theta 
  theta = theta2;
  #example = example+1
}
}

write.table(theta, file.path(modeltheta), sep = ",", row.names = FALSE,col.names = FALSE,
            qmethod = "double",append = FALSE);





