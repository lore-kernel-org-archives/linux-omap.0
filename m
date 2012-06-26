From: Archit Taneja <archit@ti.com>
Subject: [PATCH 10/17] OMAPDRM: Map the newly added omap_video_timings fields with drm mode flags
Date: Tue, 26 Jun 2012 15:06:47 +0530
Message-ID: <1340703414-1915-12-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41558 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab2FZJjF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:39:05 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Use the newly added fields in omap_video_timings(hsync, vsync and data_enable
logic levels and data, hsync and vsync latching related info) to
configure/retrieve corresponding drm mode flags in drm_display_mode.

Out of the new fields, hsync_level and vsync_level can be mapped to the drm mode
flags DRM_MODE_FLAG_PHSYNC, DRM_MODE_FLAG_NHSYNC, DRM_MODE_FLAG_PVSYNC and
DRM_MODE_FLAG_NVSYNC

When converting drm mode to omap_video_timings, the fields which don't have an
equivalent parameter in drm mode are set to the default values.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/staging/omapdrm/omap_connector.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
index 5e2856c..157f6ec 100644
--- a/drivers/staging/omapdrm/omap_connector.c
+++ b/drivers/staging/omapdrm/omap_connector.c
@@ -48,13 +48,11 @@ static inline void copy_timings_omap_to_drm(struct drm_display_mode *mode,
 	mode->vsync_end = mode->vsync_start + timings->vsw;
 	mode->vtotal = mode->vsync_end + timings->vbp;
 
-	/* note: whether or not it is interlaced, +/- h/vsync, etc,
-	 * which should be set in the mode flags, is not exposed in
-	 * the omap_video_timings struct.. but hdmi driver tracks
-	 * those separately so all we have to have to set the mode
-	 * is the way to recover these timings values, and the
-	 * omap_dss_driver would do the rest.
-	 */
+	mode->flags |= timings->hsync_level == OMAPDSS_SIG_ACTIVE_HIGH ?
+			DRM_MODE_FLAG_PHSYNC : DRM_MODE_FLAG_NHSYNC;
+
+	mode->flags |= timings->vsync_level == OMAPDSS_SIG_ACTIVE_HIGH ?
+			DRM_MODE_FLAG_PVSYNC : DRM_MODE_FLAG_NVSYNC;
 }
 
 static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
@@ -71,6 +69,16 @@ static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
 	timings->vfp = mode->vsync_start - mode->vdisplay;
 	timings->vsw = mode->vsync_end - mode->vsync_start;
 	timings->vbp = mode->vtotal - mode->vsync_end;
+
+	timings->hsync_level = mode->flags & DRM_MODE_FLAG_PHSYNC ?
+			OMAPDSS_SIG_ACTIVE_HIGH : OMAPDSS_SIG_ACTIVE_LOW;
+
+	timings->vsync_level = mode->flags & DRM_MODE_FLAG_PVSYNC ?
+			OMAPDSS_SIG_ACTIVE_HIGH : OMAPDSS_SIG_ACTIVE_LOW;
+
+	timings->pclk_edge = OMAPDSS_SIG_ACTIVE_HIGH;
+	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	timings->hsync_vsync_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 }
 
 static void omap_connector_dpms(struct drm_connector *connector, int mode)
-- 
1.7.9.5

