From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Subject: [PATCH] twl4030-usb: rename twl4030_driver to twl4030_usb_driver.
Date: Tue, 14 Oct 2008 11:37:14 +0530
Message-ID: <1223964434-5752-1-git-send-email-j-pakaravoor@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51334 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbYJNGH0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 02:07:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

The i2c_driver in twl4030-core.c and platform_driver of twl4030-usb.c
both has the name twl4030_driver. This leads to unnecessary confusion.

So rename the usb platform_driver appropriately to:
twl4030_usb_driver.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Index: linux-omap-git/drivers/i2c/chips/twl4030-usb.c
===================================================================
--- linux-omap-git.orig/drivers/i2c/chips/twl4030-usb.c	2008-10-10 20:35:15.000000000 +0530
+++ linux-omap-git/drivers/i2c/chips/twl4030-usb.c	2008-10-14 11:01:09.785700607 +0530
@@ -758,7 +758,7 @@ static int __exit twl4030_usb_remove(str
 	return 0;
 }
 
-static struct platform_driver twl4030_driver = {
+static struct platform_driver twl4030_usb_driver = {
 	.probe		= twl4030_usb_probe,
 	.remove		= __exit_p(twl4030_remove),
 	.driver		= {
@@ -769,13 +769,13 @@ static struct platform_driver twl4030_dr
 
 static int __init twl4030_usb_init(void)
 {
-	return platform_driver_register(&twl4030_driver);
+	return platform_driver_register(&twl4030_usb_driver);
 }
 subsys_initcall(twl4030_usb_init);
 
 static void __exit twl4030_usb_exit(void)
 {
-	platform_driver_unregister(&twl4030_driver);
+	platform_driver_unregister(&twl4030_usb_driver);
 }
 module_exit(twl4030_usb_exit);
 
