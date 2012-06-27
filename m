From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] staging: drm/omap: add rotation properties
Date: Wed, 27 Jun 2012 09:06:26 -0500
Message-ID: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
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
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, archit@ti.com, s-guiriec@ti.com, Rob Clark <rob@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Rob Clark <rob@ti.com>

Use tiled buffers for rotated/reflected scanout, with CRTC and plane
properties as the interface for userspace to configure rotation.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_crtc.c      |   17 +++++
 drivers/staging/omapdrm/omap_dmm_tiler.c |   47 ++++++++++++--
 drivers/staging/omapdrm/omap_dmm_tiler.h |   17 ++++-
 drivers/staging/omapdrm/omap_drv.c       |   17 +++++
 drivers/staging/omapdrm/omap_drv.h       |   32 +++++++++-
 drivers/staging/omapdrm/omap_fb.c        |   99 +++++++++++++++++++++++++-----
 drivers/staging/omapdrm/omap_gem.c       |   43 ++++++++++++-
 drivers/staging/omapdrm/omap_plane.c     |   92 ++++++++++++++++++++-------
 8 files changed, 318 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
index 8b864af..7479dcb 100644
--- a/drivers/staging/omapdrm/omap_crtc.c
+++ b/drivers/staging/omapdrm/omap_crtc.c
@@ -191,10 +191,25 @@ static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
 	return 0;
 }
 
+static int omap_crtc_set_property(struct drm_crtc *crtc,
+		struct drm_property *property, uint64_t val)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct omap_drm_private *priv = crtc->dev->dev_private;
+
+	if (property == priv->rotation_prop) {
+		crtc->invert_dimensions =
+				!!(val & ((1LL << DRM_ROTATE_90) | (1LL << DRM_ROTATE_270)));
+	}
+
+	return omap_plane_set_property(omap_crtc->plane, property, val);
+}
+
 static const struct drm_crtc_funcs omap_crtc_funcs = {
 	.set_config = drm_crtc_helper_set_config,
 	.destroy = omap_crtc_destroy,
 	.page_flip = omap_crtc_page_flip_locked,
+	.set_property = omap_crtc_set_property,
 };
 
 static const struct drm_crtc_helper_funcs omap_crtc_helper_funcs = {
@@ -231,6 +246,8 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	drm_crtc_init(dev, crtc, &omap_crtc_funcs);
 	drm_crtc_helper_add(crtc, &omap_crtc_helper_funcs);
 
+	omap_plane_install_properties(omap_crtc->plane, &crtc->base);
+
 	return crtc;
 
 fail:
diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
index 9d83060..68da290 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.c
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
@@ -401,8 +401,26 @@ int tiler_release(struct tiler_block *block)
  * Utils
  */
 
-/* calculate the tiler space address of a pixel in a view orientation */
-static u32 tiler_get_address(u32 orient, enum tiler_fmt fmt, u32 x, u32 y)
+/* calculate the tiler space address of a pixel in a view orientation...
+ * below description copied from the display subsystem section of TRM:
+ *
+ * When the TILER is addressed, the bits:
+ *   [28:27] = 0x0 for 8-bit tiled
+ *             0x1 for 16-bit tiled
+ *             0x2 for 32-bit tiled
+ *             0x3 for page mode
+ *   [31:29] = 0x0 for 0-degree view
+ *             0x1 for 180-degree view + mirroring
+ *             0x2 for 0-degree view + mirroring
+ *             0x3 for 180-degree view
+ *             0x4 for 270-degree view + mirroring
+ *             0x5 for 270-degree view
+ *             0x6 for 90-degree view
+ *             0x7 for 90-degree view + mirroring
+ * Otherwise the bits indicated the corresponding bit address to access
+ * the SDRAM.
+ */
+static u32 tiler_get_address(enum tiler_fmt fmt, u32 orient, u32 x, u32 y)
 {
 	u32 x_bits, y_bits, tmp, x_mask, y_mask, alignment;
 
@@ -414,8 +432,11 @@ static u32 tiler_get_address(u32 orient, enum tiler_fmt fmt, u32 x, u32 y)
 	x_mask = MASK(x_bits);
 	y_mask = MASK(y_bits);
 
-	if (x < 0 || x > x_mask || y < 0 || y > y_mask)
+	if (x < 0 || x > x_mask || y < 0 || y > y_mask) {
+		DBG("invalid coords: %u < 0 || %u > %u || %u < 0 || %u > %u",
+				x, x, x_mask, y, y, y_mask);
 		return 0;
+	}
 
 	/* account for mirroring */
 	if (orient & MASK_X_INVERT)
@@ -436,11 +457,22 @@ dma_addr_t tiler_ssptr(struct tiler_block *block)
 {
 	BUG_ON(!validfmt(block->fmt));
 
-	return TILVIEW_8BIT + tiler_get_address(0, block->fmt,
+	return TILVIEW_8BIT + tiler_get_address(block->fmt, 0,
 			block->area.p0.x * geom[block->fmt].slot_w,
 			block->area.p0.y * geom[block->fmt].slot_h);
 }
 
+dma_addr_t tiler_tsptr(struct tiler_block *block, uint32_t orient,
+		uint32_t x, uint32_t y)
+{
+	struct tcm_pt *p = &block->area.p0;
+	BUG_ON(!validfmt(block->fmt));
+
+	return tiler_get_address(block->fmt, orient,
+			(p->x * geom[block->fmt].slot_w) + x,
+			(p->y * geom[block->fmt].slot_h) + y);
+}
+
 void tiler_align(enum tiler_fmt fmt, uint16_t *w, uint16_t *h)
 {
 	BUG_ON(!validfmt(fmt));
@@ -448,11 +480,14 @@ void tiler_align(enum tiler_fmt fmt, uint16_t *w, uint16_t *h)
 	*h = round_up(*h, geom[fmt].slot_h);
 }
 
-uint32_t tiler_stride(enum tiler_fmt fmt)
+uint32_t tiler_stride(enum tiler_fmt fmt, uint32_t orient)
 {
 	BUG_ON(!validfmt(fmt));
 
-	return 1 << (CONT_WIDTH_BITS + geom[fmt].y_shft);
+	if (orient & MASK_XY_FLIP)
+		return 1 << (CONT_HEIGHT_BITS + geom[fmt].x_shft);
+	else
+		return 1 << (CONT_WIDTH_BITS + geom[fmt].y_shft);
 }
 
 size_t tiler_size(enum tiler_fmt fmt, uint16_t w, uint16_t h)
diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.h b/drivers/staging/omapdrm/omap_dmm_tiler.h
index 7b1052a..740911d 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.h
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.h
@@ -54,7 +54,18 @@ struct tiler_block {
 #define TILER_WIDTH             (1 << (CONT_WIDTH_BITS - SLOT_WIDTH_BITS))
 #define TILER_HEIGHT            (1 << (CONT_HEIGHT_BITS - SLOT_HEIGHT_BITS))
 
-/* tiler space addressing bitfields */
+/*
+Table 15-11. Coding and Description of TILER Orientations
+S Y X	Description				Alternate description
+0 0 0	0-degree view				Natural view
+0 0 1	0-degree view with vertical mirror 	180-degree view with horizontal mirror
+0 1 0	0-degree view with horizontal mirror 	180-degree view with vertical mirror
+0 1 1	180-degree view
+1 0 0	90-degree view with vertical mirror	270-degree view with horizontal mirror
+1 0 1	270-degree view
+1 1 0	90-degree view
+1 1 1	90-degree view with horizontal mirror	270-degree view with vertical mirror
+ */
 #define MASK_XY_FLIP		(1 << 31)
 #define MASK_Y_INVERT		(1 << 30)
 #define MASK_X_INVERT		(1 << 29)
@@ -90,7 +101,9 @@ int tiler_release(struct tiler_block *block);
 
 /* utilities */
 dma_addr_t tiler_ssptr(struct tiler_block *block);
-uint32_t tiler_stride(enum tiler_fmt fmt);
+dma_addr_t tiler_tsptr(struct tiler_block *block, uint32_t orient,
+		uint32_t x, uint32_t y);
+uint32_t tiler_stride(enum tiler_fmt fmt, uint32_t orient);
 size_t tiler_size(enum tiler_fmt fmt, uint16_t w, uint16_t h);
 size_t tiler_vsize(enum tiler_fmt fmt, uint16_t w, uint16_t h);
 void tiler_align(enum tiler_fmt fmt, uint16_t *w, uint16_t *h);
diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 4beab94..342645a 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -649,6 +649,8 @@ static int dev_firstopen(struct drm_device *dev)
  */
 static void dev_lastclose(struct drm_device *dev)
 {
+	int i;
+
 	/* we don't support vga-switcheroo.. so just make sure the fbdev
 	 * mode is active
 	 */
@@ -657,6 +659,21 @@ static void dev_lastclose(struct drm_device *dev)
 
 	DBG("lastclose: dev=%p", dev);
 
+	/* need to restore default rotation state.. not sure if there is
+	 * a cleaner way to restore properties to default state?  Maybe
+	 * a flag that properties should automatically be restored to
+	 * default state on lastclose?
+	 */
+	for (i = 0; i < priv->num_crtcs; i++) {
+		drm_object_property_set_value(&priv->crtcs[i]->base,
+				priv->rotation_prop, 0);
+	}
+
+	for (i = 0; i < priv->num_planes; i++) {
+		drm_object_property_set_value(&priv->planes[i]->base,
+				priv->rotation_prop, 0);
+	}
+
 	ret = drm_fb_helper_restore_fbdev_mode(priv->fbdev);
 	if (ret)
 		DBG("failed to restore crtc mode");
diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index f238d57..bfdf9d3 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -59,6 +59,26 @@ struct omap_drm_private {
 	struct list_head obj_list;
 
 	bool has_dmm;
+
+	/* properties: */
+	struct drm_property *rotation_prop;
+};
+
+/* this should probably be in drm-core to standardize amongst drivers */
+#define DRM_ROTATE_0	0
+#define DRM_ROTATE_90	1
+#define DRM_ROTATE_180	2
+#define DRM_ROTATE_270	3
+#define DRM_REFLECT_X	4
+#define DRM_REFLECT_Y	5
+
+/* parameters which describe (unrotated) coordinates of scanout within a fb: */
+struct omap_drm_window {
+	uint32_t rotation;
+	int32_t  crtc_x, crtc_y;		/* signed because can be offscreen */
+	uint32_t crtc_w, crtc_h;
+	uint32_t src_x, src_y;
+	uint32_t src_w, src_h;
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -87,6 +107,10 @@ int omap_plane_mode_set(struct drm_plane *plane,
 		uint32_t src_w, uint32_t src_h);
 void omap_plane_on_endwin(struct drm_plane *plane,
 		void (*fxn)(void *), void *arg);
+void omap_plane_install_properties(struct drm_plane *plane,
+		struct drm_mode_object *obj);
+int omap_plane_set_property(struct drm_plane *plane,
+		struct drm_property *property, uint64_t val);
 
 struct drm_encoder *omap_encoder_init(struct drm_device *dev,
 		struct omap_overlay_manager *mgr);
@@ -114,8 +138,8 @@ struct drm_gem_object *omap_framebuffer_bo(struct drm_framebuffer *fb, int p);
 int omap_framebuffer_replace(struct drm_framebuffer *a,
 		struct drm_framebuffer *b, void *arg,
 		void (*unpin)(void *arg, struct drm_gem_object *bo));
-void omap_framebuffer_update_scanout(struct drm_framebuffer *fb, int x, int y,
-		struct omap_overlay_info *info);
+void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
+		struct omap_drm_window *win, struct omap_overlay_info *info);
 struct drm_connector *omap_framebuffer_get_next_connector(
 		struct drm_framebuffer *fb, struct drm_connector *from);
 void omap_framebuffer_flush(struct drm_framebuffer *fb,
@@ -157,8 +181,12 @@ int omap_gem_get_pages(struct drm_gem_object *obj, struct page ***pages,
 		bool remap);
 int omap_gem_put_pages(struct drm_gem_object *obj);
 uint32_t omap_gem_flags(struct drm_gem_object *obj);
+int omap_gem_rotated_paddr(struct drm_gem_object *obj, uint32_t orient,
+		int x, int y, dma_addr_t *paddr);
 uint64_t omap_gem_mmap_offset(struct drm_gem_object *obj);
 size_t omap_gem_mmap_size(struct drm_gem_object *obj);
+int omap_gem_tiled_size(struct drm_gem_object *obj, uint16_t *w, uint16_t *h);
+int omap_gem_tiled_stride(struct drm_gem_object *obj, uint32_t orient);
 
 struct dma_buf * omap_gem_prime_export(struct drm_device *dev,
 		struct drm_gem_object *obj, int flags);
diff --git a/drivers/staging/omapdrm/omap_fb.c b/drivers/staging/omapdrm/omap_fb.c
index 74260f0..446801d 100644
--- a/drivers/staging/omapdrm/omap_fb.c
+++ b/drivers/staging/omapdrm/omap_fb.c
@@ -18,6 +18,7 @@
  */
 
 #include "omap_drv.h"
+#include "omap_dmm_tiler.h"
 
 #include "drm_crtc.h"
 #include "drm_crtc_helper.h"
@@ -137,30 +138,100 @@ static const struct drm_framebuffer_funcs omap_framebuffer_funcs = {
 	.dirty = omap_framebuffer_dirty,
 };
 
+static uint32_t get_linear_addr(struct plane *plane,
+		const struct format *format, int n, int x, int y)
+{
+	uint32_t offset;
+
+	offset = plane->offset +
+			(x * format->planes[n].stride_bpp) +
+			(y * plane->pitch / format->planes[n].sub_y);
+
+	return plane->paddr + offset;
+}
+
 /* update ovl info for scanout, handles cases of multi-planar fb's, etc.
  */
-void omap_framebuffer_update_scanout(struct drm_framebuffer *fb, int x, int y,
-		struct omap_overlay_info *info)
+void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
+		struct omap_drm_window *win, struct omap_overlay_info *info)
 {
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
 	const struct format *format = omap_fb->format;
 	struct plane *plane = &omap_fb->planes[0];
-	unsigned int offset;
+	uint32_t x, y, orient = 0;
+
+	info->color_mode = format->dss_format;
+
+	info->pos_x      = win->crtc_x;
+	info->pos_y      = win->crtc_y;
+	info->out_width  = win->crtc_w;
+	info->out_height = win->crtc_h;
+	info->width      = win->src_w;
+	info->height     = win->src_h;
+
+	x = win->src_x;
+	y = win->src_y;
+
+	if (omap_gem_flags(plane->bo) & OMAP_BO_TILED) {
+		uint32_t w = win->src_w;
+		uint32_t h = win->src_h;
+
+		switch (win->rotation & 0xf) {
+		default:
+			dev_err(fb->dev->dev, "invalid rotation: %02x",
+					(uint32_t)win->rotation);
+			/* fallthru to default to no rotation */
+		case 0:
+		case BIT(DRM_ROTATE_0):
+			orient = 0;
+			break;
+		case BIT(DRM_ROTATE_90):
+			orient = MASK_XY_FLIP | MASK_X_INVERT;
+			break;
+		case BIT(DRM_ROTATE_180):
+			orient = MASK_X_INVERT | MASK_Y_INVERT;
+			break;
+		case BIT(DRM_ROTATE_270):
+			orient = MASK_XY_FLIP | MASK_Y_INVERT;
+			break;
+		}
 
-	offset = plane->offset +
-			(x * format->planes[0].stride_bpp) +
-			(y * plane->pitch / format->planes[0].sub_y);
+		if (win->rotation & BIT(DRM_REFLECT_X))
+			orient ^= MASK_X_INVERT;
+
+		if (win->rotation & BIT(DRM_REFLECT_Y))
+			orient ^= MASK_Y_INVERT;
+
+		/* adjust x,y offset for flip/invert: */
+		if (orient & MASK_XY_FLIP)
+			swap(w, h);
+		if (orient & MASK_Y_INVERT)
+			y += h - 1;
+		if (orient & MASK_X_INVERT)
+			x += w - 1;
 
-	info->color_mode   = format->dss_format;
-	info->paddr        = plane->paddr + offset;
-	info->screen_width = plane->pitch / format->planes[0].stride_bpp;
+		omap_gem_rotated_paddr(plane->bo, orient, x, y, &info->paddr);
+		info->rotation_type = OMAP_DSS_ROT_TILER;
+		info->screen_width  = omap_gem_tiled_stride(plane->bo, orient);
+	} else {
+		info->paddr         = get_linear_addr(plane, format, 0, x, y);
+		info->rotation_type = OMAP_DSS_ROT_DMA;
+		info->screen_width  = plane->pitch;
+	}
+
+	/* convert to pixels: */
+	info->screen_width /= format->planes[0].stride_bpp;
 
 	if (format->dss_format == OMAP_DSS_COLOR_NV12) {
 		plane = &omap_fb->planes[1];
-		offset = plane->offset +
-				(x * format->planes[1].stride_bpp) +
-				(y * plane->pitch / format->planes[1].sub_y);
-		info->p_uv_addr = plane->paddr + offset;
+
+		if (info->rotation_type == OMAP_DSS_ROT_TILER) {
+			WARN_ON(!(omap_gem_flags(plane->bo) & OMAP_BO_TILED));
+			omap_gem_rotated_paddr(plane->bo, orient,
+					x/2, y/2, &info->p_uv_addr);
+		} else {
+			info->p_uv_addr = get_linear_addr(plane, format, 1, x, y);
+		}
 	} else {
 		info->p_uv_addr = 0;
 	}
@@ -377,7 +448,7 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 
 		size = pitch * mode_cmd->height / format->planes[i].sub_y;
 
-		if (size > (bos[i]->size - mode_cmd->offsets[i])) {
+		if (size > (omap_gem_mmap_size(bos[i]) - mode_cmd->offsets[i])) {
 			dev_err(dev->dev, "provided buffer object is too small! %d < %d\n",
 					bos[i]->size - mode_cmd->offsets[i], size);
 			ret = -EINVAL;
diff --git a/drivers/staging/omapdrm/omap_gem.c b/drivers/staging/omapdrm/omap_gem.c
index 3a0d035..74082aa 100644
--- a/drivers/staging/omapdrm/omap_gem.c
+++ b/drivers/staging/omapdrm/omap_gem.c
@@ -339,6 +339,17 @@ size_t omap_gem_mmap_size(struct drm_gem_object *obj)
 	return size;
 }
 
+/* get tiled size, returns -EINVAL if not tiled buffer */
+int omap_gem_tiled_size(struct drm_gem_object *obj, uint16_t *w, uint16_t *h)
+{
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
+	if (omap_obj->flags & OMAP_BO_TILED) {
+		*w = omap_obj->width;
+		*h = omap_obj->height;
+		return 0;
+	}
+	return -EINVAL;
+}
 
 /* Normal handling for the case of faulting in non-tiled buffers */
 static int fault_1d(struct drm_gem_object *obj,
@@ -832,6 +843,36 @@ fail:
 	return ret;
 }
 
+/* Get rotated scanout address (only valid if already pinned), at the
+ * specified orientation and x,y offset from top-left corner of buffer
+ * (only valid for tiled 2d buffers)
+ */
+int omap_gem_rotated_paddr(struct drm_gem_object *obj, uint32_t orient,
+		int x, int y, dma_addr_t *paddr)
+{
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
+	int ret = -EINVAL;
+
+	mutex_lock(&obj->dev->struct_mutex);
+	if ((omap_obj->paddr_cnt > 0) && omap_obj->block &&
+			(omap_obj->flags & OMAP_BO_TILED)) {
+		*paddr = tiler_tsptr(omap_obj->block, orient, x, y);
+		ret = 0;
+	}
+	mutex_unlock(&obj->dev->struct_mutex);
+	return ret;
+}
+
+/* Get tiler stride for the buffer (only valid for 2d tiled buffers) */
+int omap_gem_tiled_stride(struct drm_gem_object *obj, uint32_t orient)
+{
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
+	int ret = -EINVAL;
+	if (omap_obj->flags & OMAP_BO_TILED)
+		ret = tiler_stride(gem2fmt(omap_obj->flags), orient);
+	return ret;
+}
+
 /* acquire pages when needed (for example, for DMA where physically
  * contiguous buffer is not required
  */
@@ -1402,7 +1443,7 @@ void omap_gem_init(struct drm_device *dev)
 		 */
 		usergart[i].height = h;
 		usergart[i].height_shift = ilog2(h);
-		usergart[i].stride_pfn = tiler_stride(fmts[i]) >> PAGE_SHIFT;
+		usergart[i].stride_pfn = tiler_stride(fmts[i], 0) >> PAGE_SHIFT;
 		usergart[i].slot_shift = ilog2((PAGE_SIZE / h) >> i);
 		for (j = 0; j < NUM_USERGART_ENTRIES; j++) {
 			struct usergart_entry *entry = &usergart[i].entry[j];
diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapdrm/omap_plane.c
index 7997be7..6931d06 100644
--- a/drivers/staging/omapdrm/omap_plane.c
+++ b/drivers/staging/omapdrm/omap_plane.c
@@ -20,6 +20,7 @@
 #include <linux/kfifo.h>
 
 #include "omap_drv.h"
+#include "omap_dmm_tiler.h"
 
 /* some hackery because omapdss has an 'enum omap_plane' (which would be
  * better named omap_plane_id).. and compiler seems unhappy about having
@@ -43,10 +44,9 @@ struct omap_plane {
 	struct omap_overlay *ovl;
 	struct omap_overlay_info info;
 
-	/* Source values, converted to integers because we don't support
-	 * fractional positions:
-	 */
-	unsigned int src_x, src_y;
+	/* position/orientation of scanout within the fb: */
+	struct omap_drm_window win;
+
 
 	/* last fb that we pinned: */
 	struct drm_framebuffer *pinned_fb;
@@ -289,6 +289,7 @@ static void update_scanout(struct drm_plane *plane)
 {
 	struct omap_plane *omap_plane = to_omap_plane(plane);
 	struct omap_overlay_info *info = &omap_plane->info;
+	struct omap_drm_window *win = &omap_plane->win;
 	int ret;
 
 	ret = update_pin(plane, plane->fb);
@@ -299,11 +300,10 @@ static void update_scanout(struct drm_plane *plane)
 		return;
 	}
 
-	omap_framebuffer_update_scanout(plane->fb,
-			omap_plane->src_x, omap_plane->src_y, info);
+	omap_framebuffer_update_scanout(plane->fb, win, info);
 
 	DBG("%s: %d,%d: %08x %08x (%d)", omap_plane->ovl->name,
-			omap_plane->src_x, omap_plane->src_y,
+			win->src_x, win->src_y,
 			(u32)info->paddr, (u32)info->p_uv_addr,
 			info->screen_width);
 }
@@ -316,21 +316,18 @@ int omap_plane_mode_set(struct drm_plane *plane,
 		uint32_t src_w, uint32_t src_h)
 {
 	struct omap_plane *omap_plane = to_omap_plane(plane);
+	struct omap_drm_window *win = &omap_plane->win;
+
+	win->crtc_x = crtc_x;
+	win->crtc_y = crtc_y;
+	win->crtc_w = crtc_w;
+	win->crtc_h = crtc_h;
 
 	/* src values are in Q16 fixed point, convert to integer: */
-	src_x = src_x >> 16;
-	src_y = src_y >> 16;
-	src_w = src_w >> 16;
-	src_h = src_h >> 16;
-
-	omap_plane->info.pos_x = crtc_x;
-	omap_plane->info.pos_y = crtc_y;
-	omap_plane->info.out_width = crtc_w;
-	omap_plane->info.out_height = crtc_h;
-	omap_plane->info.width = src_w;
-	omap_plane->info.height = src_h;
-	omap_plane->src_x = src_x;
-	omap_plane->src_y = src_y;
+	win->src_x = src_x >> 16;
+	win->src_y = src_y >> 16;
+	win->src_w = src_w >> 16;
+	win->src_h = src_h >> 16;
 
 	/* note: this is done after this fxn returns.. but if we need
 	 * to do a commit/update_scanout, etc before this returns we
@@ -359,6 +356,8 @@ static int omap_plane_update(struct drm_plane *plane,
 
 static int omap_plane_disable(struct drm_plane *plane)
 {
+	struct omap_plane *omap_plane = to_omap_plane(plane);
+	omap_plane->win.rotation = BIT(DRM_ROTATE_0);
 	return omap_plane_dpms(plane, DRM_MODE_DPMS_OFF);
 }
 
@@ -409,10 +408,60 @@ void omap_plane_on_endwin(struct drm_plane *plane,
 	install_irq(plane);
 }
 
+/* helper to install properties which are common to planes and crtcs */
+void omap_plane_install_properties(struct drm_plane *plane,
+		struct drm_mode_object *obj)
+{
+	struct drm_device *dev = plane->dev;
+	struct omap_drm_private *priv = dev->dev_private;
+	struct drm_property *prop;
+
+	prop = priv->rotation_prop;
+	if (!prop) {
+		const struct drm_prop_enum_list props[] = {
+				{ DRM_ROTATE_0,   "rotate-0" },
+				{ DRM_ROTATE_90,  "rotate-90" },
+				{ DRM_ROTATE_180, "rotate-180" },
+				{ DRM_ROTATE_270, "rotate-270" },
+				{ DRM_REFLECT_X,  "reflect-x" },
+				{ DRM_REFLECT_Y,  "reflect-y" },
+		};
+		prop = drm_property_create_bitmask(dev, 0, "rotation",
+				props, ARRAY_SIZE(props));
+		if (prop == NULL)
+			return;
+		priv->rotation_prop = prop;
+	}
+	drm_object_attach_property(obj, prop, 0);
+}
+
+int omap_plane_set_property(struct drm_plane *plane,
+		struct drm_property *property, uint64_t val)
+{
+	struct omap_plane *omap_plane = to_omap_plane(plane);
+	struct omap_drm_private *priv = plane->dev->dev_private;
+	int ret = -EINVAL;
+
+	if (property == priv->rotation_prop) {
+		struct omap_overlay *ovl = omap_plane->ovl;
+
+		DBG("%s: rotation: %02x", ovl->name, (uint32_t)val);
+		omap_plane->win.rotation = val;
+
+		if (ovl->is_enabled(ovl))
+			ret = omap_plane_dpms(plane, DRM_MODE_DPMS_ON);
+		else
+			ret = 0;
+	}
+
+	return ret;
+}
+
 static const struct drm_plane_funcs omap_plane_funcs = {
 		.update_plane = omap_plane_update,
 		.disable_plane = omap_plane_disable,
 		.destroy = omap_plane_destroy,
+		.set_property = omap_plane_set_property,
 };
 
 /* initialize plane */
@@ -455,6 +504,8 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 	drm_plane_init(dev, plane, possible_crtcs, &omap_plane_funcs,
 			omap_plane->formats, omap_plane->nformats, priv);
 
+	omap_plane_install_properties(plane, &plane->base);
+
 	/* get our starting configuration, set defaults for parameters
 	 * we don't currently use, etc:
 	 */
@@ -463,7 +514,6 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 	omap_plane->info.rotation = OMAP_DSS_ROT_0;
 	omap_plane->info.global_alpha = 0xff;
 	omap_plane->info.mirror = 0;
-	omap_plane->info.mirror = 0;
 
 	/* Set defaults depending on whether we are a CRTC or overlay
 	 * layer.
-- 
1.7.9.5
