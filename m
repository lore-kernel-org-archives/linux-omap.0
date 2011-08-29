From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Issue with clock_gettime / clock_nanosleep APIs with high resolution
 timer on panda board
Date: Mon, 29 Aug 2011 13:12:36 -0500
Message-ID: <CAFQPvXcv=X0tNGPqB6srYup6EdhTKbw4jrkW3CVNx4pbZrC9GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43369 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab1H2SMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 14:12:37 -0400
Received: by vxi9 with SMTP id 9so4443495vxi.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:12:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hemant Pedanekar <hemantp@ti.com>

Hello everyone,

Greetings. I have tried the following kernels and found "the problem"
to occur on all of them with high resolution timer enabled

(1) mainline stable 3.0.1 kernel but with Hemant Pedanekar's patch
(http://www.spinics.net/lists/linux-omap/msg50742.html) and by
disabling 32KHz Timer ("System Type -> TI OMAP Common Features ->  Use
32KHz timer")
(2) Same as (1) with RT patch (3.0.1-rt11)
(3) OMAP kernel version v3.1-rc2 (
http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
)

Problem:
*********
On panda baord, I ran the v0.74 of cyclictest
(git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git)
to measure the latency (./cyclictest -l4000000000 -m -S -p99 -i70 -h60
-q -n). These arguments make the test to use TIMER_ABSTIME for
clock_nanosleep and CPU affinity (using sched_setaffinity) for the 2
threads to be set to each CPU.  It is expected to see large latencies
without the RT patch. However, when I ran the tests overnight, I
observed maximum latency of 4294967103 us (weird but it is close to
unsigned int max). So, I instrumented the test to print some
additional information and exit as soon as it finds such a weird
latency. I was also trying to stress ethernet/network/interrupts of
the system with SFTP but I think (not very sure) I could reproduce the
issue without that. clock_nanosleep was called to sleep until
27608:739311172 (sec:nsec), but after clock_nanosleep returned,
clock_gettime returned the time as 27608:739117429 (sec:nsec) which is
roughly 193 usec earlier than the value passed to clock_nanosleep and
that is the bug. I ran the test with just one thread ( remove "-S" and
add "-t1 -a1 -n" ) and saw the weird latency of 4294967294 usec.

Questions
*************
(1) Is this a known bug? If so, do we already have a fix?
(2) Does anyone have suggestions for narrowing this down further
(timer driver issue vs scheduler/kernel issue)?
(3) I am not too familiar with OMAP and Linux kernel. Which timer gets
used when I use high-resolution timer and disable the 32 KHz timer? Is
it part of "MP core"? Is this timer per CPU? Pointers to source code
for the high-res timer driver?
(4) If the timer is per CPU, are they synchronized in the hardware?
(5) In the same process/task, if a thread (created with
pthread_create) is assigned CPU affinity to a particular core
(sched_setaffinity), is it a soft-request to the scheduler or is it
guaranteed that the thread will not be scheduled on other CPUs at
all?The reason I am asking this is to rule out the possibility of the
thread jumping to different CPU and the timers are off by quite a bit
for different CPUs.
(6) Is it ok to call sched_setaffinity with the first argument 0 to
set a the affinity for a particular pthread in the process? Or, should
the value returned by gettid() should be passed instead?
(7) Should I post it to any other mailing list also?

Thanks,
Sankara
