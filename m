From: Olav Kongas <ok@artecdesign.ee>
Subject: N800: broken kernel signal handler restorer
Date: Fri, 2 Feb 2007 14:19:25 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0702021347310.7197@pcx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
