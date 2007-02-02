From: Olav Kongas <ok@artecdesign.ee>
Subject: N800: broken kernel signal handler restorer (2)
Date: Fri, 2 Feb 2007 14:32:59 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0702021432080.7230@pcx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sorry, last time it went without the example code. Here it 
comes again.

----------

Hi,

N800, 2.6.18-omap1, built by Nokia. Briefly, the 
kernel-installed signal handler restorer code does not work 
with that kernel.

If using sigaction(2) to install signal handler, uClibc and 
I guess glibc install their own sa_restorer(). However, if 
to install the signal handler without providing userspace 
sa_restorer() then the kernel's signal handler restorer code 
should be used. Below is the test program that fails on N800 
if RELY_ON_USERSPACE_SA_RESTORER is undefined. In contrast, 
that program works fine on other ARM platforms with 
different kernels here, including a 2.4.x uclinux. 

On N800, without RELY_ON_USERSPACE_SA_RESTORER, the signal 
handler is requested to return to 0xffff0500 (that was the 
value in lr on entry to signal handler). However, when 
signal handler finishes and jumps there, the SIGILL on 
0xffff0508 follows.

Any ideas, is this problem specific to nokia kernel or omap 
kernels in general or am I just doing something wrong? 
Thanks in advance.

Olav

------------------- testcode -----------------------
/*
   I compiled it with: CFLAGS := -Wall -Os -static
*/

#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <asm/unistd.h>

/* For struct kernel_sigaction */
#include <bits/kernel_sigaction.h>

/* Comment out to trigger SIGILL on 2.6.18-omap1 on N800 */
#define RELY_ON_USERSPACE_SA_RESTORER


/* Replacement of sigaction(2) to work around automagic userspace 
   sa_restorer installation in popular libc's.

   Expected to compile with -Os to:
	swi	0x009000ae
	mov	pc, lr
*/
static int my_rt_sigaction(int signum, struct kernel_sigaction *act,
			struct kernel_sigaction *oldact, int len)
{
	register long r0 asm("r0") = (long) signum ;
	register long r1 asm("r1") = (long) act;
	register long r2 asm("r2") = (long) oldact;
	register long r3 asm("r3") = (long) len;

	asm volatile(
			"swi	%1\n\t"
			: "=&r"(r0)
			: "i" (__NR_rt_sigaction),
			"0"(r0), "r"(r1), "r"(r2), "r"(r3)
                        : "memory");
	return (int) r0;
}


#ifdef RELY_ON_USERSPACE_SA_RESTORER

#define SA_RESTORER 0x04000000

/* Expected to compile with -Os to:
	swi	0x00900077
	mov	pc, lr
*/
static void my_sa_restorer(void)
{
	asm volatile ("swi	%0\n\t" :: "i" (__NR_sigreturn));
}

#endif /* RELY_ON_USERSPACE_SA_RESTORER */


static void sigchld_handler(int sig __attribute__((unused)))
{
	printf("%s: hello\n",__func__);
}


int main()
{
	int rc;
	struct kernel_sigaction kact;

	/* Install SIGCHLD handler */
	kact.k_sa_handler = sigchld_handler;
	kact.sa_flags = 0;
	sigemptyset(&kact.sa_mask);
#ifdef RELY_ON_USERSPACE_SA_RESTORER
	kact.sa_restorer = my_sa_restorer;
	kact.sa_flags |= SA_RESTORER;
	printf("Userspace sa_restorer\n");
#else
	printf("Kernel sa_restorer\n");
#endif

	/* Install signal handler */
	rc = my_rt_sigaction(SIGCHLD, & kact, 0, _NSIG / 8);
	if(rc == -1) {
		printf("%s: __my_rt_sigaction() failed\n",__func__);
		return 1;
	}

	/* Signal ourselves. If the kernel's signal restorer code
	   is borked AND we didn't provide our own sa_restorer,
	   we'll get SIGILL */
	kill(getpid(), SIGCHLD);

	return 0;
}
