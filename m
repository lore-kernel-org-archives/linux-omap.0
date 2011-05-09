From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/6] OMAP: H4: Port the display driver to new DSS2
Date: Mon,  9 May 2011 10:36:06 +0300
Message-ID: <1304926567-26814-6-git-send-email-tomi.valkeinen@ti.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39839 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752939Ab1EIHgb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 03:36:31 -0400
Received: by eye13 with SMTP id 13so2147196eye.17
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 00:36:28 -0700 (PDT)
In-Reply-To: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Port the old omapfb panel driver to DSS2. This patch changes the board
file only, the driver is ported in separate patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-h4.c |   41 ++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index bac7933..991e71e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -39,6 +39,8 @@
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
+#include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
 #include "control.h"
@@ -157,17 +159,33 @@ static struct platform_device h4_kp_device = {
 	},
 };
 
-static struct platform_device h4_lcd_device = {
-	.name		= "lcd_h4",
-	.id		= -1,
-};
-
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_flash_device,
 	&h4_kp_device,
+};
+
+static struct panel_generic_dpi_data h4_panel_data = {
+	.name			= "h4",
+};
+
+static struct omap_dss_device h4_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 16,
+	.data			= &h4_panel_data,
+};
+
+static struct omap_dss_device *h4_dss_devices[] = {
 	&h4_lcd_device,
 };
 
+static struct omap_dss_board_info h4_dss_data = {
+	.num_devices	= ARRAY_SIZE(h4_dss_devices),
+	.devices	= h4_dss_devices,
+	.default_device	= &h4_lcd_device,
+};
+
 /* 2420 Sysboot setup (2430 is different) */
 static u32 get_sysboot_value(void)
 {
@@ -271,10 +289,6 @@ static void __init h4_init_flash(void)
 	h4_flash_resource.end	= base + SZ_64M - 1;
 }
 
-static struct omap_lcd_config h4_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct omap_usb_config h4_usb_config __initdata = {
 	/* S1.10 OFF -- usb "download port"
 	 * usb0 switched to Mini-B port and isp1105 transceiver;
@@ -286,10 +300,6 @@ static struct omap_usb_config h4_usb_config __initdata = {
 	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
 };
 
-static struct omap_board_config_kernel h4_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&h4_lcd_config },
-};
-
 static void __init omap_h4_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -331,9 +341,6 @@ static void __init omap_h4_init(void)
 {
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAF);
 
-	omap_board_config = h4_config;
-	omap_board_config_size = ARRAY_SIZE(h4_config);
-
 	/*
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on
@@ -372,6 +379,8 @@ static void __init omap_h4_init(void)
 	omap2_usbfs_init(&h4_usb_config);
 	omap_serial_init();
 	h4_init_flash();
+
+	omap_display_init(&h4_dss_data);
 }
 
 static void __init omap_h4_map_io(void)
-- 
1.7.4.1

