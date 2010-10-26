From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA platform Driver
Date: Tue, 26 Oct 2010 18:55:10 +0530
Message-ID: <1288099513-1854-11-git-send-email-manjugk@ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57774 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933191Ab0JZNZb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 09:25:31 -0400
In-Reply-To: <1288099513-1854-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Convert DMA library into DMA platform driver and make use
of platform data provided by HWMOD data base for OMAP2PLUS onwards.
For OMAP1 processors, the DMA driver in mach-omap uses resource
structures for getting platform data.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/Makefile           |    2 +-
 arch/arm/mach-omap1/dma.c              |  180 ++++++++++++++++++-
 arch/arm/mach-omap2/Makefile           |    2 +-
 arch/arm/mach-omap2/dma.c              |  209 +++++++++++++++++++++-
 arch/arm/mach-omap2/include/mach/dma.h |    3 +
 arch/arm/plat-omap/dma.c               |  321 +++++++++++---------------------
 arch/arm/plat-omap/include/plat/dma.h  |   50 ++++--
 7 files changed, 538 insertions(+), 229 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 9a304d8..b7dfc54 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
+obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o dma.o
 obj-y += clock.o clock_data.o opp_data.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index e756069..38a7294 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -35,6 +35,81 @@
 #include <plat/tc.h>
 
 #define OMAP1_DMA_BASE			(0xfffed800)
+#define OMAP1_LOGICAL_DMA_CH_COUNT	17
+
+static u32 errata;
+static u32 enable_1510_mode;
+
+enum {
+	GCR1 = 0,	GSCR,		GRST,		HW_ID,
+	PCH2_ID,	PCH0_ID,	PCH1_ID,	PCHG_ID,
+	PCHD_ID,	CAPS_0_U,	CAPS_0_L,	CAPS_1_U,
+	CAPS_1_L,	CAPS_2,		CAPS_3,		CAPS_4,
+	PCH2_SR,	PCH0_SR,	PCH1_SR,	PCHD_SR,
+
+	CH_COMMON_START,
+
+	/* Common Registers */
+	CSDP1,		CCR1,		CICR1,		CSR1,
+	CEN1,		CFN1,		CSFI1,		CSEI1,
+	CPC,		CSAC1,		CDAC1,		CDEI1,
+	CDFI1,		CLNK_CTRL1,
+
+	/* Channel specific register offsets */
+	CSSA_L,		CSSA_U,		CDSA_L,		CDSA_U,
+	COLOR_L,	COLOR_U,	CCR1_2,		LCH_CTRL,
+
+	CH_COMMON_END,
+};
+
+static u16 reg_map[] = {
+	[GCR1]		= 0x400,
+	[GSCR]		= 0x404,
+	[GRST]		= 0x408,
+	[HW_ID]		= 0x442,
+	[PCH2_ID]	= 0x444,
+	[PCH0_ID]	= 0x446,
+	[PCH1_ID]	= 0x448,
+	[PCHG_ID]	= 0x44a,
+	[PCHD_ID]	= 0x44c,
+	[CAPS_0_U]	= 0x44e,
+	[CAPS_0_L]	= 0x450,
+	[CAPS_1_U]	= 0x452,
+	[CAPS_1_L]	= 0x454,
+	[CAPS_2]	= 0x456,
+	[CAPS_3]	= 0x458,
+	[CAPS_4]	= 0x45a,
+	[PCH2_SR]	= 0x460,
+	[PCH0_SR]	= 0x480,
+	[PCH1_SR]	= 0x482,
+	[PCHD_SR]	= 0x4c0,
+
+	/* Common Registers */
+	[CSDP1]		= 0x00,
+	[CCR1]		= 0x02,
+	[CICR1]		= 0x04,
+	[CSR1]		= 0x06,
+	[CEN1]		= 0x10,
+	[CFN1]		= 0x12,
+	[CSFI1]		= 0x14,
+	[CSEI1]		= 0x16,
+	[CPC]		= 0x18,	/* 15xx only */
+	[CSAC1]		= 0x18,
+	[CDAC1]		= 0x1a,
+	[CDEI1]		= 0x1c,
+	[CDFI1]		= 0x1e,
+	[CLNK_CTRL1]	= 0x28,
+
+	/* Channel specific register offsets */
+	[CSSA_L]	= 0x08,
+	[CSSA_U]	= 0x0a,
+	[CDSA_L]	= 0x0c,
+	[CDSA_U]	= 0x0e,
+	[COLOR_L]	= 0x20,
+	[COLOR_U]	= 0x22,
+	[CCR1_2]	= 0x24,
+	[LCH_CTRL]	= 0x2a,
+};
 
 static struct resource res[] __initdata = {
 	[0] = {
@@ -130,9 +205,64 @@ static struct resource res[] __initdata = {
 	},
 };
 
+static void __iomem *dma_base;
+static inline void dma_write(u16 val, int reg, int lch)
+{
+	if (reg > CH_COMMON_START)
+		__raw_writew(val, dma_base + (reg_map[reg] + 0x40 * lch));
+	else
+		__raw_writew(val, dma_base + reg_map[reg]);
+}
+
+static inline u16 dma_read(int reg, int lch)
+{
+	if (reg > CH_COMMON_START)
+		return __raw_readw(dma_base + (reg_map[reg] + 0x40 * lch));
+	else
+		return __raw_readw(dma_base + reg_map[reg]);
+}
+
+static void omap1_show_dma_caps(void)
+{
+	if (enable_1510_mode) {
+		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
+	} else {
+		u16 w;
+		printk(KERN_INFO "OMAP DMA hardware version %d\n",
+		       dma_read(HW_ID, 0));
+		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
+		       (dma_read(CAPS_0_U, 0) << 16) |
+		       dma_read(CAPS_0_L, 0),
+		       (dma_read(CAPS_1_U, 0) << 16) |
+		       dma_read(CAPS_1_L, 0),
+		       dma_read(CAPS_2, 0), dma_read(CAPS_3, 0),
+		       dma_read(CAPS_4, 0));
+
+		/* Disable OMAP 3.0/3.1 compatibility mode. */
+		w = dma_read(GSCR, 0);
+		w |= 1 << 3;
+		dma_write(w, GSCR, 0);
+	}
+	return;
+}
+
+static u32 configure_dma_errata(void)
+{
+
+	/*
+	 * Errata 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
+	 * read before the DMA controller finished disabling the channel.
+	 */
+	if (!cpu_is_omap15xx())
+		SET_DMA_ERRATA(DMA_ERRATA_3_3);
+
+	return errata;
+}
+
 static int __init omap1_system_dma_init(void)
 {
 	struct omap_system_dma_plat_info	*p;
+	struct omap_dma_dev_attr		*d;
 	struct platform_device			*pdev;
 	int ret;
 
@@ -158,20 +288,66 @@ static int __init omap1_system_dma_init(void)
 		goto exit_device_put;
 	}
 
+	d = p->dma_attr;
+	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
+					(d->lch_count), GFP_KERNEL);
+	if (!d->chan) {
+		dev_err(&pdev->dev, "%s: Memory allocation failed"
+					"for d->chan!!!\n", __func__);
+		goto exit_release_p;
+	}
+
+	/* Valid attributes for omap1 plus processors */
+	if (cpu_is_omap15xx())
+		d->dev_caps = ENABLE_1510_MODE;
+	enable_1510_mode = d->dev_caps & ENABLE_1510_MODE;
+
+	d->dev_caps		|= SRC_PORT;
+	d->dev_caps		|= DST_PORT;
+	d->dev_caps		|= SRC_INDEX;
+	d->dev_caps		|= DST_INDEX;
+	d->dev_caps		|= IS_BURST_ONLY4;
+	d->dev_caps		|= CLEAR_CSR_ON_READ;
+	d->dev_caps		|= IS_WORD_16;
+
+	d->lch_count		= OMAP1_LOGICAL_DMA_CH_COUNT;
+
+	if (cpu_is_omap15xx())
+		d->chan_count = 9;
+	else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
+		if (!(d->dev_caps & ENABLE_1510_MODE))
+			d->chan_count = 16;
+		else
+			d->chan_count = 9;
+	}
+
+	p->omap_dma_base	= (void __iomem *)res[0].start;
+	dma_base		= p->omap_dma_base;
+
+	p->show_dma_caps	= omap1_show_dma_caps;
+	p->disable_irq_lch	= NULL;
+
+	/* Configure errata handling for all omap1+ */
+	p->errata = configure_dma_errata();
+
 	ret = platform_device_add_data(pdev, p, sizeof(*p));
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_device_put;
+		goto exit_release_chan;
 	}
 	ret = platform_device_add(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_device_put;
+		goto exit_release_chan;
 	}
 	return ret;
 
+exit_release_chan:
+	kfree(d->chan);
+exit_release_p:
+	kfree(p);
 exit_device_put:
 	platform_device_put(pdev);
 exit_device_del:
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7352412..5d250c8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
-	 common.o
+	 common.o dma.o
 
 omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 30b20cd..5ca519b 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -39,6 +39,79 @@
 #include <plat/omap_device.h>
 #include <plat/dma.h>
 
+static u32 errata;
+static struct omap_dma_dev_attr *d;
+
+enum {
+	REVISION = 0,	GCR2,		IRQSTATUS_L0,	IRQSTATUS_L1,
+	IRQSTATUS_L2,	IRQSTATUS_L3,	IRQENABLE_L0,	IRQENABLE_L1,
+	IRQENABLE_L2,	IRQENABLE_L3,	SYSSTATUS,	OCP_SYSCONFIG,
+	CAPS_0,		CAPS_2,		CAPS_3,		CAPS_4,
+
+	CH_COMMON_START,
+
+	/* Common register offsets */
+	CCR2,		CLNK_CTRL2,	CICR2,		CSR2,
+	CSDP2,		CEN2,		CFN2,		CSEI2,
+	CSFI2,		CDEI2,		CDFI2,		CSAC2,
+	CDAC2,
+
+	/* Channel specific register offsets */
+	CSSA,		CDSA,		CCEN,		CCFN,
+	COLOR,
+
+	/* OMAP4 specific registers */
+	CDP,		CNDP,		CCDN,
+
+	CH_COMMON_END,
+};
+
+static u16 reg_map[] = {
+	[REVISION]		= 0x00,
+	[GCR2]			= 0x78,
+	[IRQSTATUS_L0]		= 0x08,
+	[IRQSTATUS_L1]		= 0x0c,
+	[IRQSTATUS_L2]		= 0x10,
+	[IRQSTATUS_L3]		= 0x14,
+	[IRQENABLE_L0]		= 0x18,
+	[IRQENABLE_L1]		= 0x1c,
+	[IRQENABLE_L2]		= 0x20,
+	[IRQENABLE_L3]		= 0x24,
+	[SYSSTATUS]		= 0x28,
+	[OCP_SYSCONFIG]		= 0x2c,
+	[CAPS_0]		= 0x64,
+	[CAPS_2]		= 0x6c,
+	[CAPS_3]		= 0x70,
+	[CAPS_4]		= 0x74,
+
+	/* Common register offsets */
+	[CCR2]			= 0x80,
+	[CLNK_CTRL2]		= 0x84,
+	[CICR2]			= 0x88,
+	[CSR2]			= 0x8c,
+	[CSDP2]			= 0x90,
+	[CEN2]			= 0x94,
+	[CFN2]			= 0x98,
+	[CSEI2]			= 0xa4,
+	[CSFI2]			= 0xa8,
+	[CDEI2]			= 0xac,
+	[CDFI2]			= 0xb0,
+	[CSAC2]			= 0xb4,
+	[CDAC2]			= 0xb8,
+
+	/* Channel specific register offsets */
+	[CSSA]			= 0x9c,
+	[CDSA]			= 0xa0,
+	[CCEN]			= 0xbc,
+	[CCFN]			= 0xc0,
+	[COLOR]			= 0xc4,
+
+	/* OMAP4 specific registers */
+	[CDP]			= 0xd0,
+	[CNDP]			= 0xd4,
+	[CCDN]			= 0xd8,
+};
+
 static struct omap_device_pm_latency omap2_dma_latency[] = {
 	{
 		.deactivate_func = omap_device_idle_hwmods,
@@ -47,12 +120,118 @@ static struct omap_device_pm_latency omap2_dma_latency[] = {
 	},
 };
 
+static void __iomem *dma_base;
+static inline void dma_write(u32 val, int reg, int lch)
+{
+	if (reg > CH_COMMON_START)
+		__raw_writel(val, dma_base + (reg_map[reg] + 0x60 * lch));
+	else
+		__raw_writel(val, dma_base + reg_map[reg]);
+}
+
+static inline u32 dma_read(int reg, int lch)
+{
+	if (reg > CH_COMMON_START)
+		return __raw_readl(dma_base + (reg_map[reg] + 0x60 * lch));
+	else
+		return __raw_readl(dma_base + reg_map[reg]);
+}
+
+static inline void disable_irq_lch(int lch)
+{
+	u32 val;
+
+	val = dma_read(IRQENABLE_L0, lch);
+	val &= ~(1 << lch);
+	dma_write(val, IRQENABLE_L0, lch);
+}
+
+static void omap2_show_dma_caps(void)
+{
+	u8 revision = dma_read(REVISION, 0) & 0xff;
+	printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
+				revision >> 4, revision & 0xf);
+	return;
+}
+
+static u32 configure_dma_errata(void)
+{
+
+	/*
+	 * Erratas applicable for OMAP2430ES1.0 and all omap2420
+	 *
+	 * I.
+	 * Errata ID: XX Inter Frame DMA buffering issue DMA will wrongly
+	 * buffer elements if packing and bursting is enabled. This might
+	 * result in data gets stalled in FIFO at the end of the block.
+	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
+	 * guarantee no data will stay in the DMA FIFO in case inter frame
+	 * buffering occurs
+	 *
+	 * II.
+	 * Errata ID: XX DMA may hang when several channels are used in parallel
+	 * In the following configuration, DMA channel hanging can occur:
+	 * a. Channel i, hardware synchronized, is enabled
+	 * b. Another channel (Channel x), software synchronized, is enabled.
+	 * c. Channel i is disabled before end of transfer
+	 * d. Channel i is reenabled.
+	 * e. Steps 1 to 4 are repeated a certain number of times.
+	 * f. A third channel (Channel y), software synchronized, is enabled.
+	 * Channel x and Channel y may hang immediately after step 'f'.
+	 * Workaround:
+	 * For any channel used - make sure NextLCH_ID is set to the value j.
+	 */
+	if (cpu_is_omap2420() || (cpu_is_omap2430() &&
+				(omap_type() == OMAP2430_REV_ES1_0))) {
+
+		SET_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING);
+		SET_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS);
+	}
+
+	/*
+	 * Errata ID: i378: OMAP2plus: sDMA Channel is not disabled
+	 * after a transaction error.
+	 * Workaround: SW should explicitely disable the channel.
+	 */
+	if (cpu_class_is_omap2())
+		SET_DMA_ERRATA(DMA_ERRATA_i378);
+
+	/*
+	 * Errata ID: i541: sDMA FIFO draining does not finish
+	 * If sDMA channel is disabled on the fly, sDMA enters standby even
+	 * through FIFO Drain is still in progress
+	 * Workaround: Put sDMA in NoStandby more before a logical channel is
+	 * disabled, then put it back to SmartStandby right after the channel
+	 * finishes FIFO draining.
+	 */
+	if (cpu_is_omap34xx())
+		SET_DMA_ERRATA(DMA_ERRATA_i541);
+
+	/*
+	 * Errata ID: i88 : Special programming model needed to disable DMA
+	 * before end of block.
+	 * Workaround: software must ensure that the DMA is configured in No
+	 * Standby mode(DMAx_OCP_SYSCONFIG.MIDLEMODE = "01")
+	 */
+	if (omap_type() == OMAP3430_REV_ES1_0)
+		SET_DMA_ERRATA(DMA_ERRATA_i88);
+
+	/*
+	 * Errata 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
+	 * read before the DMA controller finished disabling the channel.
+	 */
+	SET_DMA_ERRATA(DMA_ERRATA_3_3);
+
+	return errata;
+}
+
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 {
 	struct omap_device			*od;
 	struct omap_system_dma_plat_info	*p;
-	char					*name = "omap_system_dma";
+	struct resource				*mem;
+	char					*name = "omap_dma_system";
 
 	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
 	if (!p) {
@@ -60,6 +239,14 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 			__func__, name, oh->name);
 		return -ENOMEM;
 	}
+	p->regs			= reg_map;
+	p->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
+	p->disable_irq_lch	= disable_irq_lch;
+	p->show_dma_caps	= omap2_show_dma_caps;
+
+	/* Configure errata handling for all omap2+'s */
+	p->errata		= configure_dma_errata();
+
 	od = omap_device_build(name, 0, oh, p, sizeof(*p),
 			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
 
@@ -71,6 +258,26 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	}
 	kfree(p);
 
+	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&od->pdev.dev, "%s: no mem resource\n", __func__);
+		return -EINVAL;
+	}
+
+	dma_base = ioremap(mem->start, resource_size(mem));
+	if (!dma_base) {
+		dev_err(&od->pdev.dev, "%s: ioremap fail\n", __func__);
+		return -ENOMEM;
+	}
+
+	d = oh->dev_attr;
+	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
+					(d->lch_count), GFP_KERNEL);
+
+	if (!d->chan) {
+		dev_err(&od->pdev.dev, "%s: kzalloc fail\n", __func__);
+		return -ENOMEM;
+	}
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
index d0a7d5b..d13c5c0 100644
--- a/arch/arm/mach-omap2/include/mach/dma.h
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -29,4 +29,7 @@
 #ifndef __ASM_ARCH_OMAP2_DMA_H
 #define __ASM_ARCH_OMAP2_DMA_H
 
+/* Should be part of hwmod data base ? */
+#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
+
 #endif /* __ASM_ARCH_OMAP2_DMA_H */
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 0ff82d0..d8e9886 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -15,6 +15,10 @@
  *
  * Support functions for the OMAP internal DMA channels.
  *
+ * Copyright (C) 2010 Texas Instruments
+ * Converted DMA library into DMA platform driver.
+ *	- G, Manjunath Kondaiah <manjugk@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -194,6 +198,9 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
 
+static struct omap_system_dma_plat_info *p;
+static struct omap_dma_dev_attr *d;
+static u16 *reg_map;
 static int enable_1510_mode;
 static u32 errata;
 
@@ -203,27 +210,6 @@ static struct omap_dma_global_context_registers {
 	u32 dma_gcr;
 } omap_dma_global_context;
 
-struct omap_dma_lch {
-	int next_lch;
-	int dev_id;
-	u16 saved_csr;
-	u16 enabled_irqs;
-	const char *dev_name;
-	void (*callback)(int lch, u16 ch_status, void *data);
-	void *data;
-
-#ifndef CONFIG_ARCH_OMAP1
-	/* required for Dynamic chaining */
-	int prev_linked_ch;
-	int next_linked_ch;
-	int state;
-	int chain_id;
-
-	int status;
-#endif
-	long flags;
-};
-
 struct dma_link_info {
 	int *linked_dmach_q;
 	int no_of_lchs_linked;
@@ -280,15 +266,6 @@ static int omap_dma_reserve_channels;
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
 static void __iomem *dma_base;
-
-static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
-	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
-	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
-	INT_1610_DMA_CH8, INT_1610_DMA_CH9, INT_1610_DMA_CH10,
-	INT_1610_DMA_CH11, INT_1610_DMA_CH12, INT_1610_DMA_CH13,
-	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
-};
-
 static inline void disable_lnk(int lch);
 static void omap_disable_channel_irq(int lch);
 static inline void omap_enable_channel_irq(int lch);
@@ -1195,7 +1172,7 @@ void omap_start_dma(int lch)
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_chan_count];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
@@ -1288,7 +1265,7 @@ void omap_stop_dma(int lch)
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_chan_count];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {
@@ -1494,8 +1471,6 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 }
 EXPORT_SYMBOL(omap_dma_unlink_lch);
 
-/*----------------------------------------------------------------------------*/
-
 #ifndef CONFIG_ARCH_OMAP1
 /* Create chain of DMA channesls */
 static void create_dma_lch_chain(int lch_head, int lch_queue)
@@ -2309,159 +2284,59 @@ void omap_dma_global_context_restore(void)
 			omap_clear_dma(ch);
 }
 
-static void configure_dma_errata(void)
+static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 {
-
-	/*
-	 * Erratas applicable for OMAP2430ES1.0 and all omap2420
-	 *
-	 * I.
-	 * Errata ID: XX Inter Frame DMA buffering issue DMA will wrongly
-	 * buffer elements if packing and bursting is enabled. This might
-	 * result in data gets stalled in FIFO at the end of the block.
-	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
-	 * guarantee no data will stay in the DMA FIFO in case inter frame
-	 * buffering occurs
-	 *
-	 * II.
-	 * Errata ID: XX DMA may hang when several channels are used in parallel
-	 * In the following configuration, DMA channel hanging can occur:
-	 * a. Channel i, hardware synchronized, is enabled
-	 * b. Another channel (Channel x), software synchronized, is enabled.
-	 * c. Channel i is disabled before end of transfer
-	 * d. Channel i is reenabled.
-	 * e. Steps 1 to 4 are repeated a certain number of times.
-	 * f. A third channel (Channel y), software synchronized, is enabled.
-	 * Channel x and Channel y may hang immediately after step 'f'.
-	 * Workaround:
-	 * For any channel used - make sure NextLCH_ID is set to the value j.
-	 */
-	if (cpu_is_omap2420() || (cpu_is_omap2430() &&
-				(omap_type() == OMAP2430_REV_ES1_0))) {
-
-		SET_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING);
-		SET_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS);
+	struct omap_system_dma_plat_info *pdata = pdev->dev.platform_data;
+	struct resource *mem;
+	int ch, ret = 0;
+	int dma_irq;
+	char irq_name[4];
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: System DMA initialized without"
+			"platform data\n", __func__);
+		return -EINVAL;
 	}
 
-	/*
-	 * Errata ID: i378: OMAP2plus: sDMA Channel is not disabled
-	 * after a transaction error.
-	 * Workaround: SW should explicitely disable the channel.
-	 */
-	if (cpu_class_is_omap2())
-		SET_DMA_ERRATA(DMA_ERRATA_i378);
-
-	/*
-	 * Errata ID: i541: sDMA FIFO draining does not finish
-	 * If sDMA channel is disabled on the fly, sDMA enters standby even
-	 * through FIFO Drain is still in progress
-	 * Workaround: Put sDMA in NoStandby more before a logical channel is
-	 * disabled, then put it back to SmartStandby right after the channel
-	 * finishes FIFO draining.
-	 */
-	if (cpu_is_omap34xx())
-		SET_DMA_ERRATA(DMA_ERRATA_i541);
-
-	/*
-	 * Errata ID: i88 : Special programming model needed to disable DMA
-	 * before end of block.
-	 * Workaround: software must ensure that the DMA is configured in No
-	 * Standby mode(DMAx_OCP_SYSCONFIG.MIDLEMODE = "01")
-	 */
-	if (omap_type() == OMAP3430_REV_ES1_0)
-		SET_DMA_ERRATA(DMA_ERRATA_i88);
-
-	/*
-	 * Errata 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	if (!cpu_is_omap15xx())
-		SET_DMA_ERRATA(DMA_ERRATA_3_3);
-}
+	p	= pdata;
+	d	= p->dma_attr;
+	reg_map = pdata->regs;
+	errata	= p->errata;
 
-/*----------------------------------------------------------------------------*/
-
-static int __init omap_init_dma(void)
-{
-	unsigned long base;
-	int ch, r;
-
-	if (cpu_class_is_omap1()) {
-		base = OMAP1_DMA_BASE;
-		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
-	} else if (cpu_is_omap24xx()) {
-		base = OMAP24XX_DMA4_BASE;
-		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
-	} else if (cpu_is_omap34xx()) {
-		base = OMAP34XX_DMA4_BASE;
-		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
-	} else if (cpu_is_omap44xx()) {
-		base = OMAP44XX_DMA4_BASE;
-		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
-	} else {
-		pr_err("DMA init failed for unsupported omap\n");
-		return -ENODEV;
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
+		return -EINVAL;
 	}
 
-	dma_base = ioremap(base, SZ_4K);
-	BUG_ON(!dma_base);
+	dma_base = ioremap(mem->start, resource_size(mem));
+	if (!dma_base) {
+		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
+		ret = -ENOMEM;
+		goto exit_release_region;
+	}
 
 	if (cpu_class_is_omap2() && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
-		dma_lch_count = omap_dma_reserve_channels;
+		d->lch_count = omap_dma_reserve_channels;
 
-	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
-				GFP_KERNEL);
-	if (!dma_chan) {
-		r = -ENOMEM;
-		goto out_unmap;
-	}
+	dma_lch_count		= d->lch_count;
+	dma_chan_count		= dma_lch_count;
+	dma_chan		= d->chan;
 
 	if (cpu_class_is_omap2()) {
 		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
 						dma_lch_count, GFP_KERNEL);
 		if (!dma_linked_lch) {
-			r = -ENOMEM;
-			goto out_free;
+			ret = -ENOMEM;
+			goto exit_dma_chan;
 		}
 	}
+	enable_1510_mode = d->dev_caps & ENABLE_1510_MODE;
 
-	if (cpu_is_omap15xx()) {
-		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
-		dma_chan_count = 9;
-		enable_1510_mode = 1;
-	} else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
-		printk(KERN_INFO "OMAP DMA hardware version %d\n",
-		       dma_read(HW_ID, 0));
-		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
-		       (dma_read(CAPS1_0_U, 0) << 16) |
-		       dma_read(CAPS1_0_L, 0),
-		       (dma_read(CAPS1_1_U, 0) << 16) |
-		       dma_read(CAPS1_1_L, 0),
-		       dma_read(CAPS1_2, 0), dma_read(CAPS1_3, 0),
-		       dma_read(CAPS1_4, 0));
-		if (!enable_1510_mode) {
-			u16 w;
-
-			/* Disable OMAP 3.0/3.1 compatibility mode. */
-			w = dma_read(GSCR, 0);
-			w |= 1 << 3;
-			dma_write(w, GSCR, 0);
-			dma_chan_count = 16;
-		} else
-			dma_chan_count = 9;
-	} else if (cpu_class_is_omap2()) {
-		u8 revision = dma_read(REVISION, 0) & 0xff;
-		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
-		       revision >> 4, revision & 0xf);
-		dma_chan_count = dma_lch_count;
-	} else {
-		dma_chan_count = 0;
-		return 0;
-	}
+	p->show_dma_caps();
 
 	spin_lock_init(&dma_chan_lock);
-
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
 		if (cpu_class_is_omap2())
@@ -2478,19 +2353,30 @@ static int __init omap_init_dma(void)
 			 * request_irq() doesn't like dev_id (ie. ch) being
 			 * zero, so we have to kludge around this.
 			 */
-			r = request_irq(omap1_dma_irq[ch],
+			sprintf(&irq_name[0], "%d", ch);
+			dma_irq = platform_get_irq_byname(pdev, irq_name);
+
+			if (dma_irq < 0) {
+				dev_err(&pdev->dev, "%s:unable to get irq\n",
+								__func__);
+				ret = dma_irq;
+				goto exit_unmap;
+			}
+			ret = request_irq(dma_irq,
 					omap1_dma_irq_handler, 0, "DMA",
 					(void *) (ch + 1));
-			if (r != 0) {
-				int i;
-
-				printk(KERN_ERR "unable to request IRQ %d "
-				       "for DMA (error %d)\n",
-				       omap1_dma_irq[ch], r);
-				for (i = 0; i < ch; i++)
-					free_irq(omap1_dma_irq[i],
-						 (void *) (i + 1));
-				goto out_free;
+			if (ret != 0) {
+				int irq_rel;
+				dev_err(&pdev->dev, "unable to request IRQ %d"
+					"for DMA (error %d)\n", dma_irq, ret);
+				for (irq_rel = 0; irq_rel < ch;
+								irq_rel++) {
+					dma_irq = platform_get_irq(pdev,
+								irq_rel);
+					free_irq(dma_irq, (void *)
+							(irq_rel + 1));
+					goto exit_dma_chan;
+				}
 			}
 		}
 	}
@@ -2500,49 +2386,62 @@ static int __init omap_init_dma(void)
 				DMA_DEFAULT_FIFO_DEPTH, 0);
 
 	if (cpu_class_is_omap2()) {
-		int irq;
-		if (cpu_is_omap44xx())
-			irq = OMAP44XX_IRQ_SDMA_0;
-		else
-			irq = INT_24XX_SDMA_IRQ0;
-		setup_irq(irq, &omap24xx_dma_irq);
-	}
-
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		/* Enable smartidle idlemodes and autoidle */
-		u32 v = dma_read(OCP_SYSCONFIG, 0);
-		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
-				DMA_SYSCONFIG_SIDLEMODE_MASK |
-				DMA_SYSCONFIG_AUTOIDLE);
-		v |= (DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
-			DMA_SYSCONFIG_SIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
-			DMA_SYSCONFIG_AUTOIDLE);
-		dma_write(v , OCP_SYSCONFIG, 0);
-		/* reserve dma channels 0 and 1 in high security devices */
-		if (cpu_is_omap34xx() &&
-			(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
-			printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
-					"HS ROM code\n");
-			dma_chan[0].dev_id = 0;
-			dma_chan[1].dev_id = 1;
-		}
+		strcpy(irq_name, "0");
+		dma_irq = platform_get_irq_byname(pdev, irq_name);
+		setup_irq(dma_irq, &omap24xx_dma_irq);
 	}
 
-	/* Configure errata handling for all omap's */
-	configure_dma_errata();
-
+	/* reserve dma channels 0 and 1 in high security devices */
+	if (cpu_is_omap34xx() &&
+		(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
+		printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
+				"HS ROM code\n");
+		dma_chan[0].dev_id = 0;
+		dma_chan[1].dev_id = 1;
+	}
 	return 0;
 
-out_free:
+exit_dma_chan:
 	kfree(dma_chan);
+exit_unmap:
+	iounmap(dma_base);
+exit_release_region:
+	release_mem_region(mem->start, resource_size(mem));
+	return ret;
+}
 
-out_unmap:
+static int __devexit omap_system_dma_remove(struct platform_device *pdev)
+{
+	struct resource *mem;
 	iounmap(dma_base);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	return 0;
+}
+
+static struct platform_driver omap_system_dma_driver = {
+	.probe		= omap_system_dma_probe,
+	.remove		= omap_system_dma_remove,
+	.driver		= {
+		.name	= "omap_dma_system"
+	},
+};
 
-	return r;
+static int __init omap_system_dma_init(void)
+{
+	return platform_driver_register(&omap_system_dma_driver);
+}
+arch_initcall(omap_system_dma_init);
+
+static void __exit omap_system_dma_exit(void)
+{
+	platform_driver_unregister(&omap_system_dma_driver);
 }
 
-arch_initcall(omap_init_dma);
+MODULE_DESCRIPTION("OMAP SYSTEM DMA DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
 
 /*
  * Reserve the omap SDMA channels using cmdline bootarg
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 9757b22..e3a927d 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -21,21 +21,15 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
 
-/* Move omap4 specific defines to dma-44xx.h */
-#include "dma-44xx.h"
-
-/* Hardware registers for omap1 */
-#define OMAP1_DMA_BASE			(0xfffed800)
-
-/* Hardware registers for omap2 and omap3 */
-#define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
-#define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
-#define OMAP44XX_DMA4_BASE		(L4_44XX_BASE + 0x56000)
+#include <linux/platform_device.h>
 
-#define OMAP1_LOGICAL_DMA_CH_COUNT	17
-#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
+/*
+ * TODO: These dma channel defines should go away once all
+ * the omap drivers hwmod adapted.
+ */
 
-/*----------------------------------------------------------------------------*/
+/* Move omap4 specific defines to dma-44xx.h */
+#include "dma-44xx.h"
 
 /* DMA channels for omap1 */
 #define OMAP_DMA_NO_DEVICE		0
@@ -377,9 +371,39 @@ struct omap_dma_channel_params {
 #endif
 };
 
+#include <mach/dma.h>
+struct omap_dma_lch {
+	int next_lch;
+	int dev_id;
+	u16 saved_csr;
+	u16 enabled_irqs;
+	const char *dev_name;
+	void (*callback)(int lch, u16 ch_status, void *data);
+	void *data;
+	long flags;
+	/* required for Dynamic chaining */
+	int prev_linked_ch;
+	int next_linked_ch;
+	int state;
+	int chain_id;
+	int status;
+};
+
 struct omap_dma_dev_attr {
 	u32 dev_caps;
 	u16 lch_count;
+	u16 chan_count;
+	struct omap_dma_lch *chan;
+};
+
+/* System DMA platform data structure */
+struct omap_system_dma_plat_info {
+	struct omap_dma_dev_attr *dma_attr;
+	void __iomem *omap_dma_base;
+	u32 errata;
+	u16 *regs;
+	void (*disable_irq_lch)(int lch);
+	void (*show_dma_caps)(void);
 };
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
-- 
1.7.1

