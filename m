From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] ARM: OMAP: TimerMPU: Remove unused cycles-to-nsec conversions
Date: Mon, 17 Mar 2008 11:42:37 +0200
Message-ID: <1205746958-11242-14-git-send-email-tony@atomide.com>
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
 <1205746958-11242-13-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62797 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbYCQJnw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:52 -0400
In-Reply-To: <1205746958-11242-13-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@mvista.com>

These are no longer used and similar conversions are provided
by the clocksource/clockevent code.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/time.c |   33 ---------------------------------
 1 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a4f8b20..f6cf2b7 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -56,37 +56,6 @@
 #define OMAP_MPU_TIMER_BASE		OMAP_MPU_TIMER1_BASE
 #define OMAP_MPU_TIMER_OFFSET		0x100
 
-/* cycles to nsec conversions taken from arch/i386/kernel/timers/timer_tsc.c,
- * converted to use kHz by Kevin Hilman */
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_khz * 10^3))
- *		ns = cycles * (10^6 / cpu_khz)
- *
- *	Then we use scaling math (suggested by george at mvista.com) to get:
- *		ns = cycles * (10^6 * SC / cpu_khz / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *			-johnstul at us.ibm.com "math is hard, lets go shopping!"
- */
-static unsigned long cyc2ns_scale;
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_khz)
-{
-	cyc2ns_scale = (1000000 << CYC2NS_SCALE_FACTOR)/cpu_khz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
-
 typedef struct {
 	u32 cntl;			/* CNTL_TIMER, R/W */
 	u32 load_tim;			/* LOAD_TIM,   W */
@@ -194,8 +163,6 @@ static struct irqaction omap_mpu_timer1_irq = {
 
 static __init void omap_init_mpu_timer(unsigned long rate)
 {
-	set_cyc2ns_scale(rate / 1000);
-
 	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
 	omap_mpu_timer_start(0, (rate / HZ) - 1, 1);
 
-- 
1.5.3.6

