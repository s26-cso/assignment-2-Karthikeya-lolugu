#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<dlfcn.h>
int main(){
    char op[10];
    int a,b;
    while(scanf("%s %d %d",op,&a,&b) != EOF){
        char lib[25];
        snprintf(lib,sizeof(lib),"./lib%s.so",op);
        void* open=dlopen(lib,RTLD_NOW);
        if(!open) continue;
        int (*operation)(int,int);
        operation=(int(*)(int,int))dlsym(open,op);
        printf("%d\n",operation(a,b));
        dlclose(open);
    }
    return 0;
}