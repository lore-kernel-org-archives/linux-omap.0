From: Sebastien Jan <s-jan@ti.com>
Subject: [RFC PATCH 8/9] HSI: HSI device support
Date: Fri, 30 Oct 2009 11:00:07 +0100
Message-ID: <1256896808-20152-9-git-send-email-s-jan@ti.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48920 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756789AbZJ3J7J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 05:59:09 -0400
In-Reply-To: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sebastien Jan <s-jan@ti.com>, Carlos Chinea <carlos.chinea@nokia.com>

Common registers definition for HSI like devices (common to MIPI HSI and SSI
for OMAP platforms)
HSI device definition

Signed-off-by: Sebastien Jan <s-jan@ti.com>
Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 arch/arm/mach-omap2/Makefile          |    1 +
 arch/arm/mach-omap2/hsi.c             |  497 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/hsi.h |  432 ++++++++++++++++++++++++++++
 3 files changed, 930 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hsi.c
 create mode 100644 arch/arm/plat-omap/include/mach/hsi.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6b7702f..3de1c20 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -87,3 +87,4 @@ obj-y					+= $(onenand-m) $(onenand-y)
 
 smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
 obj-y					+= $(smc91x-m) $(smc91x-y)
+obj-$(CONFIG_OMAP_HSI_DEVICE)		+= hsi.o
diff --git a/arch/arm/mach-omap2/hsi.c b/arch/arm/mach-omap2/hsi.c
new file mode 100644
index 0000000..a920934
--- /dev/null
+++ b/arch/arm/mach-omap2/hsi.c
@@ -0,0 +1,497 @@
+/*
+ * arch/arm/mach-omap2/hsi.c
+ *
+ * HSI device definition
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/jiffies.h>
+#include <linux/notifier.h>
+#include <mach/clock.h>
+#include <mach/hsi.h>
+#include <linux/hsi_driver_if.h>
+#include "clock.h"
+#include <asm/clkdev.h>
+#include <mach/mux.h>
+
+#define	hsi_inl(p)	inl((unsigned long) p)
+#define	hsi_outl(v, p)	outl(v, (unsigned long) p)
+
+/**
+ *	struct hsi_internal_clk - Generic virtual hsi clock
+ *	@clk: clock data
+ *	@nb: notfier block for the DVFS notification chain
+ *	@childs: Array of HSI FCK and ICK clocks
+ *	@n_childs: Number of clocks in childs array
+ *	@rate_change: Tracks if we are in the middle of a clock rate change
+ *	@pdev: Reference to the HSI platform device associated to the clock
+ *	@drv_nb: Reference to driver nb, use to propagate the DVFS notification
+ */
+struct hsi_internal_clk {
+	struct clk clk;
+	struct notifier_block nb;
+
+	struct clk **childs;
+	int n_childs;
+
+	unsigned int rate_change:1;
+
+	struct platform_device *pdev;
+	struct notifier_block *drv_nb;
+};
+
+static void hsi_set_mode(struct platform_device *pdev, u32 mode)
+{
+	struct hsi_platform_data *pdata = pdev->dev.platform_data;
+	void __iomem *base = OMAP2_IO_ADDRESS(pdev->resource[0].start);
+	int port;
+
+	for (port = 1; port <= pdata->num_ports; port++) {
+		/* FIXME - to update: need read/modify/write or something else:
+		 * this register now also contains flow and wake ctrl
+		 */
+		hsi_outl(mode, base + HSI_HST_MODE_REG(port));
+		hsi_outl(mode, base + HSI_HSR_MODE_REG(port));
+	}
+}
+
+static void hsi_save_mode(struct platform_device *pdev)
+{
+	struct hsi_platform_data *pdata = pdev->dev.platform_data;
+	void __iomem *base = OMAP2_IO_ADDRESS(pdev->resource[0].start);
+	struct port_ctx *p;
+	int port;
+
+	for (port = 1; port <= pdata->num_ports; port++) {
+		p = &pdata->ctx.pctx[port - 1];
+		p->hst.mode = hsi_inl(base + HSI_HST_MODE_REG(port));
+		p->hsr.mode = hsi_inl(base + HSI_HSR_MODE_REG(port));
+	}
+}
+
+static void hsi_restore_mode(struct platform_device *pdev)
+{
+	struct hsi_platform_data *pdata = pdev->dev.platform_data;
+	void __iomem *base = OMAP2_IO_ADDRESS(pdev->resource[0].start);
+	struct port_ctx *p;
+	int port;
+
+	for (port = 1; port <= pdata->num_ports; port++) {
+		p = &pdata->ctx.pctx[port - 1];
+		hsi_outl(p->hst.mode, base + HSI_HST_MODE_REG(port));
+		hsi_outl(p->hsr.mode, base + HSI_HSR_MODE_REG(port));
+	}
+}
+
+static int hsi_clk_event(struct notifier_block *nb, unsigned long event,
+								void *data)
+{
+/* FIXME
+	struct hsi_internal_clk *hsi_clk =
+				container_of(nb, struct hsi_internal_clk, nb);
+	switch (event) {
+	case CLK_PRE_RATE_CHANGE:
+		hsi_clk->drv_nb->notifier_call(hsi_clk->drv_nb, event, data);
+		hsi_clk->rate_change = 1;
+		if (hsi_clk->clk.usecount > 0) {
+			hsi_save_mode(hsi_clk->pdev);
+			hsi_set_mode(hsi_clk->pdev, HSI_MODE_SLEEP);
+		}
+		break;
+	case CLK_ABORT_RATE_CHANGE:
+	case CLK_POST_RATE_CHANGE:
+		if ((hsi_clk->clk.usecount > 0) && (hsi_clk->rate_change))
+			hsi_restore_mode(hsi_clk->pdev);
+
+		hsi_clk->rate_change = 0;
+		hsi_clk->drv_nb->notifier_call(hsi_clk->drv_nb, event, data);
+		break;
+	default:
+		break;
+	}
+*/
+	return NOTIFY_DONE;
+}
+
+static int hsi_clk_notifier_register(struct clk *clk, struct notifier_block *nb)
+{
+/* FIXME : clock functions not handled yet on OMAP4
+	struct hsi_internal_clk *hsi_clk;
+	if (!clk || !nb) {
+		return -EINVAL;
+	}
+	hsi_clk = container_of(clk, struct hsi_internal_clk, clk);
+	hsi_clk->drv_nb = nb;
+	hsi_clk->nb.priority = nb->priority;
+*/
+	/* NOTE: We only want notifications from the functional clock */
+/* FIXME
+	return clk_notifier_register(hsi_clk->childs[1], &hsi_clk->nb);
+*/
+	pr_debug("%s called\n", __func__);
+	return 0;
+}
+
+static int hsi_clk_notifier_unregister(struct clk *clk,
+						struct notifier_block *nb)
+{
+/* FIXME : clock functions not handled yet on OMAP4
+	struct hsi_internal_clk *hsi_clk;
+
+	if (!clk || !nb)
+		return -EINVAL;
+
+	hsi_clk = container_of(clk, struct hsi_internal_clk, clk);
+	hsi_clk->drv_nb = NULL;
+
+	return clk_notifier_unregister(hsi_clk->childs[1], &hsi_clk->nb);
+*/
+	pr_debug(KERN_DEBUG "%s called", __func__);
+	return 0;
+}
+
+static void hsi_save_ctx(struct platform_device *pdev)
+{
+	struct hsi_platform_data *pdata = pdev->dev.platform_data;
+	void __iomem *base = OMAP2_IO_ADDRESS(pdev->resource[0].start);
+	struct port_ctx *p;
+	int port;
+
+/* FIXME - implement PM support
+	pdata->ctx.loss_count =
+			omap_pm_get_dev_context_loss_count(&pdev->dev);
+*/
+	pdata->ctx.sysconfig = hsi_inl(base + HSI_SYS_SYSCONFIG_REG);
+	pdata->ctx.gdd_gcr = hsi_inl(base + HSI_GDD_GCR_REG);
+	for (port = 1; port <= pdata->num_ports; port++) {
+		p = &pdata->ctx.pctx[port - 1];
+		p->sys_mpu_enable[0] = hsi_inl(base +
+					HSI_SYS_MPU_ENABLE_REG(port, 0));
+		p->sys_mpu_enable[1] = hsi_inl(base +
+					HSI_SYS_MPU_U_ENABLE_REG(port, 0));
+		p->hst.frame_size = hsi_inl(base +
+						HSI_HST_FRAMESIZE_REG(port));
+		p->hst.divisor = hsi_inl(base + HSI_HST_DIVISOR_REG(port));
+		p->hst.channels = hsi_inl(base + HSI_HST_CHANNELS_REG(port));
+		p->hst.arb_mode = hsi_inl(base + HSI_HST_ARBMODE_REG(port));
+		p->hsr.frame_size = hsi_inl(base +
+						HSI_HSR_FRAMESIZE_REG(port));
+/*FIXME - check this register*/
+		p->hsr.timeout = hsi_inl(base + HSI_HSR_COUNTERS_REG(port));
+		p->hsr.channels = hsi_inl(base + HSI_HSR_CHANNELS_REG(port));
+	}
+}
+
+static void hsi_restore_ctx(struct platform_device *pdev)
+{
+	struct hsi_platform_data *pdata = pdev->dev.platform_data;
+	void __iomem *base = OMAP2_IO_ADDRESS(pdev->resource[0].start);
+	struct port_ctx *p;
+	int port;
+/* FIXME - implement PM support
+	int loss_count;
+
+	loss_count = omap_pm_get_dev_context_loss_count(&pdev->dev);
+
+	if (loss_count == pdata->ctx.loss_count)
+		return;
+*/
+	hsi_outl(pdata->ctx.sysconfig, base + HSI_SYS_SYSCONFIG_REG);
+	hsi_outl(pdata->ctx.gdd_gcr, base + HSI_GDD_GCR_REG);
+	for (port = 1; port <= pdata->num_ports; port++) {
+		p = &pdata->ctx.pctx[port - 1];
+		hsi_outl(p->sys_mpu_enable[0], base +
+					HSI_SYS_MPU_ENABLE_REG(port, 0));
+		hsi_outl(p->sys_mpu_enable[1], base +
+					HSI_SYS_MPU_U_ENABLE_REG(port, 0));
+		hsi_outl(p->hst.frame_size, base +
+						HSI_HST_FRAMESIZE_REG(port));
+		hsi_outl(p->hst.divisor, base + HSI_HST_DIVISOR_REG(port));
+		hsi_outl(p->hst.channels, base + HSI_HST_CHANNELS_REG(port));
+		hsi_outl(p->hst.arb_mode, base + HSI_HST_ARBMODE_REG(port));
+		hsi_outl(p->hsr.frame_size, base +
+						HSI_HSR_FRAMESIZE_REG(port));
+/* FIXME - check this register */
+		hsi_outl(p->hsr.timeout, base + HSI_HSR_COUNTERS_REG(port));
+		hsi_outl(p->hsr.channels, base + HSI_HSR_CHANNELS_REG(port));
+	}
+}
+
+static void hsi_pdev_release(struct device *dev)
+{
+}
+
+/*
+ * NOTE: We abuse a little bit the struct port_ctx to use it also for
+ * initialization.
+ */
+static struct port_ctx hsi_port_ctx[] = {
+	[0] = {
+		.hst.mode = HSI_MODE_FRAME,
+		.hst.flow = HSI_FLOW_SYNCHRONIZED,
+		.hst.frame_size = HSI_FRAMESIZE_DEFAULT,
+		.hst.divisor = 1,
+		.hst.channels = HSI_CHANNELS_DEFAULT,
+		.hst.arb_mode = HSI_ARBMODE_ROUNDROBIN,
+		.hsr.mode = HSI_MODE_FRAME,
+		.hsr.flow = HSI_FLOW_SYNCHRONIZED,
+		.hsr.frame_size = HSI_FRAMESIZE_DEFAULT,
+		.hsr.channels = HSI_CHANNELS_DEFAULT,
+		.hsr.divisor = 0,
+		.hsr.timeout = HSI_COUNTERS_FT_DEFAULT |
+				HSI_COUNTERS_TB_DEFAULT |
+				HSI_COUNTERS_FB_DEFAULT,
+		},
+};
+
+static struct hsi_platform_data hsi_pdata = {
+	.num_ports = ARRAY_SIZE(hsi_port_ctx),
+	.ctx.pctx = hsi_port_ctx,
+	.clk_notifier_register = hsi_clk_notifier_register,
+	.clk_notifier_unregister = hsi_clk_notifier_unregister,
+};
+
+static struct resource hsi_resources[] = {
+	[0] =	{
+		.start = 0x4A058000,
+		.end = 0x4A05b950,
+		.name = "omap_hsi_iomem",
+		.flags = IORESOURCE_MEM,
+		},
+	[1] =	{
+		.start = INT_44XX_HSI_1_IRQ0,
+		.end = INT_44XX_HSI_1_IRQ0,
+		.name = "hsi_p1_mpu_irq0",
+		.flags = IORESOURCE_IRQ,
+		},
+	[2] =	{
+		.start = INT_44XX_HSI_2_IRQ1,
+		.end = INT_44XX_HSI_2_IRQ1,
+		.name = "hsi_p2_mpu_irq0",
+		.flags = IORESOURCE_IRQ,
+		},
+	[3] =	{
+		.start = INT_44XX_HSI_1_DMAIRQ,
+		.end = INT_44XX_HSI_1_DMAIRQ,
+		.name = "hsi_gdd",
+		.flags = IORESOURCE_IRQ,
+		},
+	[4] =	{
+		.start = 16, /* DMA channels available */
+		.end = 16,
+		.name = "hsi_gdd_chan_count",
+		.flags = IORESOURCE_DMA,
+		},
+};
+
+static struct platform_device hsi_pdev = {
+	.name = "omap_hsi",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(hsi_resources),
+	.resource = hsi_resources,
+	.dev =	{
+		.release = hsi_pdev_release,
+		.platform_data = &hsi_pdata,
+		},
+};
+
+#ifdef CONFIG_OMAP_HSI_POWER_MANAGEMENT
+#define __HSI_CLK_FIX__
+#ifdef __HSI_CLK_FIX__
+/*
+ * FIXME: TO BE REMOVED.
+ * This hack allows us to ensure that clocks are stable before accehsing
+ * HSI controller registers. To be removed when PM functionalty is in place.
+ */
+static int check_hsi_active(void)
+{
+	u32 reg;
+	unsigned long dl = jiffies + msecs_to_jiffies(500);
+	void __iomem *cm_idlest1 = OMAP2_IO_ADDRESS(0x48004a20);
+
+	reg = inl(cm_idlest1);
+	while ((!(reg & 0x01)) && (time_before(jiffies, dl)))
+		reg = inl(cm_idlest1);
+
+	if (!(reg & 0x01)) { /* HST */
+		pr_err("HSI is still in STANDBY ! (BUG !?)\n");
+		return -1;
+	}
+
+	return 0;
+}
+#endif /* __HSI_CLK_FIX__ */
+#endif
+
+static int hsi_clk_init(struct hsi_internal_clk *hsi_clk)
+{
+/* FIXME - update clock names on OMAP4*/
+	const char *clk_names[] = {};
+
+	int i;
+	int j;
+
+	hsi_clk->n_childs = ARRAY_SIZE(clk_names);
+	hsi_clk->childs = kzalloc(hsi_clk->n_childs * sizeof(*hsi_clk->childs),
+								GFP_KERNEL);
+	if (!hsi_clk->childs)
+		return -ENOMEM;
+
+	for (i = 0; i < hsi_clk->n_childs; i++) {
+		hsi_clk->childs[i] = clk_get(&hsi_clk->pdev->dev, clk_names[i]);
+		if (IS_ERR(hsi_clk->childs[i])) {
+			pr_err("Unable to get HSI clock: %s", clk_names[i]);
+			for (j = i - 1; j >= 0; j--)
+				clk_put(hsi_clk->childs[j]);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+
+
+static int hsi_clk_enable(struct clk *clk)
+{
+	struct hsi_internal_clk *hsi_clk =
+				container_of(clk, struct hsi_internal_clk, clk);
+/* FIXME - implement PM support
+	int err;
+	int i;
+
+	for (i = 0; i < hsi_clk->n_childs; i++) {
+		err = omap2_clk_enable(hsi_clk->childs[i]);
+		if (unlikely(err < 0))
+			goto rollback;
+	}
+*/
+#ifdef __HSI_CLK_FIX__
+	/*
+	 * FIXME: To be removed
+	 * Wait until the HSI controller has the clocks stable
+	 */
+	check_hsi_active();
+#endif
+	hsi_restore_ctx(hsi_clk->pdev);
+	if (!hsi_clk->rate_change)
+		hsi_restore_mode(hsi_clk->pdev);
+
+	return 0;
+/* FIXME - implement PM support
+rollback:
+	pr_err("Error on HSI clk child %d\n", i);
+	for (i = i - 1; i >= 0; i--)
+		omap2_clk_disable(hsi_clk->childs[i]);
+	return err;
+*/
+}
+
+static void hsi_clk_disable(struct clk *clk)
+{
+	struct hsi_internal_clk *hsi_clk =
+				container_of(clk, struct hsi_internal_clk, clk);
+/*	int i;*/
+
+	if (!hsi_clk->rate_change) {
+		hsi_save_mode(hsi_clk->pdev);
+		hsi_set_mode(hsi_clk->pdev, HSI_MODE_SLEEP);
+	}
+	/* Save ctx in all ports */
+	hsi_save_ctx(hsi_clk->pdev);
+
+/* FIXME - implement PM support
+	for (i = 0; i < hsi_clk->n_childs; i++)
+		omap2_clk_disable(hsi_clk->childs[i]);
+*/
+}
+
+static const int omap44xx_hsi_pins[] = {
+	AE18_4430_HSI1_CAWAKE,
+	AG19_4430_HSI1_CADATA,
+	AF19_4430_HSI1_CAFLAG,
+	AE19_4430_HSI1_ACREADY,
+	AF18_4430_HSI1_ACWAKE,
+	AG18_4430_HSI1_ACDATA,
+	AE17_4430_HSI1_ACFLAG,
+	AF17_4430_HSI1_CAREADY,
+};
+
+/* Mux settings for OMAP4430 */
+void omap_hsi_mux_setup(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(omap44xx_hsi_pins); i++)
+		omap_cfg_reg(omap44xx_hsi_pins[i]);
+	pr_debug("Pin muxing for HSI support done\n");
+}
+
+static const struct clkops clkops_hsi = {
+	.enable		= hsi_clk_enable,
+	.disable	= hsi_clk_disable,
+};
+
+static struct hsi_internal_clk hsi_clock = {
+	.clk = {
+		.name = "hsi_clk",
+		.id = -1,
+		.clkdm_name = "core_l4_clkdm",
+		.ops = &clkops_hsi,
+	},
+	.nb = {
+		.notifier_call = hsi_clk_event,
+		.priority = INT_MAX,
+	},
+	.pdev = &hsi_pdev,
+};
+
+/* FIXME - implement PM support
+static struct clk_lookup hsi_lk = {
+	.dev_id = NULL,
+	.con_id = "hsi_clk",
+	.clk = &hsi_clock.clk,
+};
+*/
+
+static int __init omap_hsi_init(void)
+{
+	int err;
+	struct clk *hsi_clk = &hsi_clock.clk;
+
+	hsi_clk_init(&hsi_clock);
+	clk_preinit(hsi_clk);
+/* FIXME - implement PM support
+	clkdev_add(&hsi_lk);
+*/
+	clk_register(hsi_clk);
+/* FIXME - implement PM support
+	omap2_init_clk_clkdm(hsi_clk);
+*/
+	err = platform_device_register(&hsi_pdev);
+	if (err < 0) {
+		pr_err("Unable to register HSI platform device: %d\n", err);
+		return err;
+	}
+
+	omap_hsi_mux_setup();
+
+	pr_info("HSI: device registered\n");
+	return 0;
+}
+subsys_initcall(omap_hsi_init);
diff --git a/arch/arm/plat-omap/include/mach/hsi.h b/arch/arm/plat-omap/include/mach/hsi.h
new file mode 100644
index 0000000..0b7f5ad
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/hsi.h
@@ -0,0 +1,432 @@
+/*
+ * /mach/hsi.h
+ *
+ * Hardware definitions for HSI and SSI.
+ *
+ * Copyright (C) 2007-2008 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Carlos Chinea <carlos.chinea@nokia.com>
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+/* NOTE: This file defines the registers address offsets for both the
+ * SSI and HSI devices. Most of the registers share the same offset between
+ * these devices.
+ * When common or HSI only, the constants are name HSI*. Else the SSI specific
+ * constants are name HSI_SSI*
+ */
+
+#ifndef __HSI_H__
+#define __HSI_H__
+
+#define HSI_PORT_OFFSET			0x1000
+
+/*
+ * GDD base addr : 0x48059000 (SSI)
+ * GDD base addr : 0x4A059000 (HSI)
+ */
+#define HSI_GDD_OFFSET			0x1000
+#define HSI_GDD_BASE			HSI_GDD_OFFSET	/* 0x9000 */
+
+/*
+ * HST base addr:
+ *	port 1: 0x4805a000 (SSI) - 0x4A05a000 (HSI)
+ *	port 2: 0x4805b000 (SSI) - 0x4a05b000 (HSI)
+ */
+#define HSI_HST_OFFSET			0x2000
+#define HSI_HST_BASE(port)		(HSI_HST_OFFSET + ((port - 1) *\
+							(HSI_PORT_OFFSET)))
+/*
+ * HSR base addr:
+ *	port 1: 0x4805a800 (SSI) - 0x4A05a800 (HSI)
+ *	port 2: 0x4805b800 (SSI) - 0x4A05b800 (HSI)
+ */
+#define HSI_HSR_OFFSET			0x2800
+#define HSI_HSR_BASE(port)		(HSI_HSR_OFFSET + ((port - 1) *\
+							(HSI_PORT_OFFSET)))
+/*
+ * HSI SYS registers
+ */
+#define HSI_SYS_REVISION_REG		0x0000
+#define HSI_SSI_REV_MASK		0x000000ff
+#define HSI_SSI_REV_MAJOR		0xf0
+#define HSI_SSI_REV_MINOR		0x0f
+
+#define HSI_SYS_SYSCONFIG_REG		0x0010
+#define HSI_AUTOIDLE			(1 << 0)
+#define HSI_SOFTRESET			(1 << 1)
+#define HSI_FREE_EMU			(1 << 2)	/* Only for HSI */
+#define HSI_SIDLEMODE_FORCE		0
+#define HSI_SIDLEMODE_NO		(1 << 3)
+#define HSI_SIDLEMODE_SMART		(1 << 4)
+#define HSI_SIDLEMODE_MASK		0x00000018
+#define HSI_MIDLEMODE_FORCE		0
+#define HSI_MIDLEMODE_NO		(1 << 12)
+#define HSI_MIDLEMODE_SMART		(1 << 13)
+#define HSI_MIDLEMODE_MASK		0x00003000
+
+#define HSI_SYS_SYSSTATUS_REG		0x0014
+#define HSI_RESETDONE			1
+
+#define HSI_SYS_MPU_STATUS_BASE		0x0808
+#define HSI_SYS_MPU_STATUS_PORT_OFFSET	0x10
+#define HSI_SYS_MPU_STATUS_IRQ_OFFSET	8
+
+#define HSI_SYS_MPU_STATUS_REG(port, irq)				\
+			(HSI_SYS_MPU_STATUS_BASE +			\
+			(((port - 1) * HSI_SYS_MPU_STATUS_PORT_OFFSET) +\
+			(irq * HSI_SYS_MPU_STATUS_IRQ_OFFSET)))
+
+#define HSI_SYS_MPU_ENABLE_BASE		0x080c
+#define HSI_SYS_MPU_ENABLE_PORT_OFFSET	0x10
+#define HSI_SYS_MPU_ENABLE_IRQ_OFFSET	8
+
+#define HSI_SYS_MPU_ENABLE_REG(port, irq)				\
+			(HSI_SYS_MPU_ENABLE_BASE +			\
+			(((port - 1) * HSI_SYS_MPU_ENABLE_PORT_OFFSET) +\
+			(irq * HSI_SYS_MPU_ENABLE_IRQ_OFFSET)))
+#define HSI_HST_DATAACCEPT(channel)	((channel < 8) ?		\
+					(1 << channel) : (1 << (channel - 8)))
+#define HSI_HSR_DATAAVAILABLE(channel)	(channel < 8 ?			\
+				(1 << (channel + 8)) : (1 << (channel - 8 + 8)))
+#define HSI_HSR_DATAOVERRUN(channel)	(channel < 8 ?			\
+			(1 << (channel + 16)) : (1 << (channel - 8 + 16)))
+#define HSI_ERROROCCURED		(1 << 24)
+#define HSI_BREAKDETECTED		(1 << 25)
+
+#define HSI_SYS_GDD_MPU_IRQ_STATUS_REG	0x0800
+#define HSI_SYS_GDD_MPU_IRQ_ENABLE_REG	0x0804
+#define HSI_GDD_LCH(channel)		(1 << channel)
+
+#define HSI_SYS_WAKE_OFFSET		0x10
+#define HSI_SYS_WAKE_BASE		0x0c00
+#define HSI_SYS_WAKE_REG(port)		(HSI_SYS_WAKE_BASE +\
+					((port - 1) * HSI_SYS_WAKE_OFFSET))
+#define HSI_SYS_CLEAR_WAKE_BASE		0x0c04
+#define HSI_SYS_CLEAR_WAKE_REG(port)	(HSI_SYS_CLEAR_WAKE_BASE +\
+					((port - 1) * HSI_SYS_WAKE_OFFSET))
+#define HSI_SYS_SET_WAKE_BASE		0x0c08
+#define HSI_SYS_SET_WAKE_REG(port)	(HSI_SYS_SET_WAKE_BASE +\
+					((port - 1) * HSI_SYS_WAKE_OFFSET))
+#	define HSI_SSI_WAKE_MASK	0xff	/* for SSI */
+#	define HSI_WAKE_MASK		0xffff	/* for HSI */
+#	define HSI_WAKE_4_WIRES		(0 << 16)
+#	define HSI_WAKE_READY_LVL_0	(0 << 17)
+#	define HSI_WAKE(channel)	(1 << channel | HSI_WAKE_4_WIRES |\
+							HSI_WAKE_READY_LVL_0)
+
+#define HSI_SYS_HWINFO_REG		0x0004	/* only for HSI */
+
+/* Additional registers definitions (for channels 8 .. 15) for HSI */
+#define HSI_SYS_MPU_U_STATUS_BASE	0x0408
+#define HSI_SYS_MPU_U_STATUS_REG(port, irq)				\
+			(HSI_SYS_MPU_U_STATUS_BASE +			\
+			(((port - 1) * HSI_SYS_MPU_STATUS_PORT_OFFSET) +\
+			(irq * HSI_SYS_MPU_STATUS_IRQ_OFFSET)))
+
+#define HSI_SYS_MPU_U_ENABLE_BASE	0x040c
+#define HSI_SYS_MPU_U_ENABLE_REG(port, irq)				\
+			(HSI_SYS_MPU_U_ENABLE_BASE +			\
+			(((port - 1) * HSI_SYS_MPU_ENABLE_PORT_OFFSET) +\
+			(irq * HSI_SYS_MPU_ENABLE_IRQ_OFFSET)))
+
+/*
+ * HSI HST registers
+ */
+#define HSI_HST_ID_REG(port)		(HSI_HST_BASE(port) + 0x0000)
+
+#define HSI_HST_MODE_REG(port)		(HSI_HST_BASE(port) + 0x0004)
+#define HSI_MODE_VAL_MASK		3
+#define HSI_MODE_SLEEP			0
+#define HSI_MODE_STREAM			1
+#define HSI_MODE_FRAME			2
+#define HSI_SSI_MODE_MULTIPOINTS	3		/* SSI only */
+#define HSI_FLOW_VAL_MASK		(3 << 2)	/* HSI only */
+#define HSI_FLOW_SYNCHRONIZED		(0 << 2)	/* HSI only */
+#define HSI_FLOW_PIPELINED		(1 << 2)	/* HSI only */
+#define HSI_FLOW_REAL_TIME		(2 << 2)	/* HSI only */
+#define HSI_MODE_WAKE_CTRL_AUTO		(1 << 4)	/* HSI only */
+#define HSI_MODE_WAKE_CTRL_SW		(0 << 4)	/* HSI only */
+
+#define HSI_HST_FRAMESIZE_REG(port)	(HSI_HST_BASE(port) + 0x0008)
+#define HSI_FRAMESIZE_DEFAULT		31
+#define HSI_FRAMESIZE_MAX		0x1f
+
+#define HSI_HST_TXSTATE_REG(port)	(HSI_HST_BASE(port) + 0x000c)
+#define	TXSTATE_IDLE			0
+
+#define HSI_HST_BUFSTATE_REG(port)	(HSI_HST_BASE(port) + 0x0010)
+#define HSI_HST_BUFSTATE_FIFO_REG(fifo)	((fifo < 8) ? 			\
+					HSI_HST_BUFSTATE_REG(1) : 	\
+					HSI_HST_BUFSTATE_REG(2))
+#define	HSI_BUFSTATE_CHANNEL(channel)	(channel < 8 ?			\
+					(1 << channel) : (1 << (channel - 8)))
+
+#define HSI_HST_DIVISOR_REG(port)	(HSI_HST_BASE(port) + 0x0018)
+#define HSI_DIVISOR_DEFAULT		1
+#define HSI_SSI_MAX_TX_DIVISOR		0x7f	/* for SSI */
+#define HSI_MAX_TX_DIVISOR		0xff	/* for HSI */
+
+#define HSI_HST_BREAK_REG(port)		(HSI_HST_BASE(port) + 0x0020)
+#define HSI_HST_CHANNELS_REG(port)	(HSI_HST_BASE(port) + 0x0024)
+#define HSI_CHANNELS_DEFAULT		4
+#define HSI_SSI_CHANNELS_MAX		8	/* for SSI */
+#define HSI_CHANNELS_MAX		16	/* for HSI */
+
+#define HSI_HST_ARBMODE_REG(port)	(HSI_HST_BASE(port) + 0x0028)
+#define HSI_ARBMODE_ROUNDROBIN		0
+#define HSI_ARBMODE_PRIORITY		1
+
+#define HSI_HST_BUFFER_BASE(port)		(HSI_HST_BASE(port) + 0x0080)
+#define HSI_HST_BUFFER_CH_REG(port, channel)	(HSI_HST_BUFFER_BASE(port) +\
+						(channel * 4))
+#define HSI_HST_BUFFER_FIFO_REG(fifo)	((fifo < 8) ?			\
+			(HSI_HST_BUFFER_CH_REG(1, fifo)) :		\
+			(HSI_HST_BUFFER_CH_REG(2, fifo - 8)))
+
+#define HSI_HST_SWAPBUF_BASE(port)		(HSI_HST_BASE(port) + 0x00c0)
+#define HSI_HST_SWAPBUF_CH_REG(port, channel)	(HSI_HST_SWAPBUF_BASE(port) +\
+						(channel * 4))
+
+/* Additional registers for HSI */
+#define	HSI_HST_FIFO_COUNT			16
+#define HSI_HST_MAPPING_FIFO_REG(fifo)		(HSI_HST_BASE(1) + 0x0100 +\
+						(fifo * 4))
+#define HSI_MAPPING_ENABLE		1
+#define HSI_MAPPING_CH_NUMBER_OFFSET	1
+#define HSI_MAPPING_PORT_NUMBER_OFFSET	7
+#define HSI_HST_MAPPING_THRESH_OFFSET	10
+#define HSI_HST_MAPPING_THRESH_VALUE	(0x0 << HSI_HST_MAPPING_THRESH_OFFSET)
+
+/*
+ * HSI HSR registers
+ */
+#define HSI_HSR_ID_REG(port)		(HSI_HSR_BASE(port) + 0x0000)
+
+#define HSI_HSR_MODE_REG(port)		(HSI_HSR_BASE(port) + 0x0004)
+
+#define HSI_HSR_FRAMESIZE_REG(port)	(HSI_HSR_BASE(port) + 0x0008)
+
+#define HSI_HSR_RXSTATE_REG(port)	(HSI_HSR_BASE(port) + 0x000c)
+
+#define HSI_HSR_BUFSTATE_REG(port)	(HSI_HSR_BASE(port) + 0x0010)
+#define HSI_HSR_BUFSTATE_FIFO_REG(fifo)	((fifo < 8) ? 			\
+					HSI_HSR_BUFSTATE_REG(1) : 	\
+					HSI_HSR_BUFSTATE_REG(2))
+
+#define HSI_HSR_BREAK_REG(port)		(HSI_HSR_BASE(port) + 0x001c)
+
+#define HSI_HSR_ERROR_REG(port)		(HSI_HSR_BASE(port) + 0x0020)
+#define HSI_HSR_ERROR_SIG		1
+#define HSI_HSR_ERROR_FTE		(1 << 1)	/* HSI only */
+#define HSI_HSR_ERROR_TBE		(1 << 4)	/* HSI only */
+#define HSI_HSR_ERROR_RME		(1 << 7)	/* HSI only */
+#define HSI_HSR_ERROR_TME		(1 << 11)	/* HSI only */
+
+#define HSI_HSR_ERRORACK_REG(port)	(HSI_HSR_BASE(port) + 0x0024)
+
+#define HSI_HSR_CHANNELS_REG(port)	(HSI_HSR_BASE(port) + 0x0028)
+
+#define HSI_HSR_OVERRUN_REG(port)	(HSI_HSR_BASE(port) + 0x002c)
+
+#define HSI_HSR_OVERRUNACK_REG(port)	(HSI_HSR_BASE(port) + 0x0030)
+
+#define HSI_HSR_COUNTERS_REG(port)	(HSI_HSR_BASE(port) + 0x0034)
+#define HSI_TIMEOUT_DEFAULT		0		/* SSI only */
+#define HSI_SSI_RX_TIMEOUT_MAX		0x1ff		/* SSI only */
+#define HSI_COUNTERS_FT_MASK		0x000fffff	/* HSI only */
+#define HSI_COUNTERS_TB_MASK		0x00f00000	/* HSI only */
+#define HSI_COUNTERS_FB_MASK		0xff000000	/* HSI only */
+#define HSI_COUNTERS_FT_OFFSET		0		/* HSI only */
+#define HSI_COUNTERS_TB_OFFSET		20		/* HSI only */
+#define HSI_COUNTERS_FB_OFFSET		24		/* HSI only */
+/* Default FT value: 2 x max_bits_per_frame + 20% margin */
+#define HSI_COUNTERS_FT_DEFAULT		(90 << HSI_COUNTERS_FT_OFFSET)
+#define HSI_COUNTERS_TB_DEFAULT		(6 << HSI_COUNTERS_TB_OFFSET)
+#define HSI_COUNTERS_FB_DEFAULT		(8 << HSI_COUNTERS_FB_OFFSET)
+
+#define HSI_HSR_BUFFER_BASE(port)	(HSI_HSR_BASE(port) + 0x0080)
+#define HSI_HSR_BUFFER_CH_REG(port, channel)	(HSI_HSR_BUFFER_BASE(port) +\
+						(channel * 4))
+#define HSI_HSR_BUFFER_FIFO_REG(fifo)	((fifo < 8) ?			\
+			(HSI_HSR_BUFFER_CH_REG(1, fifo)) :		\
+			(HSI_HSR_BUFFER_CH_REG(2, fifo - 8)))
+
+#define HSI_HSR_SWAPBUF_BASE(port)	(HSI_HSR_BASE(port) + 0x00c0)
+#define HSI_HSR_SWAPBUF_CH_REG(port, channel)	(HSI_HSR_SWAPBUF_BASE +\
+						(channel * 4))
+
+/* Additional registers for HSI */
+#define	HSI_HSR_FIFO_COUNT		16
+#define HSI_HSR_MAPPING_FIFO_REG(fifo)	(HSI_HSR_BASE(1) + 0x0100 +\
+					(fifo * 4))
+#define HSI_HSR_MAPPING_WORDS_MASK	(0xf << 10)
+
+#define HSI_HSR_DLL_REG(port)		(HSI_HSR_BASE(port) + 0x0144)
+#define HSI_HSR_DLL_COCHRE		1
+#define HSI_HSR_DLL_COCHGR		(1 << 4)
+#define HSI_HSR_DLL_INCO_MASK		0x0003ff00
+#define HSI_HSR_DLL_INCO_OFFSET		8
+
+#define HSI_HSR_DIVISOR_REG(port)	(HSI_HSR_BASE(port) + 0x014C)
+#define HSI_HSR_DIVISOR_MASK		0xff
+#define HSI_MAX_RX_DIVISOR		0xff
+
+
+/*
+ * HSI GDD registers
+ */
+#define HSI_SSI_GDD_HW_ID_REG		(HSI_GDD_BASE + 0x0000)
+
+#define HSI_SSI_GDD_PPORT_ID_REG	(HSI_GDD_BASE + 0x0010)
+
+#define HSI_SSI_GDD_MPORT_ID_REG	(HSI_GDD_BASE + 0x0014)
+
+#define HSI_SSI_GDD_PPORT_SR_REG	(HSI_GDD_BASE + 0x0020)
+#define HSI_PPORT_ACTIVE_LCH_NUMBER_MASK	0xff
+
+#define HSI_GDD_MPORT_SR_REG		(HSI_GDD_BASE + 0x0024)
+#define HSI_SSI_MPORT_ACTIVE_LCH_NUMBER_MASK	0xff
+
+#define HSI_SSI_GDD_TEST_REG		(HSI_GDD_BASE + 0x0040)
+#define HSI_SSI_TEST			1
+
+#define HSI_GDD_GCR_REG			(HSI_GDD_BASE + 0x0100)
+#define	HSI_CLK_AUTOGATING_ON		(1 << 3)
+#define	HSI_SWITCH_OFF			(1 << 0)
+
+#define HSI_GDD_GRST_REG		(HSI_GDD_BASE + 0x0200)
+#define HSI_SWRESET			1
+
+#define HSI_GDD_CSDP_BASE		(HSI_GDD_BASE + 0x0800)
+#define HSI_GDD_CSDP_OFFSET		0x40
+#define HSI_GDD_CSDP_REG(channel)	(HSI_GDD_CSDP_BASE +\
+					(channel * HSI_GDD_CSDP_OFFSET))
+#define HSI_DST_BURST_EN_MASK		0xc000
+#define HSI_DST_SINGLE_ACCESS0		0
+#define HSI_DST_SINGLE_ACCESS		(1 << 14)
+#define HSI_DST_BURST_4X32_BIT		(2 << 14)
+#define HSI_DST_BURST_8x32_BIT		(3 << 14)
+
+#define HSI_DST_MASK			0x1e00
+#define HSI_DST_MEMORY_PORT		(8 << 9)
+#define HSI_DST_PERIPHERAL_PORT		(9 << 9)
+
+#define HSI_SRC_BURST_EN_MASK		0x0180
+#define HSI_SRC_SINGLE_ACCESS0		0
+#define HSI_SRC_SINGLE_ACCESS		(1 << 7)
+#define HSI_SRC_BURST_4x32_BIT		(2 << 7)
+#define HSI_SRC_BURST_8x32_BIT		(3 << 7)
+
+#define HSI_SRC_MASK			0x003c
+#define HSI_SRC_MEMORY_PORT		(8 << 2)
+#define HSI_SRC_PERIPHERAL_PORT		(9 << 2)
+
+#define HSI_DATA_TYPE_MASK		3
+#define HSI_DATA_TYPE_S32		2
+
+#define HSI_GDD_CCR_BASE		(HSI_GDD_BASE + 0x0802)
+#define HSI_GDD_CCR_OFFSET		0x40
+#define HSI_GDD_CCR_REG(channel)	(HSI_GDD_CCR_BASE +\
+					(channel * HSI_GDD_CCR_OFFSET))
+#define HSI_DST_AMODE_MASK		(3 << 14)
+#define HSI_DST_AMODE_CONST		0
+#define HSI_DST_AMODE_POSTINC		(1 << 14)
+
+#define HSI_SRC_AMODE_MASK		(3 << 12)
+#define HSI_SRC_AMODE_CONST		0
+#define HSI_SRC_AMODE_POSTINC		(1 << 12)
+
+#define HSI_CCR_ENABLE			(1 << 7)
+
+#define HSI_CCR_SYNC_MASK		0x001f		/* only for SSI */
+
+#define HSI_GDD_CICR_BASE		(HSI_GDD_BASE + 0x0804)
+#define HSI_GDD_CICR_OFFSET		0x40
+#define HSI_GDD_CICR_REG(channel)	(HSI_GDD_CICR_BASE +\
+					(channel * HSI_GDD_CICR_OFFSET))
+#define HSI_BLOCK_IE			(1 << 5)
+#define HSI_HALF_IE			(1 << 2)
+#define HSI_TOUT_IE			(1 << 0)
+
+#define HSI_GDD_CSR_BASE		(HSI_GDD_BASE + 0x0806)
+#define HSI_GDD_CSR_OFFSET		0x40
+#define HSI_GDD_CSR_REG(channel)	(HSI_GDD_CSR_BASE +\
+					(channel * HSI_GDD_CSR_OFFSET))
+#define HSI_CSR_SYNC			(1 << 6)
+#define HSI_CSR_BLOCK			(1 << 5)
+#define HSI_CSR_HALF			(1 << 2)
+#define HSI_CSR_TOUT			(1 << 0)
+
+#define HSI_GDD_CSSA_BASE		(HSI_GDD_BASE + 0x0808)
+#define HSI_GDD_CSSA_OFFSET		0x40
+#define HSI_GDD_CSSA_REG(channel)	(HSI_GDD_CSSA_BASE +\
+					(channel * HSI_GDD_CSSA_OFFSET))
+
+#define HSI_GDD_CDSA_BASE		(HSI_GDD_BASE + 0x080c)
+#define HSI_GDD_CDSA_OFFSET		0x40
+#define HSI_GDD_CDSA_REG(channel)	(HSI_GDD_CDSA_BASE +\
+					(channel * HSI_GDD_CDSA_OFFSET))
+
+#define HSI_GDD_CEN_BASE		(HSI_GDD_BASE + 0x0810)
+#define HSI_GDD_CEN_OFFSET		0x40
+#define HSI_GDD_CEN_REG(channel)	(HSI_GDD_CEN_BASE +\
+					(channel * HSI_GDD_CEN_OFFSET))
+
+#define HSI_GDD_CSAC_BASE		(HSI_GDD_BASE + 0x0818)
+#define HSI_GDD_CSAC_OFFSET		0x40
+#define HSI_GDD_CSAC_REG(channel)	(HSI_GDD_CSAC_BASE +\
+					(channel * HSI_GDD_CSAC_OFFSET))
+
+#define HSI_GDD_CDAC_BASE		(HSI_GDD_BASE + 0x081a)
+#define HSI_GDD_CDAC_OFFSET		0x40
+#define HSI_GDD_CDAC_REG(channel)	(HSI_GDD_CDAC_BASE +\
+					(channel * HSI_GDD_CDAC_OFFSET))
+
+#define HSI_SSI_GDD_CLNK_CTRL_BASE	(HSI_GDD_BASE + 0x0828)
+#define HSI_SSI_GDD_CLNK_CTRL_OFFSET	0x40
+#define HSI_SSI_GDD_CLNK_CTRL_REG(channel)	(HSI_SSI_GDD_CLNK_CTRL_BASE +\
+				(channel * HSI_SSI_GDD_CLNK_CTRL_OFFSET))
+
+#define HSI_SSI_ENABLE_LNK		(1 << 15)
+#define HSI_SSI_STOP_LNK		(1 << 14)
+#define HSI_SSI_NEXT_CH_ID_MASK		0xf
+
+/*
+ * HSI Helpers
+ */
+#define HSI_SYS_MPU_ENABLE_CH_REG(port, irq, channel)			\
+				((channel < HSI_SSI_CHANNELS_MAX) ?	\
+				HSI_SYS_MPU_ENABLE_REG(port, irq) :	\
+				HSI_SYS_MPU_U_ENABLE_REG(port, irq))
+
+/**
+ *	struct omap_ssi_config - SSI board configuration
+ *	@num_ports: Number of ports in use
+ *	@cawake_line: Array of cawake gpio lines
+ */
+struct omap_ssi_board_config {
+	unsigned int num_ports;
+	int cawake_gpio[2];
+};
+extern int omap_ssi_config(struct omap_ssi_board_config *ssi_config);
+
+/**
+ *	struct omap_hsi_config - HSI board configuration
+ *	@num_ports: Number of ports in use
+ */
+struct omap_hsi_board_config {
+	unsigned int num_ports;
+};
+extern int omap_hsi_config(struct omap_hsi_board_config *hsi_config);
+
+#endif /* __HSI_H__ */
-- 
1.6.0.4

