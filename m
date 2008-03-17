From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/14] ARM: OMAP1: Timer32K: Fix timer32K for clockevents and clean it up
Date: Mon, 17 Mar 2008 11:42:36 +0200
Message-ID: <1205746958-11242-13-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
 <1205746958-11242-6-git-send-email-tony@atomide.com>
 <1205746958-11242-7-git-send-email-tony@atomide.com>
 <1205746958-11242-8-git-send-email-tony@atomide.com>
 <1205746958-11242-9-git-send-email-tony@atomide.com>
 <1205746958-11242-10-git-send-email-tony@atomide.com>
 <1205746958-11242-11-git-send-email-tony@atomide.com>
 <1205746958-11242-12-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64693 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYCQJnt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:49 -0400
In-Reply-To: <1205746958-11242-12-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This patch fixes timer32k for clockevents and syncs it with
linux-omap tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/timer32k.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 1f7365f..c4af39a 100644
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
@@ -126,9 +131,9 @@ static void omap_32k_timer_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
+	case CLOCK_EVT_MODE_ONESHOT:
 		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
 		break;
-	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		break;
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
-- 
1.5.3.6

