From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Use MMIO clocksource for 32kHz counter
Date: Sun, 10 Jul 2011 23:17:31 -0700
Message-ID: <20110711061731.GM5783@atomide.com>
References: <20110627123315.GB1777@n2100.arm.linux.org.uk>
 <20110627123754.GQ23145@atomide.com>
 <20110627191102.GV23145@atomide.com>
 <20110710141537.GB4957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30700 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756726Ab1GKGRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 02:17:41 -0400
Content-Disposition: inline
In-Reply-To: <20110710141537.GB4957@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110710 07:10]:
> On Mon, Jun 27, 2011 at 12:11:02PM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [110627 05:33]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110627 05:28]:
> > > > --- a/arch/arm/plat-omap/counter_32k.c
> > > > +++ b/arch/arm/plat-omap/counter_32k.c
> > > > +#ifdef CONFIG_ARCH_OMAP16XX
> > > > +		else if (cpu_is_omap16xx())
> > > > +			base = OMAP2_L4_IO_ADDRESS(OMAP16XX_TIMER_32K_SYNCHRONIZED);
> > 
> > BTW, the above should have been OMAP1_IO_ADDRESS instead..
> >   
> > > You should be able to replace the above with just ioremap as we now
> > > have the static mappings.
> > 
> > ..here's a patch to use ioremap with comment added about the static
> > mapping requirements.
> > 
> > Thanks for getting rid of hopefully the last remaining omap_readl
> > for omap2+ BTW :)
> 
> What're we doing with this patch and your follow-up patch?

I can queue it, it does not seem to conflict with other patches.
Below is the combined version.

Regards,

Tony


From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sun, 10 Jul 2011 23:05:34 -0700
Subject: [PATCH] Convert OMAPs 32kHz clocksource implementation to use the generic MMIO
 clocksource support.  This achieves several things:

1. It means we get rid of all these helper functions which frankly should
   never have been necessary.
2. It means omap_readl() inside these helper functions does not appear in
   ftrace output.

Another plus is that we avoid the overhead of calculating the address to
read each time, but a minus is that we use readl() which has a barrier.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
[tony@atomide.com: updated to use ioremap]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..c1795c9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -852,6 +852,7 @@ config ARCH_OMAP
 	select HAVE_CLK
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
+	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
 	select ARCH_HAS_HOLES_MEMORYMODEL
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index c13bc3d..a6cbb71 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/sched.h>
+#include <linux/clocksource.h>
 
 #include <asm/sched_clock.h>
 
@@ -26,87 +27,16 @@
 
 #include <plat/clock.h>
 
-
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
  * OMAP 730 and 1510.  Other timers could be used as clocksources, with
  * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
  * but systems won't necessarily want to spend resources that way.
  */
+static void __iomem *timer_32k_base;
 
 #define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
 
-#include <linux/clocksource.h>
-
-/*
- * offset_32k holds the init time counter value. It is then subtracted
- * from every counter read to achieve a counter that counts time from the
- * kernel boot (needed for sched_clock()).
- */
-static u32 offset_32k __read_mostly;
-
-#ifdef CONFIG_ARCH_OMAP16XX
-static cycle_t notrace omap16xx_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
-}
-#else
-#define omap16xx_32k_read	NULL
-#endif
-
-#ifdef CONFIG_SOC_OMAP2420
-static cycle_t notrace omap2420_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap2420_32k_read	NULL
-#endif
-
-#ifdef CONFIG_SOC_OMAP2430
-static cycle_t notrace omap2430_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap2430_32k_read	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static cycle_t notrace omap34xx_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap34xx_32k_read	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-static cycle_t notrace omap44xx_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap44xx_32k_read	NULL
-#endif
-
-/*
- * Kernel assumes that sched_clock can be called early but may not have
- * things ready yet.
- */
-static cycle_t notrace omap_32k_read_dummy(struct clocksource *cs)
-{
-	return 0;
-}
-
-static struct clocksource clocksource_32k = {
-	.name		= "32k_counter",
-	.rating		= 250,
-	.read		= omap_32k_read_dummy,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 /*
  * Returns current time from boot in nsecs. It's OK for this to wrap
  * around for now, as it's just a relative time stamp.
@@ -122,7 +52,7 @@ static DEFINE_CLOCK_DATA(cd);
 
 static inline unsigned long long notrace _omap_32k_sched_clock(void)
 {
-	u32 cyc = clocksource_32k.read(&clocksource_32k);
+	u32 cyc = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
 	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
 }
 
@@ -140,7 +70,7 @@ unsigned long long notrace omap_32k_sched_clock(void)
 
 static void notrace omap_update_sched_clock(void)
 {
-	u32 cyc = clocksource_32k.read(&clocksource_32k);
+	u32 cyc = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
@@ -153,6 +83,7 @@ static void notrace omap_update_sched_clock(void)
  */
 static struct timespec persistent_ts;
 static cycles_t cycles, last_cycles;
+static unsigned int persistent_mult, persistent_shift;
 void read_persistent_clock(struct timespec *ts)
 {
 	unsigned long long nsecs;
@@ -160,11 +91,10 @@ void read_persistent_clock(struct timespec *ts)
 	struct timespec *tsp = &persistent_ts;
 
 	last_cycles = cycles;
-	cycles = clocksource_32k.read(&clocksource_32k);
+	cycles = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
 	delta = cycles - last_cycles;
 
-	nsecs = clocksource_cyc2ns(delta,
-				   clocksource_32k.mult, clocksource_32k.shift);
+	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
 
 	timespec_add_ns(tsp, nsecs);
 	*ts = *tsp;
@@ -176,29 +106,46 @@ int __init omap_init_clocksource_32k(void)
 			"%s: can't register clocksource!\n";
 
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
+		u32 pbase;
+		unsigned long size = SZ_4K;
+		void __iomem *base;
 		struct clk *sync_32k_ick;
 
-		if (cpu_is_omap16xx())
-			clocksource_32k.read = omap16xx_32k_read;
-		else if (cpu_is_omap2420())
-			clocksource_32k.read = omap2420_32k_read;
+		if (cpu_is_omap16xx()) {
+			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
+			size = SZ_1K;
+		} else if (cpu_is_omap2420())
+			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap2430())
-			clocksource_32k.read = omap2430_32k_read;
+			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap34xx())
-			clocksource_32k.read = omap34xx_32k_read;
+			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap44xx())
-			clocksource_32k.read = omap44xx_32k_read;
+			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
 		else
 			return -ENODEV;
 
+		/* For this to work we must have a static mapping in io.c for this area */
+		base = ioremap(pbase, size);
+		if (!base)
+			return -ENODEV;
+
 		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
 		if (!IS_ERR(sync_32k_ick))
 			clk_enable(sync_32k_ick);
 
-		offset_32k = clocksource_32k.read(&clocksource_32k);
+		timer_32k_base = base;
+
+		/*
+		 * 120000 rough estimate from the calculations in
+		 * __clocksource_updatefreq_scale.
+		 */
+		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
+				32768, NSEC_PER_SEC, 120000);
 
-		if (clocksource_register_hz(&clocksource_32k, 32768))
-			printk(err, clocksource_32k.name);
+		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
+					  clocksource_mmio_readl_up))
+			printk(err, "32k_counter");
 
 		init_fixed_sched_clock(&cd, omap_update_sched_clock, 32,
 				       32768, SC_MULT, SC_SHIFT);
