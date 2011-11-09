From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH 2/4] omap_dss: add FocalTech ETM070003DH6 display support
Date: Wed,  9 Nov 2011 01:12:46 +0100
Message-ID: <1320797568-11169-3-git-send-email-yanok@emcraft.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:55512 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991Ab1KIANH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 19:13:07 -0500
In-Reply-To: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

Add data for the FocalTech ETM070003DH6 display to the generic_dpi_panel
display driver.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   24 ++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 519c47d..42bfe47 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -297,6 +297,30 @@ static struct panel_config generic_dpi_panels[] = {
 
 		.name			= "apollon",
 	},
+	/* FocalTech ETM070003DH6 */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 480,
+
+			.pixel_clock	= 28000,
+
+			.hsw		= 48,
+			.hfp		= 40,
+			.hbp		= 40,
+
+			.vsw		= 3,
+			.vfp		= 13,
+			.vbp		= 29,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
+		.name			= "focaltech_etm070003dh6",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.6.4

