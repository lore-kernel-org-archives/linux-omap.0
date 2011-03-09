From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-tahvo-usb: Fix struct tahvo_usb memory leak on exit
Date: Wed, 09 Mar 2011 19:09:00 +0100
Message-ID: <1299694140.1911.11.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:55052 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429Ab1CISJE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 13:09:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

The struct tahvo_usb must be free'd on remove.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-2.6.38-rc7.orig/drivers/cbus/tahvo-usb.c	2011-03-09 18:51:46.240795227 +0100
+++ linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c	2011-03-09 18:52:34.430126706 +0100
@@ -725,6 +725,8 @@ static int __init tahvo_usb_probe(struct
 
 static int __exit tahvo_usb_remove(struct platform_device *pdev)
 {
+	struct tahvo_usb *tu = platform_get_drvdata(pdev);
+
 	dev_dbg(&pdev->dev, "remove\n");
 
 	tahvo_free_irq(TAHVO_INT_VBUSON);
@@ -734,6 +736,8 @@ static int __exit tahvo_usb_remove(struc
 #ifdef CONFIG_USB_OTG
 	device_remove_file(&pdev->dev, &dev_attr_otg_mode);
 #endif
+
+	kfree(tu);
 	tahvo_usb_device = NULL;
 
 	return 0;

-- 
Greetings, Michael.

