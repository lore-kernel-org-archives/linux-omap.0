From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 5/6] OMAP: H4: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 14:20:47 +0300
Message-ID: <1315826448-27891-6-git-send-email-tomi.valkeinen@ti.com>
References: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55905 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755200Ab1ILLVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:48 -0400
Received: by bkbzu17 with SMTP id zu17so1498682bkb.38
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:09 -0700 (PDT)
In-Reply-To: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Port the old omapfb panel driver to DSS2. This patch changes the board
file only, the driver is ported in separate patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-h4.c |   42 ++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 45de2b3..f7c09de 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -40,6 +40,9 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+
 #include "mux.h"
 #include "control.h"
 
@@ -157,17 +160,33 @@ static struct platform_device h4_kp_device = {
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
@@ -271,10 +290,6 @@ static void __init h4_init_flash(void)
 	h4_flash_resource.end	= base + SZ_64M - 1;
 }
 
-static struct omap_lcd_config h4_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct omap_usb_config h4_usb_config __initdata = {
 	/* S1.10 OFF -- usb "download port"
 	 * usb0 switched to Mini-B port and isp1105 transceiver;
@@ -286,10 +301,6 @@ static struct omap_usb_config h4_usb_config __initdata = {
 	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
 };
 
-static struct omap_board_config_kernel h4_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&h4_lcd_config },
-};
-
 static void __init omap_h4_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -331,9 +342,6 @@ static void __init omap_h4_init(void)
 {
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAF);
 
-	omap_board_config = h4_config;
-	omap_board_config_size = ARRAY_SIZE(h4_config);
-
 	/*
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on
@@ -372,6 +380,8 @@ static void __init omap_h4_init(void)
 	omap2_usbfs_init(&h4_usb_config);
 	omap_serial_init();
 	h4_init_flash();
+
+	omap_display_init(&h4_dss_data);
 }
 
 static void __init omap_h4_map_io(void)
-- 
1.7.4.1

