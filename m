From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v2 08/11] OMAP: DMA: Convert DMA library into DMA platform Driver
Date: Tue, 24 Aug 2010 16:34:23 +0530
Message-ID: <1282647866-6918-9-git-send-email-manjugk@ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56920 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0HXLFy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Aug 2010 07:05:54 -0400
In-Reply-To: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch converts DMA library into DMA platform driver and make use
of platform data provided by HWMOD data base for OMAP2PLUS onwards.
For OMAP1 processors, the DMA driver in mach-omap uses resource structures
for getting platform data.

Also, it enables and uses run time PM API's

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/Makefile           |    2 +-
 arch/arm/mach-omap1/include/mach/dma.h |   66 +++++++++
 arch/arm/mach-omap2/Makefile           |    2 +-
 arch/arm/mach-omap2/include/mach/dma.h |   83 +++++++++++
 arch/arm/plat-omap/dma.c               |  244 +++++++++++++++++---------------
 arch/arm/plat-omap/include/plat/dma.h  |  157 ++-------------------
 6 files changed, 290 insertions(+), 264 deletions(-)

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
diff --git a/arch/arm/mach-omap1/include/mach/dma.h b/arch/arm/mach-omap1/include/mach/dma.h
index d446cdd..1eb0d31 100644
--- a/arch/arm/mach-omap1/include/mach/dma.h
+++ b/arch/arm/mach-omap1/include/mach/dma.h
@@ -77,4 +77,70 @@
 #define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
 #define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)
 
+/* Dummy defines to support multi omap code */
+/* Channel specific registers */
+#define OMAP_DMA4_CCR(n)		0
+#define OMAP_DMA4_CSDP(n)		0
+#define OMAP_DMA4_CEN(n)		0
+#define OMAP_DMA4_CFN(n)		0
+#define OMAP_DMA4_COLOR(n)		0
+#define OMAP_DMA4_CSSA(n)		0
+#define OMAP_DMA4_CSEI(n)		0
+#define OMAP_DMA4_CSFI(n)		0
+#define OMAP_DMA4_CDSA(n)		0
+#define OMAP_DMA4_CDEI(n)		0
+#define OMAP_DMA4_CDFI(n)		0
+#define OMAP_DMA4_CSR(n)		0
+#define OMAP_DMA4_CICR(n)		0
+#define OMAP_DMA4_CLNK_CTRL(n)		0
+#define OMAP_DMA4_CH_BASE(n)		0
+#define OMAP_DMA4_CDAC(n)		0
+#define OMAP_DMA4_CSAC(n)		0
+
+/* Common registers */
+#define OMAP_DMA4_IRQENABLE_L0		0
+#define OMAP_DMA4_OCP_SYSCONFIG		0
+#define OMAP_DMA4_GCR			0
+#define OMAP_DMA4_IRQSTATUS_L0		0
+#define OMAP_DMA4_CAPS_2		0
+#define OMAP_DMA4_CAPS_3		0
+#define OMAP_DMA4_CAPS_4		0
+#define OMAP_DMA4_REVISION		0
+
+#define OMAP_DMA4_CCR2(n)		0
+#define OMAP_DMA4_LCH_CTRL(n)		0
+#define OMAP_DMA4_COLOR_L(n)		0
+#define OMAP_DMA4_COLOR_U(n)		0
+#define OMAP1_DMA_COLOR(n)		0
+#define OMAP_DMA4_CSSA_U(n)		0
+#define OMAP_DMA4_CSSA_L(n)		0
+#define OMAP1_DMA_CSSA(n)		0
+#define OMAP_DMA4_CDSA_U(n)		0
+#define OMAP_DMA4_CDSA_L(n)		0
+#define OMAP1_DMA_CDSA(n)		0
+#define OMAP_DMA4_CPC(n)		0
+
+#define OMAP1_DMA_IRQENABLE_L0		0
+#define OMAP1_DMA_IRQENABLE_L0		0
+#define OMAP1_DMA_IRQSTATUS_L0		0
+#define OMAP1_DMA_OCP_SYSCONFIG		0
+#define OMAP_DMA4_HW_ID			0
+#define OMAP_DMA4_CAPS_0_U		0
+#define OMAP_DMA4_CAPS_0_L		0
+#define OMAP_DMA4_CAPS_1_U		0
+#define OMAP_DMA4_CAPS_1_L		0
+#define OMAP_DMA4_GSCR			0
+#define OMAP1_DMA_REVISION		0
+
+struct omap_dma_lch {
+	int next_lch;
+	int dev_id;
+	u16 saved_csr;
+	u16 enabled_irqs;
+	const char *dev_name;
+	void (*callback)(int lch, u16 ch_status, void *data);
+	void *data;
+	long flags;
+};
+
 #endif /* __ASM_ARCH_OMAP1_DMA_H */
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9b44773..6a8b231 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o dma.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
index 3eca7d8..22f4b41 100644
--- a/arch/arm/mach-omap2/include/mach/dma.h
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -77,4 +77,87 @@
 #define OMAP_DMA4_CNDP(n)		(0x60 * (n) + 0xd4)
 #define OMAP_DMA4_CCDN(n)		(0x60 * (n) + 0xd8)
 
+
+/* Dummy defines for support multi omap code */
+/* Common registers */
+#define OMAP1_DMA_GCR				0
+#define OMAP1_DMA_HW_ID				0
+#define OMAP1_DMA_CAPS_0_U			0
+#define OMAP1_DMA_CAPS_0_L			0
+#define OMAP1_DMA_CAPS_1_U			0
+#define OMAP1_DMA_CAPS_1_L			0
+#define OMAP1_DMA_CAPS_2			0
+#define OMAP1_DMA_CAPS_3			0
+#define OMAP1_DMA_CAPS_4			0
+#define OMAP1_DMA_GSCR				0
+
+/* Channel specific registers */
+#define OMAP1_DMA_CH_BASE(n)			0
+#define OMAP1_DMA_CCR(n)			0
+#define OMAP1_DMA_CSDP(n)			0
+#define OMAP1_DMA_CCR2(n)			0
+#define OMAP1_DMA_CEN(n)			0
+#define OMAP1_DMA_CFN(n)			0
+#define OMAP1_DMA_LCH_CTRL(n)			0
+#define OMAP1_DMA_COLOR_L(n)			0
+#define OMAP1_DMA_COLOR_U(n)			0
+#define OMAP1_DMA_CSSA_U(n)			0
+#define OMAP1_DMA_CSSA_L(n)			0
+#define OMAP1_DMA_CSEI(n)			0
+#define OMAP1_DMA_CSFI(n)			0
+#define OMAP1_DMA_CDSA_U(n)			0
+#define OMAP1_DMA_CDSA_L(n)			0
+#define OMAP1_DMA_CDEI(n)			0
+#define OMAP1_DMA_CDFI(n)			0
+#define OMAP1_DMA_CSR(n)			0
+#define OMAP1_DMA_CICR(n)			0
+#define OMAP1_DMA_CLNK_CTRL(n)			0
+#define OMAP1_DMA_CPC(n)			0
+#define OMAP1_DMA_CDAC(n)			0
+#define OMAP1_DMA_CSAC(n)			0
+#define OMAP1_DMA_CCEN(n)			0
+#define OMAP1_DMA_CCFN(n)			0
+
+#define OMAP_DMA4_CCR2(n)			0
+#define OMAP_DMA4_LCH_CTRL(n)			0
+#define OMAP_DMA4_COLOR_L(n)			0
+#define OMAP_DMA4_COLOR_U(n)			0
+#define OMAP1_DMA_COLOR(n)			0
+#define OMAP_DMA4_CSSA_U(n)			0
+#define OMAP_DMA4_CSSA_L(n)			0
+#define OMAP1_DMA_CSSA(n)			0
+#define OMAP_DMA4_CDSA_U(n)			0
+#define OMAP_DMA4_CDSA_L(n)			0
+#define OMAP1_DMA_CDSA(n)			0
+#define OMAP_DMA4_CPC(n)			0
+
+#define OMAP1_DMA_IRQENABLE_L0			0
+#define OMAP1_DMA_IRQSTATUS_L0			0
+#define OMAP1_DMA_OCP_SYSCONFIG			0
+#define OMAP1_DMA_OCP_SYSCONFIG			0
+#define OMAP_DMA4_HW_ID				0
+#define OMAP_DMA4_CAPS_0_U			0
+#define OMAP_DMA4_CAPS_0_L			0
+#define OMAP_DMA4_CAPS_1_U			0
+#define OMAP_DMA4_CAPS_1_L			0
+#define OMAP_DMA4_GSCR				0
+#define OMAP1_DMA_REVISION			0
+
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
 #endif /* __ASM_ARCH_OMAP2_DMA_H */
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ec7eddf..36c3dde 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -15,6 +15,9 @@
  *
  * Support functions for the OMAP internal DMA channels.
  *
+ * Copyright (C) 2010 Texas Instruments
+ * Converted DMA library into DMA platform driver.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -30,13 +33,17 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/system.h>
+
 #include <mach/hardware.h>
-#include <plat/dma.h>
 
+#include <plat/dma.h>
+#include <plat/omap_device.h>
 #include <plat/tc.h>
 
+
 #undef DEBUG
 
 #ifndef CONFIG_ARCH_OMAP1
@@ -60,27 +67,6 @@ static struct omap_dma_global_context_registers {
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
@@ -95,6 +81,7 @@ struct dma_link_info {
 };
 
 static struct dma_link_info *dma_linked_lch;
+static struct platform_device *ddev;
 
 #ifndef CONFIG_ARCH_OMAP1
 
@@ -136,15 +123,10 @@ static int omap_dma_reserve_channels;
 
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
-static void __iomem *omap_dma_base;
 
-static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
-	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
-	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
-	INT_1610_DMA_CH8, INT_1610_DMA_CH9, INT_1610_DMA_CH10,
-	INT_1610_DMA_CH11, INT_1610_DMA_CH12, INT_1610_DMA_CH13,
-	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
-};
+static void __iomem *omap_dma_base;
+static struct omap_system_dma_plat_info *p;
+static struct omap_dma_dev_attr *d;
 
 static inline void disable_lnk(int lch);
 static void omap_disable_channel_irq(int lch);
@@ -753,6 +735,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan = dma_chan + free_ch;
 	chan->dev_id = dev_id;
 
+	pm_runtime_get_sync(&ddev->dev);
+
 	if (cpu_class_is_omap1())
 		clear_lch_regs(free_ch);
 
@@ -846,6 +830,9 @@ void omap_free_dma(int lch)
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
 	dma_chan[lch].callback = NULL;
+
+	pm_runtime_put_sync(&ddev->dev);
+
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 }
 EXPORT_SYMBOL(omap_free_dma);
@@ -962,7 +949,7 @@ void omap_start_dma(int lch)
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_chan_count];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
@@ -1023,7 +1010,7 @@ void omap_stop_dma(int lch)
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[dma_chan_count];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {
@@ -2039,57 +2026,56 @@ void omap_dma_global_context_restore(void)
 			omap_clear_dma(ch);
 }
 
-/*----------------------------------------------------------------------------*/
-
-static int __init omap_init_dma(void)
+static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 {
-	unsigned long base;
-	int ch, r;
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
+	}
 
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
+	p = pdata;
+	d = p->dma_attr;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
+		return -EINVAL;
 	}
 
-	omap_dma_base = ioremap(base, SZ_4K);
-	BUG_ON(!omap_dma_base);
+	omap_dma_base = ioremap(mem->start, resource_size(mem));
+	if (!omap_dma_base) {
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
+	dma_chan_count		= d->chan_count;
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
 
 	if (cpu_is_omap15xx()) {
 		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
-		dma_chan_count = 9;
-		enable_1510_mode = 1;
 	} else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
 		printk(KERN_INFO "OMAP DMA hardware version %d\n",
 		       dma_read(HW_ID));
@@ -2107,21 +2093,14 @@ static int __init omap_init_dma(void)
 			w = dma_read(GSCR);
 			w |= 1 << 3;
 			dma_write(w, GSCR);
-			dma_chan_count = 16;
-		} else
-			dma_chan_count = 9;
+		}
 	} else if (cpu_class_is_omap2()) {
 		u8 revision = dma_read(REVISION) & 0xff;
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
-		dma_chan_count = dma_lch_count;
-	} else {
-		dma_chan_count = 0;
-		return 0;
 	}
 
 	spin_lock_init(&dma_chan_lock);
-
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
 		if (cpu_class_is_omap2())
@@ -2138,19 +2117,30 @@ static int __init omap_init_dma(void)
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
+				printk(KERN_ERR "unable to request IRQ %d"
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
@@ -2160,46 +2150,72 @@ static int __init omap_init_dma(void)
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
-		u32 v = dma_read(OCP_SYSCONFIG);
-		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
-				DMA_SYSCONFIG_SIDLEMODE_MASK |
-				DMA_SYSCONFIG_AUTOIDLE);
-		v |= (DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
-			DMA_SYSCONFIG_SIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
-			DMA_SYSCONFIG_AUTOIDLE);
-		dma_write(v , OCP_SYSCONFIG);
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
 
+	/* reserve dma channels 0 and 1 in high security devices */
+	if (cpu_is_omap34xx() &&
+		(omap_type() != OMAP2_DEVICE_TYPE_GP)) {
+		printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
+				"HS ROM code\n");
+		dma_chan[0].dev_id = 0;
+		dma_chan[1].dev_id = 1;
+	}
+
+	/* Enable run timer PM */
+	ddev = pdev;
+	pm_runtime_enable(&ddev->dev);
+
+	if (omap_dma_reserve_channels)
+		pm_runtime_get_sync(&ddev->dev);
+
+	dev_info(&pdev->dev, "System DMA registered\n");
 	return 0;
 
-out_free:
+exit_dma_chan:
 	kfree(dma_chan);
+exit_unmap:
+	iounmap(omap_dma_base);
+exit_release_region:
+	release_mem_region(mem->start, resource_size(mem));
+	return ret;
+}
 
-out_unmap:
+static int __devexit omap_system_dma_remove(struct platform_device *pdev)
+{
+	struct resource *mem;
 	iounmap(omap_dma_base);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	return 0;
+}
 
-	return r;
+static struct platform_driver omap_system_dma_driver = {
+	.probe		= omap_system_dma_probe,
+	.remove		= omap_system_dma_remove,
+	.driver		= {
+		.name	= "dma"
+	},
+};
+
+static int __init omap_system_dma_init(void)
+{
+	return platform_driver_register(&omap_system_dma_driver);
+}
+
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
index 67b9489..a44b11b 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -21,142 +21,11 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
 
+#include <linux/platform_device.h>
+
 /* Move omap4 specific defines to dma-44xx.h */
 #include "dma-44xx.h"
 
-/* Hardware registers for omap1 */
-#define OMAP1_DMA_BASE			(0xfffed800)
-
-#define OMAP1_DMA_GCR			0x400
-#define OMAP1_DMA_GSCR			0x404
-#define OMAP1_DMA_GRST			0x408
-#define OMAP1_DMA_HW_ID			0x442
-#define OMAP1_DMA_PCH2_ID		0x444
-#define OMAP1_DMA_PCH0_ID		0x446
-#define OMAP1_DMA_PCH1_ID		0x448
-#define OMAP1_DMA_PCHG_ID		0x44a
-#define OMAP1_DMA_PCHD_ID		0x44c
-#define OMAP1_DMA_CAPS_0_U		0x44e
-#define OMAP1_DMA_CAPS_0_L		0x450
-#define OMAP1_DMA_CAPS_1_U		0x452
-#define OMAP1_DMA_CAPS_1_L		0x454
-#define OMAP1_DMA_CAPS_2		0x456
-#define OMAP1_DMA_CAPS_3		0x458
-#define OMAP1_DMA_CAPS_4		0x45a
-#define OMAP1_DMA_PCH2_SR		0x460
-#define OMAP1_DMA_PCH0_SR		0x480
-#define OMAP1_DMA_PCH1_SR		0x482
-#define OMAP1_DMA_PCHD_SR		0x4c0
-
-/* Hardware registers for omap2 and omap3 */
-#define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
-#define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
-#define OMAP44XX_DMA4_BASE		(L4_44XX_BASE + 0x56000)
-
-#define OMAP_DMA4_REVISION		0x00
-#define OMAP_DMA4_GCR			0x78
-#define OMAP_DMA4_IRQSTATUS_L0		0x08
-#define OMAP_DMA4_IRQSTATUS_L1		0x0c
-#define OMAP_DMA4_IRQSTATUS_L2		0x10
-#define OMAP_DMA4_IRQSTATUS_L3		0x14
-#define OMAP_DMA4_IRQENABLE_L0		0x18
-#define OMAP_DMA4_IRQENABLE_L1		0x1c
-#define OMAP_DMA4_IRQENABLE_L2		0x20
-#define OMAP_DMA4_IRQENABLE_L3		0x24
-#define OMAP_DMA4_SYSSTATUS		0x28
-#define OMAP_DMA4_OCP_SYSCONFIG		0x2c
-#define OMAP_DMA4_CAPS_0		0x64
-#define OMAP_DMA4_CAPS_2		0x6c
-#define OMAP_DMA4_CAPS_3		0x70
-#define OMAP_DMA4_CAPS_4		0x74
-
-#define OMAP1_LOGICAL_DMA_CH_COUNT	17
-#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
-
-/* Common channel specific registers for omap1 */
-#define OMAP1_DMA_CH_BASE(n)		(0x40 * (n) + 0x00)
-#define OMAP1_DMA_CSDP(n)		(0x40 * (n) + 0x00)
-#define OMAP1_DMA_CCR(n)		(0x40 * (n) + 0x02)
-#define OMAP1_DMA_CICR(n)		(0x40 * (n) + 0x04)
-#define OMAP1_DMA_CSR(n)		(0x40 * (n) + 0x06)
-#define OMAP1_DMA_CEN(n)		(0x40 * (n) + 0x10)
-#define OMAP1_DMA_CFN(n)		(0x40 * (n) + 0x12)
-#define OMAP1_DMA_CSFI(n)		(0x40 * (n) + 0x14)
-#define OMAP1_DMA_CSEI(n)		(0x40 * (n) + 0x16)
-#define OMAP1_DMA_CPC(n)		(0x40 * (n) + 0x18)	/* 15xx only */
-#define OMAP1_DMA_CSAC(n)		(0x40 * (n) + 0x18)
-#define OMAP1_DMA_CDAC(n)		(0x40 * (n) + 0x1a)
-#define OMAP1_DMA_CDEI(n)		(0x40 * (n) + 0x1c)
-#define OMAP1_DMA_CDFI(n)		(0x40 * (n) + 0x1e)
-#define OMAP1_DMA_CLNK_CTRL(n)		(0x40 * (n) + 0x28)
-
-/* Common channel specific registers for omap2 */
-#define OMAP_DMA4_CH_BASE(n)		(0x60 * (n) + 0x80)
-#define OMAP_DMA4_CCR(n)		(0x60 * (n) + 0x80)
-#define OMAP_DMA4_CLNK_CTRL(n)		(0x60 * (n) + 0x84)
-#define OMAP_DMA4_CICR(n)		(0x60 * (n) + 0x88)
-#define OMAP_DMA4_CSR(n)		(0x60 * (n) + 0x8c)
-#define OMAP_DMA4_CSDP(n)		(0x60 * (n) + 0x90)
-#define OMAP_DMA4_CEN(n)		(0x60 * (n) + 0x94)
-#define OMAP_DMA4_CFN(n)		(0x60 * (n) + 0x98)
-#define OMAP_DMA4_CSEI(n)		(0x60 * (n) + 0xa4)
-#define OMAP_DMA4_CSFI(n)		(0x60 * (n) + 0xa8)
-#define OMAP_DMA4_CDEI(n)		(0x60 * (n) + 0xac)
-#define OMAP_DMA4_CDFI(n)		(0x60 * (n) + 0xb0)
-#define OMAP_DMA4_CSAC(n)		(0x60 * (n) + 0xb4)
-#define OMAP_DMA4_CDAC(n)		(0x60 * (n) + 0xb8)
-
-/* Channel specific registers only on omap1 */
-#define OMAP1_DMA_CSSA_L(n)		(0x40 * (n) + 0x08)
-#define OMAP1_DMA_CSSA_U(n)		(0x40 * (n) + 0x0a)
-#define OMAP1_DMA_CDSA_L(n)		(0x40 * (n) + 0x0c)
-#define OMAP1_DMA_CDSA_U(n)		(0x40 * (n) + 0x0e)
-#define OMAP1_DMA_COLOR_L(n)		(0x40 * (n) + 0x20)
-#define OMAP1_DMA_COLOR_U(n)		(0x40 * (n) + 0x22)
-#define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
-#define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)	/* not on 15xx */
-#define OMAP1_DMA_CCEN(n)		0
-#define OMAP1_DMA_CCFN(n)		0
-
-/* Channel specific registers only on omap2 */
-#define OMAP_DMA4_CSSA(n)		(0x60 * (n) + 0x9c)
-#define OMAP_DMA4_CDSA(n)		(0x60 * (n) + 0xa0)
-#define OMAP_DMA4_CCEN(n)		(0x60 * (n) + 0xbc)
-#define OMAP_DMA4_CCFN(n)		(0x60 * (n) + 0xc0)
-#define OMAP_DMA4_COLOR(n)		(0x60 * (n) + 0xc4)
-
-/* Additional registers available on OMAP4 */
-#define OMAP_DMA4_CDP(n)		(0x60 * (n) + 0xd0)
-#define OMAP_DMA4_CNDP(n)		(0x60 * (n) + 0xd4)
-#define OMAP_DMA4_CCDN(n)		(0x60 * (n) + 0xd8)
-
-/* Dummy defines to keep multi-omap compiles happy */
-#define OMAP1_DMA_REVISION		0
-#define OMAP1_DMA_IRQSTATUS_L0		0
-#define OMAP1_DMA_IRQENABLE_L0		0
-#define OMAP1_DMA_OCP_SYSCONFIG		0
-#define OMAP_DMA4_HW_ID			0
-#define OMAP_DMA4_CAPS_0_L		0
-#define OMAP_DMA4_CAPS_0_U		0
-#define OMAP_DMA4_CAPS_1_L		0
-#define OMAP_DMA4_CAPS_1_U		0
-#define OMAP_DMA4_GSCR			0
-#define OMAP_DMA4_CPC(n)		0
-
-#define OMAP_DMA4_LCH_CTRL(n)		0
-#define OMAP_DMA4_COLOR_L(n)		0
-#define OMAP_DMA4_COLOR_U(n)		0
-#define OMAP_DMA4_CCR2(n)		0
-#define OMAP1_DMA_CSSA(n)		0
-#define OMAP1_DMA_CDSA(n)		0
-#define OMAP_DMA4_CSSA_L(n)		0
-#define OMAP_DMA4_CSSA_U(n)		0
-#define OMAP_DMA4_CDSA_L(n)		0
-#define OMAP_DMA4_CDSA_U(n)		0
-#define OMAP1_DMA_COLOR(n)		0
-
-/*----------------------------------------------------------------------------*/
-
 /* DMA channels for omap1 */
 #define OMAP_DMA_NO_DEVICE		0
 #define OMAP_DMA_MCSI1_TX		1
@@ -373,21 +242,6 @@
 #define DMA_THREAD_FIFO_25		(0x02 << 14)
 #define DMA_THREAD_FIFO_50		(0x03 << 14)
 
-/* DMA4_OCP_SYSCONFIG bits */
-#define DMA_SYSCONFIG_MIDLEMODE_MASK		(3 << 12)
-#define DMA_SYSCONFIG_CLOCKACTIVITY_MASK	(3 << 8)
-#define DMA_SYSCONFIG_EMUFREE			(1 << 5)
-#define DMA_SYSCONFIG_SIDLEMODE_MASK		(3 << 3)
-#define DMA_SYSCONFIG_SOFTRESET			(1 << 2)
-#define DMA_SYSCONFIG_AUTOIDLE			(1 << 0)
-
-#define DMA_SYSCONFIG_MIDLEMODE(n)		((n) << 12)
-#define DMA_SYSCONFIG_SIDLEMODE(n)		((n) << 3)
-
-#define DMA_IDLEMODE_SMARTIDLE			0x2
-#define DMA_IDLEMODE_NO_IDLE			0x1
-#define DMA_IDLEMODE_FORCE_IDLE			0x0
-
 /* Chaining modes*/
 #ifndef CONFIG_ARCH_OMAP1
 #define OMAP_DMA_STATIC_CHAIN		0x1
@@ -480,6 +334,7 @@ struct omap_dma_channel_params {
 #endif
 };
 
+#include <mach/dma.h>
 struct omap_dma_dev_attr {
 	u32 dev_caps;
 	u16 lch_count;
@@ -487,6 +342,12 @@ struct omap_dma_dev_attr {
 	struct omap_dma_lch *chan;
 };
 
+/* System DMA platform data structure */
+struct omap_system_dma_plat_info {
+	struct omap_dma_dev_attr *dma_attr;
+	void __iomem *omap_dma_base;
+};
+
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
-- 
1.7.0.4

