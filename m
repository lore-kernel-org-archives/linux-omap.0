From: Archit Taneja <archit@ti.com>
Subject: [PATCH 10/11] OMAPDSS: panel acx565akm: remove omap_dss_device maximum backlight level usage
Date: Wed, 13 Feb 2013 19:37:13 +0530
Message-ID: <1360764434-18788-11-git-send-email-archit@ti.com>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55823 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934052Ab3BMOIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:08:24 -0500
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The omap_dss_device structs's max_backlight_level is used to pass maximum
backlight level for the platform. However, no board file using this panel
populates this field. Therefore, we remove it's usage from the panel driver.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index a980a11..a8fb26b 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -555,10 +555,7 @@ static int acx_panel_probe(struct omap_dss_device *dssdev)
 		md->cabc_mode = get_hw_cabc_mode(md);
 	}
 
-	if (md->has_bc)
-		max_brightness = 255;
-	else
-		max_brightness = dssdev->max_backlight_level;
+	max_brightness = 255;
 
 	if (md->has_bc)
 		brightness = acx565akm_get_actual_brightness(md);
-- 
1.7.9.5

