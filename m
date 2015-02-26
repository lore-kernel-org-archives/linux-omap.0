From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/15] OMAPDSS: TFP410: fix input sync signals
Date: Thu, 26 Feb 2015 14:48:58 +0200
Message-ID: <1424954949-12801-4-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60614 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105AbbBZMth (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 07:49:37 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

TFP410 requires that DE is active high and the data and syncs are driven
on rising pixel clock edge. However, at the moment the driver doesn't
request such syncs, and the end result is that the sync settings depend
on default values, which are not right in all cases.

Set the sync values explicitly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
index 92919a74e715..d9048b3df495 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
@@ -114,12 +114,21 @@ static void tfp410_disable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
+static void tfp410_fix_timings(struct omap_video_timings *timings)
+{
+	timings->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
+}
+
 static void tfp410_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
+	tfp410_fix_timings(timings);
+
 	ddata->timings = *timings;
 	dssdev->panel.timings = *timings;
 
@@ -140,6 +149,8 @@ static int tfp410_check_timings(struct omap_dss_device *dssdev,
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
+	tfp410_fix_timings(timings);
+
 	return in->ops.dpi->check_timings(in, timings);
 }
 
-- 
2.3.0

