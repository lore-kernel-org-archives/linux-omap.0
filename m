From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v4 3/3] can: ti_hecc: Add DT support for TI HECC module
Date: Fri, 17 Feb 2017 14:45:58 +0100
Message-ID: <1487339158-18809-4-git-send-email-yegorslists@googlemail.com>
References: <1487339158-18809-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487339158-18809-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

This patch converts TI HECC driver to DT only driver. This results in
removing ti_hecc.h containing now obsolete platform data.

Former transceiver_switch callback function will be now modelled via
regulator API.

Signed-off-by: Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/net/can/ti_hecc.c            | 166 +++++++++++++++++++----------------
 include/linux/can/platform/ti_hecc.h |  44 ----------
 2 files changed, 88 insertions(+), 122 deletions(-)
 delete mode 100644 include/linux/can/platform/ti_hecc.h

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 6749b18..754244d 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -17,25 +17,6 @@
  *
  */
 
-/*
- * Your platform definitions should specify module ram offsets and interrupt
- * number to use as follows:
- *
- * static struct ti_hecc_platform_data am3517_evm_hecc_pdata = {
- *         .scc_hecc_offset        = 0,
- *         .scc_ram_offset         = 0x3000,
- *         .hecc_ram_offset        = 0x3000,
- *         .mbx_offset             = 0x2000,
- *         .int_line               = 0,
- *         .revision               = 1,
- *         .transceiver_switch     = hecc_phy_control,
- * };
- *
- * Please see include/linux/can/platform/ti_hecc.h for description of
- * above fields.
- *
- */
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -46,11 +27,13 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
-#include <linux/can/platform/ti_hecc.h>
 
 #define DRV_NAME "ti_hecc"
 #define HECC_MODULE_VERSION     "0.7"
@@ -214,15 +197,14 @@ struct ti_hecc_priv {
 	struct net_device *ndev;
 	struct clk *clk;
 	void __iomem *base;
-	u32 scc_ram_offset;
-	u32 hecc_ram_offset;
-	u32 mbx_offset;
-	u32 int_line;
+	void __iomem *hecc_ram;
+	void __iomem *mbx;
+	bool use_hecc1int;
 	spinlock_t mbx_lock; /* CANME register needs protection */
 	u32 tx_head;
 	u32 tx_tail;
 	u32 rx_next;
-	void (*transceiver_switch)(int);
+	struct regulator *reg_xceiver;
 };
 
 static inline int get_tx_head_mb(struct ti_hecc_priv *priv)
@@ -242,20 +224,18 @@ static inline int get_tx_head_prio(struct ti_hecc_priv *priv)
 
 static inline void hecc_write_lam(struct ti_hecc_priv *priv, u32 mbxno, u32 val)
 {
-	__raw_writel(val, priv->base + priv->hecc_ram_offset + mbxno * 4);
+	__raw_writel(val, priv->hecc_ram + mbxno * 4);
 }
 
 static inline void hecc_write_mbx(struct ti_hecc_priv *priv, u32 mbxno,
 	u32 reg, u32 val)
 {
-	__raw_writel(val, priv->base + priv->mbx_offset + mbxno * 0x10 +
-			reg);
+	__raw_writel(val, priv->mbx + mbxno * 0x10 + reg);
 }
 
 static inline u32 hecc_read_mbx(struct ti_hecc_priv *priv, u32 mbxno, u32 reg)
 {
-	return __raw_readl(priv->base + priv->mbx_offset + mbxno * 0x10 +
-			reg);
+	return __raw_readl(priv->mbx + mbxno * 0x10 + reg);
 }
 
 static inline void hecc_write(struct ti_hecc_priv *priv, u32 reg, u32 val)
@@ -311,11 +291,16 @@ static int ti_hecc_set_btc(struct ti_hecc_priv *priv)
 	return 0;
 }
 
-static void ti_hecc_transceiver_switch(const struct ti_hecc_priv *priv,
-					int on)
+static int ti_hecc_transceiver_switch(const struct ti_hecc_priv *priv,
+				      int on)
 {
-	if (priv->transceiver_switch)
-		priv->transceiver_switch(on);
+	if (!priv->reg_xceiver)
+		return 0;
+
+	if (on)
+		return regulator_enable(priv->reg_xceiver);
+	else
+		return regulator_disable(priv->reg_xceiver);
 }
 
 static void ti_hecc_reset(struct net_device *ndev)
@@ -409,7 +394,7 @@ static void ti_hecc_start(struct net_device *ndev)
 
 	/* Prevent message over-write & Enable interrupts */
 	hecc_write(priv, HECC_CANOPC, HECC_SET_REG);
-	if (priv->int_line) {
+	if (priv->use_hecc1int) {
 		hecc_write(priv, HECC_CANMIL, HECC_SET_REG);
 		hecc_write(priv, HECC_CANGIM, HECC_CANGIM_DEF_MASK |
 			HECC_CANGIM_I1EN | HECC_CANGIM_SIL);
@@ -760,7 +745,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 	unsigned long ack, flags;
 
 	int_status = hecc_read(priv,
-		(priv->int_line) ? HECC_CANGIF1 : HECC_CANGIF0);
+		(priv->use_hecc1int) ? HECC_CANGIF1 : HECC_CANGIF0);
 
 	if (!int_status)
 		return IRQ_NONE;
@@ -806,7 +791,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 	}
 
 	/* clear all interrupt conditions - read back to avoid spurious ints */
-	if (priv->int_line) {
+	if (priv->use_hecc1int) {
 		hecc_write(priv, HECC_CANGIF1, HECC_SET_REG);
 		int_status = hecc_read(priv, HECC_CANGIF1);
 	} else {
@@ -872,58 +857,87 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
 	.ndo_change_mtu		= can_change_mtu,
 };
 
+static const struct of_device_id ti_hecc_dt_ids[] = {
+	{
+		.compatible = "ti,am3517-hecc",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_hecc_dt_ids);
+
 static int ti_hecc_probe(struct platform_device *pdev)
 {
 	struct net_device *ndev = (struct net_device *)0;
 	struct ti_hecc_priv *priv;
-	struct ti_hecc_platform_data *pdata;
-	struct resource *mem, *irq;
-	void __iomem *addr;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res, *irq;
+	struct regulator *reg_xceiver;
 	int err = -ENODEV;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		goto probe_exit;
+	if (!IS_ENABLED(CONFIG_OF) || !np)
+		return -EINVAL;
+
+	reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
+	if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (IS_ERR(reg_xceiver))
+		reg_xceiver = NULL;
+
+	ndev = alloc_candev(sizeof(struct ti_hecc_priv), HECC_MAX_TX_MBOX);
+	if (!ndev) {
+		dev_err(&pdev->dev, "alloc_candev failed\n");
+		return -ENOMEM;
 	}
+	priv = netdev_priv(ndev);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No mem resources\n");
-		goto probe_exit;
+	/* handle hecc memory */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hecc");
+	if (!res) {
+		dev_err(&pdev->dev, "can't get IORESOURCE_MEM hecc\n");
+		return -EINVAL;
 	}
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "No irq resource\n");
-		goto probe_exit;
+
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->base) {
+		dev_err(&pdev->dev, "hecc ioremap failed\n");
+		return -ENOMEM;
 	}
-	if (!request_mem_region(mem->start, resource_size(mem), pdev->name)) {
-		dev_err(&pdev->dev, "HECC region already claimed\n");
-		err = -EBUSY;
-		goto probe_exit;
+
+	/* handle hecc-ram memory */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hecc-ram");
+	if (!res) {
+		dev_err(&pdev->dev, "can't get IORESOURCE_MEM hecc-ram\n");
+		return -EINVAL;
 	}
-	addr = ioremap(mem->start, resource_size(mem));
-	if (!addr) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		err = -ENOMEM;
-		goto probe_exit_free_region;
+
+	priv->hecc_ram = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->hecc_ram) {
+		dev_err(&pdev->dev, "hecc-ram ioremap failed\n");
+		return -ENOMEM;
 	}
 
-	ndev = alloc_candev(sizeof(struct ti_hecc_priv), HECC_MAX_TX_MBOX);
-	if (!ndev) {
-		dev_err(&pdev->dev, "alloc_candev failed\n");
-		err = -ENOMEM;
-		goto probe_exit_iounmap;
+	/* handle mbx memory */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbx");
+	if (!res) {
+		dev_err(&pdev->dev, "can't get IORESOURCE_MEM mbx\n");
+		return -EINVAL;
+	}
+
+	priv->mbx = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->mbx) {
+		dev_err(&pdev->dev, "mbx ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "No irq resource\n");
+		goto probe_exit;
 	}
 
-	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
-	priv->base = addr;
-	priv->scc_ram_offset = pdata->scc_ram_offset;
-	priv->hecc_ram_offset = pdata->hecc_ram_offset;
-	priv->mbx_offset = pdata->mbx_offset;
-	priv->int_line = pdata->int_line;
-	priv->transceiver_switch = pdata->transceiver_switch;
+	priv->reg_xceiver = reg_xceiver;
+	priv->use_hecc1int = of_property_read_bool(np, "ti,use-hecc1int");
 
 	priv->can.bittiming_const = &ti_hecc_bittiming_const;
 	priv->can.do_set_mode = ti_hecc_do_set_mode;
@@ -971,10 +985,6 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	clk_put(priv->clk);
 probe_exit_candev:
 	free_candev(ndev);
-probe_exit_iounmap:
-	iounmap(addr);
-probe_exit_free_region:
-	release_mem_region(mem->start, resource_size(mem));
 probe_exit:
 	return err;
 }
@@ -996,7 +1006,6 @@ static int ti_hecc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
 #ifdef CONFIG_PM
 static int ti_hecc_suspend(struct platform_device *pdev, pm_message_t state)
 {
@@ -1045,6 +1054,7 @@ static int ti_hecc_resume(struct platform_device *pdev)
 static struct platform_driver ti_hecc_driver = {
 	.driver = {
 		.name    = DRV_NAME,
+		.of_match_table = ti_hecc_dt_ids,
 	},
 	.probe = ti_hecc_probe,
 	.remove = ti_hecc_remove,
diff --git a/include/linux/can/platform/ti_hecc.h b/include/linux/can/platform/ti_hecc.h
deleted file mode 100644
index a52f47c..0000000
--- a/include/linux/can/platform/ti_hecc.h
+++ /dev/null
@@ -1,44 +0,0 @@
-#ifndef _CAN_PLATFORM_TI_HECC_H
-#define _CAN_PLATFORM_TI_HECC_H
-
-/*
- * TI HECC (High End CAN Controller) driver platform header
- *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed as is WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-/**
- * struct hecc_platform_data - HECC Platform Data
- *
- * @scc_hecc_offset:	mostly 0 - should really never change
- * @scc_ram_offset:	SCC RAM offset
- * @hecc_ram_offset:	HECC RAM offset
- * @mbx_offset:		Mailbox RAM offset
- * @int_line:		Interrupt line to use - 0 or 1
- * @version:		version for future use
- * @transceiver_switch:	platform specific callback fn for transceiver control
- *
- * Platform data structure to get all platform specific settings.
- * this structure also accounts the fact that the IP may have different
- * RAM and mailbox offsets for different SOC's
- */
-struct ti_hecc_platform_data {
-	u32 scc_hecc_offset;
-	u32 scc_ram_offset;
-	u32 hecc_ram_offset;
-	u32 mbx_offset;
-	u32 int_line;
-	u32 version;
-	void (*transceiver_switch) (int);
-};
-#endif /* !_CAN_PLATFORM_TI_HECC_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
