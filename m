From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 16/22] i2c: omap: switch to platform_get_irq()
Date: Wed, 13 Jun 2012 18:51:05 +0300
Message-ID: <1339602671-8431-17-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35577 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab2FMPx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:59 -0400
Received: by laap9 with SMTP id p9so569599laa.36
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:56 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that's a nice helper from drivers core which
will give us the exact IRQ number, instead
of a pointer to an IRQ resource.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5e9e165..b9c9407 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1071,10 +1071,11 @@ omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
-	struct resource		*mem, *irq;
+	struct resource		*mem;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
+	int irq;
 	int r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -1084,10 +1085,10 @@ omap_i2c_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+		return irq;
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
@@ -1115,7 +1116,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev->dev = &pdev->dev;
-	dev->irq = irq->start;
+	dev->irq = irq;
 	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
 	if (!dev->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-- 
1.7.10.4

