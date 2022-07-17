#include "../header/SortCuda.h"
#include <chrono>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#define TIMES 100
#define THREAD 100

int main(int argc, char **argv) {
    int elements = 10000;//number of arry elements
	int thread = 128;
	if(argc > 1){
		elements = atoi(argv[1]);
	}
	if(argc > 2){
		thread = atoi(argv[2]);
	}
	size_t size = elements *sizeof(int);
	float time = 0.0;
	int *h_ary, *d_ary,*d_resary;

	/*malloc of houst array*/
	if((h_ary = (int *)malloc(size)) == NULL) {
		fprintf(stderr, "Out of memory, exit.\n");
		exit(1);
	}

	/*init host array*/
	init_array(h_ary,elements,1);
	shuffle_array(h_ary,elements);

	/*malloc of device array*/	
	cudaMalloc((void **)&d_ary, size);
	cudaMalloc((void **)&d_resary, size);

	/*init device array*/
	cudaMemcpy(d_ary, h_ary, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_resary, h_ary, size, cudaMemcpyHostToDevice);

	/*precheck*/
	testsort<<<elements/thread+1,thread>>>(d_ary,d_resary,elements);
	cudaMemcpy(h_ary,d_resary, size, cudaMemcpyDeviceToHost);
	if(!check_array(h_ary,elements))exit(1);
	cudaMemcpy(h_ary,d_ary, size, cudaMemcpyDeviceToHost);
	
	auto start = std::chrono::system_clock::now();
	for(int loop = 0; loop < TIMES; loop++){
		testsort<<<elements/thread+1,thread>>>(d_ary,d_resary,elements);
		cudaDeviceSynchronize();
	}
	auto end = std::chrono::system_clock::now();
	time = (std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count());
	
	free(h_ary);
	cudaFree(d_ary);
	cudaFree(d_resary);

	printf("%f(ms)\n",time/TIMES/1000000);
	
	return 0;
}


