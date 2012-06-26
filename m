From: Archit Taneja <archit@ti.com>
Subject: [PATCH 14/17] OMAPFB: Map interlace field in omap_video_timings with fb vmode flags
Date: Tue, 26 Jun 2012 15:06:51 +0530
Message-ID: <1340703414-1915-16-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43304 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756180Ab2FZJjW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:39:22 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Use the interlace field in omap_video_timings to configure/retrieve
corresponding fb mode flags in fb_var_screeninfo and fb_videomode.

The interlace field maps with the fb mode flags FB_VMODE_INTERLACED and
FB_VMODE_NONINTERLACED.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 7c99725..434aa9a 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -737,6 +737,8 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 				FB_SYNC_HOR_HIGH_ACT : 0;
 		var->sync |= timings.vsync_level == OMAPDSS_SIG_ACTIVE_HIGH ?
 				FB_SYNC_VERT_HIGH_ACT : 0;
+		var->vmode = timings.interlace ?
+				FB_VMODE_INTERLACED : FB_VMODE_NONINTERLACED;
 	} else {
 		var->pixclock = 0;
 		var->left_margin = 0;
@@ -746,11 +748,9 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 		var->hsync_len = 0;
 		var->vsync_len = 0;
 		var->sync = 0;
+		var->vmode = FB_VMODE_NONINTERLACED;
 	}
 
-	/* TODO: get these from panel->config */
-	var->vmode              = FB_VMODE_NONINTERLACED;
-
 	return 0;
 }
 
@@ -2063,6 +2063,7 @@ static int omapfb_mode_to_timings(const char *mode_str,
 	timings->vsync_level = var->sync & FB_SYNC_VERT_HIGH_ACT ?
 				OMAPDSS_SIG_ACTIVE_HIGH :
 				OMAPDSS_SIG_ACTIVE_LOW;
+	timings->interlace = var->vmode & FB_VMODE_INTERLACED;
 	timings->pclk_edge = OMAPDSS_SIG_ACTIVE_HIGH;
 	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	timings->hsync_vsync_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
@@ -2206,6 +2207,7 @@ static void fb_videomode_to_omap_timings(struct fb_videomode *m,
 	t->vsync_level = m->sync & FB_SYNC_VERT_HIGH_ACT ?
 				OMAPDSS_SIG_ACTIVE_HIGH :
 				OMAPDSS_SIG_ACTIVE_LOW;
+	t->interlace = m->vmode & FB_VMODE_INTERLACED;
 	t->pclk_edge = OMAPDSS_SIG_ACTIVE_HIGH;
 	t->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	t->hsync_vsync_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
-- 
1.7.9.5

