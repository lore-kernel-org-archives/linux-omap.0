From: Archit Taneja <archit@ti.com>
Subject: [RFC 11/11] Example: OMAPFB: clear framebuffers using writeback
Date: Wed, 7 Nov 2012 20:14:29 +0530
Message-ID: <1352299469-17609-12-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33935 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab2KGOpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 09:45:30 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This is an example to demonstrate how writeback is used to clear framebuffers.

The function omapfb_clear_fb_writeback is added as an alternative to the MPU
intensive function cfb_fillrect.

The writeback is attached to a free manager which has no overlays connected to
it, the manager's default color is set to black, and the size of both writeback
and manager are set to the framebuffer size. writeback_info is configured to
write the manager's output to the framebuffer address, and a mem to me update is
done.

This currently isn't full proof as it the logic of getting a free manager isn't
optimal yet and has a few corner cases.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |  132 +++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index be9096c..680f1eb 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1590,8 +1590,131 @@ static int omapfb_allocate_all_fbs(struct omapfb2_device *fbdev)
 	return 0;
 }
 
+static struct omap_overlay_manager *get_free_manager(struct fb_info *fbi)
+{
+	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
+	struct omap_overlay *ovl;
+	struct omap_overlay_manager *mgr, *def_mgr;
+	int i;
+
+	ovl = omap_dss_get_overlay(0);
+	def_mgr = ovl->manager;
+
+	for (i = 0; i < fbdev->num_managers; i++) {
+		mgr = fbdev->managers[i];
+		if (mgr != def_mgr)
+			return mgr;
+	}
+
+	return NULL;
+}
+
+static void wb_callback(int err, void *data)
+{
+	struct omap_dss_output *wb = (struct omap_dss_output *) data;
+
+	omapdss_writeback_bus_unlock(wb);
+}
+
+static int omapfb_clear_fb_writeback(struct fb_info *fbi)
+{
+	struct fb_var_screeninfo *var = &fbi->var;
+	struct fb_fix_screeninfo *fix = &fbi->fix;
+	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omap_overlay_manager *mgr = NULL;
+	struct omap_overlay_manager_info mgr_info;
+	struct omap_dss_output *wb, *orig_out = NULL;
+	struct omap_dss_writeback_info wb_info;
+	enum omap_color_mode mode;
+	u32 data_start_p = 0;
+	int r;
+
+	wb = omap_dss_get_writeback();
+	if (!wb)
+		return -ENODEV;
+
+	/* find the first unused overlay manager */
+	mgr = get_free_manager(fbi);
+	if (!mgr)
+		return -ENODEV;
+
+	/* free the manager output */
+	if (mgr->output) {
+		orig_out = mgr->output;
+		mgr->unset_output(mgr);
+	}
+
+	/* get framebuffer color mode */
+	r = fb_mode_to_dss_mode(var, &mode);
+	if (r)
+		return r;
+
+	/* calculate framebuffer buffer address */
+	if (ofbi->region->size)
+		omapfb_calc_addr(ofbi, var, fix, 0, &data_start_p);
+
+	/* link the free overlay manager to writeback */
+	mgr->set_output(mgr, wb);
+
+	omapdss_writeback_bus_lock(wb);
+
+	/* enable writeback to configure writeback and overlay manager params */
+	omapdss_writeback_enable(wb);
+
+	/* configure and apply manager info to set default color to zero */
+	mgr->get_manager_info(mgr, &mgr_info);
+
+	mgr_info.default_color = 0x0;
+
+	mgr->set_manager_info(mgr, &mgr_info);
+
+	mgr->apply(mgr);
+
+	/*
+	 * configure writeback parameters to write manager output to
+	 * framebuffer
+	 */
+	omapdss_writeback_set_input_size(wb, fbi->var.xres_virtual,
+		fbi->var.yres_virtual);
+
+	omapdss_writeback_get_info(wb, &wb_info);
+
+	wb_info.paddr = data_start_p;
+	wb_info.rotation_type = OMAP_DSS_ROT_DMA;
+	wb_info.rotation = 0;
+	wb_info.mirror = 0;
+	wb_info.width = fbi->var.xres_virtual;
+	wb_info.buf_width = fbi->var.xres_virtual;
+	wb_info.height = fbi->var.yres_virtual;
+	wb_info.color_mode = mode;
+
+	omapdss_writeback_set_info(wb, &wb_info);
+
+	omapdss_writeback_apply(wb);
+
+	/* start writeback update */
+	omapdss_writeback_update(wb, wb_callback, wb);
+
+	omapdss_writeback_bus_lock(wb);
+
+	/* disable writeback(and the connected manager) */
+	omapdss_writeback_disable(wb);
+
+	omapdss_writeback_bus_unlock(wb);
+
+	/* restore manager back to it's old state */
+	mgr->unset_output(mgr);
+
+	if (orig_out)
+		mgr->set_output(mgr, orig_out);
+
+	return 0;
+}
+
 static void omapfb_clear_fb(struct fb_info *fbi)
 {
+	int r;
 	const struct fb_fillrect rect = {
 		.dx = 0,
 		.dy = 0,
@@ -1601,7 +1724,14 @@ static void omapfb_clear_fb(struct fb_info *fbi)
 		.rop = ROP_COPY,
 	};
 
-	cfb_fillrect(fbi, &rect);
+	r = omapfb_clear_fb_writeback(fbi);
+
+	/*
+	 * if clearing through writeback failed, revert to clearing the
+	 * framebuffer through MPU
+	 */
+	if (r)
+		cfb_fillrect(fbi, &rect);
 }
 
 int omapfb_realloc_fbmem(struct fb_info *fbi, unsigned long size, int type)
-- 
1.7.9.5

