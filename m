From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 2/2] OMAP2: DSS: Add EDT ET0500G0DH6 display support
Date: Fri, 17 Feb 2012 13:41:59 +0100
Message-ID: <1329482519-12722-2-git-send-email-weber@corscience.de>
References: <1329482519-12722-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53705 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab2BQMm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 07:42:59 -0500
In-Reply-To: <1329482519-12722-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

The EDT ET0500G0DH6 is a 5 inch display. It is
tested on an OMAP3 board.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 708391f..78409c2 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -381,6 +381,24 @@ static struct panel_config generic_dpi_panels[] = {
 		.config			= OMAP_DSS_LCD_TFT,
 		.name			= "mitsubishi_aa084sb01",
 	},
+	/* EDT ET0500G0DH6 */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 480,
+			.pixel_clock	= 33260,
+
+			.hsw		= 128,
+			.hfp		= 216,
+			.hbp		= 40,
+
+			.vsw		= 2,
+			.vfp		= 35,
+			.vbp		= 10,
+		},
+		.config			= OMAP_DSS_LCD_TFT,
+		.name			= "edt_et0500g0dh6",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.8.4

