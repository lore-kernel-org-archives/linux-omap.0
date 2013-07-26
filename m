From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/21] ARM: OMAP: omap3stalker: use new display drivers
Date: Fri, 26 Jul 2013 10:08:15 +0300
Message-ID: <1374822504-28949-13-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38930 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225Ab3GZHJj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:39 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for OMAP3 Stalker board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3stalker.c | 61 +++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index d37e6b1..ba8342f 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -93,40 +93,50 @@ static void __init omap3_stalker_display_init(void)
 {
 	return;
 }
+static struct connector_dvi_platform_data omap3stalker_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = -1,
+};
 
-static struct omap_dss_device omap3_stalker_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
-	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
-#endif
+static struct platform_device omap3stalker_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &omap3stalker_dvi_connector_pdata,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= DSS_ENABLE_GPIO,
-	.i2c_bus_num		= -1,
+static struct encoder_tfp410_platform_data omap3stalker_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = DSS_ENABLE_GPIO,
 };
 
-static struct omap_dss_device omap3_stalker_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct platform_device omap3stalker_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &omap3stalker_tfp410_pdata,
+};
+
+static struct connector_atv_platform_data omap3stalker_tv_pdata = {
+	.name = "tv",
+	.source = "venc.0",
+#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
+	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
+#endif
+	.invert_polarity = false,
 };
 
-static struct omap_dss_device *omap3_stalker_dss_devices[] = {
-	&omap3_stalker_tv_device,
-	&omap3_stalker_dvi_device,
+static struct platform_device omap3stalker_tv_connector_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &omap3stalker_tv_pdata,
 };
 
 static struct omap_dss_board_info omap3_stalker_dss_data = {
-	.num_devices	= ARRAY_SIZE(omap3_stalker_dss_devices),
-	.devices	= omap3_stalker_dss_devices,
-	.default_device	= &omap3_stalker_dvi_device,
+	.default_display_name = "dvi",
 };
 
 static struct regulator_consumer_supply omap3stalker_vmmc1_supply[] = {
@@ -356,6 +366,9 @@ static struct usbhs_phy_data phy_data[] __initdata = {
 
 static struct platform_device *omap3_stalker_devices[] __initdata = {
 	&keys_gpio,
+	&omap3stalker_tfp410_device,
+	&omap3stalker_dvi_connector_device,
+	&omap3stalker_tv_connector_device,
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-- 
1.8.1.2

