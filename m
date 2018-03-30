From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 4/8] drm/omap: make omap_framebuffer_get_next_connector static
Date: Fri, 30 Mar 2018 19:18:18 +0200
Message-ID: <20180330171822.25896-5-sebastian.reichel@collabora.co.uk>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

omap_framebuffer_get_next_connector() is only required within omap_fb,
so let's make it static. The function had to be moved before the first
(and only) user.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 54 +++++++++++++++++++--------------------
 drivers/gpu/drm/omapdrm/omap_fb.h |  2 --
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index b65212c9a423..3f0b1f976691 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -95,6 +95,33 @@ static void omap_framebuffer_destroy(struct drm_framebuffer *fb)
 	kfree(omap_fb);
 }
 
+/* iterate thru all the connectors, returning ones that are attached
+ * to the same fb..
+ */
+static struct drm_connector *omap_framebuffer_get_next_connector(
+		struct drm_framebuffer *fb, struct drm_connector *from)
+{
+	struct drm_device *dev = fb->dev;
+	struct list_head *connector_list = &dev->mode_config.connector_list;
+	struct drm_connector *connector = from;
+
+	if (!from)
+		return list_first_entry_or_null(connector_list, typeof(*from),
+						head);
+
+	list_for_each_entry_from(connector, connector_list, head) {
+		if (connector != from) {
+			struct drm_encoder *encoder = connector->encoder;
+			struct drm_crtc *crtc = encoder ? encoder->crtc : NULL;
+			if (crtc && crtc->primary->fb == fb)
+				return connector;
+
+		}
+	}
+
+	return NULL;
+}
+
 static int omap_framebuffer_dirty(struct drm_framebuffer *fb,
 				  struct drm_file *file_priv,
 				  unsigned flags, unsigned color,
@@ -329,33 +356,6 @@ void omap_framebuffer_unpin(struct drm_framebuffer *fb)
 	mutex_unlock(&omap_fb->lock);
 }
 
-/* iterate thru all the connectors, returning ones that are attached
- * to the same fb..
- */
-struct drm_connector *omap_framebuffer_get_next_connector(
-		struct drm_framebuffer *fb, struct drm_connector *from)
-{
-	struct drm_device *dev = fb->dev;
-	struct list_head *connector_list = &dev->mode_config.connector_list;
-	struct drm_connector *connector = from;
-
-	if (!from)
-		return list_first_entry_or_null(connector_list, typeof(*from),
-						head);
-
-	list_for_each_entry_from(connector, connector_list, head) {
-		if (connector != from) {
-			struct drm_encoder *encoder = connector->encoder;
-			struct drm_crtc *crtc = encoder ? encoder->crtc : NULL;
-			if (crtc && crtc->primary->fb == fb)
-				return connector;
-
-		}
-	}
-
-	return NULL;
-}
-
 #ifdef CONFIG_DEBUG_FS
 void omap_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
 {
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.h b/drivers/gpu/drm/omapdrm/omap_fb.h
index 94ad5f9e4404..c20cb4bc714d 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.h
+++ b/drivers/gpu/drm/omapdrm/omap_fb.h
@@ -38,8 +38,6 @@ int omap_framebuffer_pin(struct drm_framebuffer *fb);
 void omap_framebuffer_unpin(struct drm_framebuffer *fb);
 void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
 		struct drm_plane_state *state, struct omap_overlay_info *info);
-struct drm_connector *omap_framebuffer_get_next_connector(
-		struct drm_framebuffer *fb, struct drm_connector *from);
 bool omap_framebuffer_supports_rotation(struct drm_framebuffer *fb);
 void omap_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m);
 
-- 
2.16.2
