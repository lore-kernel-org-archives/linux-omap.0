From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] drm/omap: add more new timings fields
Date: Fri,  7 Sep 2012 12:59:45 -0500
Message-ID: <1347040786-29156-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47471 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab2IGSAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 14:00:04 -0400
Received: by obbuo13 with SMTP id uo13so5101505obb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 11:00:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Without these, DVI is broken.

Signed-off-by: Rob Clark <rob@ti.com>
---
Greg, it looks like the omapdss changes which added these fields, as
well as the interlaced field, where merged in Linux 3.5-rc5.  So I
think both this and the 'update for interlaced' patch are needed for
both 3.6 and 3.5.

 drivers/staging/omapdrm/omap_connector.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
index 5f4a89b..55e9c86 100644
--- a/drivers/staging/omapdrm/omap_connector.c
+++ b/drivers/staging/omapdrm/omap_connector.c
@@ -52,6 +52,16 @@ static inline void copy_timings_omap_to_drm(struct drm_display_mode *mode,
 
 	if (timings->interlace)
 		mode->flags |= DRM_MODE_FLAG_INTERLACE;
+
+	if (timings->hsync_level == OMAPDSS_SIG_ACTIVE_HIGH)
+		mode->flags |= DRM_MODE_FLAG_PHSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_NHSYNC;
+
+	if (timings->vsync_level == OMAPDSS_SIG_ACTIVE_HIGH)
+		mode->flags |= DRM_MODE_FLAG_PVSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_NVSYNC;
 }
 
 static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
@@ -70,6 +80,20 @@ static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
 	timings->vbp = mode->vtotal - mode->vsync_end;
 
 	timings->interlace = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
+
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		timings->hsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	else
+		timings->hsync_level = OMAPDSS_SIG_ACTIVE_LOW;
+
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		timings->vsync_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	else
+		timings->vsync_level = OMAPDSS_SIG_ACTIVE_LOW;
+
+	timings->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 }
 
 static void omap_connector_dpms(struct drm_connector *connector, int mode)
-- 
1.7.9.5

