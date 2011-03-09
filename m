From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-tahvo-usb: Initialize the used clock
Date: Wed, 09 Mar 2011 19:14:02 +0100
Message-ID: <1299694442.1911.16.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:57326 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab1CISOG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 13:14:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

usb_l4_ick is used by the USB. Request and enable it.
Without this, all register accesses just return garbage
due to the device not being clocked.

This also cleans up the error path of the probe function
while we're at it.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-2.6.38-rc7.orig/drivers/cbus/tahvo-usb.c	2011-03-09 18:55:47.177917578 +0100
+++ linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c	2011-03-09 18:58:35.869996276 +0100
@@ -98,6 +98,7 @@ struct tahvo_usb {
 #ifdef CONFIG_USB_OTG
 	int tahvo_mode;
 #endif
+	struct clk *ick;
 };
 static struct tahvo_usb *tahvo_usb_device;
 
@@ -673,6 +674,14 @@ static int __init tahvo_usb_probe(struct
 	INIT_WORK(&tu->irq_work, tahvo_usb_irq_work);
 	mutex_init(&tu->serialize);
 
+	tu->ick = clk_get(NULL, "usb_l4_ick");
+	if (IS_ERR(tu->ick)) {
+		dev_err(dev, "Failed to get usb_l4_ick\n");
+		ret = PTR_ERR(tu->ick);
+		goto err_free_tu;
+	}
+	clk_enable(tu->ick);
+
 	/* Set initial state, so that we generate kevents only on
 	 * state changes */
 	tu->vbus_state = tahvo_read_reg(TAHVO_REG_IDSR) & 0x01;
@@ -681,10 +690,8 @@ static int __init tahvo_usb_probe(struct
 	ret = tahvo_request_irq(TAHVO_INT_VBUSON, tahvo_usb_vbus_interrupt,
 				(unsigned long) tu, "vbus_interrupt");
 	if (ret != 0) {
-		kfree(tu);
-		tahvo_usb_device = NULL;
 		printk(KERN_ERR "Could not register Tahvo interrupt for VBUS\n");
-		return ret;
+		goto err_release_clk;
 	}
 
 	/* Attributes */
@@ -709,10 +716,7 @@ static int __init tahvo_usb_probe(struct
 	ret = otg_set_transceiver(&tu->otg);
 	if (ret < 0) {
 		printk(KERN_ERR "Cannot register USB transceiver\n");
-		tahvo_usb_device = NULL;
-		kfree(tu);
-		tahvo_free_irq(TAHVO_INT_VBUSON);
-		return ret;
+		goto err_free_irq;
 	}
 
 	dev_set_drvdata(dev, tu);
@@ -721,6 +725,17 @@ static int __init tahvo_usb_probe(struct
 	 * may not be generated in addition to this. */
 	schedule_work(&tu->irq_work);
 	return 0;
+
+err_free_irq:
+	tahvo_free_irq(TAHVO_INT_VBUSON);
+err_release_clk:
+	clk_disable(tu->ick);
+	clk_put(tu->ick);
+err_free_tu:
+	kfree(tu);
+	tahvo_usb_device = NULL;
+
+	return ret;
 }
 
 static int __exit tahvo_usb_remove(struct platform_device *pdev)
@@ -736,6 +751,8 @@ static int __exit tahvo_usb_remove(struc
 #ifdef CONFIG_USB_OTG
 	device_remove_file(&pdev->dev, &dev_attr_otg_mode);
 #endif
+	clk_disable(tu->ick);
+	clk_put(tu->ick);
 
 	kfree(tu);
 	tahvo_usb_device = NULL;

-- 
Greetings, Michael.

