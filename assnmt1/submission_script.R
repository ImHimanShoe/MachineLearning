
#sometimes giving out of bound exception
#
#"F:/7th semester/COL341 Rahul garg/input/input.txt"
#test <- read.table("F:/7th semester/COL341 Rahul garg/input/input.txt",header = FALSE,sep = ",")
#file_name  = "F:/7th semester/COL341 Rahul garg/assignments/ass1/inputs/input.txt"
args <- commandArgs(trailingOnly = TRUE)
file_name <- args[1]
file_name  = "F:/7th semester/COL341 Rahul garg/assignments/ass1/inputs/inputsmall1.txt";
test <- read.table(file_name,header = FALSE,sep = ",")
mat <- as.matrix(test);
#mat =  matrix(c(3, 4,4, 5, 5, 6,6,7,7,8), nrow=2, ncol=5)
dimns1 = dim(mat)
y = mat[,dimns1[2]]  #for the ax=b equation

#mat = mat[,-dimns1[2]]
#mat = mat[-501,];
#y = y [-501];
#y = t(y);
#mat = t(mat);  #transpose to make coumn vector as row
dimns = dim(mat)  
lead = 1;
thres = .000001;
rowCount = dimns[2]-1
colCount = dimns[1];#remove -1 after it is due to y 
i = 1 #edit this
quit = FALSE
row =1;
m2 = mat;
m2 = m2[,-dimns[2]]; #removing the y
m2 = t(m2);  #this whie specific 
#--------------------------------------------------------------------
while(row <= rowCount && !quit)
{  #+1 because we have to process last one as well 
  if(colCount+1<= lead)
  {
    quit = TRUE
    break
  }
  
  i=row
  
  #finding the row with element at lead position is non zero to transfer it up.
  while(! quit && (m2[i,lead] < thres) && (m2[i,lead] > -1*thres) )
  {
    # this is just for resetting the row when starting to search in next column for leading non-zero
    #element
    #this will increase the row number if zero
    #below only if it is the last row than increase the column not row 
    if(rowCount < i+1)
    {
      #resetting the row to start over this time for new lead
      i=row;
      lead = lead+1;
      
      if(colCount+1 <= lead)
      {
        quit = TRUE;
        break;
      }
    }else {
      i = i+1;
    }
  }
  
  if(!quit)
  {
    #swaping
    temp = m2[i,];
    tempy = y[i];
    
    m2[i,] = m2[row,]
    m2[row,] = temp
    
    #swapRows(m, i, row);
    
    if(!((m2[row,lead] < thres) && (m2[row,lead] > -1*thres)) )
    {
      divider = m2[row,lead];
      m2[row,] = m2[row,]/divider;
    }  #  multiplyRow(m, row, 1.0f / m[row][lead]);
    i = 1
    while( i <= rowCount)
    {
      if(i != row)
        
      {  
        subtract = m2[i,lead];
        m2[i,] = m2[i,] - subtract*m2[row,]
        }#subtractRows(m, m[i][lead], row, i);
      i = i+1
    }
  }
  row = row+1;
}

final3 = m2[rowSums(m2^2)>thres,] #only those row which are positive and sum is greater than some positive number
final4 = t(final3);

#<-------------------------------------------------------------->
#resetting all the parameter
lead = 1;
rowCount = dimns[1]
colCount = dimns[2]-1;#remove -1 after it is due to y 
i = 1 #edit this
quit = FALSE
row =1;
m = mat;
while(row <= rowCount && !quit)
{  #+1 because we have to process last one as well 
  if(colCount+1<= lead)
  {
    quit = TRUE
    break
  }
  
  i=row
  
  #finding the row with element at lead position is non zero to transfer it up.
  while(! quit && (m[i,lead] < thres) && (m[i,lead] > -1*thres) )
  {
    # this is just for resetting the row when starting to search in next column for leading non-zero
    #element
    #this will increase the row number if zero
    #below only if it is the last row than increase the column not row 
    if(rowCount < i+1)
    {
      #resetting the row to start over this time for new lead
      i=row;
      lead = lead+1;
      
      if(colCount+1 <= lead)
      {
        quit = TRUE;
        break;
      }
    }else {
      i = i+1;
    }
  }
  
  if(!quit)
  {
    #swaping
    temp = m[i,];
    tempy = y[i];
  
    m[i,] = m[row,]
    m[row,] = temp
    
    y[i] = y[row];
    y[row] = tempy;
    #swapRows(m, i, row);
    
    if(!((m[row,lead] < thres) && (m[row,lead] > -1*thres)) )
    {
      divider = m[row,lead];
      m[row,] = m[row,]/divider;
      y[row] = y[row]/divider;
      
    }  #  multiplyRow(m, row, 1.0f / m[row][lead]);
    i = 1
    while( i <= rowCount)
    {
      if(i != row)
        
      {  
        subtract = m[i,lead];
        m[i,] = m[i,] - subtract*m[row,]
         y[i] = y[i] - subtract*y[row];
      }#subtractRows(m, m[i][lead], row, i);
      i = i+1
    }
  }
  row = row+1;
}
#<-------------------------------------------------->

y2 = m[,dimns1[2]]  #for the ax=b equation
count =0;
m = m[,-dimns[2]]; #removing the y
final = m[rowSums(m^2)>thres,] #only those row which are positive and sum is greater than some positive number
lol = dim(final);
lol[1] = lol[1]+1;
#means solution has space not unique solution have to check consistency here 
if(lol[1]<lol[2]){
  null = final[,lol[1]:lol[2]]; #to ignore the null rows
  
  max = dim(null);
  p = -1*max[1]-1;
  q = -1*length(y)-1;
  y = t(y)
  y4 = y[,-1:-lol[1]] #to judge consistency
  y = y[p:q];
  y = t(y);
  mediucre = c(1:(lol[2]-lol[1]+1)) 
  mediucre [1:(lol[2]-lol[1]+1)]= 0
  mediucre = t(mediucre)
  y = cbind(y,mediucre)
  consistent = sum(y4)<thres && sum(y4)>-1*thres
  demo2 = y;#for subtracting from the null matrix repeating y 
  for(lv in 2:max[2]){
    demo2 = rbind(demo2,y);
  }
  #p = -1*max[1]-1;
  #q = -1*dim(demo2)[2]-1;
  #demo2 = demo2[,p:q]
  demo3 = t(demo2) #converting to column space from row one 
  null = t(null)
  
  #solly = demo2-null; #for third part
  null = -1*null;  #for second part
  
  crntdim = dim(null);
  temp = lol[2]-(lol[1]-1);#strength of the null space of a 
  tempmat = diag(temp);
  
  #just adding the total format....
  solly3 = 0;
  
  null2 = cbind(null,tempmat)
  null2 = t(null2)
  if(consistent){
    #   solly2 = cbind(solly,tempmat);
    solly3 = t(y)
    solly3 = cbind (solly3, demo3+ null2);  
    
  }
  #solly2 = t(solly2);
  final2 = t(final)
}else{
  null = 0;
  null2 = null;
  i = lol[2]+1;
  j = length(y2);
  tempry = y2[i:j];
  if(j>=i && sum(tempry)>0){
    solly3 = 0; #means no solution more constrain than variable
  } else{
    solly3 = y2[1:lol[2]]
    
  }
  
  
}
write.table(final4, file.path("out_1.txt"), sep = ",", row.names = FALSE,col.names = FALSE,
            qmethod = "double",append = FALSE);

write.table(null2, file.path("out_2.txt"), sep = ",", row.names = FALSE,col.names = FALSE,
            qmethod = "double",append = FALSE);

write.table(solly3, file.path("out_3.txt"), sep = ",", row.names = FALSE,col.names = FALSE,
            qmethod = "double",append = FALSE);

