From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Sat, 27 Sep 2008 12:14:29 -0700
Message-ID: <200809271214.30165.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:27993 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753358AbYI0TOc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Sep 2008 15:14:32 -0400
In-Reply-To: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Here are some more cleanups to consider including ... these
should apply on top of all nine patches.


======= SNIP HERE!
Provide detailed diagnostics in add_children() when DEBUG is
defined ... and fix the non-DEBUG message to include minimal
status, and not appear unless there was actually an error.

Update the IRQ message; have it match what the GPIO subchip
says, and as a precaution, make it only appear if the IRQs
have been initialized.

--- beagle.orig/drivers/i2c/chips/twl4030-core.c
+++ beagle/drivers/i2c/chips/twl4030-core.c
@@ -677,6 +677,9 @@ static int add_children(struct twl4030_p
 			status = platform_device_add_data(pdev, pdata->keypad,
 					sizeof(*pdata->keypad));
 			if (status < 0) {
+				dev_dbg(&twl->client->dev,
+					"can't add keypad data, %d\n",
+					status);
 				platform_device_put(pdev);
 				goto err;
 			}
@@ -684,6 +687,7 @@ static int add_children(struct twl4030_p
 			if (status < 0)
 				platform_device_put(pdev);
 		} else {
+			pr_debug("%s: can't alloc keypad dev\n", DRIVER_NAME);
 			status = -ENOMEM;
 			goto err;
 		}
@@ -693,8 +697,10 @@ static int add_children(struct twl4030_p
 		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM1];
 
 		pdev = platform_device_alloc("twl4030_gpio", -1);
-		if (!pdev)
+		if (!pdev) {
+			pr_debug("%s: can't alloc gpio dev\n", DRIVER_NAME);
 			status = -ENOMEM;
+		}
 
 		/* more driver model init */
 		if (status == 0) {
@@ -703,6 +709,10 @@ static int add_children(struct twl4030_p
 
 			status = platform_device_add_data(pdev, pdata->gpio,
 					sizeof(*pdata->gpio));
+			if (status < 0)
+				dev_dbg(&twl->client->dev,
+					"can't add gpio data, %d\n",
+				status);
 		}
 
 		/* GPIO module IRQ */
@@ -737,12 +747,16 @@ static int add_children(struct twl4030_p
 					sizeof(*pdata->madc));
 			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+					"can't add madc data, %d\n",
+					status);
 				goto err;
 			}
 			status = platform_device_add(pdev);
 			if (status < 0)
 				platform_device_put(pdev);
 		} else {
+			pr_debug("%s: can't alloc madc dev\n", DRIVER_NAME);
 			status = -ENOMEM;
 			goto err;
 		}
@@ -788,19 +802,24 @@ static int add_children(struct twl4030_p
 					sizeof(*pdata->usb));
 			if (status < 0) {
 				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+					"can't add usb data, %d\n",
+					status);
 				goto err;
 			}
 			status = platform_device_add(pdev);
 			if (status < 0)
 				platform_device_put(pdev);
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
 
@@ -1084,13 +1103,12 @@ twl4030_probe(struct i2c_client *client,
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
