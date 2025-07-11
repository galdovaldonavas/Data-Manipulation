#EXERCISE ABOUT COMBINING ORDERED VECTORS, AND MAINTAINING THE ORDER. 

#Just for comparison, first we do the combination and ordering with the sort(function)

vector_a <- c(1, 3, 5, 7)
vector_b <- c(2, 4, 6, 8)

unio<- c(vector_a, vector_b)
union
sort(union)
sort( unio, decreasing= )


#NOW WE DO IT WITHOUT SORT FUCNTIONS.

# 1. We create objects for the length of the vectors
len1 <- length(vector_a)
len2<- length (vector_b)
len1
len2

# 2. We create an empty numeric vector (with 0) with a lenght as long as the combination of the two vectors we are dealing with

result<- numeric(len1+len2)
result

fac<-factor(3)
fac

# 3. I create reference points for each of the three vectors we will deal with: vector_a, vector_b, and result
p1<- 1
p2<- 1
pr<- 1

#4. We create the formula for the combination

while(p1<=len1 && p2<= len2){
  if(vector_a[p1]<= vector_b[p2]){result[pr]<-vector_a[p1]
  p1<-p1+1}
  else{
    result[pr]<- vector_b[p2]
       p2<-p2+1}
  pr<-pr+1
}
  
#5. añadir elementos restantes

#in case there are leftovers in vector_a, we add them

while (p1<= len1){
      result[pr]<- vector_a[p1]
      p1<-p1+1
      pr<-pr+1
      }
  
while (p2<= len2){
  result[pr]<- vector_b[p2]
  p2<-p2+1
  pr<-pr+1
}

result
  