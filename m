From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 15/23] i2c: switch twl4030-usb to use a resource for irq
Date: Tue, 30 Sep 2008 13:05:52 +0300
Message-ID: <1222769160-31615-16-git-send-email-felipe.balbi@nokia.com>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-2-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-3-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-4-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-5-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-6-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-7-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-8-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-9-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-10-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-11-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-12-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-13-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-14-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-15-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58459 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbYI3KHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:07:04 -0400
In-Reply-To: <1222769160-31615-15-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

use platform_get_irq() for getting irq number passed
to twl4030-usb via twl4030-core.c:add_children()

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   38 +++++++++++++++++++++++++++-----------
 drivers/i2c/chips/twl4030-usb.c  |    2 +-
 include/linux/i2c/twl4030.h      |    2 +-
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index e0a6ef4..43424a8 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -819,9 +819,16 @@ static int add_children(struct twl4030_platform_data *pdata)
 	}
 
 	if (twl_has_usb() && pdata->usb) {
+		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM0];
+
 		pdev = platform_device_alloc("twl4030_usb", -1);
-		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM0];
+		if (!pdev) {
+			pr_debug("%s: can't alloc usb dev\n", DRIVER_NAME);
+			status = -ENOMEM;
+			goto err;
+		}
+
+		if (status == 0) {
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
 			status = platform_device_add_data(pdev, pdata->usb,
@@ -833,16 +840,25 @@ static int add_children(struct twl4030_platform_data *pdata)
 					status);
 				goto err;
 			}
+		}
+
+		if (status == 0) {
+			struct resource r = {
+				.start = TWL4030_PWRIRQ_USB_PRES,
+				.flags = IORESOURCE_IRQ,
+			};
+
+			status = platform_device_add_resources(pdev, &r, 1);
+		}
+
+		if (status == 0)
 			status = platform_device_add(pdev);
-			if (status < 0) {
-				platform_device_put(pdev);
-				dev_dbg(&twl->client->dev,
-						"can't create usb dev, %d\n",
-						status);
-			}
-		} else {
-			pr_debug("%s: can't alloc usb dev\n", DRIVER_NAME);
-			status = -ENOMEM;
+
+		if (status < 0) {
+			platform_device_put(pdev);
+			dev_dbg(&twl->client->dev,
+					"can't create usb dev, %d\n",
+					status);
 		}
 	}
 
diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index f530e71..133cc0f 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -684,7 +684,7 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 	vbus &= USB_PRES_RISING;
 
 	twl->dev		= &pdev->dev;
-	twl->irq		= TWL4030_PWRIRQ_USB_PRES;
+	twl->irq		= platform_get_irq(pdev, 0);
 	twl->otg.set_host	= twl4030_set_host;
 	twl->otg.set_peripheral	= twl4030_set_peripheral;
 	twl->otg.set_suspend	= twl4030_set_suspend;
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 5828485..1c79c89 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -112,7 +112,7 @@ struct twl4030_platform_data {
 #define TWL4030_MODIRQ_KEYPAD		(TWL4030_IRQ_BASE + 1)
 #define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2)
 #define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3)
-#define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4)
+/* #define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4) */
 #define TWL4030_MODIRQ_PWR		(TWL4030_IRQ_BASE + 5)
 
 #define TWL4030_PWRIRQ_PWRBTN		(TWL4030_PWR_IRQ_BASE + 0)
-- 
1.6.0.2.307.gc427

