From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 12/23] drm: omapdrm: plane: update fifo size on atomic update
Date: Tue,  8 Mar 2016 17:39:44 +0100
Message-ID: <1457455195-1938-13-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is a workaround for a hardware bug occuring
on OMAP3 with manually updated panels.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_drv.h   |  1 +
 drivers/gpu/drm/omapdrm/omap_plane.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 71e2c2284b86..3ab4919aff4b 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -161,6 +161,7 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 		int id, enum drm_plane_type type);
 void omap_plane_install_properties(struct drm_plane *plane,
 		struct drm_mode_object *obj);
+void omap_plane_update_fifo(struct drm_plane *plane);
 
 struct drm_encoder *omap_encoder_init(struct drm_device *dev,
 		struct omap_dss_device *dssdev);
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index d75b197eff46..0147e416140c 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -75,6 +75,28 @@ static void omap_plane_cleanup_fb(struct drm_plane *plane,
 		omap_framebuffer_unpin(old_state->fb);
 }
 
+void omap_plane_update_fifo(struct drm_plane *plane)
+{
+	struct omap_plane *omap_plane = to_omap_plane(plane);
+	struct drm_plane_state *state = plane->state;
+	struct drm_device *dev = plane->dev;
+	bool use_fifo_merge = false;
+	u32 fifo_low, fifo_high;
+	bool use_manual_update;
+
+	if (!dispc_ovl_enabled(omap_plane->id))
+		return;
+
+	use_manual_update = omap_crtc_is_manual_updated(state->crtc);
+
+	dispc_ovl_compute_fifo_thresholds(omap_plane->id, &fifo_low, &fifo_high,
+			use_fifo_merge, use_manual_update);
+
+	dev_dbg(dev->dev, "update fifo: %d %d", fifo_low, fifo_high);
+
+	dispc_ovl_set_fifo_threshold(omap_plane->id, fifo_low, fifo_high);
+}
+
 static void omap_plane_atomic_update(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
@@ -141,6 +163,7 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	dispc_ovl_enable(omap_plane->id, true);
+	omap_plane_update_fifo(plane);
 }
 
 static void omap_plane_atomic_disable(struct drm_plane *plane,
-- 
2.7.0
