#makefile para compilar o programa vector.c
CC = arm-linux-gnueabi-gcc
CFLAGS =  -static -O3 -mfloat-abi=softfp -march=armv7-a -mtune=cortex-a8 -mfpu=neon 
#Flag que define variável de preprocessamento para usarmos o código otimizado
OPT= -Dopt

#lista de arquivos a serem compilados
OBJS= sha_driver.c sha.c
#flag que impede a autovetorização
NOVEC = -fno-tree-vectorize
#sem vetorização
OG= sha  
#auto vetorizado
AV= sha_av  
#optimizado usando biblioteca
OP= sha_opt 

make: $(OBJS)
# $^ faz referencia as dependencias da regra, neste caso $(OBJS)
#sem vetorização
	$(CC) $(CFLAGS)  $(NOVEC) $^ -o $(OG)
	
#auto vetorizado
	$(CC) $(CFLAGS)  $^ -o $(AV)
	
#optimizado usando biblioteca
	$(CC) $(CFLAGS)  $^ $(OPT) -o $(OP)
	
#use make clean para limpar os arquivos .o e executáveis
.PHONY : clean
clean:
	rm -rf $(OG) $(OP) $(AV) *.o
