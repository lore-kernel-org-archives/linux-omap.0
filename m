From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v1 9/9] OMAP: DMA: Convert DMA library into platform driver
Date: Sat,  4 Dec 2010 09:14:06 +0530
Message-ID: <1291434246-30716-10-git-send-email-manjugk@ti.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49991 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab0LDDoU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 22:44:20 -0500
In-Reply-To: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, "G, Manjunath Kondaiah" <manjugk@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Convert DMA library into DMA platform driver and make use of
platform data provided by hwmod data base for OMAP2+ onwards.

For OMAP1 processors, the DMA driver in mach-omap uses resource
structures for getting platform data.

Thanks to Tony Lindgren <tony@atomide.com> for fixing various
omap1 issues and testing the same on OSK5912 board.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/Makefile          |    2 +-
 arch/arm/mach-omap1/dma.c             |  215 +++++++++-
 arch/arm/mach-omap2/Makefile          |    2 +-
 arch/arm/mach-omap2/dma.c             |  223 +++++++++
 arch/arm/plat-omap/dma.c              |  820 +++++++++++----------------------
 arch/arm/plat-omap/include/plat/dma.h |   57 ++-
 6 files changed, 754 insertions(+), 565 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 0b1c07f..6ee1950 100644
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
index b56ee21..17814e0 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -30,6 +30,57 @@
 #include <plat/irqs.h>
 
 #define OMAP1_DMA_BASE			(0xfffed800)
+#define OMAP1_LOGICAL_DMA_CH_COUNT	17
+#define OMAP1_DMA_STRIDE		0x40
+
+static u32 errata;
+static u32 enable_1510_mode;
+static u8 dma_stride;
+static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
+
+static u16 reg_map[] = {
+	[GCR]		= 0x400,
+	[GSCR]		= 0x404,
+	[GRST1]		= 0x408,
+	[HW_ID]		= 0x442,
+	[PCH2_ID]	= 0x444,
+	[PCH0_ID]	= 0x446,
+	[PCH1_ID]	= 0x448,
+	[PCHG_ID]	= 0x44a,
+	[PCHD_ID]	= 0x44c,
+	[CAPS_0]	= 0x44e,
+	[CAPS_1]	= 0x452,
+	[CAPS_2]	= 0x456,
+	[CAPS_3]	= 0x458,
+	[CAPS_4]	= 0x45a,
+	[PCH2_SR]	= 0x460,
+	[PCH0_SR]	= 0x480,
+	[PCH1_SR]	= 0x482,
+	[PCHD_SR]	= 0x4c0,
+
+	/* Common Registers */
+	[CSDP]		= 0x00,
+	[CCR]		= 0x02,
+	[CICR]		= 0x04,
+	[CSR]		= 0x06,
+	[CEN]		= 0x10,
+	[CFN]		= 0x12,
+	[CSFI]		= 0x14,
+	[CSEI]		= 0x16,
+	[CPC]		= 0x18,	/* 15xx only */
+	[CSAC]		= 0x18,
+	[CDAC]		= 0x1a,
+	[CDEI]		= 0x1c,
+	[CDFI]		= 0x1e,
+	[CLNK_CTRL]	= 0x28,
+
+	/* Channel specific register offsets */
+	[CSSA]		= 0x08,
+	[CDSA]		= 0x0c,
+	[COLOR]		= 0x20,
+	[CCR2]		= 0x24,
+	[LCH_CTRL]	= 0x2a,
+};
 
 static struct resource res[] __initdata = {
 	[0] = {
@@ -67,6 +118,7 @@ static struct resource res[] __initdata = {
 		.start  = INT_DMA_CH5,
 		.flags  = IORESOURCE_IRQ,
 	},
+	/* Handled in lcd_dma.c */
 	[7] = {
 		.name   = "6",
 		.start  = INT_DMA_LCD,
@@ -125,9 +177,100 @@ static struct resource res[] __initdata = {
 	},
 };
 
+static void __iomem *dma_base;
+static inline void dma_write(u32 val, int reg, int lch)
+{
+	u8  stride;
+	u32 offset;
+
+	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	offset = reg_map[reg] + (stride * lch);
+
+	__raw_writew(val, dma_base + offset);
+	if ((reg > CLNK_CTRL && reg < CCEN) ||
+			(reg > PCHD_ID && reg < CAPS_2)) {
+		u32 offset2 = reg_map[reg] + 2 + (stride * lch);
+		__raw_writew(val >> 16, dma_base + offset2);
+	}
+}
+
+static inline u32 dma_read(int reg, int lch)
+{
+	u8 stride;
+	u32 offset, val;
+
+	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	offset = reg_map[reg] + (stride * lch);
+
+	val = __raw_readw(dma_base + offset);
+	if ((reg > CLNK_CTRL && reg < CCEN) ||
+			(reg > PCHD_ID && reg < CAPS_2)) {
+		u16 upper;
+		u32 offset2 = reg_map[reg] + 2 + (stride * lch);
+		upper = __raw_readw(dma_base + offset2);
+		val |= (upper << 16);
+	}
+	return val;
+}
+
+static void omap1_clear_lch_regs(int lch)
+{
+	int i = dma_common_ch_start;
+
+	for (; i <= dma_common_ch_end; i += 1)
+		dma_write(0, i, lch);
+}
+
+static void omap1_clear_dma(int lch)
+{
+	u32 l;
+
+	l = dma_read(CCR, lch);
+	l &= ~OMAP_DMA_CCR_EN;
+	dma_write(l, CCR, lch);
+
+	/* Clear pending interrupts */
+	l = dma_read(CSR, lch);
+}
+
+static void omap1_show_dma_caps(void)
+{
+	if (enable_1510_mode) {
+		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
+	} else {
+		u16 w;
+		printk(KERN_INFO "OMAP DMA hardware version %d\n",
+							dma_read(HW_ID, 0));
+		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
+			dma_read(CAPS_0, 0), dma_read(CAPS_1, 0),
+			dma_read(CAPS_2, 0), dma_read(CAPS_3, 0),
+			dma_read(CAPS_4, 0));
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
+	 * Erratum 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
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
 
@@ -138,6 +281,12 @@ static int __init omap1_system_dma_init(void)
 		return -ENOMEM;
 	}
 
+	dma_base = ioremap(res[0].start, resource_size(&res[0]));
+	if (!dma_base) {
+		pr_err("%s: Unable to ioremap\n", __func__);
+		return -ENODEV;
+	}
+
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
@@ -153,22 +302,84 @@ static int __init omap1_system_dma_init(void)
 		goto exit_device_put;
 	}
 
+	d = kzalloc(sizeof(struct omap_dma_dev_attr), GFP_KERNEL);
+	if (!d) {
+		dev_err(&pdev->dev, "%s: Unable to allocate 'd' for %s\n",
+			__func__, pdev->name);
+		ret = -ENOMEM;
+		goto exit_release_p;
+	}
+
+	d->lch_count		= OMAP1_LOGICAL_DMA_CH_COUNT;
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
+
+	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
+					(d->lch_count), GFP_KERNEL);
+	if (!d->chan) {
+		dev_err(&pdev->dev, "%s: Memory allocation failed"
+					"for d->chan!!!\n", __func__);
+		goto exit_release_d;
+	}
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
+	p->dma_attr = d;
+
+	p->show_dma_caps	= omap1_show_dma_caps;
+	p->clear_lch_regs	= omap1_clear_lch_regs;
+	p->clear_dma		= omap1_clear_dma;
+	p->dma_write		= dma_write;
+	p->dma_read		= dma_read;
+	p->disable_irq_lch	= NULL;
+
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
 
+	dma_stride		= OMAP1_DMA_STRIDE;
+	dma_common_ch_start	= CPC;
+	dma_common_ch_end	= COLOR;
+
 	return ret;
 
+exit_release_chan:
+	kfree(d->chan);
+exit_release_d:
+	kfree(d);
+exit_release_p:
+	kfree(p);
 exit_device_put:
 	platform_device_put(pdev);
 exit_device_del:
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fbc8739..b2fe063 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
-	 common.o gpio.o
+	 common.o gpio.o dma.o
 
 omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index e2c897a..4a9a56a 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -32,6 +32,61 @@
 #include <plat/omap_device.h>
 #include <plat/dma.h>
 
+#define OMAP2_DMA_STRIDE	0x60
+
+static u32 errata;
+static u8 dma_stride;
+
+static struct omap_dma_dev_attr *d;
+
+static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
+
+static u16 reg_map[] = {
+	[REVISION]		= 0x00,
+	[GCR]			= 0x78,
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
+	[CCR]			= 0x80,
+	[CLNK_CTRL]		= 0x84,
+	[CICR]			= 0x88,
+	[CSR]			= 0x8c,
+	[CSDP]			= 0x90,
+	[CEN]			= 0x94,
+	[CFN]			= 0x98,
+	[CSEI]			= 0xa4,
+	[CSFI]			= 0xa8,
+	[CDEI]			= 0xac,
+	[CDFI]			= 0xb0,
+	[CSAC]			= 0xb4,
+	[CDAC]			= 0xb8,
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
@@ -40,13 +95,151 @@ static struct omap_device_pm_latency omap2_dma_latency[] = {
 	},
 };
 
+static void __iomem *dma_base;
+static inline void dma_write(u32 val, int reg, int lch)
+{
+	u8  stride;
+	u32 offset;
+
+	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	offset = reg_map[reg] + (stride * lch);
+	__raw_writel(val, dma_base + offset);
+}
+
+static inline u32 dma_read(int reg, int lch)
+{
+	u8 stride;
+	u32 offset, val;
+
+	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	offset = reg_map[reg] + (stride * lch);
+	val = __raw_readl(dma_base + offset);
+	return val;
+}
+
+static inline void omap2_disable_irq_lch(int lch)
+{
+	u32 val;
+
+	val = dma_read(IRQENABLE_L0, lch);
+	val &= ~(1 << lch);
+	dma_write(val, IRQENABLE_L0, lch);
+}
+
+static void omap2_clear_dma(int lch)
+{
+	int i = dma_common_ch_start;
+
+	for (; i <= dma_common_ch_end; i += 1)
+		dma_write(0, i, lch);
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
+	 * Errata applicable for OMAP2430ES1.0 and all omap2420
+	 *
+	 * I.
+	 * Erratum ID: Not Available
+	 * Inter Frame DMA buffering issue DMA will wrongly
+	 * buffer elements if packing and bursting is enabled. This might
+	 * result in data gets stalled in FIFO at the end of the block.
+	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
+	 * guarantee no data will stay in the DMA FIFO in case inter frame
+	 * buffering occurs
+	 *
+	 * II.
+	 * Erratum ID: Not Available
+	 * DMA may hang when several channels are used in parallel
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
+	 * Erratum ID: i378: OMAP2+: sDMA Channel is not disabled
+	 * after a transaction error.
+	 * Workaround: SW should explicitely disable the channel.
+	 */
+	if (cpu_class_is_omap2())
+		SET_DMA_ERRATA(DMA_ERRATA_i378);
+
+	/*
+	 * Erratum ID: i541: sDMA FIFO draining does not finish
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
+	 * Erratum ID: i88 : Special programming model needed to disable DMA
+	 * before end of block.
+	 * Workaround: software must ensure that the DMA is configured in No
+	 * Standby mode(DMAx_OCP_SYSCONFIG.MIDLEMODE = "01")
+	 */
+	if (omap_type() == OMAP3430_REV_ES1_0)
+		SET_DMA_ERRATA(DMA_ERRATA_i88);
+
+	/*
+	 * Erratum 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
+	 * read before the DMA controller finished disabling the channel.
+	 */
+	SET_DMA_ERRATA(DMA_ERRATA_3_3);
+
+	/*
+	 * Erratum ID: Not Available
+	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
+	 * after secure sram context save and restore.
+	 * Work around: Hence we need to manually clear those IRQs to avoid
+	 * spurious interrupts. This affects only secure devices.
+	 */
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		SET_DMA_ERRATA(DMA_ROMCODE_BUG);
+
+	return errata;
+}
+
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 {
 	struct omap_device			*od;
 	struct omap_system_dma_plat_info	*p;
+	struct resource				*mem;
 	char					*name = "omap_dma_system";
 
+	dma_stride		= OMAP2_DMA_STRIDE;
+	dma_common_ch_start	= CSDP;
+	if (cpu_is_omap3630() || cpu_is_omap4430())
+		dma_common_ch_end = CCDN;
+	else
+		dma_common_ch_end = CCFN;
+
 	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
 	if (!p) {
 		pr_err("%s: Unable to allocate pdata for %s:%s\n",
@@ -54,6 +247,17 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		return -ENOMEM;
 	}
 
+	p->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
+	p->disable_irq_lch	= omap2_disable_irq_lch;
+	p->show_dma_caps	= omap2_show_dma_caps;
+	p->clear_dma		= omap2_clear_dma;
+	p->dma_write		= dma_write;
+	p->dma_read		= dma_read;
+
+	p->clear_lch_regs	= NULL;
+
+	p->errata		= configure_dma_errata();
+
 	od = omap_device_build(name, 0, oh, p, sizeof(*p),
 			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
 	kfree(p);
@@ -63,6 +267,25 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		return IS_ERR(od);
 	}
 
+	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&od->pdev.dev, "%s: no mem resource\n", __func__);
+		return -EINVAL;
+	}
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
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 6f51bf3..c4b2b47 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -15,6 +15,10 @@
  *
  * Support functions for the OMAP internal DMA channels.
  *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Converted DMA library into DMA platform driver.
+ *	- G, Manjunath Kondaiah <manjugk@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -40,96 +44,6 @@
 
 #undef DEBUG
 
-static u16 reg_map_omap1[] = {
-	[GCR]		= 0x400,
-	[GSCR]		= 0x404,
-	[GRST1]		= 0x408,
-	[HW_ID]		= 0x442,
-	[PCH2_ID]	= 0x444,
-	[PCH0_ID]	= 0x446,
-	[PCH1_ID]	= 0x448,
-	[PCHG_ID]	= 0x44a,
-	[PCHD_ID]	= 0x44c,
-	[CAPS_0]	= 0x44e,
-	[CAPS_1]	= 0x452,
-	[CAPS_2]	= 0x456,
-	[CAPS_3]	= 0x458,
-	[CAPS_4]	= 0x45a,
-	[PCH2_SR]	= 0x460,
-	[PCH0_SR]	= 0x480,
-	[PCH1_SR]	= 0x482,
-	[PCHD_SR]	= 0x4c0,
-
-	/* Common Registers */
-	[CSDP]		= 0x00,
-	[CCR]		= 0x02,
-	[CICR]		= 0x04,
-	[CSR]		= 0x06,
-	[CEN]		= 0x10,
-	[CFN]		= 0x12,
-	[CSFI]		= 0x14,
-	[CSEI]		= 0x16,
-	[CPC]		= 0x18,	/* 15xx only */
-	[CSAC]		= 0x18,
-	[CDAC]		= 0x1a,
-	[CDEI]		= 0x1c,
-	[CDFI]		= 0x1e,
-	[CLNK_CTRL]	= 0x28,
-
-	/* Channel specific register offsets */
-	[CSSA]		= 0x08,
-	[CDSA]		= 0x0c,
-	[COLOR]		= 0x20,
-	[CCR2]		= 0x24,
-	[LCH_CTRL]	= 0x2a,
-};
-
-static u16 reg_map_omap2[] = {
-	[REVISION]		= 0x00,
-	[GCR]			= 0x78,
-	[IRQSTATUS_L0]		= 0x08,
-	[IRQSTATUS_L1]		= 0x0c,
-	[IRQSTATUS_L2]		= 0x10,
-	[IRQSTATUS_L3]		= 0x14,
-	[IRQENABLE_L0]		= 0x18,
-	[IRQENABLE_L1]		= 0x1c,
-	[IRQENABLE_L2]		= 0x20,
-	[IRQENABLE_L3]		= 0x24,
-	[SYSSTATUS]		= 0x28,
-	[OCP_SYSCONFIG]		= 0x2c,
-	[CAPS_0]		= 0x64,
-	[CAPS_2]		= 0x6c,
-	[CAPS_3]		= 0x70,
-	[CAPS_4]		= 0x74,
-
-	/* Common register offsets */
-	[CCR]			= 0x80,
-	[CLNK_CTRL]		= 0x84,
-	[CICR]			= 0x88,
-	[CSR]			= 0x8c,
-	[CSDP]			= 0x90,
-	[CEN]			= 0x94,
-	[CFN]			= 0x98,
-	[CSEI]			= 0xa4,
-	[CSFI]			= 0xa8,
-	[CDEI]			= 0xac,
-	[CDFI]			= 0xb0,
-	[CSAC]			= 0xb4,
-	[CDAC]			= 0xb8,
-
-	/* Channel specific register offsets */
-	[CSSA]			= 0x9c,
-	[CDSA]			= 0xa0,
-	[CCEN]			= 0xbc,
-	[CCFN]			= 0xc0,
-	[COLOR]			= 0xc4,
-
-	/* OMAP4 specific registers */
-	[CDP]			= 0xd0,
-	[CNDP]			= 0xd4,
-	[CCDN]			= 0xd8,
-};
-
 #ifndef CONFIG_ARCH_OMAP1
 enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
 	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
@@ -143,6 +57,9 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
 
+static struct omap_system_dma_plat_info *p;
+static struct omap_dma_dev_attr *d;
+
 static int enable_1510_mode;
 static u32 errata;
 
@@ -152,27 +69,6 @@ static struct omap_dma_global_context_registers {
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
@@ -228,18 +124,6 @@ static int omap_dma_reserve_channels;
 
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
-static void __iomem *omap_dma_base;
-static u16 *reg_map;
-static u8 dma_stride;
-static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
-
-static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
-	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
-	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
-	INT_1610_DMA_CH8, INT_1610_DMA_CH9, INT_1610_DMA_CH10,
-	INT_1610_DMA_CH11, INT_1610_DMA_CH12, INT_1610_DMA_CH13,
-	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
-};
 
 static inline void disable_lnk(int lch);
 static void omap_disable_channel_irq(int lch);
@@ -248,52 +132,9 @@ static inline void omap_enable_channel_irq(int lch);
 #define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
 						__func__);
 
-static inline void dma_write(u32 val, int reg, int lch)
-{
-	u8  stride;
-	u32 offset;
-
-	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
-	offset = reg_map[reg] + (stride * lch);
-
-	if (dma_stride  == 0x40) {
-		__raw_writew(val, omap_dma_base + offset);
-		if ((reg > CLNK_CTRL && reg < CCEN) ||
-				(reg > PCHD_ID && reg < CAPS_2)) {
-			u32 offset2 = reg_map[reg] + 2 + (stride * lch);
-			__raw_writew(val >> 16, omap_dma_base + offset2);
-		}
-	} else {
-		__raw_writel(val, omap_dma_base + offset);
-	}
-}
-
-static inline u32 dma_read(int reg, int lch)
-{
-	u8 stride;
-	u32 offset, val;
-
-	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
-	offset = reg_map[reg] + (stride * lch);
-
-	if (dma_stride  == 0x40) {
-		val = __raw_readw(omap_dma_base + offset);
-		if ((reg > CLNK_CTRL && reg < CCEN) ||
-				(reg > PCHD_ID && reg < CAPS_2)) {
-			u16 upper;
-			u32 offset2 = reg_map[reg] + 2 + (stride * lch);
-			upper = __raw_readw(omap_dma_base + offset2);
-			val |= (upper << 16);
-		}
-	} else {
-		val = __raw_readl(omap_dma_base + offset);
-	}
-	return val;
-}
-
 #ifdef CONFIG_ARCH_OMAP15XX
 /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
-static int omap_dma_in_1510_mode(void)
+int omap_dma_in_1510_mode(void)
 {
 	return enable_1510_mode;
 }
@@ -325,15 +166,6 @@ static inline void set_gdma_dev(int req, int dev)
 #define set_gdma_dev(req, dev)	do {} while (0)
 #endif
 
-/* Omap1 only */
-static void clear_lch_regs(int lch)
-{
-	int i = dma_common_ch_start;
-
-	for (; i <= dma_common_ch_end; i += 1)
-		dma_write(0, i, lch);
-}
-
 void omap_set_dma_priority(int lch, int dst_port, int priority)
 {
 	unsigned long reg;
@@ -366,12 +198,12 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 	if (cpu_class_is_omap2()) {
 		u32 ccr;
 
-		ccr = dma_read(CCR, lch);
+		ccr = p->dma_read(CCR, lch);
 		if (priority)
 			ccr |= (1 << 6);
 		else
 			ccr &= ~(1 << 6);
-		dma_write(ccr, CCR, lch);
+		p->dma_write(ccr, CCR, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_priority);
@@ -382,31 +214,31 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 {
 	u32 l;
 
-	l = dma_read(CSDP, lch);
+	l = p->dma_read(CSDP, lch);
 	l &= ~0x03;
 	l |= data_type;
-	dma_write(l, CSDP, lch);
+	p->dma_write(l, CSDP, lch);
 
 	if (cpu_class_is_omap1()) {
 		u16 ccr;
 
-		ccr = dma_read(CCR, lch);
+		ccr = p->dma_read(CCR, lch);
 		ccr &= ~(1 << 5);
 		if (sync_mode == OMAP_DMA_SYNC_FRAME)
 			ccr |= 1 << 5;
-		dma_write(ccr, CCR, lch);
+		p->dma_write(ccr, CCR, lch);
 
-		ccr = dma_read(CCR2, lch);
+		ccr = p->dma_read(CCR2, lch);
 		ccr &= ~(1 << 2);
 		if (sync_mode == OMAP_DMA_SYNC_BLOCK)
 			ccr |= 1 << 2;
-		dma_write(ccr, CCR2, lch);
+		p->dma_write(ccr, CCR2, lch);
 	}
 
 	if (cpu_class_is_omap2() && dma_trigger) {
 		u32 val;
 
-		val = dma_read(CCR, lch);
+		val = p->dma_read(CCR, lch);
 
 		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
 		val &= ~((1 << 23) | (3 << 19) | 0x1f);
@@ -431,11 +263,11 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 		} else {
 			val &= ~(1 << 24);	/* dest synch */
 		}
-		dma_write(val, CCR, lch);
+		p->dma_write(val, CCR, lch);
 	}
 
-	dma_write(elem_count, CEN, lch);
-	dma_write(frame_count, CFN, lch);
+	p->dma_write(elem_count, CEN, lch);
+	p->dma_write(frame_count, CFN, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
@@ -446,7 +278,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
-		w = dma_read(CCR2, lch);
+		w = p->dma_read(CCR2, lch);
 		w &= ~0x03;
 
 		switch (mode) {
@@ -461,22 +293,22 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		default:
 			BUG();
 		}
-		dma_write(w, CCR2, lch);
+		p->dma_write(w, CCR2, lch);
 
-		w = dma_read(LCH_CTRL, lch);
+		w = p->dma_read(LCH_CTRL, lch);
 		w &= ~0x0f;
 		/* Default is channel type 2D */
 		if (mode) {
-			dma_write(color, COLOR, lch);
+			p->dma_write(color, COLOR, lch);
 			w |= 1;		/* Channel type G */
 		}
-		dma_write(w, LCH_CTRL, lch);
+		p->dma_write(w, LCH_CTRL, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		u32 val;
 
-		val = dma_read(CCR, lch);
+		val = p->dma_read(CCR, lch);
 		val &= ~((1 << 17) | (1 << 16));
 
 		switch (mode) {
@@ -491,10 +323,10 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		default:
 			BUG();
 		}
-		dma_write(val, CCR, lch);
+		p->dma_write(val, CCR, lch);
 
 		color &= 0xffffff;
-		dma_write(color, COLOR, lch);
+		p->dma_write(color, COLOR, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_color_mode);
@@ -504,10 +336,10 @@ void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 	if (cpu_class_is_omap2()) {
 		u32 csdp;
 
-		csdp = dma_read(CSDP, lch);
+		csdp = p->dma_read(CSDP, lch);
 		csdp &= ~(0x3 << 16);
 		csdp |= (mode << 16);
-		dma_write(csdp, CSDP, lch);
+		p->dma_write(csdp, CSDP, lch);
 	}
 }
 EXPORT_SYMBOL(omap_set_dma_write_mode);
@@ -517,10 +349,10 @@ void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
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
@@ -535,21 +367,21 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
-		w = dma_read(CSDP, lch);
+		w = p->dma_read(CSDP, lch);
 		w &= ~(0x1f << 2);
 		w |= src_port << 2;
-		dma_write(w, CSDP, lch);
+		p->dma_write(w, CSDP, lch);
 	}
 
-	l = dma_read(CCR, lch);
+	l = p->dma_read(CCR, lch);
 	l &= ~(0x03 << 12);
 	l |= src_amode << 12;
-	dma_write(l, CCR, lch);
+	p->dma_write(l, CCR, lch);
 
-	dma_write(src_start, CSSA, lch);
+	p->dma_write(src_start, CSSA, lch);
 
-	dma_write(src_ei, CSEI, lch);
-	dma_write(src_fi, CSFI, lch);
+	p->dma_write(src_ei, CSEI, lch);
+	p->dma_write(src_fi, CSFI, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
 
@@ -577,8 +409,8 @@ void omap_set_dma_src_index(int lch, int eidx, int fidx)
 	if (cpu_class_is_omap2())
 		return;
 
-	dma_write(eidx, CSEI, lch);
-	dma_write(fidx, CSFI, lch);
+	p->dma_write(eidx, CSEI, lch);
+	p->dma_write(fidx, CSFI, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_index);
 
@@ -586,11 +418,11 @@ void omap_set_dma_src_data_pack(int lch, int enable)
 {
 	u32 l;
 
-	l = dma_read(CSDP, lch);
+	l = p->dma_read(CSDP, lch);
 	l &= ~(1 << 6);
 	if (enable)
 		l |= (1 << 6);
-	dma_write(l, CSDP, lch);
+	p->dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_data_pack);
 
@@ -599,7 +431,7 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	unsigned int burst = 0;
 	u32 l;
 
-	l = dma_read(CSDP, lch);
+	l = p->dma_read(CSDP, lch);
 	l &= ~(0x03 << 7);
 
 	switch (burst_mode) {
@@ -635,7 +467,7 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	}
 
 	l |= (burst << 7);
-	dma_write(l, CSDP, lch);
+	p->dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
 
@@ -647,21 +479,21 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 	u32 l;
 
 	if (cpu_class_is_omap1()) {
-		l = dma_read(CSDP, lch);
+		l = p->dma_read(CSDP, lch);
 		l &= ~(0x1f << 9);
 		l |= dest_port << 9;
-		dma_write(l, CSDP, lch);
+		p->dma_write(l, CSDP, lch);
 	}
 
-	l = dma_read(CCR, lch);
+	l = p->dma_read(CCR, lch);
 	l &= ~(0x03 << 14);
 	l |= dest_amode << 14;
-	dma_write(l, CCR, lch);
+	p->dma_write(l, CCR, lch);
 
-	dma_write(dest_start, CDSA, lch);
+	p->dma_write(dest_start, CDSA, lch);
 
-	dma_write(dst_ei, CDEI, lch);
-	dma_write(dst_fi, CDFI, lch);
+	p->dma_write(dst_ei, CDEI, lch);
+	p->dma_write(dst_fi, CDFI, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
 
@@ -670,8 +502,8 @@ void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 	if (cpu_class_is_omap2())
 		return;
 
-	dma_write(eidx, CDEI, lch);
-	dma_write(fidx, CDFI, lch);
+	p->dma_write(eidx, CDEI, lch);
+	p->dma_write(fidx, CDFI, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_index);
 
@@ -679,11 +511,11 @@ void omap_set_dma_dest_data_pack(int lch, int enable)
 {
 	u32 l;
 
-	l = dma_read(CSDP, lch);
+	l = p->dma_read(CSDP, lch);
 	l &= ~(1 << 13);
 	if (enable)
 		l |= 1 << 13;
-	dma_write(l, CSDP, lch);
+	p->dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
 
@@ -692,7 +524,7 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	unsigned int burst = 0;
 	u32 l;
 
-	l = dma_read(CSDP, lch);
+	l = p->dma_read(CSDP, lch);
 	l &= ~(0x03 << 14);
 
 	switch (burst_mode) {
@@ -725,7 +557,7 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 		return;
 	}
 	l |= (burst << 14);
-	dma_write(l, CSDP, lch);
+	p->dma_write(l, CSDP, lch);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
@@ -735,18 +567,18 @@ static inline void omap_enable_channel_irq(int lch)
 
 	/* Clear CSR */
 	if (cpu_class_is_omap1())
-		status = dma_read(CSR, lch);
+		status = p->dma_read(CSR, lch);
 	else if (cpu_class_is_omap2())
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
+		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
 
 	/* Enable some nice interrupts. */
-	dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
+	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
 }
 
 static void omap_disable_channel_irq(int lch)
 {
 	if (cpu_class_is_omap2())
-		dma_write(0, CICR, lch);
+		p->dma_write(0, CICR, lch);
 }
 
 void omap_enable_dma_irq(int lch, u16 bits)
@@ -765,7 +597,7 @@ static inline void enable_lnk(int lch)
 {
 	u32 l;
 
-	l = dma_read(CLNK_CTRL, lch);
+	l = p->dma_read(CLNK_CTRL, lch);
 
 	if (cpu_class_is_omap1())
 		l &= ~(1 << 14);
@@ -780,18 +612,18 @@ static inline void enable_lnk(int lch)
 			l = dma_chan[lch].next_linked_ch | (1 << 15);
 #endif
 
-	dma_write(l, CLNK_CTRL, lch);
+	p->dma_write(l, CLNK_CTRL, lch);
 }
 
 static inline void disable_lnk(int lch)
 {
 	u32 l;
 
-	l = dma_read(CLNK_CTRL, lch);
+	l = p->dma_read(CLNK_CTRL, lch);
 
 	/* Disable interrupts */
 	if (cpu_class_is_omap1()) {
-		dma_write(0, CICR, lch);
+		p->dma_write(0, CICR, lch);
 		/* Set the STOP_LNK bit */
 		l |= 1 << 14;
 	}
@@ -802,7 +634,7 @@ static inline void disable_lnk(int lch)
 		l &= ~(1 << 15);
 	}
 
-	dma_write(l, CLNK_CTRL, lch);
+	p->dma_write(l, CLNK_CTRL, lch);
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 
@@ -815,9 +647,9 @@ static inline void omap2_enable_irq_lch(int lch)
 		return;
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0, lch);
+	val = p->dma_read(IRQENABLE_L0, lch);
 	val |= 1 << lch;
-	dma_write(val, IRQENABLE_L0, lch);
+	p->dma_write(val, IRQENABLE_L0, lch);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
@@ -830,9 +662,9 @@ static inline void omap2_disable_irq_lch(int lch)
 		return;
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
-	val = dma_read(IRQENABLE_L0, lch);
+	val = p->dma_read(IRQENABLE_L0, lch);
 	val &= ~(1 << lch);
-	dma_write(val, IRQENABLE_L0, lch);
+	p->dma_write(val, IRQENABLE_L0, lch);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 
@@ -859,8 +691,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan = dma_chan + free_ch;
 	chan->dev_id = dev_id;
 
-	if (cpu_class_is_omap1())
-		clear_lch_regs(free_ch);
+	if (p->clear_lch_regs)
+		p->clear_lch_regs(free_ch);
 
 	if (cpu_class_is_omap2())
 		omap_clear_dma(free_ch);
@@ -897,17 +729,17 @@ int omap_request_dma(int dev_id, const char *dev_name,
 		 * Disable the 1510 compatibility mode and set the sync device
 		 * id.
 		 */
-		dma_write(dev_id | (1 << 10), CCR, free_ch);
+		p->dma_write(dev_id | (1 << 10), CCR, free_ch);
 	} else if (cpu_is_omap7xx() || cpu_is_omap15xx()) {
-		dma_write(dev_id, CCR, free_ch);
+		p->dma_write(dev_id, CCR, free_ch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		omap2_enable_irq_lch(free_ch);
 		omap_enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, free_ch);
-		dma_write(1 << free_ch, IRQSTATUS_L0, 0);
+		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, free_ch);
+		p->dma_write(1 << free_ch, IRQSTATUS_L0, 0);
 	}
 
 	*dma_ch_out = free_ch;
@@ -928,23 +760,23 @@ void omap_free_dma(int lch)
 
 	if (cpu_class_is_omap1()) {
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR, lch);
+		p->dma_write(0, CICR, lch);
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR, lch);
+		p->dma_write(0, CCR, lch);
 	}
 
 	if (cpu_class_is_omap2()) {
 		omap2_disable_irq_lch(lch);
 
 		/* Clear the CSR register and IRQ status register */
-		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
-		dma_write(1 << lch, IRQSTATUS_L0, lch);
+		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
+		p->dma_write(1 << lch, IRQSTATUS_L0, lch);
 
 		/* Disable all DMA interrupts for the channel. */
-		dma_write(0, CICR, lch);
+		p->dma_write(0, CICR, lch);
 
 		/* Make sure the DMA transfer is stopped. */
-		dma_write(0, CCR, lch);
+		p->dma_write(0, CCR, lch);
 		omap_clear_dma(lch);
 	}
 
@@ -985,7 +817,7 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 	reg |= (0x3 & tparams) << 12;
 	reg |= (arb_rate & 0xff) << 16;
 
-	dma_write(reg, GCR, 0);
+	p->dma_write(reg, GCR, 0);
 }
 EXPORT_SYMBOL(omap_dma_set_global_params);
 
@@ -1008,14 +840,14 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		printk(KERN_ERR "Invalid channel id\n");
 		return -EINVAL;
 	}
-	l = dma_read(CCR, lch);
+	l = p->dma_read(CCR, lch);
 	l &= ~((1 << 6) | (1 << 26));
 	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
 		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
 	else
 		l |= ((read_prio & 0x1) << 6);
 
-	dma_write(l, CCR, lch);
+	p->dma_write(l, CCR, lch);
 
 	return 0;
 }
@@ -1030,24 +862,7 @@ void omap_clear_dma(int lch)
 	unsigned long flags;
 
 	local_irq_save(flags);
-
-	if (cpu_class_is_omap1()) {
-		u32 l;
-
-		l = dma_read(CCR, lch);
-		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR, lch);
-
-		/* Clear pending interrupts */
-		l = dma_read(CSR, lch);
-	}
-
-	if (cpu_class_is_omap2()) {
-		int i = dma_common_ch_start;
-		for (; i <= dma_common_ch_end; i += 1)
-			dma_write(0, i, lch);
-	}
-
+	p->clear_dma(lch);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(omap_clear_dma);
@@ -1061,13 +876,13 @@ void omap_start_dma(int lch)
 	 * before starting dma transfer.
 	 */
 	if (cpu_is_omap15xx())
-		dma_write(0, CPC, lch);
+		p->dma_write(0, CPC, lch);
 	else
-		dma_write(0, CDAC, lch);
+		p->dma_write(0, CDAC, lch);
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_lch_count];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
@@ -1090,17 +905,17 @@ void omap_start_dma(int lch)
 			cur_lch = next_lch;
 		} while (next_lch != -1);
 	} else if (IS_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS))
-		dma_write(lch, CLNK_CTRL, lch);
+		p->dma_write(lch, CLNK_CTRL, lch);
 
 	omap_enable_channel_irq(lch);
 
-	l = dma_read(CCR, lch);
+	l = p->dma_read(CCR, lch);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING))
 			l |= OMAP_DMA_CCR_BUFFERING_DISABLE;
 	l |= OMAP_DMA_CCR_EN;
 
-	dma_write(l, CCR, lch);
+	p->dma_write(l, CCR, lch);
 
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
@@ -1112,46 +927,46 @@ void omap_stop_dma(int lch)
 
 	/* Disable all interrupts on the channel */
 	if (cpu_class_is_omap1())
-		dma_write(0, CICR, lch);
+		p->dma_write(0, CICR, lch);
 
-	l = dma_read(CCR, lch);
+	l = p->dma_read(CCR, lch);
 	if (IS_DMA_ERRATA(DMA_ERRATA_i541) &&
 			(l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
 		int i = 0;
 		u32 sys_cf;
 
 		/* Configure No-Standby */
-		l = dma_read(OCP_SYSCONFIG, lch);
+		l = p->dma_read(OCP_SYSCONFIG, lch);
 		sys_cf = l;
 		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
 		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
-		dma_write(l , OCP_SYSCONFIG, 0);
+		p->dma_write(l , OCP_SYSCONFIG, 0);
 
-		l = dma_read(CCR, lch);
+		l = p->dma_read(CCR, lch);
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR, lch);
+		p->dma_write(l, CCR, lch);
 
 		/* Wait for sDMA FIFO drain */
-		l = dma_read(CCR, lch);
+		l = p->dma_read(CCR, lch);
 		while (i < 100 && (l & (OMAP_DMA_CCR_RD_ACTIVE |
 					OMAP_DMA_CCR_WR_ACTIVE))) {
 			udelay(5);
 			i++;
-			l = dma_read(CCR, lch);
+			l = p->dma_read(CCR, lch);
 		}
 		if (i >= 100)
 			printk(KERN_ERR "DMA drain did not complete on "
 					"lch %d\n", lch);
 		/* Restore OCP_SYSCONFIG */
-		dma_write(sys_cf, OCP_SYSCONFIG, lch);
+		p->dma_write(sys_cf, OCP_SYSCONFIG, lch);
 	} else {
 		l &= ~OMAP_DMA_CCR_EN;
-		dma_write(l, CCR, lch);
+		p->dma_write(l, CCR, lch);
 	}
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_lch_count];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {
@@ -1212,15 +1027,15 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_is_omap15xx())
-		offset = dma_read(CPC, lch);
+		offset = p->dma_read(CPC, lch);
 	else
-		offset = dma_read(CSAC, lch);
+		offset = p->dma_read(CSAC, lch);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
-		offset = dma_read(CSAC, lch);
+		offset = p->dma_read(CSAC, lch);
 
 	if (cpu_class_is_omap1())
-		offset |= (dma_read(CSSA, lch) & 0xFFFF0000);
+		offset |= (p->dma_read(CSSA, lch) & 0xFFFF0000);
 
 	return offset;
 }
@@ -1239,19 +1054,19 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 	dma_addr_t offset = 0;
 
 	if (cpu_is_omap15xx())
-		offset = dma_read(CPC, lch);
+		offset = p->dma_read(CPC, lch);
 	else
-		offset = dma_read(CDAC, lch);
+		offset = p->dma_read(CDAC, lch);
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
 	 * read before the DMA controller finished disabling the channel.
 	 */
 	if (!cpu_is_omap15xx() && offset == 0)
-		offset = dma_read(CDAC, lch);
+		offset = p->dma_read(CDAC, lch);
 
 	if (cpu_class_is_omap1())
-		offset |= (dma_read(CDSA, lch) & 0xFFFF0000);
+		offset |= (p->dma_read(CDSA, lch) & 0xFFFF0000);
 
 	return offset;
 }
@@ -1259,7 +1074,7 @@ EXPORT_SYMBOL(omap_get_dma_dst_pos);
 
 int omap_get_dma_active_status(int lch)
 {
-	return (dma_read(CCR, lch) & OMAP_DMA_CCR_EN) != 0;
+	return (p->dma_read(CCR, lch) & OMAP_DMA_CCR_EN) != 0;
 }
 EXPORT_SYMBOL(omap_get_dma_active_status);
 
@@ -1272,7 +1087,7 @@ int omap_dma_running(void)
 			return 1;
 
 	for (lch = 0; lch < dma_chan_count; lch++)
-		if (dma_read(CCR, lch) & OMAP_DMA_CCR_EN)
+		if (p->dma_read(CCR, lch) & OMAP_DMA_CCR_EN)
 			return 1;
 
 	return 0;
@@ -1287,7 +1102,7 @@ void omap_dma_link_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR, lch_head) | (3 << 8),
+			p->dma_write(p->dma_read(CCR, lch_head) | (3 << 8),
 								CCR, lch_head);
 			return;
 		}
@@ -1314,7 +1129,7 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
-			dma_write(dma_read(CCR, lch_head) & ~(3 << 8),
+			p->dma_write(p->dma_read(CCR, lch_head) & ~(3 << 8),
 								CCR, lch_head);
 			return;
 		}
@@ -1341,8 +1156,6 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 }
 EXPORT_SYMBOL(omap_dma_unlink_lch);
 
-/*----------------------------------------------------------------------------*/
-
 #ifndef CONFIG_ARCH_OMAP1
 /* Create chain of DMA channesls */
 static void create_dma_lch_chain(int lch_head, int lch_queue)
@@ -1367,15 +1180,15 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 					lch_queue;
 	}
 
-	l = dma_read(CLNK_CTRL, lch_head);
+	l = p->dma_read(CLNK_CTRL, lch_head);
 	l &= ~(0x1f);
 	l |= lch_queue;
-	dma_write(l, CLNK_CTRL, lch_head);
+	p->dma_write(l, CLNK_CTRL, lch_head);
 
-	l = dma_read(CLNK_CTRL, lch_queue);
+	l = p->dma_read(CLNK_CTRL, lch_queue);
 	l &= ~(0x1f);
 	l |= (dma_chan[lch_queue].next_linked_ch);
-	dma_write(l, CLNK_CTRL, lch_queue);
+	p->dma_write(l, CLNK_CTRL, lch_queue);
 }
 
 /**
@@ -1651,13 +1464,13 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 
 	/* Set the params to the free channel */
 	if (src_start != 0)
-		dma_write(src_start, CSSA, lch);
+		p->dma_write(src_start, CSSA, lch);
 	if (dest_start != 0)
-		dma_write(dest_start, CDSA, lch);
+		p->dma_write(dest_start, CDSA, lch);
 
 	/* Write the buffer size */
-	dma_write(elem_count, CEN, lch);
-	dma_write(frame_count, CFN, lch);
+	p->dma_write(elem_count, CEN, lch);
+	p->dma_write(frame_count, CFN, lch);
 
 	/*
 	 * If the chain is dynamically linked,
@@ -1690,7 +1503,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 				enable_lnk(dma_chan[lch].prev_linked_ch);
 				dma_chan[lch].state = DMA_CH_QUEUED;
 				start_dma = 0;
-				if (0 == ((1 << 7) & dma_read(
+				if (0 == ((1 << 7) & p->dma_read(
 					CCR, dma_chan[lch].prev_linked_ch))) {
 					disable_lnk(dma_chan[lch].
 						    prev_linked_ch);
@@ -1707,7 +1520,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			}
 			omap_enable_channel_irq(lch);
 
-			l = dma_read(CCR, lch);
+			l = p->dma_read(CCR, lch);
 
 			if ((0 == (l & (1 << 24))))
 				l &= ~(1 << 25);
@@ -1718,12 +1531,12 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 					l |= (1 << 7);
 					dma_chan[lch].state = DMA_CH_STARTED;
 					pr_debug("starting %d\n", lch);
-					dma_write(l, CCR, lch);
+					p->dma_write(l, CCR, lch);
 				} else
 					start_dma = 0;
 			} else {
 				if (0 == (l & (1 << 7)))
-					dma_write(l, CCR, lch);
+					p->dma_write(l, CCR, lch);
 			}
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
@@ -1768,7 +1581,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 		omap_enable_channel_irq(channels[0]);
 	}
 
-	l = dma_read(CCR, channels[0]);
+	l = p->dma_read(CCR, channels[0]);
 	l |= (1 << 7);
 	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
 	dma_chan[channels[0]].state = DMA_CH_STARTED;
@@ -1777,7 +1590,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 		l &= ~(1 << 25);
 	else
 		l |= (1 << 25);
-	dma_write(l, CCR, channels[0]);
+	p->dma_write(l, CCR, channels[0]);
 
 	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
 
@@ -1813,19 +1626,19 @@ int omap_stop_dma_chain_transfers(int chain_id)
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
-		l = dma_read(CCR, channels[i]);
+		l = p->dma_read(CCR, channels[i]);
 		l &= ~(1 << 7);
-		dma_write(l, CCR, channels[i]);
+		p->dma_write(l, CCR, channels[i]);
 
 		/* Disable the link in all the channels */
 		disable_lnk(channels[i]);
@@ -1838,7 +1651,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	OMAP_DMA_CHAIN_QINIT(chain_id);
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
-		dma_write(sys_cf, OCP_SYSCONFIG, 0);
+		p->dma_write(sys_cf, OCP_SYSCONFIG, 0);
 
 	return 0;
 }
@@ -1880,8 +1693,8 @@ int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	*ei = dma_read(CCEN, lch);
-	*fi = dma_read(CCFN, lch);
+	*ei = p->dma_read(CCEN, lch);
+	*fi = p->dma_read(CCFN, lch);
 
 	return 0;
 }
@@ -1918,7 +1731,7 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return dma_read(CDAC, lch);
+	return p->dma_read(CDAC, lch);
 }
 EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
 
@@ -1952,7 +1765,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return dma_read(CSAC, lch);
+	return p->dma_read(CSAC, lch);
 }
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */
@@ -1969,7 +1782,7 @@ static int omap1_dma_handle_ch(int ch)
 		csr = dma_chan[ch].saved_csr;
 		dma_chan[ch].saved_csr = 0;
 	} else
-		csr = dma_read(CSR, ch);
+		csr = p->dma_read(CSR, ch);
 	if (enable_1510_mode && ch <= 2 && (csr >> 7) != 0) {
 		dma_chan[ch + 6].saved_csr = csr >> 7;
 		csr &= 0x7f;
@@ -2022,13 +1835,13 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 
 static int omap2_dma_handle_ch(int ch)
 {
-	u32 status = dma_read(CSR, ch);
+	u32 status = p->dma_read(CSR, ch);
 
 	if (!status) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
 				ch);
-		dma_write(1 << ch, IRQSTATUS_L0, ch);
+		p->dma_write(1 << ch, IRQSTATUS_L0, ch);
 		return 0;
 	}
 	if (unlikely(dma_chan[ch].dev_id == -1)) {
@@ -2047,9 +1860,9 @@ static int omap2_dma_handle_ch(int ch)
 		if (IS_DMA_ERRATA(DMA_ERRATA_i378)) {
 			u32 ccr;
 
-			ccr = dma_read(CCR, ch);
+			ccr = p->dma_read(CCR, ch);
 			ccr &= ~OMAP_DMA_CCR_EN;
-			dma_write(ccr, CCR, ch);
+			p->dma_write(ccr, CCR, ch);
 			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
 		}
 	}
@@ -2060,16 +1873,16 @@ static int omap2_dma_handle_ch(int ch)
 		printk(KERN_INFO "DMA misaligned error with device %d\n",
 		       dma_chan[ch].dev_id);
 
-	dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, ch);
-	dma_write(1 << ch, IRQSTATUS_L0, ch);
+	p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, ch);
+	p->dma_write(1 << ch, IRQSTATUS_L0, ch);
 	/* read back the register to flush the write */
-	dma_read(IRQSTATUS_L0, ch);
+	p->dma_read(IRQSTATUS_L0, ch);
 
 	/* If the ch is not chained then chain_id will be -1 */
 	if (dma_chan[ch].chain_id != -1) {
 		int chain_id = dma_chan[ch].chain_id;
 		dma_chan[ch].state = DMA_CH_NOTSTARTED;
-		if (dma_read(CLNK_CTRL, ch) & (1 << 15))
+		if (p->dma_read(CLNK_CTRL, ch) & (1 << 15))
 			dma_chan[dma_chan[ch].next_linked_ch].state =
 							DMA_CH_STARTED;
 		if (dma_linked_lch[chain_id].chain_mode ==
@@ -2079,10 +1892,10 @@ static int omap2_dma_handle_ch(int ch)
 		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
 			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
 
-		status = dma_read(CSR, ch);
+		status = p->dma_read(CSR, ch);
 	}
 
-	dma_write(status, CSR, ch);
+	p->dma_write(status, CSR, ch);
 
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
@@ -2096,13 +1909,13 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
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
@@ -2128,206 +1941,66 @@ static struct irqaction omap24xx_dma_irq;
 void omap_dma_global_context_save(void)
 {
 	omap_dma_global_context.dma_irqenable_l0 =
-		dma_read(IRQENABLE_L0, 0);
+		p->dma_read(IRQENABLE_L0, 0);
 	omap_dma_global_context.dma_ocp_sysconfig =
-		dma_read(OCP_SYSCONFIG, 0);
-	omap_dma_global_context.dma_gcr = dma_read(GCR, 0);
+		p->dma_read(OCP_SYSCONFIG, 0);
+	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
 }
 
 void omap_dma_global_context_restore(void)
 {
 	int ch;
 
-	dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
-	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
+	p->dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
+	p->dma_write(omap_dma_global_context.dma_ocp_sysconfig,
 		OCP_SYSCONFIG, 0);
-	dma_write(omap_dma_global_context.dma_irqenable_l0,
+	p->dma_write(omap_dma_global_context.dma_irqenable_l0,
 		IRQENABLE_L0, 0);
 
 	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
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
-	 * Errata applicable for OMAP2430ES1.0 and all omap2420
-	 *
-	 * I.
-	 * Erratum ID: Not Available
-	 * Inter Frame DMA buffering issue DMA will wrongly
-	 * buffer elements if packing and bursting is enabled. This might
-	 * result in data gets stalled in FIFO at the end of the block.
-	 * Workaround: DMA channels must have BUFFERING_DISABLED bit set to
-	 * guarantee no data will stay in the DMA FIFO in case inter frame
-	 * buffering occurs
-	 *
-	 * II.
-	 * Erratum ID: Not Available
-	 * DMA may hang when several channels are used in parallel
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
-		SET_DMA_ERRATA(DMA_ERRATA_IFRAME_BUFFERING);
-		SET_DMA_ERRATA(DMA_ERRATA_PARALLEL_CHANNELS);
-	}
-
-	/*
-	 * Erratum ID: i378: OMAP2plus: sDMA Channel is not disabled
-	 * after a transaction error.
-	 * Workaround: SW should explicitely disable the channel.
-	 */
-	if (cpu_class_is_omap2())
-		SET_DMA_ERRATA(DMA_ERRATA_i378);
-
-	/*
-	 * Erratum ID: i541: sDMA FIFO draining does not finish
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
-	 * Erratum ID: i88 : Special programming model needed to disable DMA
-	 * before end of block.
-	 * Workaround: software must ensure that the DMA is configured in No
-	 * Standby mode(DMAx_OCP_SYSCONFIG.MIDLEMODE = "01")
-	 */
-	if (cpu_is_omap34xx() && (omap_type() == OMAP3430_REV_ES1_0))
-		SET_DMA_ERRATA(DMA_ERRATA_i88);
-
-	/*
-	 * Erratum 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
-	 * read before the DMA controller finished disabling the channel.
-	 */
-	if (!cpu_is_omap15xx())
-		SET_DMA_ERRATA(DMA_ERRATA_3_3);
-
-	/*
-	 * Erratum ID: Not Available
-	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
-	 * after secure sram context save and restore.
-	 * Work around: Hence we need to manually clear those IRQs to avoid
-	 * spurious interrupts. This affects only secure devices.
-	 */
-	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
-		SET_DMA_ERRATA(DMA_ROMCODE_BUG);
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
+	int ch, ret = 0;
+	int dma_irq;
+	char irq_name[4];
+	int irq_rel;
+
+	p = pdev->dev.platform_data;
+	if (!p) {
+		dev_err(&pdev->dev, "%s: System DMA initialized without"
+			"platform data\n", __func__);
+		return -EINVAL;
 	}
 
-	omap_dma_base = ioremap(base, SZ_4K);
-	BUG_ON(!omap_dma_base);
-
-	if (cpu_class_is_omap1()) {
-		dma_stride		= 0x40;
-		reg_map			= reg_map_omap1;
-		dma_common_ch_start	= CPC;
-		dma_common_ch_end	= COLOR;
-	} else {
-		dma_stride		= 0x60;
-		reg_map			= reg_map_omap2;
-		dma_common_ch_start	= CSDP;
-		if (cpu_is_omap3630() || cpu_is_omap4430())
-			dma_common_ch_end = CCDN;
-		else
-			dma_common_ch_end = CCFN;
-	}
+	d			= p->dma_attr;
+	errata			= p->errata;
 
-	if (cpu_class_is_omap2() && omap_dma_reserve_channels
+	if ((d->dev_caps & RESERVE_CHANNEL) && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
-		dma_lch_count = omap_dma_reserve_channels;
+		d->lch_count	= omap_dma_reserve_channels;
 
-	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
-				GFP_KERNEL);
-	if (!dma_chan) {
-		r = -ENOMEM;
-		goto out_unmap;
-	}
+	dma_lch_count		= d->lch_count;
+	dma_chan_count		= dma_lch_count;
+	dma_chan		= d->chan;
+	enable_1510_mode	= d->dev_caps & ENABLE_1510_MODE;
 
 	if (cpu_class_is_omap2()) {
 		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
 						dma_lch_count, GFP_KERNEL);
 		if (!dma_linked_lch) {
-			r = -ENOMEM;
-			goto out_free;
+			ret = -ENOMEM;
+			goto exit_dma_lch_fail;
 		}
 	}
 
-	if (cpu_is_omap15xx()) {
-		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
-		dma_chan_count = 9;
-		enable_1510_mode = 1;
-	} else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
-		printk(KERN_INFO "OMAP DMA hardware version %d\n",
-		       dma_read(HW_ID, 0));
-		printk(KERN_INFO "DMA capabilities: %08x:%08x:%04x:%04x:%04x\n",
-		       dma_read(CAPS_0, 0), dma_read(CAPS_1, 0),
-		       dma_read(CAPS_2, 0), dma_read(CAPS_3, 0),
-		       dma_read(CAPS_4, 0));
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
-
 	spin_lock_init(&dma_chan_lock);
-
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
 		if (cpu_class_is_omap2())
@@ -2344,20 +2017,23 @@ static int __init omap_init_dma(void)
 			 * request_irq() doesn't like dev_id (ie. ch) being
 			 * zero, so we have to kludge around this.
 			 */
-			r = request_irq(omap1_dma_irq[ch],
+			sprintf(&irq_name[0], "%d", ch);
+			dma_irq = platform_get_irq_byname(pdev, irq_name);
+
+			if (dma_irq < 0) {
+				ret = dma_irq;
+				goto exit_dma_irq_fail;
+			}
+
+			/* INT_DMA_LCD is handled in lcd_dma.c */
+			if (dma_irq == INT_DMA_LCD)
+				continue;
+
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
-			}
+			if (ret != 0)
+				goto exit_dma_irq_fail;
 		}
 	}
 
@@ -2366,47 +2042,91 @@ static int __init omap_init_dma(void)
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
+		strcpy(irq_name, "0");
+		dma_irq = platform_get_irq_byname(pdev, irq_name);
+		if (dma_irq < 0) {
+			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
+			goto exit_dma_lch_fail;
+		}
+		ret = setup_irq(dma_irq, &omap24xx_dma_irq);
+		if (ret) {
+			dev_err(&pdev->dev, "set_up failed for IRQ %d"
+				"for DMA (error %d)\n", dma_irq, ret);
+			goto exit_dma_lch_fail;
 		}
 	}
-	configure_dma_errata();
 
+	/* reserve dma channels 0 and 1 in high security devices */
+	if (cpu_is_omap34xx() &&
+		(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
+		printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
+				"HS ROM code\n");
+		dma_chan[0].dev_id = 0;
+		dma_chan[1].dev_id = 1;
+	}
+	p->show_dma_caps();
 	return 0;
 
-out_free:
+exit_dma_irq_fail:
+	dev_err(&pdev->dev, "unable to request IRQ %d"
+			"for DMA (error %d)\n", dma_irq, ret);
+	for (irq_rel = 0; irq_rel < ch;	irq_rel++) {
+		dma_irq = platform_get_irq(pdev, irq_rel);
+		free_irq(dma_irq, (void *)(irq_rel + 1));
+	}
+
+exit_dma_lch_fail:
+	kfree(p);
+	kfree(d);
 	kfree(dma_chan);
+	return ret;
+}
 
-out_unmap:
-	iounmap(omap_dma_base);
+static int __devexit omap_system_dma_remove(struct platform_device *pdev)
+{
+	int dma_irq;
 
-	return r;
+	if (cpu_class_is_omap2()) {
+		char irq_name[4];
+		strcpy(irq_name, "0");
+		dma_irq = platform_get_irq_byname(pdev, irq_name);
+		remove_irq(dma_irq, &omap24xx_dma_irq);
+	} else {
+		int irq_rel = 0;
+		for ( ; irq_rel < dma_chan_count; irq_rel++) {
+			dma_irq = platform_get_irq(pdev, irq_rel);
+			free_irq(dma_irq, (void *)(irq_rel + 1));
+		}
+	}
+	kfree(p);
+	kfree(d);
+	kfree(dma_chan);
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
+
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
index 4b51d2b..d1c916f 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -21,19 +21,15 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
 
-/* Move omap4 specific defines to dma-44xx.h */
-#include "dma-44xx.h"
-
-/* Hardware registers for omap1 */
-#define OMAP1_DMA_BASE			(0xfffed800)
+#include <linux/platform_device.h>
 
-/* Hardware registers for omap2 and omap3 */
-#define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
-#define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
-#define OMAP44XX_DMA4_BASE		(L4_44XX_BASE + 0x56000)
+/*
+ * TODO: These dma channel defines should go away once all
+ * the omap drivers hwmod adapted.
+ */
 
-#define OMAP1_LOGICAL_DMA_CH_COUNT	17
-#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
+/* Move omap4 specific defines to dma-44xx.h */
+#include "dma-44xx.h"
 
 /* DMA channels for omap1 */
 #define OMAP_DMA_NO_DEVICE		0
@@ -302,6 +298,14 @@
 #define IS_CSSA_32			BIT(0x3)
 #define IS_CDSA_32			BIT(0x4)
 #define IS_RW_PRIORITY			BIT(0x5)
+#define ENABLE_1510_MODE		BIT(0x6)
+#define SRC_PORT			BIT(0x7)
+#define DST_PORT			BIT(0x8)
+#define SRC_INDEX			BIT(0x9)
+#define DST_INDEX			BIT(0xA)
+#define IS_BURST_ONLY4			BIT(0xB)
+#define CLEAR_CSR_ON_READ		BIT(0xC)
+#define IS_WORD_16			BIT(0xD)
 
 enum omap_reg_offsets {
 
@@ -397,9 +401,40 @@ struct omap_dma_channel_params {
 #endif
 };
 
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
+	u32 errata;
+	void (*disable_irq_lch)(int lch);
+	void (*show_dma_caps)(void);
+	void (*clear_lch_regs)(int lch);
+	void (*clear_dma)(int lch);
+	void (*dma_write)(u32 val, int reg, int lch);
+	u32 (*dma_read)(int reg, int lch);
 };
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
-- 
1.7.1

