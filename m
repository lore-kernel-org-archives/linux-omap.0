From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 3/3] [OMAP] HTCHERALD: Add USB configuration to HTC Herald
Date: Sun, 22 Nov 2009 13:28:44 -0800
Message-ID: <1258925324.11242.6.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50176 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbZKVV2k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Nov 2009 16:28:40 -0500
Received: by pwi3 with SMTP id 3so3058423pwi.21
        for <linux-omap@vger.kernel.org>; Sun, 22 Nov 2009 13:28:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This change implements USB client side support into the HTC
Herald board configuration.  It uses a similar, but updated
algorithm to initialize the USB as is used in the linwizard
project.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/board-htcherald.c |   70 +++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 5f28a5c..8949570 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -39,6 +39,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/keypad.h>
+#include <plat/usb.h>
 
 #include <mach/irqs.h>
 
@@ -140,6 +141,15 @@ static struct platform_device kp_device = {
 	.resource	= kp_resources,
 };
 
+/* USB Device */
+static struct omap_usb_config htcherald_usb_config __initdata = {
+	.otg = 0,
+	.register_host = 0,
+	.register_dev  = 1,
+	.hmc_mode = 4,
+	.pins[0] = 2,
+};
+
 /* LCD Device resources */
 static struct platform_device lcd_device = {
 	.name           = "lcd_htcherald",
@@ -214,6 +224,63 @@ static void __init htcherald_disable_watchdog(void)
 	}
 }
 
+#define HTCHERALD_GPIO_USB_EN1 33
+#define HTCHERALD_GPIO_USB_EN2 73
+#define HTCHERALD_GPIO_USB_DM  35
+#define HTCHERALD_GPIO_USB_DP  36
+
+static void __init htcherald_usb_enable(void)
+{
+	unsigned int tries = 20;
+	unsigned int value = 0;
+
+	/* Request the GPIOs we need to control here */
+	if (gpio_request(HTCHERALD_GPIO_USB_EN1, "herald_usb") < 0) {
+		printk(KERN_WARNING "Unable to request HTCHERALD_GPIO_USB_EN1, USB will be unavailable\n");
+		goto done;
+	}
+
+	if (gpio_request(HTCHERALD_GPIO_USB_EN2, "herald_usb") < 0) {
+		printk(KERN_WARNING "Unable to request HTCHERALD_GPIO_USB_EN2, USB will be unavailable\n");
+		goto err1;
+	}
+
+	if (gpio_request(HTCHERALD_GPIO_USB_DM, "herald_usb") < 0) {
+		printk(KERN_WARNING "Unable to request HTCHERALD_GPIO_USB_DM, USB will be unavailable\n");
+		goto err2;
+	}
+
+	if (gpio_request(HTCHERALD_GPIO_USB_DP, "herald_usb") < 0) {
+		printk(KERN_WARNING "Unable to request HTCHERALD_GPIO_USB_DP, USB will be unavailable\n");
+		goto err3;
+	}
+
+	/* force USB_EN GPIO to 0 */
+	do {
+		gpio_direction_output(HTCHERALD_GPIO_USB_EN1, 0); /* output low */
+	} while((value = gpio_get_value(HTCHERALD_GPIO_USB_EN1)) == 1 && --tries);
+
+	if (value == 1) {
+		printk(KERN_WARNING "unable to reset USB_EN GPIO after 20 tries.\n");
+		printk(KERN_WARNING "I will try to continue anyway: USB may not be available.\n");
+	}
+
+	gpio_direction_output(HTCHERALD_GPIO_USB_EN2, 0); /* output low */
+	gpio_direction_input(HTCHERALD_GPIO_USB_DM); /* input */
+	gpio_direction_input(HTCHERALD_GPIO_USB_DP); /* input */
+
+	goto done;
+
+err3:
+	gpio_free(HTCHERALD_GPIO_USB_DM);
+err2:
+	gpio_free(HTCHERALD_GPIO_USB_EN2);
+err1:
+	gpio_free(HTCHERALD_GPIO_USB_EN1);
+done:
+	printk(KERN_INFO "USB setup complete.\n");
+}
+
 static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
@@ -225,6 +292,9 @@ static void __init htcherald_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	htcherald_disable_watchdog();
+
+	htcherald_usb_enable();
+	omap_usb_init(&htcherald_usb_config);
 }
 
 static void __init htcherald_init_irq(void)
-- 
1.6.3.3


