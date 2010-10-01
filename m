From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] cbus: tahvo-usb: move platform_device to board file
Date: Fri,  1 Oct 2010 10:47:18 +0300
Message-ID: <1285919238-26555-5-git-send-email-balbi@ti.com>
References: <1285919238-26555-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50238 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211Ab0JAHr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 03:47:28 -0400
In-Reply-To: <1285919238-26555-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

No functional changes, just moving platform_device
registration to the proper location.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-n8x0.c |    6 ++++++
 drivers/cbus/tahvo-usb.c         |   13 -------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index f5ac666..a3b7b63 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -236,6 +236,11 @@ static struct platform_device tahvo_device = {
 	.num_resources	= ARRAY_SIZE(tahvo_resource),
 };
 
+static struct platform_device tahvo_usb_device = {
+	.name		= "tahvo-usb",
+	.id		= -1,
+};
+
 static struct resource retu_resource[] = {
 	{
 		.start	= -EINVAL, /* set later */
@@ -284,6 +289,7 @@ static void __init n8x0_cbus_init(void)
 
 	tahvo_resource[0].start = gpio_to_irq(tahvo_irq_pin);
 	platform_device_register(&tahvo_device);
+	platform_device_register(&tahvo_usb_device);
 
 	if (machine_is_nokia770()) {
 		retu_irq_pin = 62;
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 1cb81fd..3e3b85f 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -742,27 +742,15 @@ static struct platform_driver tahvo_usb_driver = {
 	.remove		= __exit_p(tahvo_usb_remove),
 };
 
-static struct platform_device tahvo_usb_device = {
-	.name		= "tahvo-usb",
-	.id		= -1,
-};
-
 static int __init tahvo_usb_init(void)
 {
 	int ret = 0;
 
-	printk(KERN_INFO "Tahvo USB transceiver driver initializing\n");
 	ret = platform_driver_probe(&tahvo_usb_driver, tahvo_usb_probe);
 	if (ret)
 		return ret;
-	ret = platform_device_register(&tahvo_usb_device);
-	if (ret < 0) {
-		platform_driver_unregister(&tahvo_usb_driver);
-		return ret;
-	}
 	ret = platform_driver_probe(&omap_otg_driver, omap_otg_probe);
 	if (ret) {
-		platform_device_unregister(&tahvo_usb_device);
 		platform_driver_unregister(&tahvo_usb_driver);
 		return ret;
 	}
@@ -774,7 +762,6 @@ subsys_initcall(tahvo_usb_init);
 static void __exit tahvo_usb_exit(void)
 {
 	platform_driver_unregister(&omap_otg_driver);
-	platform_device_unregister(&tahvo_usb_device);
 	platform_driver_unregister(&tahvo_usb_driver);
 }
 module_exit(tahvo_usb_exit);
-- 
1.7.3.rc0.35.g8ac8c

