__global__ void bitonicSort_Dev(int* ary,int i,int j){
    int id = blockIdx.x*blockDim.x + threadIdx.x;
    int ip = id^i;

    if(ip>id){
        if((id&j)==0){
            if(ary[id]>ary[ip]){
                int tmp = ary[id];
                ary[id] = ary[ip];
                ary[ip] = tmp;
            }
        }
        if((id&j)!=0){
            if(ary[id]<ary[ip]){
                int tmp = ary[id];
                ary[id] = ary[ip];
                ary[ip] = tmp;
            }
        }
    }
}

void bitonicsort(int* d_ary,int elements,int block,int thread){
    
    for(int i = 2; i <= elements; elements *= 2){
        for (int j = i / 2; j > 0; j /= 2){
            bitonicSort_Dev<<<block,thread>>>(d_ary,i,j);
            cudaDeviceSynchronize();
        }
    }

}

__global__ void testsort(int* ary,int* resary,int elements){
    int id = threadIdx.x + blockDim.x * blockIdx.x;
    if(id < elements){
        int number = 0;
        for(int i = 1;i<elements;i++){
            if(ary[id]>ary[i]){
                number++;
            }
        }
        resary[number] = ary[id];
    }
    
}





/*__global__ void bitonicsort(int* ary,int elements){
    int id = blockIdx.x*blockDim.x + threadIdx.x;
    //sorting
    for(int length = 2; length <= elements; length *= 2){
        for (int mlength = length / 2; mlength > 0; mlength /= 2){
            int ixj = id ^ mlength;
            
			if (ixj > id) {
				int	tmp;
                if ((id & length) == 0) {
                    if (ary[id] > ary[ixj]) {
						tmp = ary[ixj];
						ary[ixj] = ary[id];
						ary[id] = tmp;
                    }
                } else {
                    if (ary[id] < ary[ixj]) {
                        tmp = ary[ixj];
						ary[ixj] = ary[id];
						ary[id] = tmp;
                    }
                }
            }
            __threadfence();
            __syncthreads();
        }
    }
    return;
}
*/