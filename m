From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 09/13] uio: uio_pruss: add devicetree support
Date: Sun, 29 Jun 2014 18:21:43 +0200
Message-ID: <1404058907-21112-10-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35036 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbaF2QWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:22:07 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Add support to probe via devicetree.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index afaf726..2df54ab 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -26,6 +26,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/genalloc.h>
+#include <linux/of_device.h>
 
 #define DRV_NAME "pruss_uio"
 #define DRV_VERSION "1.0"
@@ -70,6 +71,27 @@ struct uio_pruss_dev {
 	struct gen_pool *sram_pool;
 };
 
+#ifdef CONFIG_OF
+struct uio_pruss_params {
+	u32 pintc_offset;
+};
+
+static const struct uio_pruss_params uio_pruss_v1_params = {
+	.pintc_offset = 0x4000,
+};
+
+static const struct uio_pruss_params uio_pruss_v2_params = {
+	.pintc_offset = 0x20000,
+};
+
+static const struct of_device_id pruss_of_match_table[] = {
+	{ .compatible = "ti,pruss-v1", .data = &uio_pruss_v1_params, },
+	{ .compatible = "ti,pruss-v2", .data = &uio_pruss_v2_params, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pruss_of_match_table);
+#endif
+
 static irqreturn_t pruss_handler(int irq, struct uio_info *info)
 {
 	struct uio_pruss_dev *gdev = info->priv;
@@ -111,6 +133,8 @@ static int pruss_probe(struct platform_device *pdev)
 	struct uio_pruss_dev *gdev;
 	struct resource *regs_prussio;
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	const struct uio_pruss_params *params;
 	int ret = -ENODEV, cnt = 0, i;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 	dma_addr_t ddr_paddr;
@@ -123,13 +147,21 @@ static int pruss_probe(struct platform_device *pdev)
 	if (!gdev->info)
 		return -ENOMEM;
 
-	/* Power on PRU in case its not done as part of boot-loader */
-	gdev->pruss_clk = clk_get(dev, "pruss");
-	if (IS_ERR(gdev->pruss_clk)) {
-		dev_err(dev, "Failed to get clock\n");
-		return PTR_ERR(gdev->pruss_clk);
+	if (dev->of_node) {
+		match = of_match_device(pruss_of_match_table, dev);
+		params = match->data;
+		gdev->pintc_base = params->pintc_offset;
 	} else {
+		/* Power on PRU in case its not done as part of boot-loader */
+		gdev->pruss_clk = clk_get(dev, "pruss");
+		if (IS_ERR(gdev->pruss_clk)) {
+			dev_err(dev, "Failed to get clock\n");
+			return PTR_ERR(gdev->pruss_clk);
+		}
+
 		clk_enable(gdev->pruss_clk);
+
+		gdev->pintc_base = pdata->pintc_base;
 	}
 
 	regs_prussio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -139,7 +171,7 @@ static int pruss_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	if (pdata->sram_pool) {
+	if (pdata && pdata->sram_pool) {
 		gdev->sram_pool = pdata->sram_pool;
 		gdev->sram_vaddr =
 			(unsigned long)gen_pool_dma_alloc(gdev->sram_pool,
@@ -156,7 +188,6 @@ static int pruss_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	gdev->pintc_base = pdata->pintc_base;
 	gdev->hostirq_start = platform_get_irq(pdev, 0);
 
 	for (cnt = 0, p = gdev->info; cnt < MAX_PRUSS_EVT; cnt++, p++) {
@@ -214,6 +245,7 @@ static struct platform_driver pruss_driver = {
 	.driver = {
 		   .name = DRV_NAME,
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(pruss_of_match_table),
 		   },
 };
 
-- 
2.0.0

