From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/27] drm/omap: DVI connector fix
Date: Thu, 30 May 2013 12:36:02 +0300
Message-ID: <1369906580-27585-10-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030420Ab3E3JhA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:37:00 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The omapdrm driver currently uses a string comparison to find out if the
display is a DVI display. This is not reliable, and as we now have a
specific display type for DVI, let's use that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 4c0bc40..8949246 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -65,10 +65,8 @@ static int get_connector_type(struct omap_dss_device *dssdev)
 	switch (dssdev->type) {
 	case OMAP_DISPLAY_TYPE_HDMI:
 		return DRM_MODE_CONNECTOR_HDMIA;
-	case OMAP_DISPLAY_TYPE_DPI:
-		if (!strcmp(dssdev->name, "dvi"))
-			return DRM_MODE_CONNECTOR_DVID;
-		/* fallthrough */
+	case OMAP_DISPLAY_TYPE_DVI:
+		return DRM_MODE_CONNECTOR_DVID;
 	default:
 		return DRM_MODE_CONNECTOR_Unknown;
 	}
-- 
1.8.1.2

