From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2: drop redundant pending write check for
 gptimer
Date: Thu, 11 Dec 2008 15:14:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812111431350.26754@utopia.booyaka.com>
References: <20081205023737.3868.78857.stgit@localhost> <20081205024121.3868.18876.stgit@localhost> <20081207112511.GB1646@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D05AD4C@dlee02.ent.ti.com>
 <20081207170624.GA17640@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43828 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758817AbYLKWOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 17:14:48 -0500
In-Reply-To: <20081207170624.GA17640@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tglx@linutronix.de
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, akpm@linuxfoundation.org, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Thomas,

On Sun, 7 Dec 2008, Russell King - ARM Linux wrote:

> On Sun, Dec 07, 2008 at 08:55:54AM -0600, Woodruff, Richard wrote:
> > Yes, NOHZ is _poor_ today in respect to needless reprogramming. Code can
> > be improved. I have sent Thomas a patch for the same which is in the MM
> > tree for a while now.
> 
> When I discussed this problem with Thomas, his reaction was rather
> negative due to there being conflicting requirements between this and
> ia64.

Could you comment further on the problems with this patch from Richard 
Woodruff, linked at [1]?  Looks like you had some comments which were not 
addressed, so, the patch at the bottom of this message reimplements 
Richard's original patch to try to take those into account.  Does this 
updated patch address your concerns?  Implementing something like this 
is a major win for OMAP and probably other platforms also.

...

1. http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.28-rc2/2.6.28-rc2-mm1/broken-out/tick-schedc-suppress-needless-timer-reprogramming.patch


- Paul


[PATCH] Suppress needless timer reprogramming (version 2)

<paul@pwsan.com>: patch reimplemented to respond to tglx comments from 
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.28-rc2/2.6.28-rc2-mm1/broken-out/tick-schedc-
This new patch has not been tested to determine whether it works as well 
as the original patch, will try to get Richard to confirm this.

...

From: "Woodruff, Richard" <r-woodruff2@ti.com>

In my device I get many interrupts from a high speed USB device in a very
short period of time.  The system spends a lot of time reprogramming the
hardware timer which is in a slower timing domain as compared to the CPU.
This results in the CPU spending a huge amount of time waiting for the
timer posting to be done.  All of this reprogramming is useless as the
wake up time has not changed.

As measured using ETM trace this drops my reprogramming penalty from
almost 60% CPU load down to 15% during high interrupt rate.  I can send
traces to show this.

Suppress setting of duplicate timer event when timer already stopped.
Timer programming can be very costly and can result in long cpu stall/wait
times.

---
 kernel/time/tick-sched.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 342fc9c..0255cb1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -346,8 +346,18 @@ void tick_nohz_stop_sched_tick(int inidle)
 			/* Check, if the timer was already in the past */
 			if (hrtimer_active(&ts->sched_timer))
 				goto out;
-		} else if (!tick_program_event(expires, 0))
-				goto out;
+		} else if (ktime_equal(expires, dev->next_event)) {
+			/*
+			 * No point in reprogramming the timer, since
+			 * we'd be reprogramming it with the same
+			 * expiration.  [On some platforms (e.g., OMAP)
+			 * timer reprogramming is costly.]
+			 */
+			goto out;
+		} else if (!tick_program_event(expires, 0)) {
+			goto out;
+		}
+
 		/*
 		 * We are past the event already. So we crossed a
 		 * jiffie boundary. Update jiffies and raise the
