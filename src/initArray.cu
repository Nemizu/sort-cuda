#include<stdlib.h>

void init_array(int* ary,int elements,int step){
    for(int i=0;i<elements;i+=step){
        ary[i] = i; 
    }
	return;
}

void shuffle_array(int* ary,int elements){
	//rundom
    for(int i=0;i<elements;i++){
        int r = rand()%elements;
        int tmp = ary[i];
        ary[i] = ary[r];
        ary[r] = tmp; 
    }
	return;
}