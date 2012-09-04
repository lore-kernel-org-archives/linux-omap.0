From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 1/2] drm: support for rotated scanout
Date: Tue,  4 Sep 2012 11:35:56 -0500
Message-ID: <1346776556-13098-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Rob Clark <rob@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Rob Clark <rob@ti.com>

For drivers that can support rotated scanout, the extra parameter
checking in drm-core, while nice, tends to get confused.  To solve
this drivers can set the crtc or plane invert_dimensions field so
that the dimension checking takes into account the rotation that
the driver is performing.

v1: original
v2: remove invert_dimensions from plane, at Ville's suggestion.
    Userspace can give rotated src coordinates, so invert_dimensions
    is not required for planes.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/gpu/drm/drm_crtc.c |   46 +++++++++++++++++++++++++++++---------------
 include/drm/drm_crtc.h     |    5 +++++
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 08a7aa7..901de9a 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -377,6 +377,7 @@ int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	crtc->dev = dev;
 	crtc->funcs = funcs;
+	crtc->invert_dimensions = false;
 
 	mutex_lock(&dev->mode_config.mutex);
 
@@ -1852,6 +1853,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	DRM_DEBUG_KMS("[CRTC:%d]\n", crtc->base.id);
 
 	if (crtc_req->mode_valid) {
+		int hdisplay, vdisplay;
 		/* If we have a mode we need a framebuffer. */
 		/* If we pass -1, set the mode with the currently bound fb */
 		if (crtc_req->fb_id == -1) {
@@ -1887,14 +1889,20 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 
 		drm_mode_set_crtcinfo(mode, CRTC_INTERLACE_HALVE_V);
 
-		if (mode->hdisplay > fb->width ||
-		    mode->vdisplay > fb->height ||
-		    crtc_req->x > fb->width - mode->hdisplay ||
-		    crtc_req->y > fb->height - mode->vdisplay) {
-			DRM_DEBUG_KMS("Invalid CRTC viewport %ux%u+%u+%u for fb size %ux%u.\n",
-				      mode->hdisplay, mode->vdisplay,
-				      crtc_req->x, crtc_req->y,
-				      fb->width, fb->height);
+		hdisplay = mode->hdisplay;
+		vdisplay = mode->vdisplay;
+
+		if (crtc->invert_dimensions)
+			swap(hdisplay, vdisplay);
+
+		if (hdisplay > fb->width ||
+		    vdisplay > fb->height ||
+		    crtc_req->x > fb->width - hdisplay ||
+		    crtc_req->y > fb->height - vdisplay) {
+			DRM_DEBUG_KMS("Invalid fb size %ux%u for CRTC viewport %ux%u+%d+%d%s.\n",
+				      fb->width, fb->height,
+				      hdisplay, vdisplay, crtc_req->x, crtc_req->y,
+				      crtc->invert_dimensions ? " (inverted)" : "");
 			ret = -ENOSPC;
 			goto out;
 		}
@@ -3489,6 +3497,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 	struct drm_framebuffer *fb;
 	struct drm_pending_vblank_event *e = NULL;
 	unsigned long flags;
+	int hdisplay, vdisplay;
 	int ret = -EINVAL;
 
 	if (page_flip->flags & ~DRM_MODE_PAGE_FLIP_FLAGS ||
@@ -3518,14 +3527,19 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 		goto out;
 	fb = obj_to_fb(obj);
 
-	if (crtc->mode.hdisplay > fb->width ||
-	    crtc->mode.vdisplay > fb->height ||
-	    crtc->x > fb->width - crtc->mode.hdisplay ||
-	    crtc->y > fb->height - crtc->mode.vdisplay) {
-		DRM_DEBUG_KMS("Invalid fb size %ux%u for CRTC viewport %ux%u+%d+%d.\n",
-			      fb->width, fb->height,
-			      crtc->mode.hdisplay, crtc->mode.vdisplay,
-			      crtc->x, crtc->y);
+	hdisplay = crtc->mode.hdisplay;
+	vdisplay = crtc->mode.vdisplay;
+
+	if (crtc->invert_dimensions)
+		swap(hdisplay, vdisplay);
+
+	if (hdisplay > fb->width ||
+	    vdisplay > fb->height ||
+	    crtc->x > fb->width - hdisplay ||
+	    crtc->y > fb->height - vdisplay) {
+		DRM_DEBUG_KMS("Invalid fb size %ux%u for CRTC viewport %ux%u+%d+%d%s.\n",
+			      fb->width, fb->height, hdisplay, vdisplay, crtc->x, crtc->y,
+			      crtc->invert_dimensions ? " (inverted)" : "");
 		ret = -ENOSPC;
 		goto out;
 	}
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index ced3625..7ba9b39 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -358,6 +358,9 @@ struct drm_crtc_funcs {
  * @enabled: is this CRTC enabled?
  * @mode: current mode timings
  * @hwmode: mode timings as programmed to hw regs
+ * @invert_dimensions: for purposes of error checking crtc vs fb sizes,
+ *    invert the width/height of the crtc.  This is used if the driver
+ *    is performing 90 or 270 degree rotated scanout
  * @x: x position on screen
  * @y: y position on screen
  * @funcs: CRTC control functions
@@ -391,6 +394,8 @@ struct drm_crtc {
 	 */
 	struct drm_display_mode hwmode;
 
+	bool invert_dimensions;
+
 	int x, y;
 	const struct drm_crtc_funcs *funcs;
 
-- 
1.7.9.5
