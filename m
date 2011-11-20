From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH V2] omap_dss: add FocalTech ETM070003DH6 display support
Date: Sun, 20 Nov 2011 19:15:39 +0100
Message-ID: <1321812939-22620-1-git-send-email-yanok@emcraft.com>
References: <1321525575.1919.78.camel@deskari>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34603 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab1KTSPr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Nov 2011 13:15:47 -0500
In-Reply-To: <1321525575.1919.78.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

Add data for the FocalTech ETM070003DH6 display to the generic_dpi_panel
display driver.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
Changes from V1:
 - acb, acbi, power_on_delay and power_off_delay fields removed.

 drivers/video/omap2/displays/panel-generic-dpi.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 519c47d..593f831 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -297,6 +297,26 @@ static struct panel_config generic_dpi_panels[] = {
 
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
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS,
+		.name			= "focaltech_etm070003dh6",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.6.4

