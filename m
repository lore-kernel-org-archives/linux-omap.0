From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/21] ARM: OMAP: Pandora: use new display drivers
Date: Fri, 26 Jul 2013 10:08:21 +0300
Message-ID: <1374822504-28949-19-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37020 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225Ab3GZHJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:50 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for OMAP3 Pandora board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c | 48 +++++++++++++++-----------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index b1547a0..9c2b180 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -231,34 +231,21 @@ static struct twl4030_keypad_data pandora_kp_data = {
 	.rep		= 1,
 };
 
-static struct panel_tpo_td043_data lcd_data = {
-	.nreset_gpio		= 157,
-};
-
-static struct omap_dss_device pandora_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "tpo_td043mtea1_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 24,
-	.data			= &lcd_data,
-};
-
-static struct omap_dss_device pandora_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct connector_atv_platform_data pandora_tv_pdata = {
+	.name = "tv",
+	.source = "venc.0",
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.invert_polarity = false,
 };
 
-static struct omap_dss_device *pandora_dss_devices[] = {
-	&pandora_lcd_device,
-	&pandora_tv_device,
+static struct platform_device pandora_tv_connector_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &pandora_tv_pdata,
 };
 
 static struct omap_dss_board_info pandora_dss_data = {
-	.num_devices	= ARRAY_SIZE(pandora_dss_devices),
-	.devices	= pandora_dss_devices,
-	.default_device	= &pandora_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static void pandora_wl1251_init_card(struct mmc_card *card)
@@ -348,7 +335,7 @@ static struct regulator_consumer_supply pandora_vdds_supplies[] = {
 };
 
 static struct regulator_consumer_supply pandora_vcc_lcd_supply[] = {
-	REGULATOR_SUPPLY("vcc", "display0"),
+	REGULATOR_SUPPLY("vcc", "spi1.1"),
 };
 
 static struct regulator_consumer_supply pandora_usb_phy_supply[] = {
@@ -529,13 +516,21 @@ static int __init omap3pandora_i2c_init(void)
 	return 0;
 }
 
+static struct panel_tpo_td043mtea1_platform_data pandora_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+
+	.data_lines		= 24,
+	.nreset_gpio		= 157,
+};
+
 static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 	{
-		.modalias		= "tpo_td043mtea1_panel_spi",
+		.modalias		= "panel-tpo-td043mtea1",
 		.bus_num		= 1,
 		.chip_select		= 1,
 		.max_speed_hz		= 375000,
-		.platform_data		= &pandora_lcd_device,
+		.platform_data		= &pandora_lcd_pdata,
 	}
 };
 
@@ -580,6 +575,7 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_keys_gpio,
 	&pandora_vwlan_device,
 	&pandora_backlight,
+	&pandora_tv_connector_device,
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-- 
1.8.1.2

