#ifndef DEVSTREAM
#define DEVSTREAM

void init_array(int*,int,int);
void shuffle_array(int*,int);
bool check_array(int*,int);
void bitonicsort(int*,int,int,int);
__global__ void bitonicsort_Dev(int*,int,int);
__global__ void testsort(int*,int*,int);
#endif

