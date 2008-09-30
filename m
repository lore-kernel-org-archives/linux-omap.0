From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 11/23] provide detailed diagnostics in add_children()
Date: Tue, 30 Sep 2008 13:05:48 +0300
Message-ID: <1222769160-31615-12-git-send-email-felipe.balbi@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34597 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYI3KG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:06:57 -0400
In-Reply-To: <1222769160-31615-11-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Provide detailed diagnostics in add_children() when DEBUG is
defined ... and fix the non-DEBUG message to include minimal
status, and not appear unless there was actually an error.

Update the IRQ message; have it match what the GPIO subchip
says, and as a precaution, make it only appear if the IRQs
have been initialized.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Added a few more diagnostics when platform_device_add() fails.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   59 ++++++++++++++++++++++++++++++-------
 1 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 22850a8..5dcc3b1 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -672,8 +672,10 @@ static int add_children(struct twl4030_platform_data *pdata)
 		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM1];
 
 		pdev = platform_device_alloc("twl4030_gpio", -1);
-		if (!pdev)
+		if (!pdev) {
+			pr_debug("%s: can't alloc gpio dev\n", DRIVER_NAME);
 			status = -ENOMEM;
+		}
 
 		/* more driver model init */
 		if (status == 0) {
@@ -682,6 +684,12 @@ static int add_children(struct twl4030_platform_data *pdata)
 
 			status = platform_device_add_data(pdev, pdata->gpio,
 					sizeof(*pdata->gpio));
+			if (status < 0) {
+				dev_dbg(&twl->client->dev,
+					"can't add gpio data, %d\n",
+					status);
+				goto err;
+			}
 		}
 
 		/* GPIO module IRQ */
@@ -715,13 +723,21 @@ static int add_children(struct twl4030_platform_data *pdata)
 			status = platform_device_add_data(pdev, pdata->keypad,
 					sizeof(*pdata->keypad));
 			if (status < 0) {
+				dev_dbg(&twl->client->dev,
+					"can't add keypad data, %d\n",
+					status);
 				platform_device_put(pdev);
 				goto err;
 			}
 			status = platform_device_add(pdev);
-			if (status < 0)
+			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+						"can't create keypad dev, %d\n",
+						status);
+			}
 		} else {
+			pr_debug("%s: can't alloc keypad dev\n", DRIVER_NAME);
 			status = -ENOMEM;
 			goto err;
 		}
@@ -737,12 +753,20 @@ static int add_children(struct twl4030_platform_data *pdata)
 					sizeof(*pdata->madc));
 			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+					"can't add madc data, %d\n",
+					status);
 				goto err;
 			}
 			status = platform_device_add(pdev);
-			if (status < 0)
+			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+						"can't create madc dev, %d\n",
+						status);
+			}
 		} else {
+			pr_debug("%s: can't alloc madc dev\n", DRIVER_NAME);
 			status = -ENOMEM;
 			goto err;
 		}
@@ -770,9 +794,14 @@ static int add_children(struct twl4030_platform_data *pdata)
 			 */
 
 			status = platform_device_add(pdev);
-			if (status < 0)
+			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+						"can't create rtc dev, %d\n",
+						status);
+			}
 		} else {
+			pr_debug("%s: can't alloc rtc dev\n", DRIVER_NAME);
 			status = -ENOMEM;
 			goto err;
 		}
@@ -788,19 +817,28 @@ static int add_children(struct twl4030_platform_data *pdata)
 					sizeof(*pdata->usb));
 			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+					"can't add usb data, %d\n",
+					status);
 				goto err;
 			}
 			status = platform_device_add(pdev);
-			if (status < 0)
+			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+						"can't create usb dev, %d\n",
+						status);
+			}
 		} else {
+			pr_debug("%s: can't alloc usb dev\n", DRIVER_NAME);
 			status = -ENOMEM;
 			goto err;
 		}
 	}
 
 err:
-	pr_err("failed to add twl4030's children\n");
+	if (status)
+		pr_err("failed to add twl4030's children (status %d)\n", status);
 	return status;
 }
 
@@ -1084,13 +1122,12 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			&& twl4030_irq_base == 0
 			&& client->irq
 			&& pdata->irq_base
-			&& pdata->irq_end > pdata->irq_base)
+			&& pdata->irq_end > pdata->irq_base) {
 		twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
+		dev_info(&client->dev, "IRQ %d chains IRQs %d..%d\n",
+				client->irq, pdata->irq_base, pdata->irq_end - 1);
+	}
 
-	dev_info(&client->dev, "chaining %d irqs\n",
-			twl4030_irq_base
-				? (pdata->irq_end - pdata->irq_base)
-				: 0);
 	return 0;
 
 fail:
-- 
1.6.0.2.307.gc427

