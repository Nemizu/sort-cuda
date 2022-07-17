all:a.out

sortCuda.o:../src/sortCuda.cu
	nvcc -c ../src/sortCuda.cu -O3

initArray.o:../src/initArray.cu
	nvcc -c ../src/initArray.cu -O3

checkArray.o:../src/checkArray.cu
	nvcc -c ../src/checkArray.cu -O3

main.o:./main.cu
	nvcc -c ./main.cu -O3

a.out:main.o sortCuda.o initArray.o checkArray.o
	nvcc sortCuda.o main.o initArray.o checkArray.o -O3

clean:
	rm *.o *.out *.stats
