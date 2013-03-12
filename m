From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 3/4] drm/omap: Make fixed resolution panels work
Date: Tue, 12 Mar 2013 18:36:23 +0530
Message-ID: <1363093583-28285-1-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43491 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932183Ab3CLNHW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 09:07:22 -0400
In-Reply-To: <1362493070-17706-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, Archit Taneja <archit@ti.com>

The omapdrm driver requires omapdss panel drivers to expose ops like detect,
set_timings and check_timings. These can be NULL for fixed panel DPI, DBI, DSI
and SDI drivers. At some places, there are no checks to see if the panel driver
has these ops or not, and that leads to a crash.

The following things are done to make fixed panels work:

- The omap_connector's detect function is modified such that it considers panel
  types which are generally fixed panels as always connected(provided the panel
  driver doesn't have a detect op). Hence, the connector corresponding to these
  panels is always in a 'connected' state.

- If a panel driver doesn't have a check_timings op, assume that it supports the
  mode passed to omap_connector_mode_valid(the 'mode_valid' drm helper function)

- The function omap_encoder_update shouldn't really do anything for fixed
  resolution panels, make sure that it calls set_timings only if the panel
  driver has one.

Signed-off-by: Archit Taneja <archit@ti.com>
---
Note: In v2, we make sure that the mode passed on to omapdrm matches the timings
of the fixed resolution panel.

 drivers/gpu/drm/omapdrm/omap_connector.c |   27 +++++++++++++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_encoder.c   |   17 +++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index c451c41..a72fedd 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -110,6 +110,11 @@ static enum drm_connector_status omap_connector_detect(
 			ret = connector_status_connected;
 		else
 			ret = connector_status_disconnected;
+	} else if (dssdev->type == OMAP_DISPLAY_TYPE_DPI ||
+			dssdev->type == OMAP_DISPLAY_TYPE_DBI ||
+			dssdev->type == OMAP_DISPLAY_TYPE_SDI ||
+			dssdev->type == OMAP_DISPLAY_TYPE_DSI) {
+		ret = connector_status_connected;
 	} else {
 		ret = connector_status_unknown;
 	}
@@ -189,12 +194,30 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
 	struct omap_video_timings timings = {0};
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *new_mode;
-	int ret = MODE_BAD;
+	int r, ret = MODE_BAD;
 
 	copy_timings_drm_to_omap(&timings, mode);
 	mode->vrefresh = drm_mode_vrefresh(mode);
 
-	if (!dssdrv->check_timings(dssdev, &timings)) {
+	/*
+	 * if the panel driver doesn't have a check_timings, it's most likely
+	 * a fixed resolution panel, check if the timings match with the
+	 * panel's timings
+	 */
+	if (dssdrv->check_timings) {
+		r = dssdrv->check_timings(dssdev, &timings);
+	} else {
+		struct omap_video_timings t;
+
+		dssdrv->get_timings(dssdev, &t);
+
+		if (memcmp(&timings, &t, sizeof(struct omap_video_timings)))
+			r = -EINVAL;
+		else
+			r = 0;
+	}
+
+	if (!r) {
 		/* check if vrefresh is still valid */
 		new_mode = drm_mode_duplicate(dev, mode);
 		new_mode->clock = timings.pixel_clock;
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index d48df71..47971c2 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -135,13 +135,26 @@ int omap_encoder_update(struct drm_encoder *encoder,
 
 	dssdev->output->manager = mgr;
 
-	ret = dssdrv->check_timings(dssdev, timings);
+	if (dssdrv->check_timings) {
+		ret = dssdrv->check_timings(dssdev, timings);
+	} else {
+		struct omap_video_timings t;
+
+		dssdrv->get_timings(dssdev, &t);
+
+		if (memcmp(timings, &t, sizeof(struct omap_video_timings)))
+			ret = -EINVAL;
+		else
+			ret = 0;
+	}
+
 	if (ret) {
 		dev_err(dev->dev, "could not set timings: %d\n", ret);
 		return ret;
 	}
 
-	dssdrv->set_timings(dssdev, timings);
+	if (dssdrv->set_timings)
+		dssdrv->set_timings(dssdev, timings);
 
 	return 0;
 }
-- 
1.7.10.4

