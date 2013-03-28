From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/28] ARM: OMAP: CM-T35: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:12 +0200
Message-ID: <1364474962-20439-19-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44569 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab3C1MuJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:09 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mike Rapoport <mike@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 1b34c96..4f23be0 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -294,20 +294,20 @@ static void __init cm_t35_init_display(void)
 #define CM_T35_DVI_EN_GPIO 54
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.power_down_gpio	= CM_T35_DVI_EN_GPIO,
 	.i2c_bus_num		= -1,
 };
 
-static struct omap_dss_device cm_t35_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct platform_device cm_t35_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_device *cm_t35_dss_devices[] = {
-	&cm_t35_dvi_device,
 	&cm_t35_tv_device,
 };
 
@@ -321,6 +321,8 @@ static void __init cm_t35_init_display(void)
 {
 	int err;
 
+	platform_device_register(&cm_t35_dvi_device);
+
 	err = omap_display_init(&cm_t35_dss_data);
 	if (err)
 		pr_err("CM-T35: failed to register DSS device\n");
-- 
1.7.10.4

