From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap1: Fix sched_clock implementation when both MPU timer
 and 32K timer are used (Re: State of LDP3430 platform)
Date: Wed, 19 Jan 2011 10:43:21 -0800
Message-ID: <20110119184321.GY4957@atomide.com>
References: <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
 <20110115233744.GA18159@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
 <4D3309F9.8090900@gmail.com>
 <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
 <20110118222613.GS4957@atomide.com>
 <20110118223536.GT4957@atomide.com>
 <20110118232102.GU4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53513 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab1ASSnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 13:43:37 -0500
Content-Disposition: inline
In-Reply-To: <20110118232102.GU4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Weber <thomas.weber.linux@googlemail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* Tony Lindgren <tony@atomide.com> [110118 15:20]:
> * Tony Lindgren <tony@atomide.com> [110118 14:34]:
> > For omap15xx and 730 we need to use the MPU timer
> > as the 32K timer is not available. For omap16xx
> > we want to use the 32K timer because of PM. Fix this
> > by allowing to build in both timers.
> 
> This still needs one more patch to deal with the
> sched_clock for MPU timer..

And here's that patch to make sched_clock work with both
timers.

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 18 Jan 2011 17:00:00 -0800
Subject: [PATCH] omap1: Fix sched_clock implementation when both MPU timer and 32K timer are used

Earlier patches select HAVE_SCHED_CLOCK for omaps. To have working sched_clock
also for MPU timer, we need to implement it in a way where the right one gets
selected during the runtime.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -219,6 +219,24 @@ static struct clocksource clocksource_mpu = {
 
 static DEFINE_CLOCK_DATA(cd);
 
+static inline unsigned long long notrace _omap_mpu_sched_clock(void)
+{
+	u32 cyc = mpu_read(&clocksource_mpu);
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+#ifndef CONFIG_OMAP_32K_TIMER
+unsigned long long notrace sched_clock(void)
+{
+	return _omap_mpu_sched_clock();
+}
+#else
+static unsigned long long notrace omap_mpu_sched_clock(void)
+{
+	return _omap_mpu_sched_clock();
+}
+#endif
+
 static void notrace mpu_update_sched_clock(void)
 {
 	u32 cyc = mpu_read(&clocksource_mpu);
@@ -262,6 +280,30 @@ static inline void omap_mpu_timer_init(void)
 }
 #endif	/* CONFIG_OMAP_MPU_TIMER */
 
+#if defined(CONFIG_OMAP_MPU_TIMER) && defined(CONFIG_OMAP_32K_TIMER)
+static unsigned long long (*preferred_sched_clock)(void);
+
+unsigned long long notrace sched_clock(void)
+{
+	if (!preferred_sched_clock)
+		return 0;
+
+	return preferred_sched_clock();
+}
+
+static inline void preferred_sched_clock_init(bool use_32k_sched_clock)
+{
+	if (use_32k_sched_clock)
+		preferred_sched_clock = omap_32k_sched_clock;
+	else
+		preferred_sched_clock = omap_mpu_sched_clock;
+}
+#else
+static inline void preferred_sched_clock_init(bool use_32k_sched_clcok)
+{
+}
+#endif
+
 static inline int omap_32k_timer_usable(void)
 {
 	int res = false;
@@ -283,8 +325,12 @@ static inline int omap_32k_timer_usable(void)
  */
 static void __init omap_timer_init(void)
 {
-	if (!omap_32k_timer_usable())
+	if (omap_32k_timer_usable()) {
+		preferred_sched_clock_init(1);
+	} else {
 		omap_mpu_timer_init();
+		preferred_sched_clock_init(0);
+	}
 }
 
 struct sys_timer omap_timer = {
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -120,12 +120,24 @@ static DEFINE_CLOCK_DATA(cd);
 #define SC_MULT		4000000000u
 #define SC_SHIFT	17
 
-unsigned long long notrace sched_clock(void)
+static inline unsigned long long notrace _omap_32k_sched_clock(void)
 {
 	u32 cyc = clocksource_32k.read(&clocksource_32k);
 	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
 }
 
+#ifndef CONFIG_OMAP_MPU_TIMER
+unsigned long long notrace sched_clock(void)
+{
+	return _omap_32k_sched_clock();
+}
+#else
+unsigned long long notrace omap_32k_sched_clock(void)
+{
+	return _omap_32k_sched_clock();
+}
+#endif
+
 static void notrace omap_update_sched_clock(void)
 {
 	u32 cyc = clocksource_32k.read(&clocksource_32k);
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -37,6 +37,7 @@ extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
+extern unsigned long long notrace omap_32k_sched_clock(void);
 
 extern void omap_reserve(void);
 
