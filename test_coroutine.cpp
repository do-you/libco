//
// Created by zhou on 2017/4/26.
//

#include "co_routine.h"
#include <stdio.h>

stCoRoutine_t *routine1 = NULL;

void *f1(void *arg)
{
    int a = 1;
    double b = 1.2;
    printf("%p--%d--%lf\n", arg, ++a, b);
    co_yield_ct();
    printf("%p--%d--%lf\n", arg, ++a, b);

}

int main()
{
    co_create(&routine1, NULL, f1, (void *) 10);
    co_resume(routine1);
    co_resume(routine1);
    return 0;
}