From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 7/7] [htcherald] Add board support for UARTs, bluetooth
Date: Mon, 19 Jul 2010 21:07:46 -0700
Message-ID: <1279598866-18716-6-git-send-email-darkstar6262@gmail.com>
References: <1279598866-18716-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab0GTEId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 00:08:33 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so5354123iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Jul 2010 21:08:32 -0700 (PDT)
In-Reply-To: <1279598866-18716-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds bluetooth and UART initialization support to the
HTC Herald board driver.  This allows use of the serial bluetooth
adapter attached to UART1 using hciattach.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/Makefile          |    2 +-
 arch/arm/mach-omap1/board-htcherald.c |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index facfaeb..0b8cb18 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 obj-$(CONFIG_AMS_DELTA_FIQ)		+= ams-delta-fiq.o ams-delta-fiq-handler.o
 obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
-obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o
+obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o htc-bt.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 1b12b75..cf4b908 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -47,8 +47,10 @@
 #include <plat/keypad.h>
 #include <plat/usb.h>
 #include <plat/mmc.h>
+#include <plat/mux.h>
 
 #include <mach/irqs.h>
+#include <mach/htc-bt.h>
 
 #include <linux/delay.h>
 
@@ -138,6 +140,7 @@ Happy Times         0 1 0 x  x x 0 x
 
 #define HTCPLD_GPIO_LED_DPAD		HTCPLD_BASE(0, 0)
 #define HTCPLD_GPIO_LED_KBD		HTCPLD_BASE(1, 0)
+#define HTCPLD_GPIO_BT_POWER		HTCPLD_BASE(1, 4)
 #define HTCPLD_GPIO_LED_CAPS		HTCPLD_BASE(1, 5)
 #define HTCPLD_GPIO_LED_RED_FLASH	HTCPLD_BASE(2, 1)
 #define HTCPLD_GPIO_LED_RED_SOLID	HTCPLD_BASE(2, 2)
@@ -423,6 +426,22 @@ static struct omap_mmc_platform_data htc_mmc1_data = {
 static struct omap_mmc_platform_data *htc_mmc_data[1];
 #endif
 
+/* Bluetooth */
+#define HTCHERALD_GPIO_BT_ENABLE 125
+
+static struct htc_bt_data htcherald_bt_data = {
+	.uart_clock	= "uart1_ck",
+	.gpio_pwr	= HTCPLD_GPIO_BT_POWER,
+	.gpio_enable	= HTCHERALD_GPIO_BT_ENABLE,
+};
+
+static struct platform_device bt_device = {
+	.name		= "htc-bt",
+	.id		= -1,
+	.dev = {
+		.platform_data = &htcherald_bt_data,
+	},
+};
 
 /* Platform devices for the Herald */
 static struct platform_device *devices[] __initdata = {
@@ -431,6 +450,7 @@ static struct platform_device *devices[] __initdata = {
 	&htcpld_device,
 	&gpio_leds_device,
 	&herald_gpiokeys_device,
+	&bt_device,
 };
 
 /*
@@ -574,6 +594,7 @@ done:
 	printk(KERN_INFO "USB setup complete.\n");
 }
 
+
 static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
@@ -595,6 +616,8 @@ static void __init htcherald_init(void)
 
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
+	omap_serial_init();
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 	htc_mmc_data[0] = &htc_mmc1_data;
 	omap1_init_mmc(htc_mmc_data, 1);
-- 
1.7.0.4

