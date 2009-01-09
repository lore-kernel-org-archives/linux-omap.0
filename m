From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH 0/1] OMAP gptimer based event monitor driver for oprofile
Date: Fri, 9 Jan 2009 17:11:21 +0200
Message-ID: <200901091711.21863.siarhei.siamashka@nokia.com>
References: <ESEBH1026QcqnWwAeRa000037d8@esebh102.NOE.Nokia.com> <13B9B4C6EF24D648824FF11BE8967162036D4E62EE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54095 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbZAIPQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 10:16:31 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D4E62EE@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, oprofile-list <oprofile-list@lists.sourceforge.net>

On Thursday 08 January 2009 22:19:02 ext Woodruff, Richard wrote:
> Hi,
>
> > Current revisions of Cortex-A8 core have a hardware bug in performance
> > monitoring unit, which makes it very unreliable in Oprofile.
> >
> > We discussed this problem offlist with Richard Woodruff some time ago and
> > he suggested to use GPTIMER to get better event samples collection
> > frequency, comparable to the one typically used with the hardware
> > performance counters. The use of GPTIMER instead of a standard oprofile
> > timer based backend makes the process of profiling applications less
> > painful and more precise.
>
> Cool.  This will help a lot.
>
> I did get some more information from ARM on core bug which is now in their
> official errata.  As a future enhancement it should be possible to use PMNC
> event counters as long as they do not overflow.  This might allow a GPT -
> PMNC hybrid.  The 32bit counters can run for a good amount before rolling.

Unfortunately the performance counters are hardly usable in oprofile with this
bug. The whole concept of oprofile is statistical sampling and each collected
sample involves a counter overflow and interrupt. If this functionality is
broken, not much can be done except not to use it.

The hybrid model where we use a periodic timer interrupt, but try to check HW
counter deltas between timer interrupts and apply some kind of correction will
not work.

Let's consider the following example: we have a tight loop which consists of
two parts A and B, which take equal amount of time, but part A generates some
number of X events, but part B does not generate them at all. If timer
interrupts are generated with a period much longer than loop iteration, we
can't see any difference between part A and B in the respect to event X at
all. These events will be completely blurred between both parts. In the case
of normal oprofile operation, the events would be collected properly (btw,
having a performance counter threshold as as a prime number may be a
good idea in order to avoid unwanted correlations and possible periodic
effects, I always wondered why oprofile default is set to 100000 cycles).

I also tried a hybrid approach with having some kind of "watchdog" using
gptimer, which periodically verifies the state of PMU and restores it to
proper operation if it gets broken. Unfortunately when profiling the code with
the heavy use of syscalls, PMU gets broken way too often (dozens of times
per second). In additions, this extra periodic timer interrupt also gets
sampled and shows up in the profile report as an extra "noise". One more
approach would be to add a mode to collect performance statistics for userland
only and have checks for PMU state on every location where control is
transferred to userland (exit from syscalls, interrupts, etc.). But it can be
too intrusive and adds runtime overhead which may be unacceptable.

Fortunately, the vast majority of application developers (but not all of them
of course) never use anything else than just the CPU cycle counter when
profiling. And even if they ever try to use the other hardware performance
counters, they often misinterpret the results :)

So just a high resolution timer is good enough for most uses. It is better to
have sample collection rate configurable. So that it can be set to quite a
high value if benchmarking some application startup for example. On the other
hand, on normal profiling it is better to have oprofile and sample collection
introduced overhead reasonable.

On the other hand, hardware performance counters of course still can be used
for other purposes, just not for oprofile.

BTW, this event monitor driver can be useful for OMAP1 devices, ARM cores from
which do not have any performance counters at all. So it is not just OMAP3
workaround for oprofile, but may have its own use.

I already mentioned power management and frequency scaling. We don't really
want to collect samples if the system is idle. Also it might be interesting to
have timer clock cycle rate proportional to the clock rate of the CPU. I also
tried to experiment with this stuff, but did not get any good results yet
(maybe I did some silly mistake in my tests). A help from some power
management guru can be probably useful.

I'm really not an expert in kernel development or OMAP hardware. I just want
to have a usable version of oprofile for OMAP3 in a reasonable timeframe.

> Additionally, the bug is greatly minimized in future stepping of CortexA8.
> It will be a while before that core goes into a production device.

Even if the effect is minimized, it is still too unreliable to be used :(

PS. I only observed the bug with CCNT myself, the other counters seemed to be
fine in my tests. But the preliminary report from ARM that I got earlier was
not so optimistic. Maybe I need to get and check an updated official errata
list now.

-- 
Best regards,
Siarhei Siamashka
