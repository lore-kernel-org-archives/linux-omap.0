From: Archit Taneja <archit@ti.com>
Subject: [PATCH 15/17] OMAPDRM: Map interlace field in omap_video_timings with drm mode flags
Date: Tue, 26 Jun 2012 15:06:52 +0530
Message-ID: <1340703414-1915-17-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43428 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756180Ab2FZJjZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:39:25 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Use the interlace field in omap_video_timings to configure/retrieve
corresponding flags in drm_display_mode.

The interlace field maps with the drm mode flag DRM_MODE_FLAG_INTERLACE.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/staging/omapdrm/omap_connector.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
index 157f6ec..05dda41 100644
--- a/drivers/staging/omapdrm/omap_connector.c
+++ b/drivers/staging/omapdrm/omap_connector.c
@@ -53,6 +53,8 @@ static inline void copy_timings_omap_to_drm(struct drm_display_mode *mode,
 
 	mode->flags |= timings->vsync_level == OMAPDSS_SIG_ACTIVE_HIGH ?
 			DRM_MODE_FLAG_PVSYNC : DRM_MODE_FLAG_NVSYNC;
+
+	mode->flags |= timings->interlace ? DRM_MODE_FLAG_INTERLACE : 0;
 }
 
 static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
@@ -76,6 +78,9 @@ static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
 	timings->vsync_level = mode->flags & DRM_MODE_FLAG_PVSYNC ?
 			OMAPDSS_SIG_ACTIVE_HIGH : OMAPDSS_SIG_ACTIVE_LOW;
 
+	timings->interlace = mode->flags & DRM_MODE_FLAG_INTERLACE ?
+			true : false;
+
 	timings->pclk_edge = OMAPDSS_SIG_ACTIVE_HIGH;
 	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	timings->hsync_vsync_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
-- 
1.7.9.5

