From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 2/2] ARM: OMAP: igep0020: use display init from dss-common
Date: Wed,  9 Oct 2013 11:19:19 +0200
Message-ID: <1381310359-20668-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1381310359-20668-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42137 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab3JIJU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 05:20:26 -0400
In-Reply-To: <1381310359-20668-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomy Valkeinen <tomi.valkeinen@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Now that display information and setup is made from dss-common
there is no need to have this code in the board file.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v2:
 - None, this is a new patch added for v3.

 arch/arm/mach-omap2/board-igep0020.c | 41 +++---------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 06dbb2d..d648d50 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -43,6 +43,7 @@
 #include "board-flash.h"
 #include "control.h"
 #include "gpmc-onenand.h"
+#include "dss-common.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
@@ -50,7 +51,6 @@
 #define IGEP2_GPIO_LED0_GREEN   26
 #define IGEP2_GPIO_LED0_RED     27
 #define IGEP2_GPIO_LED1_RED     28
-#define IGEP2_GPIO_DVI_PUP      170
 
 #define IGEP2_RB_GPIO_WIFI_NPD     94
 #define IGEP2_RB_GPIO_WIFI_NRESET  95
@@ -429,41 +429,6 @@ static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 	.setup		= igep_twl_gpio_setup,
 };
 
-static struct connector_dvi_platform_data omap3stalker_dvi_connector_pdata = {
-	.name                   = "dvi",
-	.source                 = "tfp410.0",
-	.i2c_bus_num            = 3,
-};
-
-static struct platform_device omap3stalker_dvi_connector_device = {
-	.name                   = "connector-dvi",
-	.id                     = 0,
-	.dev.platform_data      = &omap3stalker_dvi_connector_pdata,
-};
-
-static struct encoder_tfp410_platform_data omap3stalker_tfp410_pdata = {
-	.name                   = "tfp410.0",
-	.source                 = "dpi.0",
-	.data_lines             = 24,
-	.power_down_gpio        = IGEP2_GPIO_DVI_PUP,
-};
-
-static struct platform_device omap3stalker_tfp410_device = {
-	.name                   = "tfp410",
-	.id                     = 0,
-	.dev.platform_data      = &omap3stalker_tfp410_pdata,
-};
-
-static struct omap_dss_board_info igep2_dss_data = {
-	.default_display_name = "dvi",
-};
-
-static struct platform_device *igep_devices[] __initdata = {
-	&igep_vwlan_device,
-	&omap3stalker_tfp410_device,
-	&omap3stalker_dvi_connector_device,
-};
-
 static int igep2_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -663,7 +628,8 @@ static void __init igep_init(void)
 
 	/* Register I2C busses and drivers */
 	igep_i2c_init();
-	platform_add_devices(igep_devices, ARRAY_SIZE(igep_devices));
+	platform_device_register(&igep_vwlan_device);
+	omap3_igep2_display_init_of();
 	omap_serial_init();
 	omap_sdrc_init(m65kxxxxam_sdrc_params,
 				  m65kxxxxam_sdrc_params);
@@ -681,7 +647,6 @@ static void __init igep_init(void)
 	igep_wlan_bt_init();
 
 	if (machine_is_igep0020()) {
-		omap_display_init(&igep2_dss_data);
 		igep2_init_smsc911x();
 		usbhs_init_phys(igep2_phy_data, ARRAY_SIZE(igep2_phy_data));
 		usbhs_init(&igep2_usbhs_bdata);
-- 
1.8.4.rc3

