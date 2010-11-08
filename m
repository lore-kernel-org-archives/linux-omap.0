From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v4 10/13] OMAP: DMA: Convert DMA library into DMA platform Driver
Date: Mon,  8 Nov 2010 19:37:49 +0530
Message-ID: <1289225272-9767-11-git-send-email-manjugk@ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48273 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754796Ab0KHOID (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 09:08:03 -0500
In-Reply-To: <1289225272-9767-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Convert DMA library into DMA platform driver and make use
of platform data provided by hwmod data base for OMAP2PLUS onwards.
For OMAP1 processors, the DMA driver in mach-omap uses resource
structures for getting platform data.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/Makefile           |    2 +-
 arch/arm/mach-omap1/dma.c              |  182 ++++++++-
 arch/arm/mach-omap2/Makefile           |    2 +-
 arch/arm/mach-omap2/dma.c              |  211 +++++++++-
 arch/arm/mach-omap2/include/mach/dma.h |    3 +
 arch/arm/plat-omap/dma.c               |  748 +++++++++++++-------------------
 arch/arm/plat-omap/include/plat/dma.h  |   52 ++-
 7 files changed, 739 insertions(+), 461 deletions(-)

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
index e756069..b9d1635 100644
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
 
@@ -158,20 +288,68 @@ static int __init omap1_system_dma_init(void)
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
+	p->dma_write		= dma_write;
+	p->dma_read		= dma_read;
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
index 60e51bc..f16e38e 100644
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
index 30b20cd..d03c261 100644
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
@@ -60,6 +239,16 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 			__func__, name, oh->name);
 		return -ENOMEM;
 	}
+	p->regs			= reg_map;
+	p->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
+	p->disable_irq_lch	= disable_irq_lch;
+	p->show_dma_caps	= omap2_show_dma_caps;
+	p->dma_write		= dma_write;
+	p->dma_read		= dma_read;
+
+	/* Configure errata handling for all omap2+'s */
+	p->errata		= configure_dma_errata();
+
 	od = omap_device_build(name, 0, oh, p, sizeof(*p),
 			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
 
@@ -71,6 +260,26 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
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
index 0e1c7b4..562fe66 100644
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
@@ -296,43 +273,6 @@ static inline void omap_enable_channel_irq(int lch);
 #define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
 						__func__);
 
-static inline void dma_write(u32 val, int reg, int lch)
-{
-	if (cpu_class_is_omap1()) {
-		if (reg > OMAP1_CH_COMMON_START)
-			__raw_writew(val, dma_base +
-				(reg_map_omap1[reg] + 0x40 * lch));
-		else
-			__raw_writew(val, dma_base + reg_map_omap1[reg]);
-	} else {
-		if (reg > OMAP2_CH_COMMON_START)
-			__raw_writel(val, dma_base +
-				(reg_map_omap2[reg] + 0x60 * lch));
-		else
-			__raw_writel(val, dma_base + reg_map_omap2[reg]);
-	}
-}
-
-static inline u32 dma_read(int reg, int lch)
-{
-	u32 val;
-
-	if (cpu_class_is_omap1()) {
-		if (reg > OMAP1_CH_COMMON_START)
-			val = __raw_readw(dma_base +
-					(reg_map_omap1[reg] + 0x40 * lch));
-		else
-			val = __raw_readw(dma_base + reg_map_omap1[reg]);
-	} else {
-		if (reg > OMAP2_CH_COMMON_START)
-			val = __raw_readl(dma_base +
-					(reg_map_omap2[reg] + 0x60 * lch));
-		else
-			val = __raw_readl(dma_base + reg_map_omap2[reg]);
-	}
-	return val;
-}
-
 #ifdef CONFIG_ARCH_OMAP15XX
 /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
 int omap_dma_in_1510_mode(void)
@@ -373,7 +313,7 @@ static void clear_lch_regs(int lch)
 	int i = OMAP1_CH_COMMON_START;
 
 	for (; i <= OMAP1_CH_COMMON_END; i += 1)
-		dma_write(0, i, lch);
+		p->dma_write(0, i, lch);
 }
 
 void omap_set_dma_priority(int lch, int dst_port, int priority)
@@ -408,12 +348,12 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 	if (cpu_class_is_omap2()) {
 		u32 ccr;
 
-		ccr = dma_read(CCR2, lch);
+		ccr = p->dma_read(CCR2, lch);
 		if (priority)
 			ccr |= (1 << 6);
 		else
 			ccr &= ~(1 << 6);
-		dma_write(ccr, CCR2, lch);
+		p->dma_write(ccr, CCR2, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_priority);
@@ -427,33 +367,33 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 	if (cpu_class_is_omap1()) {
 		u16 ccr;
 
-		l = dma_read(CSDP1, lch);
+		l = p->dma_read(CSDP1, lch);
 		l &= ~0x03;
 		l |= data_type;
-		dma_write(l, CSDP1, lch);
+		p->dma_write(l, CSDP1, lch);
 
-		ccr = dma_read(CCR1, lch);
+		ccr = p->dma_read(CCR1, lch);
 		ccr &= ~(1 << 5);
 		if (sync_mode == OMAP_DMA_SYNC_FRAME)
 			ccr |= 1 << 5;
-		dma_write(ccr, CCR1, lch);
+		p->dma_write(ccr, CCR1, lch);
 
-		ccr = dma_read(CCR1_2, lch);
+		ccr = p->dma_read(CCR1_2, lch);
 		ccr &= ~(1 << 2);
 		if (sync_mode == OMAP_DMA_SYNC_BLOCK)
 			ccr |= 1 << 2;
-		dma_write(ccr, CCR1_2, lch);
+		p->dma_write(ccr, CCR1_2, lch);
 	}
 
 	if (cpu_class_is_omap2() && dma_trigger) {
 		u32 val;
 
-		l = dma_read(CSDP2, lch);
+		l = p->dma_read(CSDP2, lch);
 		l &= ~0x03;
 		l |= data_type;
-		dma_write(l, CSDP2, lch);
+		p->dma_write(l, CSDP2, lch);
 
-		val = dma_read(CCR2, lch);
+		val = p->dma_read(CCR2, lch);
 
 		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
 		val &= ~((1 << 23) | (3 << 19) | 0x1f);
@@ -478,14 +418,14 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 		} else {
 			val &= ~(1 << 24);	/* dest synch */
 		}
-		dma_write(val, CCR2, lch);
+		p->dma_write(val, CCR2, lch);
 	}
 	if (cpu_class_is_omap1()) {
-		dma_write(elem_count, CEN1, lch);
-		dma_write(frame_count, CFN1, lch);
+		p->dma_write(elem_count, CEN1, lch);
+		p->dma_write(frame_count, CFN1, lch);
 	} else {
-		dma_write(elem_count, CEN2, lch);
-		dma_write(frame_count, CFN2, lch);
+		p->dma_write(elem_count, CEN2, lch);
+		p->dma_write(frame_count, CFN2, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
@@ -497,7 +437,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
-		w = dma_read(CCR1_2, lch);
+		w = p->dma_read(CCR1_2, lch);
 		w &= ~0x03;
 
 		switch (mode) {
@@ -512,23 +452,23 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		default:
 			BUG();
 		}
-		dma_write(w, CCR1_2, lch);
+		p->dma_write(w, CCR1_2, lch);
 
-		w = dma_read(LCH_CTRL, lch);
+		w = p->dma_read(LCH_CTRL, lch);
 		w &= ~0x0f;
 		/* Default is channel type 2D */
 		if (mode) {
-			dma_write((u16)color, COLOR_L, lch);
-			dma_write((u16)(color >> 16), COLOR_U, lch);
+			p->dma_write((u16)color, COLOR_L, lch);
+			p->dma_write((u16)(color >> 16), COLOR_U, lch);
 			w |= 1;		/* Channel type G */
 		}
-		dma_write(w, LCH_CTRL, lch);
+		p->dma_write(w, LCH_CTRL, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		u32 val;
 
-		val = dma_read(CCR2, lch);
+		val = p->dma_read(CCR2, lch);
 		val &= ~((1 << 17) | (1 << 16));
 
 		switch (mode) {
@@ -543,10 +483,10 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		default:
 			BUG();
 		}
-		dma_write(val, CCR2, lch);
+		p->dma_write(val, CCR2, lch);
 
 		color &= 0xffffff;
-		dma_write(color, COLOR, lch);
+		p->dma_write(color, COLOR, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_color_mode);
@@ -556,10 +496,10 @@ void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 	if (cpu_class_is_omap2()) {
 		u32 csdp;
 
-		csdp = dma_read(CSDP2, lch);
+		csdp = p->dma_read(CSDP2, lch);
 		csdp &= ~(0x3 << 16);
 		csdp |= (mode << 16);
-		dma_write(csdp, CSDP2, lch);
+		p->dma_write(csdp, CSDP2, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_write_mode);
@@ -569,10 +509,10 @@ void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
 	if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
 		u32 l;
 
-		l = dma_read(LCH_CTRL, lch);
+		l = p->dma_read(LCH_CTRL, lch);
 		l &= ~0x7;
 		l |= mode;
-		dma_write(l, LCH_CTRL, lch);
+		p->dma_write(l, LCH_CTRL, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_channel_mode);
@@ -587,37 +527,37 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
-		w = dma_read(CSDP1, lch);
+		w = p->dma_read(CSDP1, lch);
 		w &= ~(0x1f << 2);
 		w |= src_port << 2;
-		dma_write(w, CSDP1, lch);
+		p->dma_write(w, CSDP1, lch);
 
-		l = dma_read(CCR1, lch);
+		l = p->dma_read(CCR1, lch);
 	} else
-		l = dma_read(CCR2, lch);
+		l = p->dma_read(CCR2, lch);
 
 	l &= ~(0x03 << 12);
 	l |= src_amode << 12;
 
 	if (cpu_class_is_omap1())
-		dma_write(l, CCR1, lch);
+		p->dma_write(l, CCR1, lch);
 	else
-		dma_write(l, CCR2, lch);
+		p->dma_write(l, CCR2, lch);
 
 	if (cpu_class_is_omap1()) {
-		dma_write(src_start >> 16, CSSA_U, lch);
-		dma_write((u16)src_start, CSSA_L, lch);
+		p->dma_write(src_start >> 16, CSSA_U, lch);
+		p->dma_write((u16)src_start, CSSA_L, lch);
 	}
 
 	if (cpu_class_is_omap2())
-		dma_write(src_start, CSSA, lch);
+		p->dma_write(src_start, CSSA, lch);
 
 	if (cpu_class_is_omap1()) {
-		dma_write(src_ei, CSEI1, lch);
-		dma_write(src_fi, CSFI1, lch);
+		p->dma_write(src_ei, CSEI1, lch);
+		p->dma_write(src_fi, CSFI1, lch);
 	} else {
-		dma_write(src_ei, CSEI2, lch);
-		dma_write(src_fi, CSFI2, lch);
+		p->dma_write(src_ei, CSEI2, lch);
+		p->dma_write(src_fi, CSFI2, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
@@ -646,8 +586,8 @@ void omap_set_dma_src_index(int lch, int eidx, int fidx)
 	if (cpu_class_is_omap2())
 		return;
 
-	dma_write(eidx, CSEI1, lch);
-	dma_write(fidx, CSFI1, lch);
+	p->dma_write(eidx, CSEI1, lch);
+	p->dma_write(fidx, CSFI1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_index);
 
@@ -656,18 +596,18 @@ void omap_set_dma_src_data_pack(int lch, int enable)
 	u32 l;
 
 	if (cpu_class_is_omap1())
-		l = dma_read(CSDP1, lch);
+		l = p->dma_read(CSDP1, lch);
 	else
-		l = dma_read(CSDP2, lch);
+		l = p->dma_read(CSDP2, lch);
 
 	l &= ~(1 << 6);
 	if (enable)
 		l |= (1 << 6);
 
 	if (cpu_class_is_omap1())
-		dma_write(l, CSDP1, lch);
+		p->dma_write(l, CSDP1, lch);
 	else
-		dma_write(l, CSDP2, lch);
+		p->dma_write(l, CSDP2, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_data_pack);
 
@@ -677,9 +617,9 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	u32 l;
 
 	if (cpu_class_is_omap2())
-		l = dma_read(CSDP2, lch);
+		l = p->dma_read(CSDP2, lch);
 	else
-		l = dma_read(CSDP1, lch);
+		l = p->dma_read(CSDP1, lch);
 
 	l &= ~(0x03 << 7);
 
@@ -718,9 +658,9 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	l |= (burst << 7);
 
 	if (cpu_class_is_omap2())
-		dma_write(l, CSDP2, lch);
+		p->dma_write(l, CSDP2, lch);
 	else
-		dma_write(l, CSDP1, lch);
+		p->dma_write(l, CSDP1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
 
@@ -732,37 +672,37 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 	u32 l;
 
 	if (cpu_class_is_omap1()) {
-		l = dma_read(CSDP1, lch);
+		l = p->dma_read(CSDP1, lch);
 		l &= ~(0x1f << 9);
 		l |= dest_port << 9;
-		dma_write(l, CSDP1, lch);
+		p->dma_write(l, CSDP1, lch);
 
-		l = dma_read(CCR1, lch);
+		l = p->dma_read(CCR1, lch);
 	} else
-		l = dma_read(CCR2, lch);
+		l = p->dma_read(CCR2, lch);
 
 	l &= ~(0x03 << 14);
 	l |= dest_amode << 14;
 
 	if (cpu_class_is_omap1())
-		dma_write(l, CCR1, lch);
+		p->dma_write(l, CCR1, lch);
 	else
-		dma_write(l, CCR2, lch);
+		p->dma_write(l, CCR2, lch);
 
 	if (cpu_class_is_omap1()) {
-		dma_write(dest_start >> 16, CDSA_U, lch);
-		dma_write(dest_start, CDSA_L, lch);
+		p->dma_write(dest_start >> 16, CDSA_U, lch);
+		p->dma_write(dest_start, CDSA_L, lch);
 	}
 
 	if (cpu_class_is_omap2())
-		dma_write(dest_start, CDSA, lch);
+		p->dma_write(dest_start, CDSA, lch);
 
 	if (cpu_class_is_omap1()) {
-		dma_write(dst_ei, CDEI1, lch);
-		dma_write(dst_fi, CDFI1, lch);
+		p->dma_write(dst_ei, CDEI1, lch);
+		p->dma_write(dst_fi, CDFI1, lch);
 	} else {
-		dma_write(dst_ei, CDEI2, lch);
-		dma_write(dst_fi, CDFI2, lch);
+		p->dma_write(dst_ei, CDEI2, lch);
+		p->dma_write(dst_fi, CDFI2, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
@@ -772,8 +712,8 @@ void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 	if (cpu_class_is_omap2())
 		return;
 
-	dma_write(eidx, CDEI1, lch);
-	dma_write(fidx, CDFI1, lch);
+	p->dma_write(eidx, CDEI1, lch);
+	p->dma_write(fidx, CDFI1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_index);
 
@@ -782,18 +722,18 @@ void omap_set_dma_dest_data_pack(int lch, int enable)
 	u32 l;
 
 	if (cpu_class_is_omap2())
-		l = dma_read(CSDP2, lch);
+		l = p->dma_read(CSDP2, lch);
 	else
-		l = dma_read(CSDP1, lch);
+		l = p->dma_read(CSDP1, lch);
 
 	l &= ~(1 << 13);
 	if (enable)
 		l |= 1 << 13;
 
 	if (cpu_class_is_omap2())
-		dma_write(l, CSDP2, lch);
+		p->dma_write(l, CSDP2, lch);
 	else
-		dma_write(l, CSDP1, lch);
+		p->dma_write(l, CSDP1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
 
@@ -802,9 +742,9 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	unsigned int burst = 0;
 	u32 l;
 	if (cpu_class_is_omap2())
-		l = dma_read(CSDP2, lch);
+		l = p->dma_read(CSDP2, lch);
 	else
-		l = dma_read(CSDP1, lch);
+		l = p->dma_read(CSDP1, lch);
 
 	l &= ~(0x03 << 14);
 
@@ -841,9 +781,9 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	l |= (burst << 14);
 
 	if (cpu_class_is_omap2())
-		dma_write(l, CSDP2, lch);
+		p->dma_write(l, CSDP2, lch);
 	else
-		dma_write(l, CSDP1, lch);
+		p->dma_write(l, CSDP1, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
@@ -853,20 +793,20 @@ static inline void omap_enable_channel_irq(int lch)
 
 	/* Clear CSR */
 	if (cpu_class_is_omap1()) {
-		status = dma_read(CSR1, lch);
-		dma_write(dma_chan[lch].enabled_irqs, CICR1, lch);
+		status = p->dma_read(CSR1, lch);
+		p->dma_write(dma_chan[lch].enabled_irqs, CICR1, lch);
 	} else if (cpu_class_is_omap2()) {
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
-		dma_write(dma_chan[lch].enabled_irqs, CICR2, lch);
+		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
+		p->dma_write(dma_chan[lch].enabled_irqs, CICR2, lch);
 	}
 }
 
 static void omap_disable_channel_irq(int lch)
 {
 	if (cpu_class_is_omap2())
-		dma_write(0, CICR2, lch);
+		p->dma_write(0, CICR2, lch);
 	else
-		dma_write(0, CICR1, lch);
+		p->dma_write(0, CICR1, lch);
 }
 
 void omap_enable_dma_irq(int lch, u16 bits)
@@ -886,10 +826,10 @@ static inline void enable_lnk(int lch)
 	u32 l;
 
 	if (cpu_class_is_omap1()) {
-		l = dma_read(CLNK_CTRL1, lch);
+		l = p->dma_read(CLNK_CTRL1, lch);
 		l &= ~(1 << 14);
 	} else
-		l = dma_read(CLNK_CTRL2, lch);
+		l = p->dma_read(CLNK_CTRL2, lch);
 
 	/* Set the ENABLE_LNK bits */
 	if (dma_chan[lch].next_lch != -1)
@@ -898,9 +838,9 @@ static inline void enable_lnk(int lch)
 	if (cpu_class_is_omap2()) {
 		if (dma_chan[lch].next_linked_ch != -1)
 			l = dma_chan[lch].next_linked_ch | (1 << 15);
-		dma_write(l, CLNK_CTRL2, lch);
+		p->dma_write(l, CLNK_CTRL2, lch);
 	} else
-		dma_write(l, CLNK_CTRL1, lch);
+		p->dma_write(l, CLNK_CTRL1, lch);
 }
 
 static inline void disable_lnk(int lch)
@@ -909,19 +849,19 @@ static inline void disable_lnk(int lch)
 
 	/* Disable interrupts */
 	if (cpu_class_is_omap1()) {
-		l = dma_read(CLNK_CTRL1, lch);
-		dma_write(0, CICR1, lch);
+		l = p->dma_read(CLNK_CTRL1, lch);
+		p->dma_write(0, CICR1, lch);
 		/* Set the STOP_LNK bit */
 		l |= 1 << 14;
-		dma_write(l, CLNK_CTRL1, lch);
+		p->dma_write(l, CLNK_CTRL1, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
-		l = dma_read(CLNK_CTRL2, lch);
+		l = p->dma_read(CLNK_CTRL2, lch);
 		omap_disable_channel_irq(lch);
 		/* Clear the ENABLE_LNK bit */
 		l &= ~(1 << 15);
-		dma_write(l, CLNK_CTRL2, lch);
+		p->dma_write(l, CLNK_CTRL2, lch);
 	}
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
@@ -935,9 +875,9 @@ static inline void omap2_enable_irq_lch(int lch)
 		return;
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0, 0);
+	val = p->dma_read(IRQENABLE_L0, 0);
 	val |= 1 << lch;
-	dma_write(val, IRQENABLE_L0, 0);
+	p->dma_write(val, IRQENABLE_L0, 0);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
@@ -950,9 +890,9 @@ static inline void omap2_disable_irq_lch(int lch)
 		return;
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0, 0);
+	val = p->dma_read(IRQENABLE_L0, 0);
 	val &= ~(1 << lch);
-	dma_write(val, IRQENABLE_L0, 0);
+	p->dma_write(val, IRQENABLE_L0, 0);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
@@ -1017,17 +957,17 @@ int omap_request_dma(int dev_id, const char *dev_name,
 		 * Disable the 1510 compatibility mode and set the sync device
 		 * id.
 		 */
-		dma_write(dev_id | (1 << 10), CCR1, free_ch);
+		p->dma_write(dev_id | (1 << 10), CCR1, free_ch);
 	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
-		dma_write(dev_id, CCR1, free_ch);
+		p->dma_write(dev_id, CCR1, free_ch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		omap2_enable_irq_lch(free_ch);
 		omap_enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, free_ch);
-		dma_write(1 << free_ch, IRQSTATUS_L0, 0);
+		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, free_ch);
+		p->dma_write(1 << free_ch, IRQSTATUS_L0, 0);
 	}
 
 	*dma_ch_out = free_ch;
@@ -1048,23 +988,23 @@ void omap_free_dma(int lch)
 
 	if (cpu_class_is_omap1()) {
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR1, lch);
+		p->dma_write(0, CICR1, lch);
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR1, lch);
+		p->dma_write(0, CCR1, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		omap2_disable_irq_lch(lch);
 
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
-		dma_write(1 << lch, IRQSTATUS_L0, 0);
+		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, lch);
+		p->dma_write(1 << lch, IRQSTATUS_L0, 0);
 
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR2, lch);
+		p->dma_write(0, CICR2, lch);
 
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR2, lch);
+		p->dma_write(0, CCR2, lch);
 		omap_clear_dma(lch);
 	}
 
@@ -1105,7 +1045,7 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 	reg |= (0x3 & tparams) << 12;
 	reg |= (arb_rate & 0xff) << 16;
 
-	dma_write(reg, GCR2, 0);
+	p->dma_write(reg, GCR2, 0);
 }
 EXPORT_SYMBOL(omap_dma_set_global_params);
 
@@ -1130,15 +1070,15 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 	}
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx()) {
-		l = dma_read(CCR2, lch);
+		l = p->dma_read(CCR2, lch);
 		l &= ~((1 << 6) | (1 << 26));
 		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
-		dma_write(l, CCR2, lch);
+		p->dma_write(l, CCR2, lch);
 	} else {
-		l = dma_read(CCR1, lch);
+		l = p->dma_read(CCR1, lch);
 		l &= ~((1 << 6) | (1 << 26));
 		l |= ((read_prio & 0x1) << 6);
-		dma_write(l, CCR1, lch);
+		p->dma_write(l, CCR1, lch);
 	}
 
 	return 0;
@@ -1158,19 +1098,19 @@ void omap_clear_dma(int lch)
 	if (cpu_class_is_omap1()) {
 		u32 l;
 
-		l = dma_read(CCR1, lch);
+		l = p->dma_read(CCR1, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR1, lch);
+		p->dma_write(l, CCR1, lch);
 
 		/* Clear pending interrupts */
-		l = dma_read(CSR1, lch);
+		l = p->dma_read(CSR1, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		int i = OMAP2_CH_COMMON_START;
 
 		for (; i <= OMAP2_CH_COMMON_END; i++)
-			dma_write(0, i, lch);
+			p->dma_write(0, i, lch);
 	}
 
 	local_irq_restore(flags);
@@ -1186,16 +1126,16 @@ void omap_start_dma(int lch)
 	 * before starting dma transfer.
 	 */
 	if (cpu_is_omap15xx())
-		dma_write(0, CPC, lch);
+		p->dma_write(0, CPC, lch);
 	else if (cpu_class_is_omap1())
-		dma_write(0, CDAC1, lch);
+		p->dma_write(0, CDAC1, lch);
 	else
-		dma_write(0, CDAC2, lch);
+		p->dma_write(0, CDAC2, lch);
 
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_chan_count];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
@@ -1218,22 +1158,22 @@ void omap_start_dma(int lch)
 			cur_lch = next_lch;
 		} while (next_lch != -1);
 	} else if (IS_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS))
-		dma_write(lch, CLNK_CTRL2, lch);
+		p->dma_write(lch, CLNK_CTRL2, lch);
 
 	omap_enable_channel_irq(lch);
 
 	if (cpu_class_is_omap1()) {
-		l = dma_read(CCR1, lch);
+		l = p->dma_read(CCR1, lch);
 		l |= OMAP_DMA_CCR_EN;
-		dma_write(l, CCR1, lch);
+		p->dma_write(l, CCR1, lch);
 	} else {
-		l = dma_read(CCR2, lch);
+		l = p->dma_read(CCR2, lch);
 
 		if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
 			l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 
 		l |= OMAP_DMA_CCR_EN;
-		dma_write(l, CCR2, lch);
+		p->dma_write(l, CCR2, lch);
 	}
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
@@ -1245,7 +1185,7 @@ void omap_stop_dma(int lch)
 
 	/* Disable all interrupts on the channel */
 	if (cpu_class_is_omap1())
-		dma_write(0, CICR1, lch);
+		p->dma_write(0, CICR1, lch);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
 			(l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
@@ -1253,42 +1193,42 @@ void omap_stop_dma(int lch)
 		u32 sys_cf;
 
 		/* Configure No-Standby */
-		l = dma_read(OCP_SYSCONFIG, 0);
+		l = p->dma_read(OCP_SYSCONFIG, 0);
 		sys_cf = l;
 		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
 		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		dma_write(l , OCP_SYSCONFIG, 0);
+		p->dma_write(l , OCP_SYSCONFIG, 0);
 
-		l = dma_read(CCR2, lch);
+		l = p->dma_read(CCR2, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR2, lch);
+		p->dma_write(l, CCR2, lch);
 
 		/* Wait for sDMA FIFO drain */
-		l = dma_read(CCR2, lch);
+		l = p->dma_read(CCR2, lch);
 		while (i < 100 && (l & (OMAP_DMA_CCR_RD_ACTIVE |
 					OMAP_DMA_CCR_WR_ACTIVE))) {
 			udelay(5);
 			i++;
-			l = dma_read(CCR2, lch);
+			l = p->dma_read(CCR2, lch);
 		}
 		if (i >= 100)
 			printk(KERN_ERR "DMA drain did not complete on "
 					"lch %d\n", lch);
 		/* Restore OCP_SYSCONFIG */
-		dma_write(sys_cf, OCP_SYSCONFIG, 0);
+		p->dma_write(sys_cf, OCP_SYSCONFIG, 0);
 	} else if (cpu_class_is_omap1()) {
-		l = dma_read(CCR1, lch);
+		l = p->dma_read(CCR1, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR1, lch);
+		p->dma_write(l, CCR1, lch);
 	} else {
-		l = dma_read(CCR2, lch);
+		l = p->dma_read(CCR2, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR2, lch);
+		p->dma_write(l, CCR2, lch);
 	}
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_chan_count];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {
@@ -1349,21 +1289,21 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_is_omap15xx())
-		offset = dma_read(CPC, lch);
+		offset = p->dma_read(CPC, lch);
 	else if (cpu_class_is_omap1())
-		offset = dma_read(CSAC1, lch);
+		offset = p->dma_read(CSAC1, lch);
 	else
-		offset = dma_read(CSAC2, lch);
+		offset = p->dma_read(CSAC2, lch);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0) {
 		if (cpu_class_is_omap1())
-			offset = dma_read(CSAC1, lch);
+			offset = p->dma_read(CSAC1, lch);
 		else
-			offset = dma_read(CSAC2, lch);
+			offset = p->dma_read(CSAC2, lch);
 	}
 
 	if (cpu_class_is_omap1())
-		offset |= (dma_read(CSSA_U, lch) << 16);
+		offset |= (p->dma_read(CSSA_U, lch) << 16);
 
 	return offset;
 }
@@ -1382,11 +1322,11 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_is_omap15xx())
-		offset = dma_read(CPC, lch);
+		offset = p->dma_read(CPC, lch);
 	else if (cpu_class_is_omap1())
-		offset = dma_read(CDAC1, lch);
+		offset = p->dma_read(CDAC1, lch);
 	else
-		offset = dma_read(CDAC2, lch);
+		offset = p->dma_read(CDAC2, lch);
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
@@ -1394,13 +1334,13 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 	 */
 	if (!cpu_is_omap15xx() && offset == 0) {
 		if (cpu_class_is_omap1())
-			offset = dma_read(CDAC1, lch);
+			offset = p->dma_read(CDAC1, lch);
 		else
-			offset = dma_read(CDAC2, lch);
+			offset = p->dma_read(CDAC2, lch);
 	}
 
 	if (cpu_class_is_omap1())
-		offset |= (dma_read(CDSA_U, lch) << 16);
+		offset |= (p->dma_read(CDSA_U, lch) << 16);
 
 	return offset;
 }
@@ -1409,9 +1349,9 @@ EXPORT_SYMBOL(omap_get_dma_dst_pos);
 int omap_get_dma_active_status(int lch)
 {
 	if (cpu_class_is_omap1())
-		return (dma_read(CCR1, lch) & OMAP_DMA_CCR_EN) != 0;
+		return (p->dma_read(CCR1, lch) & OMAP_DMA_CCR_EN) != 0;
 	else
-		return (dma_read(CCR2, lch) & OMAP_DMA_CCR_EN) != 0;
+		return (p->dma_read(CCR2, lch) & OMAP_DMA_CCR_EN) != 0;
 }
 EXPORT_SYMBOL(omap_get_dma_active_status);
 
@@ -1421,10 +1361,10 @@ int omap_dma_running(void)
 
 	for (lch = 0; lch < dma_chan_count; lch++) {
 		if (cpu_class_is_omap1()) {
-			if (dma_read(CCR1, lch) & OMAP_DMA_CCR_EN)
+			if (p->dma_read(CCR1, lch) & OMAP_DMA_CCR_EN)
 				return 1;
 		} else {
-			if (dma_read(CCR2, lch) & OMAP_DMA_CCR_EN)
+			if (p->dma_read(CCR2, lch) & OMAP_DMA_CCR_EN)
 				return 1;
 		}
 	}
@@ -1440,7 +1380,7 @@ void omap_dma_link_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR1, lch_head) | (3 << 8),
+			p->dma_write(p->dma_read(CCR1, lch_head) | (3 << 8),
 							CCR1, lch_head);
 			return;
 		}
@@ -1467,7 +1407,7 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR1, lch_head) & ~(3 << 8),
+			p->dma_write(p->dma_read(CCR1, lch_head) & ~(3 << 8),
 								CCR1, lch_head);
 			return;
 		}
@@ -1494,8 +1434,6 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 }
 EXPORT_SYMBOL(omap_dma_unlink_lch);
 
-/*----------------------------------------------------------------------------*/
-
 #ifndef CONFIG_ARCH_OMAP1
 /* Create chain of DMA channesls */
 static void create_dma_lch_chain(int lch_head, int lch_queue)
@@ -1520,15 +1458,15 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 					lch_queue;
 	}
 
-	l = dma_read(CLNK_CTRL2, lch_head);
+	l = p->dma_read(CLNK_CTRL2, lch_head);
 	l &= ~(0x1f);
 	l |= lch_queue;
-	dma_write(l, CLNK_CTRL2, lch_head);
+	p->dma_write(l, CLNK_CTRL2, lch_head);
 
-	l = dma_read(CLNK_CTRL2, lch_queue);
+	l = p->dma_read(CLNK_CTRL2, lch_queue);
 	l &= ~(0x1f);
 	l |= (dma_chan[lch_queue].next_linked_ch);
-	dma_write(l, CLNK_CTRL2, lch_queue);
+	p->dma_write(l, CLNK_CTRL2, lch_queue);
 }
 
 /**
@@ -1804,13 +1742,13 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 
 	/* Set the params to the free channel */
 	if (src_start != 0)
-		dma_write(src_start, CSSA, lch);
+		p->dma_write(src_start, CSSA, lch);
 	if (dest_start != 0)
-		dma_write(dest_start, CDSA, lch);
+		p->dma_write(dest_start, CDSA, lch);
 
 	/* Write the buffer size */
-	dma_write(elem_count, CEN2, lch);
-	dma_write(frame_count, CFN2, lch);
+	p->dma_write(elem_count, CEN2, lch);
+	p->dma_write(frame_count, CFN2, lch);
 
 	/*
 	 * If the chain is dynamically linked,
@@ -1843,7 +1781,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 				enable_lnk(dma_chan[lch].prev_linked_ch);
 				dma_chan[lch].state = DMA_CH_QUEUED;
 				start_dma = 0;
-				if (0 == ((1 << 7) & dma_read(
+				if (0 == ((1 << 7) & p->dma_read(
 					CCR2, dma_chan[lch].prev_linked_ch))) {
 					disable_lnk(dma_chan[lch].
 						    prev_linked_ch);
@@ -1860,7 +1798,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			}
 			omap_enable_channel_irq(lch);
 
-			l = dma_read(CCR2, lch);
+			l = p->dma_read(CCR2, lch);
 
 			if ((0 == (l & (1 << 24))))
 				l &= ~(1 << 25);
@@ -1871,12 +1809,12 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 					l |= (1 << 7);
 					dma_chan[lch].state = DMA_CH_STARTED;
 					pr_debug("starting %d\n", lch);
-					dma_write(l, CCR2, lch);
+					p->dma_write(l, CCR2, lch);
 				} else
 					start_dma = 0;
 			} else {
 				if (0 == (l & (1 << 7)))
-					dma_write(l, CCR2, lch);
+					p->dma_write(l, CCR2, lch);
 			}
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
@@ -1921,7 +1859,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 		omap_enable_channel_irq(channels[0]);
 	}
 
-	l = dma_read(CCR2, channels[0]);
+	l = p->dma_read(CCR2, channels[0]);
 	l |= (1 << 7);
 	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
 	dma_chan[channels[0]].state = DMA_CH_STARTED;
@@ -1930,7 +1868,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 		l &= ~(1 << 25);
 	else
 		l |= (1 << 25);
-	dma_write(l, CCR2, channels[0]);
+	p->dma_write(l, CCR2, channels[0]);
 
 	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
 
@@ -1966,19 +1904,19 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
-		sys_cf = dma_read(OCP_SYSCONFIG, 0);
+		sys_cf = p->dma_read(OCP_SYSCONFIG, 0);
 		l = sys_cf;
 		/* Middle mode reg set no Standby */
 		l &= ~((1 << 12)|(1 << 13));
-		dma_write(l, OCP_SYSCONFIG, 0);
+		p->dma_write(l, OCP_SYSCONFIG, 0);
 	}
 
 	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
 
 		/* Stop the Channel transmission */
-		l = dma_read(CCR2, channels[i]);
+		l = p->dma_read(CCR2, channels[i]);
 		l &= ~(1 << 7);
-		dma_write(l, CCR2, channels[i]);
+		p->dma_write(l, CCR2, channels[i]);
 
 		/* Disable the link in all the channels */
 		disable_lnk(channels[i]);
@@ -1991,7 +1929,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
-		dma_write(sys_cf, OCP_SYSCONFIG, 0);
+		p->dma_write(sys_cf, OCP_SYSCONFIG, 0);
 
 	return 0;
 }
@@ -2033,8 +1971,8 @@ int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	*ei = dma_read(CCEN, lch);
-	*fi = dma_read(CCFN, lch);
+	*ei = p->dma_read(CCEN, lch);
+	*fi = p->dma_read(CCFN, lch);
 
 	return 0;
 }
@@ -2071,7 +2009,7 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return dma_read(CDAC2, lch);
+	return p->dma_read(CDAC2, lch);
 }
 EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
 
@@ -2105,7 +2043,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return dma_read(CSAC2, lch);
+	return p->dma_read(CSAC2, lch);
 }
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */
@@ -2122,7 +2060,7 @@ static int omap1_dma_handle_ch(int ch)
 		csr = dma_chan[ch].saved_csr;
 		dma_chan[ch].saved_csr = 0;
 	} else
-		csr = dma_read(CSR1, ch);
+		csr = p->dma_read(CSR1, ch);
 	if (enable_1510_mode && ch <= 2 && (csr >> 7) != 0) {
 		dma_chan[ch + 6].saved_csr = csr >> 7;
 		csr &= 0x7f;
@@ -2175,13 +2113,13 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 
 static int omap2_dma_handle_ch(int ch)
 {
-	u32 status = dma_read(CSR2, ch);
+	u32 status = p->dma_read(CSR2, ch);
 
 	if (!status) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
 				ch);
-		dma_write(1 << ch, IRQSTATUS_L0, 0);
+		p->dma_write(1 << ch, IRQSTATUS_L0, 0);
 		return 0;
 	}
 	if (unlikely(dma_chan[ch].dev_id == -1)) {
@@ -2200,9 +2138,9 @@ static int omap2_dma_handle_ch(int ch)
 		if (IS_DMA_ERRATA(DMA_ERRATA_i378)) {
 			u32 ccr;
 
-			ccr = dma_read(CCR2, ch);
+			ccr = p->dma_read(CCR2, ch);
 			ccr &= ~OMAP_DMA_CCR_EN;
-			dma_write(ccr, CCR2, ch);
+			p->dma_write(ccr, CCR2, ch);
 			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
 		}
 	}
@@ -2213,16 +2151,16 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO "DMA misaligned error with device %d\n",
 		       dma_chan[ch].dev_id);
 
-	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, ch);
-	dma_write(1 << ch, IRQSTATUS_L0, ch);
+	p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR2, ch);
+	p->dma_write(1 << ch, IRQSTATUS_L0, ch);
 	/* read back the register to flush the write */
-	dma_read(IRQSTATUS_L0, ch);
+	p->dma_read(IRQSTATUS_L0, ch);
 
 	/* If the ch is not chained then chain_id will be -1 */
 	if (dma_chan[ch].chain_id != -1) {
 		int chain_id = dma_chan[ch].chain_id;
 		dma_chan[ch].state = DMA_CH_NOTSTARTED;
-		if (dma_read(CLNK_CTRL2, ch) & (1 << 15))
+		if (p->dma_read(CLNK_CTRL2, ch) & (1 << 15))
 			dma_chan[dma_chan[ch].next_linked_ch].state =
 							DMA_CH_STARTED;
 		if (dma_linked_lch[chain_id].chain_mode ==
@@ -2232,10 +2170,10 @@ static int omap2_dma_handle_ch(int ch)
 		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
 			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
 
-		status = dma_read(CSR2, ch);
+		status = p->dma_read(CSR2, ch);
 	}
 
-	dma_write(status, CSR2, ch);
+	p->dma_write(status, CSR2, ch);
 
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
@@ -2249,13 +2187,13 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 	u32 val, enable_reg;
 	int i;
 
-	val = dma_read(IRQSTATUS_L0, 0);
+	val = p->dma_read(IRQSTATUS_L0, 0);
 	if (val == 0) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
 		return IRQ_HANDLED;
 	}
-	enable_reg = dma_read(IRQENABLE_L0, 0);
+	enable_reg = p->dma_read(IRQENABLE_L0, 0);
 	val &= enable_reg; /* Dispatch only relevant interrupts */
 	for (i = 0; i < dma_lch_count && val != 0; i++) {
 		if (val & 1)
@@ -2281,20 +2219,20 @@ static struct irqaction omap24xx_dma_irq;
 void omap_dma_global_context_save(void)
 {
 	omap_dma_global_context.dma_irqenable_l0 =
-		dma_read(IRQENABLE_L0, 0);
+		p->dma_read(IRQENABLE_L0, 0);
 	omap_dma_global_context.dma_ocp_sysconfig =
-		dma_read(OCP_SYSCONFIG, 0);
-	omap_dma_global_context.dma_gcr = dma_read(GCR2, 0);
+		p->dma_read(OCP_SYSCONFIG, 0);
+	omap_dma_global_context.dma_gcr = p->dma_read(GCR2, 0);
 }
 
 void omap_dma_global_context_restore(void)
 {
 	int ch;
 
-	dma_write(omap_dma_global_context.dma_gcr, GCR2, 0);
-	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
+	p->dma_write(omap_dma_global_context.dma_gcr, GCR2, 0);
+	p->dma_write(omap_dma_global_context.dma_ocp_sysconfig,
 		OCP_SYSCONFIG, 0);
-	dma_write(omap_dma_global_context.dma_irqenable_l0,
+	p->dma_write(omap_dma_global_context.dma_irqenable_l0,
 		IRQENABLE_L0, 0);
 
 	/*
@@ -2304,166 +2242,66 @@ void omap_dma_global_context_restore(void)
 	 * affects only secure devices.
 	 */
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
-		dma_write(0x3 , IRQSTATUS_L0, 0);
+		p->dma_write(0x3 , IRQSTATUS_L0, 0);
 
 	for (ch = 0; ch < dma_chan_count; ch++)
 		if (dma_chan[ch].dev_id != -1)
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
+	p	= pdata;
+	d	= p->dma_attr;
+	reg_map = pdata->regs;
+	errata	= p->errata;
 
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
-
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
@@ -2480,19 +2318,30 @@ static int __init omap_init_dma(void)
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
@@ -2502,49 +2351,62 @@ static int __init omap_init_dma(void)
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
index 9757b22..8133c75 100644
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
@@ -377,9 +371,41 @@ struct omap_dma_channel_params {
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
+	void (*dma_write)(u32 val, int reg, int lch);
+	u32 (*dma_read)(int reg, int lch);
 };
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
-- 
1.7.1

