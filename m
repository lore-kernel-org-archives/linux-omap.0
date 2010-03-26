From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] arm: omap1/2/3/4: convert clocksource to a platform_driver
Date: Fri, 26 Mar 2010 09:21:57 +0200
Message-ID: <1269588117-17024-1-git-send-email-felipe.balbi@nokia.com>
References: <20100324065442.GB7534@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51502 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0CZHWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 03:22:17 -0400
In-Reply-To: <20100324065442.GB7534@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Convert the omap32k clocksource driver into a platform_driver
and while at that, also remove the ifdeferry around the code.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

Amended both patches into one since there were
different clock names before. Now the change
will still be bisectable.

 arch/arm/mach-omap1/devices.c        |   24 ++++
 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 arch/arm/mach-omap2/devices.c        |   38 +++++
 arch/arm/plat-omap/Makefile          |    4 +-
 arch/arm/plat-omap/clocksource.c     |  250 ++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/common.c          |  158 ---------------------
 8 files changed, 317 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm/plat-omap/clocksource.c

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 379100c..acbf475 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -28,6 +28,29 @@
 
 /*-------------------------------------------------------------------------*/
 
+#define OMAP16XX_TIMER_32K_BASE		0xfffbc400
+
+static struct resource omap_32k_resources[] = {
+	{
+		.start		= OMAP16XX_TIMER_32K_BASE,
+		.end		= SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_32k_device = {
+	.name			= "omap-clksrc",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(omap_32k_resources),
+	.resource		= omap_32k_resources,
+};
+
+static void omap_init_32k(void)
+{
+       if (cpu_is_omap16xx())
+	       (void) platform_device_register(&omap_32k_device);
+};
+
 #if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
 
 #define	OMAP_RTC_BASE		0xfffb4800
@@ -295,6 +318,7 @@ static int __init omap1_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 
+	omap_init_32k();
 	omap_init_mbox();
 	omap_init_rtc();
 	omap_init_spi100k();
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index d932b14..0115853 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1806,7 +1806,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
+	CLK("omap-clksrc",	"ick",	&sync_32k_ick,	CK_242X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
 	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0438b6e..d2e1041 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1900,7 +1900,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
+	CLK("omap-clksrc",	"ick",	&sync_32k_ick,	CK_243X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..6bf0f96 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3414,7 +3414,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
-	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
+	CLK("omap-clksrc",	"ick", &omap_32ksync_ick, CK_3XXX),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
 	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 23e4d77..8f8eb4f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -29,6 +29,43 @@
 
 #include "mux.h"
 
+static struct resource omap_32k_resources[] = {
+	{
+		.start		= -EINVAL,	/* gets changed later */
+		.end		= -EINVAL,	/* gets changed later */
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_32k_device = {
+	.name			= "omap-clksrc",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(omap_32k_resources),
+	.resource		= omap_32k_resources,
+};
+
+static void omap_init_32k(void)
+{
+	if (cpu_is_omap2420()) {
+		omap_32k_resources[0].start = OMAP2420_32KSYNCT_BASE;
+		omap_32k_resources[0].end = OMAP2420_32KSYNCT_BASE + SZ_4K;
+	} else if (cpu_is_omap2430()) {
+		omap_32k_resources[0].start = OMAP2430_32KSYNCT_BASE;
+		omap_32k_resources[0].end = OMAP2430_32KSYNCT_BASE + SZ_4K;
+	} else if (cpu_is_omap34xx()) {
+		omap_32k_resources[0].start = OMAP3430_32KSYNCT_BASE;
+		omap_32k_resources[0].end = OMAP3430_32KSYNCT_BASE + SZ_4K;
+	} else if (cpu_is_omap44xx()) {
+		omap_32k_resources[0].start = OMAP4430_32KSYNCT_BASE;
+		omap_32k_resources[0].end = OMAP4430_32KSYNCT_BASE + SZ_4K;
+	} else {	/* not supported */
+		return;
+	}
+
+
+	(void) platform_device_register(&omap_32k_device);
+};
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -794,6 +831,7 @@ static int __init omap2_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_hsmmc_reset();
+	omap_init_32k();
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 98f0191..4630be3 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-	 usb.o fb.o io.o
+	 usb.o fb.o io.o clocksource.o
 obj-m :=
 obj-n :=
 obj-  :=
@@ -30,4 +30,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
-obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
\ No newline at end of file
+obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
diff --git a/arch/arm/plat-omap/clocksource.c b/arch/arm/plat-omap/clocksource.c
new file mode 100644
index 0000000..bf5842a
--- /dev/null
+++ b/arch/arm/plat-omap/clocksource.c
@@ -0,0 +1,250 @@
+/*
+ * clocksource.c -- OMAP Clocksource Driver
+ *
+ * Copyright (C) 2005-2010 Tony Lindgren <tony@atomide.com>
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Felipe Balbi <me@felipebalbi.com>
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/time.h>
+#include <linux/clocksource.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+struct omap_clksrc {
+	struct timespec		persistent_ts;
+	struct clocksource	cs;
+	cycles_t		cycles;
+	cycles_t		last_cycles;
+
+	struct device		*dev;
+	struct clk		*ick;
+	void __iomem		*base;
+
+	/*
+	 * offset_32k holds the init time counter value. It is then subtracted
+	 * from every counter read to achieve a counter that counts time from the
+	 * kernel boot (needed for sched_clock()).
+	 */
+	u32			offset_32k __read_mostly;
+};
+
+#define to_omap_clksrc(cs)	(container_of(cs, struct omap_clksrc, cs))
+
+static struct omap_clksrc	*thecs;
+
+static inline u32 omap_clksrc_readl(const void __iomem *base, unsigned offset)
+{
+	return __raw_readl(base + offset);
+}
+
+static cycle_t omap_clksrc_32k_read(struct clocksource *cs)
+{
+	struct omap_clksrc	*omap = to_omap_clksrc(cs);
+
+	return omap_clksrc_readl(omap->base, 0x10) - omap->offset_32k;
+}
+
+/*
+ * Returns current time from boot in nsecs. It's OK for this to wrap
+ * around for now, as it's just a relative time stamp.
+ */
+unsigned long long sched_clock(void)
+{
+	struct omap_clksrc	*omap = thecs;
+
+	if (!omap)
+		return 0;
+
+	return clocksource_cyc2ns(omap->cs.read(&omap->cs),
+			omap->cs.mult, omap->cs.shift);
+}
+
+/**
+ * read_persistent_clock -  Return time from a persistent clock.
+ *
+ * Reads the time from a source which isn't disabled during PM, the
+ * 32k sync timer.  Convert the cycles elapsed since last read into
+ * nsecs and adds to a monotonically increasing timespec.
+ */
+void read_persistent_clock(struct timespec *ts)
+{
+	struct omap_clksrc	*omap = thecs;
+	unsigned long long	nsecs;
+	cycles_t		delta;
+	struct timespec		*tsp;
+
+	if (!omap) {
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+		return;
+	}
+
+	tsp = &omap->persistent_ts;
+
+	omap->last_cycles = omap->cycles;
+	omap->cycles = omap->cs.read(&omap->cs);
+	delta = omap->cycles - omap->last_cycles;
+
+	nsecs = clocksource_cyc2ns(delta,
+			omap->cs.mult, omap->cs.shift);
+
+	timespec_add_ns(tsp, nsecs);
+	*ts = *tsp;
+}
+
+static int __init omap_clksrc_probe(struct platform_device *pdev)
+{
+	struct omap_clksrc		*omap;
+	struct resource			*res;
+	struct clk			*ick;
+
+	int				ret;
+
+	void __iomem			*base;
+
+	omap = kzalloc(sizeof(*omap), GFP_KERNEL);
+	if (!omap) {
+		dev_dbg(&pdev->dev, "unable to allocate memory\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "couldn't get resource\n");
+		ret = -ENODEV;
+		goto err1;
+	}
+
+	base = ioremap(res->start, resource_size(res));
+	if (!base) {
+		dev_dbg(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	ick = clk_get(&pdev->dev, "ick");
+	if (IS_ERR(ick)) {
+		dev_dbg(&pdev->dev, "couldn't get clock\n");
+		ret = PTR_ERR(ick);
+		goto err3;
+	}
+
+	ret = clk_enable(ick);
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't enable clock\n");
+		goto err4;
+	}
+
+	omap->base	= base;
+	omap->dev	= &pdev->dev;
+	omap->ick	= ick;
+
+	omap->cs.name	= "32k_counter";
+	omap->cs.rating	= 250;
+	omap->cs.read	= omap_clksrc_32k_read;
+	omap->cs.mask	= CLOCKSOURCE_MASK(32);
+	omap->cs.shift	= 10;
+	omap->cs.flags	= CLOCK_SOURCE_IS_CONTINUOUS;
+	omap->cs.mult	= clocksource_hz2mult(32768, omap->cs.shift);
+
+	platform_set_drvdata(pdev, omap);
+
+	ret = clocksource_register(&omap->cs);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to register clocksource\n");
+		goto err5;
+	}
+
+	/* initialize our offset */
+	omap->offset_32k	=  omap_clksrc_32k_read(&omap->cs);
+
+	/*
+	 * REVISIT for now we need to keep a global static pointer
+	 * to this clocksource instance. Would it make any sense
+	 * to provide a get_clocksource() to fetch the clocksource
+	 * we just registered ?
+	 */
+	thecs = omap;
+
+	return 0;
+
+err5:
+	clk_disable(ick);
+
+err4:
+	clk_put(ick);
+
+err3:
+	iounmap(base);
+
+err2:
+err1:
+	kfree(omap);
+
+err0:
+	return ret;
+}
+
+static int __exit omap_clksrc_remove(struct platform_device *pdev)
+{
+	struct omap_clksrc	*omap = platform_get_drvdata(pdev);
+
+	clocksource_unregister(&omap->cs);
+	clk_disable(omap->ick);
+	clk_put(omap->ick);
+	iounmap(omap->base);
+	kfree(omap);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static void omap_clksrc_shutdown(struct platform_device *pdev)
+{
+	struct omap_clksrc	*omap = platform_get_drvdata(pdev);
+
+	clk_disable(omap->ick);
+}
+
+static struct platform_driver omap_clksrc_driver = {
+	.remove		= __exit_p(omap_clksrc_remove),
+	.shutdown	= omap_clksrc_shutdown,
+	.driver		= {
+		.name	= "omap-clksrc",
+	},
+};
+
+static int __init omap_clksrc_init(void)
+{
+	return platform_driver_probe(&omap_clksrc_driver, omap_clksrc_probe);
+}
+arch_initcall(omap_clksrc_init);
+
+static void __exit omap_clksrc_exit(void)
+{
+	platform_driver_unregister(&omap_clksrc_driver);
+}
+module_exit(omap_clksrc_exit);
+
+MODULE_AUTHOR("Felipe Balbi <me@felipebalbi.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 01cbb48..4be635a 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -87,164 +87,6 @@ const void *omap_get_var_config(u16 tag, size_t *len)
 }
 EXPORT_SYMBOL(omap_get_var_config);
 
-/*
- * 32KHz clocksource ... always available, on pretty most chips except
- * OMAP 730 and 1510.  Other timers could be used as clocksources, with
- * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
- * but systems won't necessarily want to spend resources that way.
- */
-
-#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
-
-#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
-
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
-static cycle_t omap16xx_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
-}
-#else
-#define omap16xx_32k_read	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2420
-static cycle_t omap2420_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap2420_32k_read	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-static cycle_t omap2430_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap2430_32k_read	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static cycle_t omap34xx_32k_read(struct clocksource *cs)
-{
-	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap34xx_32k_read	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-static cycle_t omap44xx_32k_read(struct clocksource *cs)
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
-static cycle_t omap_32k_read_dummy(struct clocksource *cs)
-{
-	return 0;
-}
-
-static struct clocksource clocksource_32k = {
-	.name		= "32k_counter",
-	.rating		= 250,
-	.read		= omap_32k_read_dummy,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 10,
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-/*
- * Returns current time from boot in nsecs. It's OK for this to wrap
- * around for now, as it's just a relative time stamp.
- */
-unsigned long long sched_clock(void)
-{
-	return clocksource_cyc2ns(clocksource_32k.read(&clocksource_32k),
-				  clocksource_32k.mult, clocksource_32k.shift);
-}
-
-/**
- * read_persistent_clock -  Return time from a persistent clock.
- *
- * Reads the time from a source which isn't disabled during PM, the
- * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec.
- */
-static struct timespec persistent_ts;
-static cycles_t cycles, last_cycles;
-void read_persistent_clock(struct timespec *ts)
-{
-	unsigned long long nsecs;
-	cycles_t delta;
-	struct timespec *tsp = &persistent_ts;
-
-	last_cycles = cycles;
-	cycles = clocksource_32k.read(&clocksource_32k);
-	delta = cycles - last_cycles;
-
-	nsecs = clocksource_cyc2ns(delta,
-				   clocksource_32k.mult, clocksource_32k.shift);
-
-	timespec_add_ns(tsp, nsecs);
-	*ts = *tsp;
-}
-
-static int __init omap_init_clocksource_32k(void)
-{
-	static char err[] __initdata = KERN_ERR
-			"%s: can't register clocksource!\n";
-
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		struct clk *sync_32k_ick;
-
-		if (cpu_is_omap16xx())
-			clocksource_32k.read = omap16xx_32k_read;
-		else if (cpu_is_omap2420())
-			clocksource_32k.read = omap2420_32k_read;
-		else if (cpu_is_omap2430())
-			clocksource_32k.read = omap2430_32k_read;
-		else if (cpu_is_omap34xx())
-			clocksource_32k.read = omap34xx_32k_read;
-		else if (cpu_is_omap44xx())
-			clocksource_32k.read = omap44xx_32k_read;
-		else
-			return -ENODEV;
-
-		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
-		if (sync_32k_ick)
-			clk_enable(sync_32k_ick);
-
-		clocksource_32k.mult = clocksource_hz2mult(32768,
-					    clocksource_32k.shift);
-
-		offset_32k = clocksource_32k.read(&clocksource_32k);
-
-		if (clocksource_register(&clocksource_32k))
-			printk(err, clocksource_32k.name);
-	}
-	return 0;
-}
-arch_initcall(omap_init_clocksource_32k);
-
-#endif	/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX)) */
-
 /* Global address base setup code */
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-- 
1.7.0.rc0.33.g7c3932

