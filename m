From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/14] ARM: OMAP1: Timer32K: Fix timer32K for
	clockevents and clean it up, take #2
Date: Tue, 25 Mar 2008 12:09:41 +0200
Message-ID: <20080325100940.GQ14978@atomide.com>
References: <1205746958-11242-7-git-send-email-tony@atomide.com> <1205746958-11242-8-git-send-email-tony@atomide.com> <1205746958-11242-9-git-send-email-tony@atomide.com> <1205746958-11242-10-git-send-email-tony@atomide.com> <1205746958-11242-11-git-send-email-tony@atomide.com> <1205746958-11242-12-git-send-email-tony@atomide.com> <1205746958-11242-13-git-send-email-tony@atomide.com> <20080320165243.GD16166@flint.arm.linux.org.uk> <87y78dntfz.fsf@paris.hilman.org> <20080321120425.GA3732@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="924gEkU1VlJlwnwX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56385 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbYCYKK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 06:10:29 -0400
Content-Disposition: inline
In-Reply-To: <20080321120425.GA3732@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@mvista.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080321 14:05]:
> On Thu, Mar 20, 2008 at 11:25:52AM -0700, Kevin Hilman wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > On Mon, Mar 17, 2008 at 11:42:36AM +0200, Tony Lindgren wrote:
> > >> This patch fixes timer32k for clockevents and syncs it with
> > >> linux-omap tree.
> > >> 
> > >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >> ---
> > >>  arch/arm/mach-omap1/timer32k.c |   20 ++++++++++++++------
> > >>  1 files changed, 14 insertions(+), 6 deletions(-)
> > >> 
> > >>...
> > >> @@ -126,9 +131,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
> > >>  
> > >>  	switch (mode) {
> > >>  	case CLOCK_EVT_MODE_PERIODIC:
> > >> +	case CLOCK_EVT_MODE_ONESHOT:
> > >>  		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
> > >>  		break;
> > >> -	case CLOCK_EVT_MODE_ONESHOT:
> > >
> > > I didn't think an event was supposed to be programmed to fire when one
> > > shot mode is selected - from the other implementations, it appears that
> > > the timer should be disabled until set_next_event() has been called.
> > 
> > That is correct.  The 'start' should only be happening for the
> > periodic mode.  This following change should be done.
> 
> Or just omit the bogus change from the original patch.

OK, here's the fixed patch.

Tony

--924gEkU1VlJlwnwX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-timer32k-clockevent.patch"

>From c23b8d7f1a25aea1452a0d94799c62bba154edfc Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 13 Mar 2008 08:47:21 +0200
Subject: [PATCH] ARM: OMAP1: Timer32K: Fix timer32K for clockevents and clean it up

This patch fixes timer32k for clockevents and syncs it with
linux-omap tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 1f7365f..fbbdb80 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/plat-omap/timer32k.c
+ * linux/arch/arm/mach-omap1/timer32k.c
  *
  * OMAP 32K Timer
  *
@@ -40,7 +40,6 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
-
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clocksource.h>
@@ -71,8 +70,6 @@ struct sys_timer omap_timer;
 
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
 #else
 #error OMAP 32KHz timer does not currently work on 15XX!
 #endif
@@ -119,6 +116,14 @@ static inline void omap_32k_timer_stop(void)
 
 #define omap_32k_timer_ack_irq()
 
+static int omap_32k_timer_set_next_event(unsigned long delta,
+					 struct clock_event_device *dev)
+{
+	omap_32k_timer_start(delta);
+
+	return 0;
+}
+
 static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 				    struct clock_event_device *evt)
 {
@@ -139,8 +144,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 
 static struct clock_event_device clockevent_32k_timer = {
 	.name		= "32k-timer",
-	.features       = CLOCK_EVT_FEAT_PERIODIC,
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
+	.set_next_event	= omap_32k_timer_set_next_event,
 	.set_mode	= omap_32k_timer_set_mode,
 };
 
@@ -171,6 +177,8 @@ static struct irqaction omap_32k_timer_irq = {
 
 static __init void omap_init_32k_timer(void)
 {
+	setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
+
 	clockevent_32k_timer.mult = div_sc(OMAP_32K_TICKS_PER_SEC,
 					   NSEC_PER_SEC,
 					   clockevent_32k_timer.shift);

--924gEkU1VlJlwnwX--
