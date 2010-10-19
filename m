From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] cbus: tahvo-usb: move platform_device to board file
Date: Tue, 19 Oct 2010 10:29:18 +0300
Message-ID: <1287473358-25634-5-git-send-email-balbi@ti.com>
References: <1287473358-25634-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35429 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758086Ab0JSH3m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 03:29:42 -0400
In-Reply-To: <1287473358-25634-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

No functional changes, just moving platform_device
registration to the proper location.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    6 ++++++
 arch/arm/mach-omap2/board-n8x0.c     |    6 ++++++
 drivers/cbus/tahvo-usb.c             |   15 ++-------------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index fabc154..51bd52c 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -141,6 +141,11 @@ static struct platform_device tahvo_device = {
 	.num_resources	= ARRAY_SIZE(tahvo_resource),
 };
 
+static struct platform_device tahvo_usb_device = {
+	.name		= "tahvo-usb",
+	.id		= -1,
+};
+
 static void __init nokia770_cbus_init(void)
 {
 	int		ret;
@@ -181,6 +186,7 @@ static void __init nokia770_cbus_init(void)
 
 	tahvo_resource[0].start = gpio_to_irq(40);
 	platform_device_register(&tahvo_device);
+	platform_device_register(&tahvo_usb_device);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 1823f01..ebd460e 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -250,6 +250,11 @@ static struct platform_device tahvo_device = {
 	.num_resources	= ARRAY_SIZE(tahvo_resource),
 };
 
+static struct platform_device tahvo_usb_device = {
+	.name		= "tahvo-usb",
+	.id		= -1,
+};
+
 static void __init n8x0_cbus_init(void)
 {
 	int		ret;
@@ -291,6 +296,7 @@ static void __init n8x0_cbus_init(void)
 
 	tahvo_resource[0].start = gpio_to_irq(111);
 	platform_device_register(&tahvo_device);
+	platform_device_register(&tahvo_usb_device);
 }
 
 #else
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 1cb81fd..3b83bab 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -742,30 +742,20 @@ static struct platform_driver tahvo_usb_driver = {
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
+
 	ret = platform_driver_probe(&omap_otg_driver, omap_otg_probe);
 	if (ret) {
-		platform_device_unregister(&tahvo_usb_device);
 		platform_driver_unregister(&tahvo_usb_driver);
 		return ret;
 	}
+
 	return 0;
 }
 
@@ -774,7 +764,6 @@ subsys_initcall(tahvo_usb_init);
 static void __exit tahvo_usb_exit(void)
 {
 	platform_driver_unregister(&omap_otg_driver);
-	platform_device_unregister(&tahvo_usb_device);
 	platform_driver_unregister(&tahvo_usb_driver);
 }
 module_exit(tahvo_usb_exit);
-- 
1.7.3.rc0.35.g8ac8c

