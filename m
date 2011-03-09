From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-tahvo-usb: Fix tahvo_usb_device pointer
Date: Wed, 09 Mar 2011 19:07:05 +0100
Message-ID: <1299694025.1911.9.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:34689 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439Ab1CISHK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 13:07:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

The static tahvo_usb_device is uninitialized, but used
in the otg interrupt handler. This results in a NULL pointer
dereference on interrupt.
Fix this by storing a struct tahvo_usb pointer instead of
a platform device.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

The global tahvo_usb_device pointer should eventually be removed
completely in a later patch. But let's get it working first.


Index: linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-2.6.38-rc7.orig/drivers/cbus/tahvo-usb.c	2011-03-09 18:47:41.147540155 +0100
+++ linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c	2011-03-09 18:50:59.658485748 +0100
@@ -99,7 +99,7 @@ struct tahvo_usb {
 	int tahvo_mode;
 #endif
 };
-static struct platform_device tahvo_usb_device;
+static struct tahvo_usb *tahvo_usb_device;
 
 /*
  * ---------------------------------------------------------------------------
@@ -114,8 +114,7 @@ static struct platform_device *tahvo_otg
 
 static irqreturn_t omap_otg_irq(int irq, void *arg)
 {
-	struct platform_device *otg_dev = arg;
-	struct tahvo_usb *tu = platform_get_drvdata(otg_dev);
+	struct tahvo_usb *tu = arg;
 	u16 otg_irq;
 
 	otg_irq = omap_readw(OTG_IRQ_SRC);
@@ -201,12 +200,12 @@ static int __init omap_otg_probe(struct
 
 	return request_irq(tahvo_otg_dev->resource[1].start,
 			   omap_otg_irq, IRQF_DISABLED, DRIVER_NAME,
-			   &tahvo_usb_device);
+			   tahvo_usb_device);
 }
 
 static int __exit omap_otg_remove(struct platform_device *pdev)
 {
-	free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
+	free_irq(tahvo_otg_dev->resource[1].start, tahvo_usb_device);
 	tahvo_otg_dev = NULL;
 
 	return 0;
@@ -659,6 +658,7 @@ static int __init tahvo_usb_probe(struct
 	tu = kzalloc(sizeof(*tu), GFP_KERNEL);
 	if (!tu)
 		return -ENOMEM;
+	tahvo_usb_device = tu;
 
 	tu->pt_dev = container_of(dev, struct platform_device, dev);
 #ifdef CONFIG_USB_OTG
@@ -682,6 +682,7 @@ static int __init tahvo_usb_probe(struct
 				(unsigned long) tu, "vbus_interrupt");
 	if (ret != 0) {
 		kfree(tu);
+		tahvo_usb_device = NULL;
 		printk(KERN_ERR "Could not register Tahvo interrupt for VBUS\n");
 		return ret;
 	}
@@ -708,6 +709,7 @@ static int __init tahvo_usb_probe(struct
 	ret = otg_set_transceiver(&tu->otg);
 	if (ret < 0) {
 		printk(KERN_ERR "Cannot register USB transceiver\n");
+		tahvo_usb_device = NULL;
 		kfree(tu);
 		tahvo_free_irq(TAHVO_INT_VBUSON);
 		return ret;
@@ -732,6 +734,8 @@ static int __exit tahvo_usb_remove(struc
 #ifdef CONFIG_USB_OTG
 	device_remove_file(&pdev->dev, &dev_attr_otg_mode);
 #endif
+	tahvo_usb_device = NULL;
+
 	return 0;
 }
 

-- 
Greetings, Michael.

