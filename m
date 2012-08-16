From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 11/24] i2c: omap: switch to platform_get_irq()
Date: Thu, 16 Aug 2012 19:33:42 +0530
Message-ID: <1345125835-15524-12-git-send-email-shubhrajyoti@ti.com>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36358 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932660Ab2HPOEz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 10:04:55 -0400
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

that's a nice helper from drivers core which
will give us the exact IRQ number, instead
of a pointer to an IRQ resource.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0adbfb1..e9907b5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -993,11 +993,12 @@ omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
-	struct resource		*mem, *irq;
+	struct resource		*mem;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	irq_handler_t isr;
+	int irq;
 	int r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -1006,10 +1007,11 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "no mem resource?\n");
 		return -ENODEV;
 	}
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+		return irq;
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
@@ -1043,7 +1045,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev->dev = &pdev->dev;
-	dev->irq = irq->start;
+	dev->irq = irq;
 
 	platform_set_drvdata(pdev, dev);
 	init_completion(&dev->cmd_complete);
-- 
1.7.5.4

