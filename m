From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCHv2 1/2] OMAP: DSS2: Support for Seiko 70WVW1TZ3
Date: Tue,  3 May 2011 09:07:36 +0200
Message-ID: <1304406457-5109-2-git-send-email-eballetbo@iseebcn.com>
References: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42375 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab1ECHHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 03:07:44 -0400
In-Reply-To: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add support for Seiko 70WVW1TZ3, a LCD 7.0inch WVGA (800x480) display
type with 24-bit RGB interface and Touch-Panel, to panel-generic-dpi

Tested with IGEP v2 board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 4a9b9ff..644d370 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -181,6 +181,31 @@ static struct panel_config generic_dpi_panels[] = {
 		.power_off_delay	= 0,
 		.name			= "samsung_lte430wq_f0c",
 	},
+
+	/* Seiko 70WVW1TZ3Z3 */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 480,
+
+			.pixel_clock	= 33000,
+
+			.hsw		= 128,
+			.hfp		= 10,
+			.hbp		= 10,
+
+			.vsw		= 2,
+			.vfp		= 4,
+			.vbp		= 11,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+						OMAP_DSS_LCD_IHS,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "seiko_70wvw1tz3",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.0.4

