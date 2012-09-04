From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 2/2] drm/omap: invert dimensions on crtc when rotated
Date: Tue,  4 Sep 2012 11:36:20 -0500
Message-ID: <1346776580-13136-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33741 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357Ab2IDQgZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 12:36:25 -0400
Received: by ghrr11 with SMTP id r11so1286386ghr.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 09:36:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

If rotated 90 or 270, we need to invert the dimensions used by drm
core for calculating if the dimensions of an attached fb are correct.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_crtc.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
index 98a10bc..dade3de 100644
--- a/drivers/staging/omapdrm/omap_crtc.c
+++ b/drivers/staging/omapdrm/omap_crtc.c
@@ -195,6 +195,13 @@ static int omap_crtc_set_property(struct drm_crtc *crtc,
 		struct drm_property *property, uint64_t val)
 {
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct omap_drm_private *priv = crtc->dev->dev_private;
+
+	if (property == priv->rotation_prop) {
+		crtc->invert_dimensions =
+				!!(val & ((1LL << DRM_ROTATE_90) | (1LL << DRM_ROTATE_270)));
+	}
+
 	return omap_plane_set_property(omap_crtc->plane, property, val);
 }
 
-- 
1.7.9.5

