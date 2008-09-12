From: rajesh k <hirajeshk@yahoo.com>
Subject: omap-sdp3430_Mirroring patch
Date: Fri, 12 Sep 2008 05:01:25 -0700 (PDT)
Message-ID: <433234.80955.qm@web32001.mail.mud.yahoo.com>
Reply-To: hirajeshk@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web32001.mail.mud.yahoo.com ([68.142.207.98]:46180 "HELO
	web32001.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752819AbYILMIH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2008 08:08:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: krajesh@ti.com

From: Rajesh K  <krajesh@ti.com>

OMAP FBDEV:Add VRFB framebuffer mirroring support for OMAP SDP 3430

This patch Should apply on top of rotation patch to enable the mirroring
feature.This patch provides mirroring support for OMAP SDP 3430. You will
have to append video=omapfb:rotate=0 parameters to your u-boot arguments
to get this working. This supports 0,90,180 and 270 degree mirroring.

Signed-off-by: Rajesh K      <krajesh@ti.com>
               Iqbal Shareef <iqbal@ti.com>

---
 arch/arm/plat-omap/include/mach/omapfb.h |    3 +
 drivers/video/omap/dispc.c               |   73 ++++++++++++++++++++++++++++++
 drivers/video/omap/omapfb_main.c         |   12 +++++
 3 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index 6abc327..27483e8 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -79,6 +79,7 @@
 #define OMAPFB_MEMTYPE_SDRAM		0
 #define OMAPFB_MEMTYPE_SRAM		1
 #define OMAPFB_MEMTYPE_MAX		1
+#define OMAPFBIO_MIRROR             _IOW('F', 0x21, u_int32_t)
 
 enum omapfb_color_format {
 	OMAPFB_COLOR_RGB565 = 0,
@@ -307,6 +308,8 @@ struct lcd_ctrl {
 					   int pos_x, int pos_y, int width,
 					   int height, int color_mode);
 	int		(*set_rotate)	  (int plane, int angle);
+	int             (*set_mirror)     (struct fb_info *fbi,
+						int plane, int mirror);
 	int		(*setup_mem)	  (int plane, size_t size,
 					   int mem_type, unsigned long *paddr);
 	int		(*mmap)		  (struct fb_info *info,
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index f882db4..de72ecb 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -147,6 +147,8 @@
 #define RESMAP_MASK(_page_nr)						\
 	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))
 
+u32 start;
+u32 row_inc;
 dma_addr_t save_paddr;
 unsigned long save_vaddr;
 
@@ -157,6 +159,7 @@ struct {
 	u32 yoffset;
 	unsigned long size_val;
 	unsigned long control_val;
+	int omapfb_rotation;
 } vrfb;
 
 static int omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel);
@@ -529,6 +532,7 @@ int omap_dispc_set_rotate(int plane, int angle)
 	int width, height;
 	u32 addr_base;
 	u32 Bpp;
+	vrfb.omapfb_rotation = angle;
 	width = dispc.fbdev->fb_info[0]->var.xres;
 	height = dispc.fbdev->fb_info[0]->var.yres;
 	Bpp = dispc.fbdev->fb_info[0]->var.bits_per_pixel / 8;
@@ -573,6 +577,74 @@ int omap_dispc_set_rotate(int plane, int angle)
 	return 0;
 }
 
+/*
+*       omapfb_set_mirror_params : Setting mirror parameters.
+*       fb_var_screeninfo :     fb_var_screeninfo
+*       fb_fix_screeninfo :     fb_fix_screeninfo
+*       rotation          :     rotation angle
+*       Return :        Returns an integer
+*/
+static int omapfb_set_mirror_params(const struct fb_var_screeninfo *var,
+					const struct fb_fix_screeninfo *fix)
+{
+	int context = 0;
+	u32 view_address_base;
+	u32 total_width, img_width;
+	u32 xoffset, yoffset;
+	view_address_base = SMS_ROT_VIRT_BASE(context, 0);
+
+	switch (vrfb.omapfb_rotation) {
+	case 0:
+	case 180:
+	default:
+		xoffset = var->xoffset;
+		if (vrfb.omapfb_rotation == 0)
+			xoffset += var->xres_virtual - var->xres;
+		start = view_address_base + (var->yres - var->yoffset
+				- 1) * fix->line_length
+				- (xoffset*var->bits_per_pixel)/8;
+		total_width = fix->line_length;
+		img_width = (var->xres *  var->bits_per_pixel)/8;
+		break;
+	case 90:
+	case 270:
+		yoffset = var->yoffset;
+		if (vrfb.omapfb_rotation == 270)
+			yoffset += var->yres_virtual - var->yres;
+		start = view_address_base + (var->xres - var->xoffset
+				- 1) * fix->line_length
+				+ (yoffset*var->bits_per_pixel)/8;
+		total_width = fix->line_length;
+		img_width = (var->yres * var->bits_per_pixel)/8;
+		break;
+	}
+	row_inc = -(total_width + img_width) + 1;
+	return 0;
+}
+
+static int omap_dispc_set_mirror(struct fb_info *info, int plane, int mirror)
+{
+	int ret = 0;
+	if (mirror > 0) {
+		omapfb_set_mirror_params(&info->var, &info->fix);
+		/* clear the GOLCD */
+		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0);
+		omap_writel(start, DSS_REG_BASE + DISPC_REG_OFFSET
+					+ DISPC_GFX_BA0);
+		omap_writel(1, DSS_REG_BASE + DISPC_REG_OFFSET
+					+ DISPC_GFX_PIXEL_INC);
+		omap_writel(row_inc, DSS_REG_BASE + DISPC_REG_OFFSET
+					+ DISPC_GFX_ROW_INC);
+		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0x20);
+		return ret;
+	} else {
+		ret = omap_dispc_set_rotate(OMAPFB_PLANE_GFX,
+					vrfb.omapfb_rotation);
+		return ret;
+	}
+}
+
+
 static void write_firh_reg(int plane, int reg, u32 value)
 {
 	u32 base;
@@ -1666,4 +1738,5 @@ const struct lcd_ctrl omap2_int_ctrl = {
 	.get_color_key		= omap_dispc_get_color_key,
 	.mmap			= omap_dispc_mmap_user,
 	.set_rotate             = omap_dispc_set_rotate,
+	.set_mirror             = omap_dispc_set_mirror,
 };
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 92d571c..42af550 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1083,6 +1083,9 @@ EXPORT_SYMBOL(omapfb_write_first_pixel);
 static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 			unsigned long arg)
 {
+	int mirroring;
+	int ret = 0;
+	void __user *argp = (void __user *)arg;
 	struct omapfb_plane_struct *plane = fbi->par;
 	struct omapfb_device	*fbdev = plane->fbdev;
 	struct fb_ops		*ops = fbi->fbops;
@@ -1107,6 +1110,15 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 		else
 			omapfb_mirror(fbi, p.mirror);
 		break;
+	case OMAPFBIO_MIRROR:
+		if (!copy_from_user(&mirroring, argp, sizeof(mirroring))) {
+			if (plane->fbdev->ctrl->set_mirror != NULL) {
+				ret = plane->fbdev->ctrl->set_mirror(fbi,
+						OMAPFB_PLANE_GFX, mirroring);
+			}
+			return ret;
+		}
+		break;
 	case OMAPFB_SYNC_GFX:
 		omapfb_sync(fbi);
 		break;
-- 
1.5.3.2



      
