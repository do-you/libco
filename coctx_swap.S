/*
* Tencent is pleased to support the open source community by making Libco available.

* Copyright (C) 2014 THL A29 Limited, a Tencent company. All rights reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License"); 
* you may not use this file except in compliance with the License. 
* You may obtain a copy of the License at
*
*	http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, 
* software distributed under the License is distributed on an "AS IS" BASIS, 
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
* See the License for the specific language governing permissions and 
* limitations under the License.
*/

.globl coctx_swap
#if !defined( __APPLE__ )
#.type  coctx_swap, @function
#endif
coctx_swap:

#if defined(__i386__)
	leal 4(%esp), %eax //sp 
	movl 4(%esp), %esp 
	leal 32(%esp), %esp //parm a : &regs[7] + sizeof(void*)

	pushl %eax //esp ->parm a 

	pushl %ebp
	pushl %esi
	pushl %edi
	pushl %edx
	pushl %ecx
	pushl %ebx
	pushl -4(%eax)

	
	movl 4(%eax), %esp //parm b -> &regs[0]

	popl %eax  //ret func addr
	popl %ebx  
	popl %ecx
	popl %edx
	popl %edi
	popl %esi
	popl %ebp
	popl %esp
	pushl %eax //set ret func addr

	xorl %eax, %eax
	ret

#elif defined(__x86_64__)
	leaq 8(%rsp),%rax //令rax的值为call coctx_swap前rsp的值

#ifdef WIN32
    leaq 112(%rcx),%rsp//第一个参数的ss_size的地址
#else
	leaq 112(%rdi),%rsp//第一个参数的ss_size的地址
#endif
	pushq %rax//压入regs[13]
	pushq %rbx//压入regs[12]
	pushq %rcx//压入regs[11]
	pushq %rdx//压入regs[10]

	pushq -8(%rax) //ret func addr压入regs[9]

	pushq %rsi//压入regs[8]
	pushq %rdi//压入regs[7]
	pushq %rbp//压入regs[6]
	pushq %r8//压入regs[5]
	pushq %r9//压入regs[4]
	pushq %r12//压入regs[3]
	pushq %r13//压入regs[2]
	pushq %r14//压入regs[1]
	pushq %r15//压入regs[0]

#ifdef WIN32
    movq %rdx, %rsp//第二个参数的首地址,以下时依次取出
#else
    movq %rsi, %rsp//第二个参数的首地址,以下时依次取出
#endif
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %r9
	popq %r8
	popq %rbp
	popq %rdi
	popq %rsi
	popq %rax //ret func addr
	popq %rdx
	popq %rcx
	popq %rbx
	popq %rsp

	pushq %rax//
	
	xorl %eax, %eax
	ret
#endif
