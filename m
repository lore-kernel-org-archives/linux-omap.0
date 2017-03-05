From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 07/10] drm: omapdrm: plane: update fifo size on atomic update
Date: Sun,  5 Mar 2017 01:43:06 +0100
Message-ID: <20170305004309.28259-7-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is a workaround for a hardware bug occuring on OMAP3
with manually updated panels. Details about the HW bug are
unknown to me, but without this fix the panel refresh does
not work at all on Nokia N950.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c   |  2 ++
 drivers/gpu/drm/omapdrm/dss/omapdss.h |  4 ++++
 drivers/gpu/drm/omapdrm/omap_drv.h    |  1 +
 drivers/gpu/drm/omapdrm/omap_plane.c  | 23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index d956e6266368..97240e59b248 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -1321,6 +1321,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 			plane != OMAP_DSS_WB)
 		dispc_write_reg(DISPC_OVL_PRELOAD(plane), min(high, 0xfffu));
 }
+EXPORT_SYMBOL(dispc_ovl_set_fifo_threshold);
 
 void dispc_enable_fifomerge(bool enable)
 {
@@ -1379,6 +1380,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		*fifo_high = total_fifo_size - buf_unit;
 	}
 }
+EXPORT_SYMBOL(dispc_ovl_compute_fifo_thresholds);
 
 static void dispc_ovl_set_mflag(enum omap_plane plane, bool enable)
 {
diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 5666ecbe4b80..65c3530a3b53 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -878,6 +878,10 @@ void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
 int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool replication, const struct videomode *vm, bool mem_to_mem);
+void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
+		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
+		bool manual_update);
+void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 
 enum omap_dss_output_id dispc_mgr_get_supported_outputs(enum omap_channel channel);
 
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index ee8901dc0381..71b5c5e25ee4 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -146,6 +146,7 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 		u32 possible_crtcs);
 void omap_plane_install_properties(struct drm_plane *plane,
 		struct drm_mode_object *obj);
+void omap_plane_update_fifo(struct drm_plane *plane);
 
 struct drm_encoder *omap_encoder_init(struct drm_device *dev,
 		struct omap_dss_device *dssdev);
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index 386d90af70f7..8d290cfe8925 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -73,6 +73,28 @@ static void omap_plane_cleanup_fb(struct drm_plane *plane,
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
@@ -137,6 +159,7 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	dispc_ovl_enable(omap_plane->id, true);
+	omap_plane_update_fifo(plane);
 }
 
 static void omap_plane_atomic_disable(struct drm_plane *plane,
-- 
2.11.0
