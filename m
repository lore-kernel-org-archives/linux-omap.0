From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 10:00:40 +0300
Message-ID: <20101004070040.GE2559@legolas.emea.dhcp.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101001213532.1408.55832.stgit@twilight.localdomain>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
 <20101004065624.GD2559@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60332 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab0JDHAp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 03:00:45 -0400
Content-Disposition: inline
In-Reply-To: <20101004065624.GD2559@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 04, 2010 at 01:56:24AM -0500, Balbi, Felipe wrote:
>On Mon, Oct 04, 2010 at 12:34:48AM -0500, Shilimkar, Santosh wrote:
>>Felipe,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Paul Walmsley
>>> Sent: Saturday, October 02, 2010 3:06 AM
>>> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>> Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
>>>
>>> Split plat-omap/common.c into three pieces:
>>>
>>> 1. the 32KiHz sync timer and clocksource code, which now lives in
>>>    plat-omap/32ksynctimer.c;
>>>
>>I remember you have converted the 32k sync time code to a platform driver.
>>That was also addressing the multi-omap build and was removing all
>>the compile time switches.
>>Do you plan to rebase it and post it again ?
>
>I still have that sitting on my gitorious tree. The patch is attached
>to this mail. I compile tested (only) for omap3_defconfig, it probably
>needs to start using pm_runtime functions at some point and probably
>move to drivers/clocksource instead of arch/arm/plat-omap.
>
>patch is also available at [1]
>
>[1] git://gitorious.org/usb/usb.git clksource

I made a few changes to make checkpatch.pl --strict happy. Attached

-- 
balbi

--EeQfGwPcQSOJBaQU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arm-omap1-2-3-4-convert-32k-sync-driver-to-a-platform.diff"

>From 42dddbbd0738b36106e8aa9851ab16851642bdd0 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Tue, 23 Mar 2010 12:54:14 +0200
Subject: [PATCH] arm: omap1/2/3/4: convert 32k-sync driver to a platform_driver
Organization: Texas Instruments\n

Convert the omap32k clocksource driver into a platform_driver
and while at that, also remove the ifdeferry around the code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/devices.c        |   24 ++++
 arch/arm/mach-omap2/clock2420_data.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 arch/arm/mach-omap2/devices.c        |   35 +++++
 arch/arm/plat-omap/Makefile          |    4 +-
 arch/arm/plat-omap/common.c          |  158 ---------------------
 arch/arm/plat-omap/counter-32k.c     |  253 ++++++++++++++++++++++++++++++++++
 8 files changed, 317 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm/plat-omap/counter-32k.c

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index aa07256..62170fd 100644
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
+	.name			= "omap-counter-32k",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(omap_32k_resources),
+	.resource		= omap_32k_resources,
+};
+
+static void omap_init_32k(void)
+{
+	if (cpu_is_omap16xx())
+		(void) platform_device_register(&omap_32k_device);
+};
+
 #if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
 
 #define	OMAP_RTC_BASE		0xfffb4800
@@ -223,6 +246,7 @@ static int __init omap1_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 
+	omap_init_32k();
 	omap_init_mbox();
 	omap_init_rtc();
 	omap_init_spi100k();
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 37d65d6..781bfeb 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1806,7 +1806,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
+	CLK("omap-counter-32k",	"ick",	&sync_32k_ick,	CK_242X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
 	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index b33118f..e997692 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1900,7 +1900,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
+	CLK("omap-counter-32k",	"ick",	&sync_32k_ick,	CK_243X),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index dfdce2d..257a8fe 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3343,7 +3343,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
-	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
+	CLK("omap-counter-32k",	"ick", &omap_32ksync_ick, CK_3XXX),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
 	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..8f1714e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -31,6 +31,40 @@
 
 #include "mux.h"
 
+static struct resource omap_32k_resources[] = {
+	{
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_32k_device = {
+	.name			= "omap-counter-32k",
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
+	(void) platform_device_register(&omap_32k_device);
+};
+
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource cam_resources[] = {
@@ -847,6 +881,7 @@ static int __init omap2_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_hsmmc_reset();
+	omap_init_32k();
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 9405831..ff57f33 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-	 usb.o fb.o io.o
+	 usb.o fb.o io.o counter-32k.o
 obj-m :=
 obj-n :=
 obj-  :=
@@ -31,4 +31,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
-obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
\ No newline at end of file
+obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3008e71..b8683b2 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -89,164 +89,6 @@ void __init omap_reserve(void)
 	omap_vram_reserve_sdram_memblock();
 }
 
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
diff --git a/arch/arm/plat-omap/counter-32k.c b/arch/arm/plat-omap/counter-32k.c
new file mode 100644
index 0000000..f3fcb38
--- /dev/null
+++ b/arch/arm/plat-omap/counter-32k.c
@@ -0,0 +1,253 @@
+/*
+ * counter-32k.c -- OMAP 32k Sync Timer Clocksource Driver
+ *
+ * Copyright (C) 2005-2010 Tony Lindgren <tony@atomide.com>
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Felipe Balbi <me@felipebalbi.com>
+ * Copyright (C) 2009-2010 Texas Instruments
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
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/clocksource.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+struct omap_counter_32k_device {
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
+	 * from every counter read to achieve a counter that counts time from
+	 * the kernel boot (needed for sched_clock()).
+	 */
+	u32			offset_32k __read_mostly;
+};
+
+#define to_omap_32k(cs)	(container_of(cs, struct omap_counter_32k_device, cs))
+
+static struct omap_counter_32k_device	*thecs;
+
+static inline u32 omap_counter_32k_readl(const void __iomem *base,
+		unsigned offset)
+{
+	return __raw_readl(base + offset);
+}
+
+static cycle_t omap_counter_32k_32k_read(struct clocksource *cs)
+{
+	struct omap_counter_32k_device	*omap = to_omap_32k(cs);
+
+	return omap_counter_32k_readl(omap->base, 0x10) - omap->offset_32k;
+}
+
+/*
+ * Returns current time from boot in nsecs. It's OK for this to wrap
+ * around for now, as it's just a relative time stamp.
+ */
+unsigned long long sched_clock(void)
+{
+	struct omap_counter_32k_device	*omap = thecs;
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
+	struct omap_counter_32k_device	*omap = thecs;
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
+static int __init omap_counter_32k_probe(struct platform_device *pdev)
+{
+	struct omap_counter_32k_device		*omap;
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
+	omap->cs.name	= "counter-32k";
+	omap->cs.rating	= 250;
+	omap->cs.read	= omap_counter_32k_32k_read;
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
+	omap->offset_32k	=  omap_counter_32k_32k_read(&omap->cs);
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
+static int __exit omap_counter_32k_remove(struct platform_device *pdev)
+{
+	struct omap_counter_32k_device	*omap = platform_get_drvdata(pdev);
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
+static void omap_counter_32k_shutdown(struct platform_device *pdev)
+{
+	struct omap_counter_32k_device	*omap = platform_get_drvdata(pdev);
+
+	clk_disable(omap->ick);
+}
+
+static struct platform_driver omap_counter_32k_driver = {
+	.remove		= __exit_p(omap_counter_32k_remove),
+	.shutdown	= omap_counter_32k_shutdown,
+	.driver		= {
+		.name	= "omap-counter-32k",
+	},
+};
+
+static int __init omap_counter_32k_init(void)
+{
+	return platform_driver_probe(&omap_counter_32k_driver,
+			omap_counter_32k_probe);
+}
+arch_initcall(omap_counter_32k_init);
+
+static void __exit omap_counter_32k_exit(void)
+{
+	platform_driver_unregister(&omap_counter_32k_driver);
+}
+module_exit(omap_counter_32k_exit);
+
+MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.3.rc0.35.g8ac8c


--EeQfGwPcQSOJBaQU--
