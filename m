From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/28] ARM: OMAP: Devkit8000: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:11 +0200
Message-ID: <1364474962-20439-18-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57266 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab3C1MuG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:50:06 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e90808c..d05f069 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -163,20 +163,20 @@ static struct omap_dss_board_info devkit8000_dss_data = {
 #elif defined(CONFIG_MACH_DEVKIT8000_EXPANSION_DVI)
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.power_down_gpio	= -1,
 	.i2c_bus_num		= 1,
 };
 
-static struct omap_dss_device devkit8000_dvi_device = {
-	.name                   = "dvi",
-	.type                   = OMAP_DISPLAY_TYPE_DPI,
-	.driver_name            = "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines     = 24,
+static struct platform_device devkit8000_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_device *devkit8000_dss_devices[] = {
-	&devkit8000_dvi_device,
 	&devkit8000_tv_device,
 };
 
@@ -452,6 +452,9 @@ static struct platform_device *devkit8000_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
 	&omap_dm9000_dev,
+#if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_DVI)
+	&devkit8000_dvi_device,
+#endif
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-- 
1.7.10.4

