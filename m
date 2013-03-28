From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/28] ARM: OMAP: Panda: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:04 +0200
Message-ID: <1364474962-20439-11-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55077 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab3C1Mt5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:57 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 135fdd8..fac4b3e 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -25,6 +25,7 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
@@ -42,19 +43,18 @@
 /* Display DVI */
 #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
 
-/* Using generic display panel */
-static struct tfp410_platform_data omap4_dvi_panel = {
+static struct tfp410_platform_data omap4_tfp410_pdata = {
+	.name			= "dvi",
+	.source			= "dpi.0",
 	.i2c_bus_num		= 3,
+	.data_lines		= 24,
 	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
 };
 
-static struct omap_dss_device omap4_panda_dvi_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "dvi",
-	.driver_name		= "tfp410",
-	.data			= &omap4_dvi_panel,
-	.phy.dpi.data_lines	= 24,
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
+static struct platform_device omap4_panda_tfp410_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &omap4_tfp410_pdata,
 };
 
 static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
@@ -72,19 +72,19 @@ static struct omap_dss_device  omap4_panda_hdmi_device = {
 };
 
 static struct omap_dss_device *omap4_panda_dss_devices[] = {
-	&omap4_panda_dvi_device,
 	&omap4_panda_hdmi_device,
 };
 
 static struct omap_dss_board_info omap4_panda_dss_data = {
 	.num_devices	= ARRAY_SIZE(omap4_panda_dss_devices),
 	.devices	= omap4_panda_dss_devices,
-	.default_device	= &omap4_panda_dvi_device,
+	.default_display_name = "dvi",
 };
 
 void __init omap4_panda_display_init(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
+	platform_device_register(&omap4_panda_tfp410_device);
 
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
@@ -103,6 +103,7 @@ void __init omap4_panda_display_init(void)
 void __init omap4_panda_display_init_of(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
+	platform_device_register(&omap4_panda_tfp410_device);
 }
 
 
-- 
1.7.10.4

