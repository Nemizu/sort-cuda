#include <stdio.h>

bool check_array(int* ary,int elements){
    for(int loop = 0;loop < elements-2;loop++){
		if(ary[loop] > ary[loop+1]){
			printf("error| number of %d,", loop);
			exit(1);
            return false;
		}
	}
	return true;
}