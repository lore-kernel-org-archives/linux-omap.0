From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 2/2] OMAP: DSS2: Support for Powertip PH480272T
Date: Mon,  2 May 2011 12:29:44 +0200
Message-ID: <1304332184-14687-3-git-send-email-eballetbo@iseebcn.com>
References: <1304332184-14687-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39273 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab1EBK34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 06:29:56 -0400
In-Reply-To: <1304332184-14687-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add support for Powertip PH480242T, a LCD 4.3inch (480x242) display
type with 24-bit RGB interface, to panel-generic-dpi.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index e8819ee..3250a85 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -206,6 +206,31 @@ static struct panel_config generic_dpi_panels[] = {
 		.power_off_delay	= 0,
 		.name			= "70wvw1tz3",
 	},
+
+	/* Powertip PH480272T */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 272,
+
+			.pixel_clock	= 9000,
+
+			.hsw		= 40,
+			.hfp		= 2,
+			.hbp		= 2,
+
+			.vsw		= 10,
+			.vfp		= 2,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "ph480272t",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.0.4

