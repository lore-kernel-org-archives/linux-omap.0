From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] drm/omap: update for interlaced
Date: Wed,  5 Sep 2012 16:48:53 -0500
Message-ID: <1346881733-31970-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51072 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab2IEVs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 17:48:56 -0400
Received: by obbuo13 with SMTP id uo13so1253833obb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 14:48:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

'struct omap_video_timings' was updated w/ a 'bool interlaced'.  Without
a matching update in omap_connector, this field could have undefined
values from the stack, which isn't quite ideal.

Update the fxns to convert omapdss<->drm timings structs, and zero-init
'struct omap_video_timings' when it is declared on stack to avoid issues
like this in the future.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_connector.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_connector.c b/drivers/staging/omapdrm/omap_connector.c
index 5e2856c..5f4a89b 100644
--- a/drivers/staging/omapdrm/omap_connector.c
+++ b/drivers/staging/omapdrm/omap_connector.c
@@ -48,13 +48,10 @@ static inline void copy_timings_omap_to_drm(struct drm_display_mode *mode,
 	mode->vsync_end = mode->vsync_start + timings->vsw;
 	mode->vtotal = mode->vsync_end + timings->vbp;
 
-	/* note: whether or not it is interlaced, +/- h/vsync, etc,
-	 * which should be set in the mode flags, is not exposed in
-	 * the omap_video_timings struct.. but hdmi driver tracks
-	 * those separately so all we have to have to set the mode
-	 * is the way to recover these timings values, and the
-	 * omap_dss_driver would do the rest.
-	 */
+	mode->flags = 0;
+
+	if (timings->interlace)
+		mode->flags |= DRM_MODE_FLAG_INTERLACE;
 }
 
 static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
@@ -71,6 +68,8 @@ static inline void copy_timings_drm_to_omap(struct omap_video_timings *timings,
 	timings->vfp = mode->vsync_start - mode->vdisplay;
 	timings->vsw = mode->vsync_end - mode->vsync_start;
 	timings->vbp = mode->vtotal - mode->vsync_end;
+
+	timings->interlace = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
 }
 
 static void omap_connector_dpms(struct drm_connector *connector, int mode)
@@ -187,7 +186,7 @@ static int omap_connector_get_modes(struct drm_connector *connector)
 		}
 	} else {
 		struct drm_display_mode *mode = drm_mode_create(dev);
-		struct omap_video_timings timings;
+		struct omap_video_timings timings = {0};
 
 		dssdrv->get_timings(dssdev, &timings);
 
@@ -291,7 +290,7 @@ void omap_connector_mode_set(struct drm_connector *connector,
 	struct omap_connector *omap_connector = to_omap_connector(connector);
 	struct omap_dss_device *dssdev = omap_connector->dssdev;
 	struct omap_dss_driver *dssdrv = dssdev->driver;
-	struct omap_video_timings timings;
+	struct omap_video_timings timings = {0};
 
 	copy_timings_drm_to_omap(&timings, mode);
 
-- 
1.7.9.5

