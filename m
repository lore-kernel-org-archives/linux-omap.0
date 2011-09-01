From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 1/3] OMAP: DSS2: Support for Innolux AT070TN83
Date: Thu,  1 Sep 2011 15:05:07 +0200
Message-ID: <1314882308-25915-1-git-send-email-weber@corscience.de>
References: <1314859332.1933.4.camel@deskari>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59482 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab1IANFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 09:05:40 -0400
In-Reply-To: <1314859332.1933.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add support for Innolux AT070TN83, a 7 inch LCD
with RGB-Interface and touch panel to panel-generic-dpi.

Tested with Devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 9c90f75..b401304 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -232,6 +232,31 @@ static struct panel_config generic_dpi_panels[] = {
 		.power_off_delay	= 0,
 		.name			= "powertip_ph480272t",
 	},
+
+	/* Innolux AT070TN83 */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 480,
+
+			.pixel_clock	= 40000,
+
+			.hsw		= 48,
+			.hfp		= 1,
+			.hbp		= 1,
+
+			.vsw		= 3,
+			.vfp		= 12,
+			.vbp		= 25,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "innolux_at070tn83",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.6.1

