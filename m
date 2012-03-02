From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 08/12] gpio/twl: Allocate irq_desc dynamically for SPARSE_IRQ support
Date: Fri, 2 Mar 2012 17:50:20 +0100
Message-ID: <1330707024-23730-9-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030381Ab2CBQvb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 11:51:31 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Do not use the board pdata for irq_base, but allocate them dynamically
to allow a proper support of SPARSE_IRQ.

Fix an unneeded line wrap.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-twl4030.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 697396c..49e5c6e 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -395,23 +395,26 @@ static int gpio_twl4030_remove(struct platform_device *pdev);
 static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 {
 	struct twl4030_gpio_platform_data *pdata = pdev->dev.platform_data;
-	int ret;
+	int ret, irq_base;
 
 	/* maybe setup IRQs */
-	if (pdata->irq_base) {
-		if (is_module()) {
-			dev_err(&pdev->dev,
-				"can't dispatch IRQs from modules\n");
-			goto no_irqs;
-		}
-		ret = twl4030_sih_setup(&pdev->dev, TWL4030_MODULE_GPIO,
-					pdata->irq_base);
-		if (ret < 0)
-			return ret;
-		WARN_ON(ret != pdata->irq_base);
-		twl4030_gpio_irq_base = ret;
+	if (is_module()) {
+		dev_err(&pdev->dev, "can't dispatch IRQs from modules\n");
+		goto no_irqs;
+	}
+
+	irq_base = irq_alloc_descs(-1, 0, TWL4030_GPIO_MAX, 0);
+	if (irq_base < 0) {
+		dev_err(&pdev->dev, "Failed to alloc irq_descs\n");
+		return irq_base;
 	}
 
+	ret = twl4030_sih_setup(&pdev->dev, TWL4030_MODULE_GPIO, irq_base);
+	if (ret < 0)
+		return ret;
+
+	twl4030_gpio_irq_base = irq_base;
+
 no_irqs:
 	/*
 	 * NOTE:  boards may waste power if they don't set pullups
@@ -443,9 +446,7 @@ no_irqs:
 
 	ret = gpiochip_add(&twl_gpiochip);
 	if (ret < 0) {
-		dev_err(&pdev->dev,
-				"could not register gpiochip, %d\n",
-				ret);
+		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
 		twl_gpiochip.ngpio = 0;
 		gpio_twl4030_remove(pdev);
 	} else if (pdata->setup) {
-- 
1.7.0.4

