From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap: trivial: checkpatch cleanups to board files
Date: Tue, 18 May 2010 18:25:20 +0530
Message-ID: <1274187320-3900-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57003 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757198Ab0ERMz0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 08:55:26 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4ICtM27031994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 07:55:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

- Fix space before tabs
- Add missing printk log level

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Cleanup only - no functional changes

I can break up this into one patch per file if needed,
but I suppose that's unnecessary

 arch/arm/mach-omap2/board-am3517evm.c        |    6 +++---
 arch/arm/mach-omap2/board-apollon.c          |    2 +-
 arch/arm/mach-omap2/board-h4.c               |   10 +++++-----
 arch/arm/mach-omap2/board-igep0020.c         |   12 ++++++------
 arch/arm/mach-omap2/board-ldp.c              |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-am3517evm.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-am3517evm.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-am3517evm.c
@@ -287,7 +287,7 @@ static struct omap_dss_device am3517_evm
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "lcd",
 	.driver_name		= "sharp_lq_panel",
-	.phy.dpi.data_lines 	= 16,
+	.phy.dpi.data_lines	= 16,
 	.platform_enable	= am3517_evm_panel_enable_lcd,
 	.platform_disable	= am3517_evm_panel_disable_lcd,
 };
@@ -302,8 +302,8 @@ static void am3517_evm_panel_disable_tv(
 }
 
 static struct omap_dss_device am3517_evm_tv_device = {
-	.type 			= OMAP_DISPLAY_TYPE_VENC,
-	.name 			= "tv",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.name			= "tv",
 	.driver_name		= "venc",
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
 	.platform_enable	= am3517_evm_panel_enable_tv,
Index: linux-omap-2.6/arch/arm/mach-omap2/board-apollon.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-apollon.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-apollon.c
@@ -326,7 +326,7 @@ static void __init omap_apollon_init(voi
 	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
 
 	/*
- 	 * Make sure the serial ports are muxed on at this point.
+	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
Index: linux-omap-2.6/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-h4.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-h4.c
@@ -138,11 +138,11 @@ static struct platform_device h4_flash_d
 static struct omap_kp_platform_data h4_kp_data = {
 	.rows		= 6,
 	.cols		= 7,
-	.keymap 	= h4_keymap,
-	.keymapsize 	= ARRAY_SIZE(h4_keymap),
+	.keymap		= h4_keymap,
+	.keymapsize	= ARRAY_SIZE(h4_keymap),
 	.rep		= 1,
-	.row_gpios 	= row_gpios,
-	.col_gpios 	= col_gpios,
+	.row_gpios	= row_gpios,
+	.col_gpios	= col_gpios,
 };
 
 static struct platform_device h4_kp_device = {
@@ -260,7 +260,7 @@ static void __init h4_init_flash(void)
 	unsigned long base;
 
 	if (gpmc_cs_request(H4_FLASH_CS, SZ_64M, &base) < 0) {
-		printk("Can't request GPMC CS for flash\n");
+		printk(KERN_ERR "Can't request GPMC CS for flash\n");
 		return;
 	}
 	h4_flash_resource.start	= base;
Index: linux-omap-2.6/arch/arm/mach-omap2/board-igep0020.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-igep0020.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-igep0020.c
@@ -38,12 +38,12 @@
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
 #define IGEP2_GPIO_USBH_NRESET  24
-#define IGEP2_GPIO_LED0_GREEN 	26
-#define IGEP2_GPIO_LED0_RED 	27
-#define IGEP2_GPIO_LED1_RED   	28
+#define IGEP2_GPIO_LED0_GREEN	26
+#define IGEP2_GPIO_LED0_RED	27
+#define IGEP2_GPIO_LED1_RED	28
 #define IGEP2_GPIO_DVI_PUP	170
-#define IGEP2_GPIO_WIFI_NPD 	94
-#define IGEP2_GPIO_WIFI_NRESET 	95
+#define IGEP2_GPIO_WIFI_NPD	94
+#define IGEP2_GPIO_WIFI_NRESET	95
 
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
 	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
@@ -518,7 +518,7 @@ static void __init igep2_init(void)
 	if ((gpio_request(IGEP2_GPIO_WIFI_NPD, "GPIO_WIFI_NPD") == 0) &&
 	    (gpio_direction_output(IGEP2_GPIO_WIFI_NPD, 1) == 0)) {
 		gpio_export(IGEP2_GPIO_WIFI_NPD, 0);
-/* 		gpio_set_value(IGEP2_GPIO_WIFI_NPD, 0); */
+/*		gpio_set_value(IGEP2_GPIO_WIFI_NPD, 0); */
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NPD\n");
 
Index: linux-omap-2.6/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-ldp.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-ldp.c
@@ -141,7 +141,7 @@ static struct gpio_keys_button ldp_gpio_
 		.gpio			= 104,
 		.desc			= "func 3",
 		.active_low		= 1,
-		.debounce_interval 	= 30,
+		.debounce_interval	= 30,
 	},
 	[4] = {
 		.code			= KEY_F4,
Index: linux-omap-2.6/arch/arm/mach-omap2/board-rx51-peripherals.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -59,7 +59,7 @@ static struct spi_board_info rx51_periph
 		.modalias		= "wl1251",
 		.bus_num		= 4,
 		.chip_select		= 0,
-		.max_speed_hz   	= 48000000,
+		.max_speed_hz		= 48000000,
 		.mode                   = SPI_MODE_3,
 		.controller_data	= &wl1251_mcspi_config,
 		.platform_data		= &wl1251_pdata,
