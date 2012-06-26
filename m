From: Archit Taneja <archit@ti.com>
Subject: [PATCH 17/17] OMAPDSS: DSI: Remove redundant fields in omap_dss_dsi_videomode_data
Date: Tue, 26 Jun 2012 15:06:54 +0530
Message-ID: <1340703414-1915-19-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43440 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756251Ab2FZJjf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:39:35 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The struct omap_dss_dsi_videomode_data holds polaritiy/logic level information
of the DISPC video port signals DE, HSYNC and VSYNC. This information already
exists in the omap_video_timings struct.

Use the fields in omap_video_timings to program VP_DE_POL, VP_HSYNC_POL and
VP_VSYNC_POL in DSI_CTRL. Remove the redundant fields in
omap_dss_dsi_videomode_data.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   11 ++++++++---
 include/video/omapdss.h       |    3 ---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 061bf53..3844430 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3628,13 +3628,18 @@ static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
 static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	int de_pol = dssdev->panel.dsi_vm_data.vp_de_pol;
-	int hsync_pol = dssdev->panel.dsi_vm_data.vp_hsync_pol;
-	int vsync_pol = dssdev->panel.dsi_vm_data.vp_vsync_pol;
+	int de_pol, hsync_pol, vsync_pol;
+	int de_level = dssdev->panel.timings.de_level;
+	int hsync_level = dssdev->panel.timings.hsync_level;
+	int vsync_level = dssdev->panel.timings.vsync_level;
 	bool vsync_end = dssdev->panel.dsi_vm_data.vp_vsync_end;
 	bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
 	u32 r;
 
+	de_pol = de_level == OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
+	hsync_pol = hsync_level == OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
+	vsync_pol = vsync_level == OMAPDSS_SIG_ACTIVE_HIGH ? 1 : 0;
+
 	r = dsi_read_reg(dsidev, DSI_CTRL);
 	r = FLD_MOD(r, de_pol, 9, 9);		/* VP_DE_POL */
 	r = FLD_MOD(r, hsync_pol, 10, 10);	/* VP_HSYNC_POL */
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 1498bb3..f627ad9 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -255,9 +255,6 @@ struct omap_dss_dsi_videomode_data {
 	int hfp_blanking_mode;
 
 	/* Video port sync events */
-	int vp_de_pol;
-	int vp_hsync_pol;
-	int vp_vsync_pol;
 	bool vp_vsync_end;
 	bool vp_hsync_end;
 
-- 
1.7.9.5

