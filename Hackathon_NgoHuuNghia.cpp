#include<stdio.h>
#include<stdlib.h>
#define MAX 100
	
typedef struct {
    int array[MAX];       
    int top;
} Stack;

void inital(Stack* stack){
	stack->top = -1;
}
int isFull(Stack* stack){
	if(stack->top >= MAX - 1){
		return 1;
	}
	return 0;
};
int isEmpty(Stack* stack) {
	if(stack->top == -1){
		printf("Ngan xep rong");
		return 1;
		}
		printf("Ngan xep co phan tu");
		return 0; 
}
void push(Stack* stack,int value){
	if(isFull(stack) == 1){
		printf("Ngan xep day, khong the them vao");
		return;
	}
	stack->array[++(stack->top)] = value;
}
int pop(Stack* stack) {
    if (stack->top == -1) {
        printf("Ngan xep rong\n");
        return -1; 
    }
    return stack->array[(stack->top)--];  
}
void display(Stack* stack) {
    if (stack->top == -1) {
    	printf("Ngan xep rong");
        return;
    }
    printf("Ngan xep \n");
    for (int i = stack->top; i >= 0; i--) {
        printf("%d\n", stack->array[i]);
    }
}
int peek(Stack* stack){
	if(stack->top == -1){
		printf("Ngan xep rong");
		return 1;
	}else{
		return stack->array[stack->top];
	}
} 
int size(Stack* stack) {
    return stack->top + 1; 
}
void clear(Stack* stack) {
    stack->top = -1; 
}

void reverse(Stack* stack) {
    if (stack->top == -1) {
        printf("Ngan xep rong\n");
        return;
    }
    Stack tempStack;
    inital(&tempStack);
    while (stack->top != -1) {
        push(&tempStack, pop(stack));
    }
    display(&tempStack);
}
int main(){
	int value;
	Stack stack;
	inital(&stack);
	do{
		printf("\n===================MENU==================\n");
		printf("1. Them phan tu vao phan xep (push)\n");
		printf("2. Lay phan tu khoi ngan xep (pop)\n");
		printf("3. Kiem tra phan tu tren cung ngan xep (peek/top)\n");
		printf("4. Kiem tra ngan xep co rong khong (isEmpty)\n");
		printf("5. Lay kick thuoc ngan xep (size)\n");
		printf("6. In toan bo ngan xep (display)\n");
		printf("7. Xoa toan bo ngan xep (clear)\n");
		printf("8. In cac phan tu theo thu tu nguoc lai (reverse)\n");
		printf("9. Thoat\n");
		printf("Vui long chon tu 1 - 9: ");
		int choice;
		scanf("%d",&choice);
		switch(choice){
			case 1:
				printf("Nhap vao gia tri can them: ");
				scanf("%d",&value);
				push(&stack,value);
				break;
			case 2:
				pop(&stack);
				break;
			case 3:
				int top;
				top = peek(&stack);
				printf("%d",&top);
				break;
			case 4:
				isEmpty(&stack);
				break;
			case 5:
				int sizeStack;
				sizeStack = size(&stack);
				printf("Kich thuoc ngan xep: %d",&sizeStack);
				break;
			case 6:
				display(&stack);
				break;
			case 7:
				clear(&stack);
				break;
			case 8:
				reverse(&stack);
				break;
			case 9:
				exit(0);
			default:
				printf("Vui long chon lai: ");
		}
	}while(1 == 1);
	
	return 0;
}

