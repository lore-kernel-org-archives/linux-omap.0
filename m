From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 06/10] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Fri,  9 Jul 2010 04:21:18 +0530
Message-ID: <1278629482-32501-7-git-send-email-manjugk@ti.com>
References: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37477 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758720Ab0GHWyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 18:54:16 -0400
In-Reply-To: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

This patch converts omap2/3/4 dma driver into platform
devices through using omap hwmod, omap device and runtime pm
frameworks.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/dma.c              |  200 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h |   76 ++++++++++++
 2 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dma.c
 create mode 100644 arch/arm/mach-omap2/include/mach/dma.h

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
new file mode 100644
index 0000000..548321b
--- /dev/null
+++ b/arch/arm/mach-omap2/dma.c
@@ -0,0 +1,200 @@
+/*
+ * dma.c - OMAP2 specific DMA code
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
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+#include <plat/dma.h>
+
+struct omap_device_pm_latency omap2_dma_latency[] = {
+	{
+	.deactivate_func = omap_device_idle_hwmods,
+	.activate_func	 = omap_device_enable_hwmods,
+	.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+struct omap_dma_reg_offset dma_reg_offset[] = {
+	{
+	.lch_base		= OMAP_DMA4_CH_BASE,
+	.gcr			= OMAP_DMA4_GCR,
+	.ocp_sysconfig		= OMAP_DMA4_OCP_SYSCONFIG,
+	.rev			= OMAP_DMA4_REVISION,
+	.common_ch	= {
+		.csdp		= OMAP_DMA4_CSDP,
+		.ccr		= OMAP_DMA4_CCR,
+		.cicr		= OMAP_DMA4_CICR,
+		.csr		= OMAP_DMA4_CSR,
+		.csfi		= OMAP_DMA4_CSFI,
+		.csei		= OMAP_DMA4_CSEI,
+		.cdac		= OMAP_DMA4_CDAC,
+		.cdei		= OMAP_DMA4_CDEI,
+		.cdfi		= OMAP_DMA4_CDFI,
+		.clnk_ctrl	= OMAP_DMA4_CLNK_CTRL,
+		.cen		= OMAP_DMA4_CEN,
+		.cfn		= OMAP_DMA4_CFN,
+	},
+	.ch_specific	= {
+		.cssa		= OMAP_DMA4_CSSA,
+		.cdsa		= OMAP_DMA4_CDSA,
+	},
+	.irqreg		= {
+		.irq_status_l0	= OMAP_DMA4_IRQSTATUS_L0,
+		.irq_enable_l0	= OMAP_DMA4_IRQENABLE_L0,
+	},
+
+	.reg_caps	= {
+		.caps_0		= OMAP_DMA4_CAPS_0,
+	},
+	},
+};
+struct omap_dma_reg_offset *r = (struct omap_dma_reg_offset *)&dma_reg_offset;
+
+struct omap_dma_dev_attr *d;
+
+static struct omap_system_dma_plat_info *omap2_pdata;
+static void __iomem *dma_base;
+static struct dma_link_info *dma_linked_lch;
+static u32 dma_chan_count;
+
+/* One time initializations */
+static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *user)
+{
+	struct omap_device *od;
+	struct omap_system_dma_plat_info *pdata;
+	struct resource *mem;
+	char *name = "dma";
+
+	pdata = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: Unable to allocate pdata for %s:%s\n",
+			__func__, name, oh->name);
+		return -ENOMEM;
+	}
+
+
+	pdata->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
+
+	pdata->dma_reg_offset		= r;
+
+	pdata->disable_irq_lch		= disable_irq_lch;
+	pdata->enable_irq_lch		= enable_irq_lch;
+	pdata->dma_handle_ch		= omap2_dma_handle_ch;
+	pdata->clear_lch_regs		= NULL;
+	pdata->dma_running		= dma_running;
+	pdata->set_prio_lch		= set_prio_lch;
+	pdata->dma_irq_register		= dma_irq_register;
+	pdata->enable_lnk		= omap_enable_lnk;
+	pdata->disable_lnk		= omap_disable_lnk;
+	pdata->enable_channel_irq	= omap_enable_channel_irq;
+	pdata->disable_channel_irq	= omap_disable_channel_irq;
+	pdata->clear_ccr_csr		= NULL;
+	pdata->sync_device_set		= NULL;
+
+	/* Handling Errata's for all OMAP2PLUS processors */
+	pdata->errata			= 0;
+
+	if (cpu_is_omap242x() ||
+		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0))
+		pdata->errata		= DMA_CHAINING_ERRATA;
+
+	/*
+	 * Errata: On ES2.0 BUFFERING disable must be set.
+	 * This will always fail on ES1.0
+	 */
+	if (cpu_is_omap24xx())
+		pdata->errata		|= DMA_BUFF_DISABLE_ERRATA;
+
+	/*
+	 * Errata: OMAP2: sDMA Channel is not disabled
+	 * after a transaction error. So we explicitely
+	 * disable the channel
+	 */
+	if (cpu_class_is_omap2())
+		pdata->errata		|= DMA_CH_DISABLE_ERRATA;
+
+	/* Errata: OMAP3 :
+	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
+	 * after secure sram context save and restore. Hence we need to
+	 * manually clear those IRQs to avoid spurious interrupts. This
+	 * affects only secure devices.
+	 */
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		pdata->errata		|= DMA_IRQ_STATUS_ERRATA;
+
+	/* Errata3.3: Applicable for all omap2 plus */
+	pdata->errata			|= OMAP3_3_ERRATUM;
+
+	od = omap_device_build(name, 0, oh, pdata, sizeof(*pdata),
+			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Cant build omap_device for %s:%s.\n",
+			__func__, name, oh->name);
+		kfree(pdata);
+		return 0;
+	}
+
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
+	/* Get DMA device attributes from hwmod data base */
+	d = (struct omap_dma_dev_attr *)oh->dev_attr;
+
+	dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
+					d->dma_lch_count, GFP_KERNEL);
+	if (!dma_linked_lch) {
+		int ret;
+		ret = -ENOMEM;
+		kfree(pdata);
+		return ret;
+	}
+	omap2_pdata    = pdata;
+
+	pm_runtime_enable(&(od->pdev.dev));
+	return 0;
+}
+
+static int __init omap2_system_dma_init(void)
+{
+	int ret;
+
+	ret = omap_hwmod_for_each_by_class("dma",
+			omap2_system_dma_init_dev, NULL);
+
+	return ret;
+}
+arch_initcall(omap2_system_dma_init);
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
new file mode 100644
index 0000000..a8d8fee
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -0,0 +1,76 @@
+/*
+ *  arch/arm/mach-omap2/include/mach/dma.h
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
+#ifndef __ASM_ARCH_OMAP2_DMA_H
+#define __ASM_ARCH_OMAP2_DMA_H
+#include <plat/dma.h>
+
+/* OMAP2 Plus register offset's */
+#define OMAP_DMA4_REVISION		0x00
+#define OMAP_DMA4_GCR			0x78
+#define OMAP_DMA4_IRQSTATUS_L0		0x08
+#define OMAP_DMA4_IRQSTATUS_L1		0x0c
+#define OMAP_DMA4_IRQSTATUS_L2		0x10
+#define OMAP_DMA4_IRQSTATUS_L3		0x14
+#define OMAP_DMA4_IRQENABLE_L0		0x18
+#define OMAP_DMA4_IRQENABLE_L1		0x1c
+#define OMAP_DMA4_IRQENABLE_L2		0x20
+#define OMAP_DMA4_IRQENABLE_L3		0x24
+#define OMAP_DMA4_SYSSTATUS		0x28
+#define OMAP_DMA4_OCP_SYSCONFIG		0x2c
+#define OMAP_DMA4_CAPS_0		0x64
+#define OMAP_DMA4_CAPS_2		0x6c
+#define OMAP_DMA4_CAPS_3		0x70
+#define OMAP_DMA4_CAPS_4		0x74
+
+/* Should be part of hwmod data base ? */
+#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
+
+/* Common channel specific registers for omap2 */
+#define OMAP_DMA4_CH_BASE		(0x60)
+
+#define OMAP_DMA4_CCR			(0x80)
+#define OMAP_DMA4_CLNK_CTRL		(0x84)
+#define OMAP_DMA4_CICR			(0x88)
+#define OMAP_DMA4_CSR			(0x8c)
+#define OMAP_DMA4_CSDP			(0x90)
+#define OMAP_DMA4_CEN			(0x94)
+#define OMAP_DMA4_CFN			(0x98)
+#define OMAP_DMA4_CSEI			(0xa4)
+#define OMAP_DMA4_CSFI			(0xa8)
+#define OMAP_DMA4_CDEI			(0xac)
+#define OMAP_DMA4_CDFI			(0xb0)
+#define OMAP_DMA4_CSAC			(0xb4)
+#define OMAP_DMA4_CDAC			(0xb8)
+
+/* Channel specific registers only on omap2 */
+#define OMAP_DMA4_CSSA			(0x9c)
+#define OMAP_DMA4_CDSA			(0xa0)
+#define OMAP_DMA4_CCEN			(0xbc)
+#define OMAP_DMA4_CCFN			(0xc0)
+#define OMAP_DMA4_COLOR			(0xc4)
+
+/* Additional registers available on OMAP4 */
+#define OMAP_DMA4_CDP			(0xd0)
+#define OMAP_DMA4_CNDP			(0xd4)
+#define OMAP_DMA4_CCDN			(0xd8)
+
+#endif /* __ASM_ARCH_OMAP2_DMA_H */
-- 
1.7.0.4

