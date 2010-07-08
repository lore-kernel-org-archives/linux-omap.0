From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 05/10] OMAP1: DMA: Introduce DMA driver as platform driver
Date: Fri,  9 Jul 2010 04:21:17 +0530
Message-ID: <1278629482-32501-6-git-send-email-manjugk@ti.com>
References: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab0GHWyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 18:54:18 -0400
In-Reply-To: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

This patch introduces OMAP1 DMA driver as platform device
and adds support for registering through platform device
layer.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/dma.c              |  271 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/dma.h |   80 ++++++++++
 arch/arm/plat-omap/include/plat/dma.h  |  118 ++++++++++++++
 3 files changed, 469 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.c
 create mode 100644 arch/arm/mach-omap1/include/mach/dma.h

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
new file mode 100644
index 0000000..57be4f5
--- /dev/null
+++ b/arch/arm/mach-omap1/dma.c
@@ -0,0 +1,271 @@
+/*
+ * dma.c - OMAP1/OMAP7xx-specific DMA code
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * Author:
+ *	Manjunatha GK <manjugk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <mach/dma.h>
+
+#include <plat/irqs.h>
+#include <plat/dma.h>
+#include <plat/tc.h>
+
+#define OMAP_FUNC_MUX_ARM_BASE          (0xfffe1000 + 0xec)
+
+#define omap1_dma_read(reg)		__raw_readw(dma_base + reg)
+#define omap1_dma_write(val, reg)	__raw_writew(val, dma_base + reg)
+
+static struct resource res[] __initdata = {
+	[0] = {
+		.start	= OMAP1_DMA_BASE,
+		.end	= OMAP1_DMA_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name   = "system_dma_0",
+		.start  = INT_DMA_CH0_6,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.name   = "system_dma_1",
+		.start  = INT_DMA_CH1_7,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[3] = {
+		.name   = "system_dma_2",
+		.start  = INT_DMA_CH2_8,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[4] = {
+		.name   = "system_dma_3",
+		.start  = INT_DMA_CH3,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[5] = {
+		.name   = "system_dma_4",
+		.start  = INT_DMA_CH4,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[6] = {
+		.name   = "system_dma_5",
+		.start  = INT_DMA_CH5,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[7] = {
+		.name   = "system_dma_6",
+		.start  = INT_DMA_LCD,
+		.flags  = IORESOURCE_IRQ,
+	},
+	/* irq's for omap16xx and omap7xx */
+	[8] = {
+		.name   = "system_dma_7",
+		.start  = 53 + IH2_BASE,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[9] = {
+		.name   = "system_dma_8",
+		.start  = 54 + IH2_BASE,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[10] = {
+		.name  = "system_dma_9",
+		.start = 55 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+	[11] = {
+		.name  = "system_dma_10",
+		.start = 56 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+	[12] = {
+		.name  = "system_dma_11",
+		.start = 57 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+	[13] = {
+		.name  = "system_dma_12",
+		.start = 58 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+	[14] = {
+		.name  = "system_dma_13",
+		.start = 59 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+	[15] = {
+		.name  = "system_dma_14",
+		.start = 60 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+	[16] = {
+		.name  = "system_dma_15",
+		.start = 61 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+	[17] = {
+		.name  = "system_dma_16",
+		.start = 62 + IH2_BASE,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_dma_reg_offset dma_reg_offset[] = {
+	{
+	.lch_base		= OMAP1_DMA_CH_BASE,
+	.gcr			= OMAP1_DMA_GCR,
+	.gscr			= OMAP1_DMA_GSCR,
+	.grst			= OMAP1_DMA_GRST,
+	.hw_id			= OMAP1_DMA_HW_ID,
+	.ch_specific = {
+		.cssa_l		= OMAP1_DMA_CSSA_L,
+		.cssa_u		= OMAP1_DMA_CSSA_U,
+		.cdsa_l		= OMAP1_DMA_CDSA_L,
+		.cdsa_u		= OMAP1_DMA_CDSA_U,
+		.lch_ctrl	= OMAP1_DMA_LCH_CTRL,
+		.color_l	= OMAP1_DMA_COLOR_L,
+		.color_u	= OMAP1_DMA_COLOR_U,
+		.ccr2		= OMAP1_DMA_CCR2,
+	},
+	.common_ch   = {
+		.csdp		= OMAP1_DMA_CSDP,
+		.ccr		= OMAP1_DMA_CCR,
+		.csei		= OMAP1_DMA_CSEI,
+		.csfi		= OMAP1_DMA_CSFI,
+		.cdei		= OMAP1_DMA_CDEI,
+		.cdfi		= OMAP1_DMA_CDFI,
+		.clnk_ctrl	= OMAP1_DMA_CLNK_CTRL,
+		.cpc		= OMAP1_DMA_CPC,
+		.cdac		= OMAP1_DMA_CDAC,
+		.cicr		= OMAP1_DMA_CICR,
+	},
+	.reg_caps = {
+		.caps_0u	= OMAP1_DMA_CAPS_0_U,
+		.caps_0l	= OMAP1_DMA_CAPS_0_L,
+		.caps_1u	= OMAP1_DMA_CAPS_1_U,
+		.caps_1l	= OMAP1_DMA_CAPS_1_L,
+		.caps_2		= OMAP1_DMA_CAPS_2,
+		.caps_3		= OMAP1_DMA_CAPS_3,
+		.caps_4		= OMAP1_DMA_CAPS_4,
+	},
+	},
+};
+struct omap_dma_reg_offset *r = (struct omap_dma_reg_offset *)&dma_reg_offset;
+
+
+static struct omap_dma_lch *omap1_dma_chan;
+static void __iomem *dma_base;
+static int enable_1510_mode;
+
+static int __init omap1_system_dma_init(void)
+{
+	struct platform_device *pdev;
+	struct omap_system_dma_plat_info *pdata;
+	struct omap_dma_dev_attr *d;
+	int ret;
+
+	pdev = platform_device_alloc("system_dma", 0);
+	if (!pdev) {
+		pr_err("%s: Unable to device alloc for dma\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret) {
+		pr_err("%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_device_put;
+	}
+
+	pdata = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: Unable to allocate pdata for %s\n",
+			__func__, pdev->name);
+		ret = -ENOMEM;
+		goto exit_device_put;
+	}
+
+	d = pdata->dma_attr;
+
+	/* Valid attributes for omap1 plus processors */
+	d->dma_dev_attr = 0;
+
+	if (cpu_is_omap15xx())
+		d->dma_dev_attr = enable_1510_mode = ENABLE_1510_MODE;
+
+	d->dma_dev_attr			|= SRC_PORT;
+	d->dma_dev_attr			|= DST_PORT;
+	d->dma_dev_attr			|= SRC_INDEX;
+	d->dma_dev_attr			|= DST_INDEX;
+	d->dma_dev_attr			|= IS_BURST_ONLY4;
+	d->dma_dev_attr			|= CLEAR_CSR_ON_READ;
+	d->dma_dev_attr			|= IS_WORD_16;
+
+	d->dma_lch_count		= OMAP1_LOGICAL_DMA_CH_COUNT;
+
+	pdata->omap_dma_base		= (void __iomem *)res[0].start;
+	pdata->dma_reg_offset		= r;
+
+	pdata->dma_handle_ch		= omap1_dma_handle_ch;
+	pdata->clear_lch_regs		= clear_lch_regs;
+	pdata->clear_ccr_csr		= clear_ccr_csr;
+	pdata->sync_device_set		= sync_device_set;
+	pdata->dma_running		= dma_running;
+	pdata->dma_irq_register		= dma_irq_register;
+	pdata->set_prio_lch		= set_prio_lch;
+	pdata->enable_lnk		= enable_lnk;
+	pdata->disable_lnk		= disable_lnk;
+	pdata->enable_channel_irq	= omap_enable_channel_irq;
+	pdata->disable_channel_irq	= NULL;
+	pdata->set_dma_write_mode	= NULL;
+	pdata->disable_irq_lch		= NULL;
+	pdata->enable_irq_lch		= NULL;
+
+	dma_base			= pdata->omap_dma_base;
+
+	/* Errata handling for all omap1 plus processors */
+	pdata->errata			= 0;
+
+	if (cpu_class_is_omap1() && !cpu_is_omap15xx())
+		pdata->errata		|= OMAP3_3_ERRATUM;
+
+	ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+	if (ret) {
+		pr_err("%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_release_pdata;
+	}
+	ret = platform_device_add(pdev);
+	if (ret) {
+		pr_err("%s: Unable to add resources for %s%d\n",
+			__func__, pdev->name, pdev->id);
+		goto exit_release_pdata;
+	}
+
+exit_release_pdata:
+	kfree(pdata);
+exit_device_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+arch_initcall(omap1_system_dma_init);
diff --git a/arch/arm/mach-omap1/include/mach/dma.h b/arch/arm/mach-omap1/include/mach/dma.h
new file mode 100644
index 0000000..7c23330
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/dma.h
@@ -0,0 +1,80 @@
+/*
+ *  arch/arm/mach-omap1/include/mach/dma.h
+ *
+ *  Copyright (C) 2010 Texas Instruments, Inc.
+ *  Author: Manjunatha GK <manjugk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __ASM_ARCH_OMAP1_DMA_H
+#define __ASM_ARCH_OMAP1_DMA_H
+/* Hardware registers for omap1 */
+#define OMAP1_DMA_BASE			(0xfffed800)
+
+#define OMAP1_DMA_GCR			0x400
+#define OMAP1_DMA_GSCR			0x404
+#define OMAP1_DMA_GRST			0x408
+#define OMAP1_DMA_HW_ID			0x442
+#define OMAP1_DMA_PCH2_ID		0x444
+#define OMAP1_DMA_PCH0_ID		0x446
+#define OMAP1_DMA_PCH1_ID		0x448
+#define OMAP1_DMA_PCHG_ID		0x44a
+#define OMAP1_DMA_PCHD_ID		0x44c
+#define OMAP1_DMA_CAPS_0_U		0x44e
+#define OMAP1_DMA_CAPS_0_L		0x450
+#define OMAP1_DMA_CAPS_1_U		0x452
+#define OMAP1_DMA_CAPS_1_L		0x454
+#define OMAP1_DMA_CAPS_2		0x456
+#define OMAP1_DMA_CAPS_3		0x458
+#define OMAP1_DMA_CAPS_4		0x45a
+#define OMAP1_DMA_PCH2_SR		0x460
+#define OMAP1_DMA_PCH0_SR		0x480
+#define OMAP1_DMA_PCH1_SR		0x482
+#define OMAP1_DMA_PCHD_SR		0x4c0
+
+#define OMAP1_LOGICAL_DMA_CH_COUNT	17
+
+/* Common channel specific registers for omap1 */
+#define OMAP1_DMA_CH_BASE		(0x40)
+
+#define OMAP1_DMA_CSDP			(0x00)
+#define OMAP1_DMA_CCR			(0x02)
+#define OMAP1_DMA_CICR			(0x04)
+#define OMAP1_DMA_CSR			(0x06)
+#define OMAP1_DMA_CEN			(0x10)
+#define OMAP1_DMA_CFN			(0x12)
+#define OMAP1_DMA_CSFI			(0x14)
+#define OMAP1_DMA_CSEI			(0x16)
+#define OMAP1_DMA_CPC			(0x18)	/* 15xx only */
+#define OMAP1_DMA_CSAC			(0x18)
+#define OMAP1_DMA_CDAC			(0x1a)
+#define OMAP1_DMA_CDEI			(0x1c)
+#define OMAP1_DMA_CDFI			(0x1e)
+#define OMAP1_DMA_CLNK_CTRL		(0x28)
+
+/* Channel specific registers only on omap1 */
+#define OMAP1_DMA_CSSA_L		(0x08)
+#define OMAP1_DMA_CSSA_U		(0x0a)
+#define OMAP1_DMA_CDSA_L		(0x0c)
+#define OMAP1_DMA_CDSA_U		(0x0e)
+#define OMAP1_DMA_COLOR_L		(0x20)
+#define OMAP1_DMA_COLOR_U		(0x22)
+#define OMAP1_DMA_CCR2			(0x24)
+#define OMAP1_DMA_LCH_CTRL		(0x2a)	/* not on 15xx */
+#define OMAP1_DMA_CCEN			0
+#define OMAP1_DMA_CCFN			0
+
+#endif /* __ASM_ARCH_OMAP1_DMA_H */
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 02232ca..fcc7d6e 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -21,6 +21,8 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
 
+#include <linux/platform_device.h>
+
 /* Move omap4 specific defines to dma-44xx.h */
 #include "dma-44xx.h"
 
@@ -429,6 +431,76 @@ enum omap_dma_channel_mode {
 	OMAP_DMA_LCH_PD
 };
 
+/* Register offset's structures */
+struct dma_irq_offset {
+	int irq_status_l0;
+	int irq_enable_l0;
+};
+
+struct dma_common_ch {
+	/* common channel specific register offsets */
+	int csdp;
+	int ccr;
+	int cicr;
+	int csr;
+	int cen;
+	int cfn;
+	int csfi;
+	int csei;
+	int cpc;
+	int csac;
+	int cdac;
+	int cdei;
+	int cdfi;
+	int clnk_ctrl;
+};
+
+struct dma_ch_specific {
+	/* channel specific registers */
+	int cssa;
+	int cssa_l;
+	int cssa_u;
+	int cdsa;
+	int cdsa_l;
+	int cdsa_u;
+	int color;
+	int color_l;
+	int color_u;
+	int ccr2;
+	int lch_ctrl;
+	int ccen;
+	int ccfn;
+};
+
+struct dma_reg_caps {
+	int caps_0;
+	int caps_0u;
+	int caps_0l;
+	int caps_1u;
+	int caps_1l;
+	int caps_2;
+	int caps_3;
+	int caps_4;
+};
+
+struct omap_dma_reg_offset {
+	int lch_base;
+
+	/* Hardware registers */
+	int gcr;
+	int gscr;
+	int grst;
+	int hw_id;
+	int rev;
+	int sysstatus;
+	int ocp_sysconfig;
+
+	struct dma_ch_specific ch_specific;
+	struct dma_reg_caps reg_caps;
+	struct dma_common_ch common_ch;
+	struct dma_irq_offset irqreg;
+};
+
 struct omap_dma_channel_params {
 	int data_type;		/* data type 8,16,32 */
 	int elem_count;		/* number of elements in a frame */
@@ -463,6 +535,52 @@ struct omap_dma_channel_params {
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
+	/* required for Dynamic chaining */
+	int prev_linked_ch;
+	int next_linked_ch;
+	int state;
+	int chain_id;
+
+	int status;
+	long flags;
+};
+
+struct omap_dma_dev_attr {
+	u32 dma_dev_attr;
+	u16 dma_lch_count;
+};
+
+/* System DMA platform data structure */
+struct omap_system_dma_plat_info {
+	struct omap_dma_dev_attr *dma_attr;
+	u32 errata;
+	struct omap_dma_reg_offset *dma_reg_offset;
+	void __iomem *omap_dma_base;
+	void (*clear_lch_regs)(int lch);
+	void (*clear_ccr_csr)(int lch);
+	void (*set_dma_write_mode)(int lch, int mode);
+	void (*enable_irq_lch)(int lch);
+	void (*disable_irq_lch)(int lch);
+	int  (*dma_running) (int dma_chan_count);
+	int (*dma_handle_ch) (int ch);
+	void (*sync_device_set)(int dev_id, int free_ch);
+	int  (*set_prio_lch)(int l, unsigned char read_prio,
+					unsigned char write_prio);
+	int  (*dma_irq_register)(int dma_irq, int irq_count,
+				struct omap_dma_lch *dma_chan);
+	void (*enable_lnk)(int lch);
+	void (*disable_lnk)(int lch);
+	void (*enable_channel_irq)(int lch);
+	void (*disable_channel_irq)(int lch);
+};
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
-- 
1.7.0.4

