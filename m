From: nskamat@ti.com
Subject: [PATCH] Re: omap-sdp3430_Rotation patch
Date: Wed, 17 Sep 2008 10:43:30 -0500
Message-ID: <1221666210-24970-1-git-send-email-nskamat@ti.com>
References: <20080916074100.GA6034@flint.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58516 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbYIQPnm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2008 11:43:42 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8HFha8V031549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 10:43:41 -0500
In-Reply-To: <20080916074100.GA6034@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajesh K <krajesh@ti.com>, Iqbal Shareef <iqbal@ti.com>

From: Rajesh K <krajesh@ti.com>

OMAP FBDEV: VRFB framebuffer rotation support

This patch provides rotation support for OMAP2/3. You will have to append
video=omapfb:rotation=0 parameters to your u-boot arguments to get this
working. This supports 0,90,180 and 270 degree rotations.

Signed-off-by: Rajesh K <krajesh@ti.com>
Signed-off-by: Iqbal Shareef <iqbal@ti.com>
---
 arch/arm/plat-omap/include/mach/omapfb.h |    4 +-
 drivers/video/omap/dispc.c               |  189 +++++++++++++++++++++++++++++-
 drivers/video/omap/dispc.h               |   33 +++++-
 drivers/video/omap/omapfb_main.c         |   32 +++---
 4 files changed, 236 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index a4a84f3..338a11d 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -277,7 +277,7 @@ typedef int (*omapfb_notifier_callback_t)(struct notifier_block *,
 
 struct omapfb_mem_region {
 	dma_addr_t	paddr;
-	void		*vaddr;
+	void __iomem	*vaddr;
 	unsigned long	size;
 	u8		type;		/* OMAPFB_PLANE_MEM_* */
 	unsigned	alloc:1;	/* allocated by the driver */
@@ -306,7 +306,7 @@ struct lcd_ctrl {
 					   int screen_width,
 					   int pos_x, int pos_y, int width,
 					   int height, int color_mode);
-	int		(*set_rotate)	  (int angle);
+	int		(*set_rotate)	  (int plane, int angle);
 	int		(*setup_mem)	  (int plane, size_t size,
 					   int mem_type, unsigned long *paddr);
 	int		(*mmap)		  (struct fb_info *info,
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index ce4c4de..1f5a7a5 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -149,12 +149,25 @@
 #define RESMAP_MASK(_page_nr)						\
 	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))
 
+unsigned long save_paddr;
+unsigned long save_vaddr;
+
 struct resmap {
 	unsigned long	start;
 	unsigned	page_cnt;
 	unsigned long	*map;
 };
 
+struct {
+	unsigned long   paddr[4];
+	void __iomem   *vaddr[4];
+	u32 xoffset;
+	u32 yoffset;
+	unsigned long size_val;
+	unsigned long control_val;
+} vrfb;
+
+static void omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel);
 static struct {
 	void __iomem	*base;
 
@@ -459,6 +472,170 @@ static int omap_dispc_setup_plane(int plane, int channel_out,
 	return r;
 }
 
+/*
+*  pages_per_side : Will provide pages per side
+*      @ img_side : img_side
+*      @ page_exp : page_exponential
+*      Return Value: Returns pages per side value.
+*/
+
+static inline u32 pages_per_side(u32 img_side, u32 page_exp)
+{
+	return (img_side + (1<<page_exp) - 1) >> page_exp;
+}
+
+/*
+*      omap2_disp_set_vrfb : Will configure VRFB Support.Its a rotation engine
+*      which will supports rotations of 0,90,180,270 degrees.
+*      @width: Width of the  image
+*      @height : height of the image
+*      @bytes_per_pixel : color depth of the image
+*      return value :  None
+*/
+
+static void omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel)
+{
+	int page_width_exp, page_height_exp, pixel_size_exp;
+	int context = 0;
+	vrfb.size_val = 0;
+	vrfb.control_val = 0;
+	pixel_size_exp = bytes_per_pixel >> 1;
+	page_width_exp = PAGE_WIDTH_EXP;
+	page_height_exp = PAGE_HEIGHT_EXP;
+
+	width = ((1<<page_width_exp) *
+			(pages_per_side(width * bytes_per_pixel,
+			page_width_exp))) >> pixel_size_exp;
+	height = (1<<page_height_exp) *
+			(pages_per_side(height, page_height_exp));
+
+	__raw_writel(save_paddr, SMS_ROT0_PHYSICAL_BA(context));
+	__raw_writel(0, SMS_ROT0_SIZE(context));
+
+	vrfb.size_val |= (width << SMS_IMAGEWIDTH_OFFSET)|
+			(height << SMS_IMAGEHEIGHT_OFFSET);
+	__raw_writel(vrfb.size_val, SMS_ROT0_SIZE(context));
+	__raw_writel(0, SMS_ROT_CONTROL(context));
+	vrfb.control_val |= pixel_size_exp << SMS_PS_OFFSET
+			| (page_width_exp - pixel_size_exp) << SMS_PW_OFFSET
+			| page_height_exp << SMS_PH_OFFSET;
+	__raw_writel(vrfb.control_val, SMS_ROT_CONTROL(context));
+}
+
+/*
+*      omap_dispc_set_rotate : configuring rotation registers based on angle.
+*      @ plane: graphics or video pipe line
+*      @ angle: Rotation angle.
+*      Return Value: Returns 0 on success
+			Returns -1 if it fails.
+*/
+
+int omap_dispc_set_rotate(int plane, int angle)
+{
+	int width, height;
+	u32 addr_base;
+	u32 bpp;
+	int r = 0;
+
+	width = dispc.fbdev->fb_info[0]->var.xres;
+	height = dispc.fbdev->fb_info[0]->var.yres;
+	bpp = dispc.fbdev->fb_info[0]->var.bits_per_pixel / 8;
+
+	if (plane == OMAPFB_PLANE_GFX) {
+		enable_lcd_clocks(1);
+		/* clear GOLCD bit */
+		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0);
+		if (rotation == 1) {
+			omap2_disp_set_vrfb(width, height, bpp);
+			switch (angle) {
+			case 0:
+				addr_base = vrfb.paddr[0];
+				dispc_write_reg(DISPC_GFX_BA0, addr_base);
+				dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+				dispc_write_reg(DISPC_GFX_ROW_INC,
+					(ROT_LINE_LENGTH - width) * bpp + 1);
+			break;
+			case 90:
+				addr_base = vrfb.paddr[1];
+				dispc_write_reg(DISPC_GFX_BA0, addr_base);
+				dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+				dispc_write_reg(DISPC_GFX_ROW_INC,
+					(ROT_LINE_LENGTH - height) * bpp + 1);
+			break;
+			case 180:
+				addr_base = vrfb.paddr[2];
+				dispc_write_reg(DISPC_GFX_BA0, addr_base);
+				dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+				dispc_write_reg(DISPC_GFX_ROW_INC,
+					(ROT_LINE_LENGTH - width) * bpp + 1);
+			break;
+			case 270:
+				addr_base = vrfb.paddr[3];
+				dispc_write_reg(DISPC_GFX_BA0, addr_base);
+				dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+				dispc_write_reg(DISPC_GFX_ROW_INC,
+					(ROT_LINE_LENGTH - height) * bpp + 1);
+			break;
+			}
+		} else {
+			return r;
+		}
+		/* set GOLCD bit */
+		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0x20);
+		enable_lcd_clocks(0);
+	}
+	return r;
+}
+
+static int omap2_alloc_vrfb_mem(struct omapfb_mem_desc *req_vram)
+{
+	int r = 0;
+	memset(&vrfb, 0, sizeof(vrfb));
+	vrfb.paddr[0] = SMS_ROT_BASE_ADDR(0, 0);
+	vrfb.paddr[1] = SMS_ROT_BASE_ADDR(0, 90);
+	vrfb.paddr[2] = SMS_ROT_BASE_ADDR(0, 180);
+	vrfb.paddr[3] = SMS_ROT_BASE_ADDR(0, 270);
+
+	if (!request_mem_region(vrfb.paddr[0],
+		req_vram->region[0].size, "omapfb")) {
+			r = -1;
+			printk(KERN_ERR "omapfb: can't reserve VRFB0 area\n");
+	}
+
+	if (!request_mem_region(vrfb.paddr[1],
+		req_vram->region[0].size, "omapfb")) {
+			r = -1;
+			printk(KERN_ERR "omapfb: can't reserve VRFB90 area\n");
+	}
+
+	if (!request_mem_region(vrfb.paddr[2],
+		req_vram->region[0].size, "omapfb")) {
+			r = -1;
+			printk(KERN_ERR "omapfb: can't reserveVRFB180 area\n");
+	}
+
+	if (!request_mem_region(vrfb.paddr[3],
+		req_vram->region[0].size, "omapfb")) {
+			r = -1;
+			printk(KERN_ERR "omapfb: can't reserve VRFB270 area\n");
+	}
+
+	vrfb.vaddr[0] = ioremap(vrfb.paddr[0],
+				req_vram->region[0].size);
+	vrfb.vaddr[1] = ioremap(vrfb.paddr[1],
+				req_vram->region[0].size);
+	vrfb.vaddr[2] = ioremap(vrfb.paddr[2],
+				req_vram->region[0].size);
+	vrfb.vaddr[3] = ioremap(vrfb.paddr[3],
+				req_vram->region[0].size);
+	if ((!vrfb.vaddr[0]) || (!vrfb.vaddr[1]) || (!vrfb.vaddr[2])
+				|| (!vrfb.vaddr[3])) {
+		r = -1;
+		printk(KERN_ERR "omapfb: can't map rotated view(s)\n");
+	}
+	return r;
+}
+
 static void write_firh_reg(int plane, int reg, u32 value)
 {
 	u32 base;
@@ -1425,10 +1602,16 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 
 	if ((r = alloc_palette_ram()) < 0)
 		goto fail2;
-
+	if (rotation == 1) {
+		if (omap2_alloc_vrfb_mem(req_vram) < 0)
+			printk(KERN_ERR "VRFB memory allocation failed");
+		}
 	if ((r = setup_fbmem(req_vram)) < 0)
 		goto fail3;
-
+	if (rotation == 1) {
+		save_paddr = dispc.mem_desc.region[0].paddr;
+		dispc.fbdev->mem_desc.region[0].vaddr = vrfb.vaddr[0];
+	}
 	if (!skip_init) {
 		for (i = 0; i < dispc.mem_desc.region_cnt; i++) {
 			memset(dispc.mem_desc.region[i].vaddr, 0,
@@ -1478,7 +1661,6 @@ fail0:
 static void omap_dispc_cleanup(void)
 {
 	int i;
-
 	omap_dispc_set_update_mode(OMAPFB_UPDATE_DISABLED);
 	/* This will also disable clocks that are on */
 	for (i = 0; i < dispc.mem_desc.region_cnt; i++)
@@ -1507,4 +1689,5 @@ const struct lcd_ctrl omap2_int_ctrl = {
 	.set_color_key		= omap_dispc_set_color_key,
 	.get_color_key		= omap_dispc_get_color_key,
 	.mmap			= omap_dispc_mmap_user,
+	.set_rotate             = omap_dispc_set_rotate,
 };
diff --git a/drivers/video/omap/dispc.h b/drivers/video/omap/dispc.h
index ef720a7..506e4c6 100644
--- a/drivers/video/omap/dispc.h
+++ b/drivers/video/omap/dispc.h
@@ -2,7 +2,7 @@
 #define _DISPC_H
 
 #include <linux/interrupt.h>
-
+#include <mach/hardware.h>
 #define DISPC_PLANE_GFX			0
 #define DISPC_PLANE_VID1		1
 #define DISPC_PLANE_VID2		2
@@ -32,6 +32,37 @@
 #define DISPC_TFT_DATA_LINES_18		2
 #define DISPC_TFT_DATA_LINES_24		3
 
+/* Rotation using VRFB */
+extern int rotation;
+#define SMS_ROT_BASE_ADDR(context, degree)      (0x70000000            \
+				| 0x4000000 * (context) \
+				| 0x1000000 * (degree/90))
+#define BITS_PER_PIXEL		16  /* RGB value */
+#define VRFB_SIZE               (2048 * 640 * (BITS_PER_PIXEL/8))
+#define PAGE_WIDTH_EXP          5 /* Assuming SDRAM pagesize= 1024 */
+#define PAGE_HEIGHT_EXP         5 /* 1024 = 2^5 * 2^5 */
+#define SMS_IMAGEHEIGHT_OFFSET  16
+#define SMS_IMAGEWIDTH_OFFSET   0
+#define SMS_PH_OFFSET           8
+#define SMS_PW_OFFSET           4
+#define SMS_PS_OFFSET           0
+#define ROT_LINE_LENGTH         2048
+
+#define DSS_REG_BASE           0x48050000
+#define DISPC_REG_OFFSET       0x00000400
+#define DISPC_BASE             0x48050400
+#define OMAP_SMS_BASE           (0x6C000000)
+#define DISPC_GFX_BA0          0x0080
+#define DISPC_GFX_ROW_INC      0x00AC
+#define DISPC_GFX_PIXEL_INC    0x00B0
+#define DISPC_CONTROL          0x0040
+
+#define SMS_ROT0_PHYSICAL_BA(context)   OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x188 \
+					+ 0x10 * context)
+#define SMS_ROT_CONTROL(context)        OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x180 \
+					+ 0x10 * context)
+#define SMS_ROT0_SIZE(context)          OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x184 \
+					+ 0x10 * context)
 extern void omap_dispc_set_lcd_size(int width, int height);
 
 extern void omap_dispc_enable_lcd_out(int enable);
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index d176a2c..1d2ceb8 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -35,7 +35,8 @@
 #include "dispc.h"
 
 #define MODULE_NAME	"omapfb"
-
+int rotation = -1;
+#define ROT_LINE_LENGTH         2048
 static unsigned int	def_accel;
 static unsigned long	def_vram[OMAPFB_PLANE_NUM];
 static unsigned int	def_vram_cnt;
@@ -219,9 +220,11 @@ static int ctrl_change_mode(struct fb_info *fbi)
 	if (r < 0)
 		return r;
 
-	if (fbdev->ctrl->set_rotate != NULL)
-		if((r = fbdev->ctrl->set_rotate(var->rotate)) < 0)
+	if (fbdev->ctrl->set_rotate != NULL) {
+		r = fbdev->ctrl->set_rotate(0, var->rotate);
+		if (r < 0)
 			return r;
+		}
 
 	if ((fbdev->ctrl->set_scale != NULL) && (plane->idx > 0))
 		r = fbdev->ctrl->set_scale(plane->idx,
@@ -425,7 +428,7 @@ static void set_fb_fix(struct fb_info *fbi)
 		break;
 	}
 	fix->accel		= FB_ACCEL_OMAP1610;
-	fix->line_length	= var->xres_virtual * bpp / 8;
+	fix->line_length        = ROT_LINE_LENGTH * bpp / 8;
 }
 
 static int set_color_mode(struct omapfb_plane_struct *plane,
@@ -497,14 +500,13 @@ static int set_fb_var(struct fb_info *fbi,
 	bpp = var->bits_per_pixel;
 	if (plane->color_mode == OMAPFB_COLOR_RGB444)
 		bpp = 16;
-
+	xres_min = OMAPFB_PLANE_XRES_MIN;
+	xres_max = panel->x_res;
+	yres_min = OMAPFB_PLANE_YRES_MIN;
+	yres_max = panel->y_res;
 	switch (var->rotate) {
 	case 0:
 	case 180:
-		xres_min = OMAPFB_PLANE_XRES_MIN;
-		xres_max = panel->x_res;
-		yres_min = OMAPFB_PLANE_YRES_MIN;
-		yres_max = panel->y_res;
 		if (cpu_is_omap15xx()) {
 			var->xres = panel->x_res;
 			var->yres = panel->y_res;
@@ -512,10 +514,6 @@ static int set_fb_var(struct fb_info *fbi,
 		break;
 	case 90:
 	case 270:
-		xres_min = OMAPFB_PLANE_YRES_MIN;
-		xres_max = panel->y_res;
-		yres_min = OMAPFB_PLANE_XRES_MIN;
-		yres_max = panel->x_res;
 		if (cpu_is_omap15xx()) {
 			var->xres = panel->y_res;
 			var->yres = panel->x_res;
@@ -1718,7 +1716,7 @@ static int omapfb_do_probe(struct platform_device *pdev,
 
 	pr_info("omapfb: configured for panel %s\n", fbdev->panel->name);
 
-	def_vxres = def_vxres ? : fbdev->panel->x_res;
+	def_vxres = ROT_LINE_LENGTH;
 	def_vyres = def_vyres ? : fbdev->panel->y_res;
 
 	init_state++;
@@ -1909,8 +1907,10 @@ static int __init omapfb_setup(char *options)
 			def_vxres = simple_strtoul(this_opt + 6, NULL, 0);
 		else if (!strncmp(this_opt, "vyres:", 6))
 			def_vyres = simple_strtoul(this_opt + 6, NULL, 0);
-		else if (!strncmp(this_opt, "rotate:", 7))
-			def_rotate = (simple_strtoul(this_opt + 7, NULL, 0));
+		else if (!strncmp(this_opt, "rotation=", 9)) {
+			rotation = 1;
+			def_rotate = (simple_strtoul(this_opt + 9, NULL, 0));
+			}
 		else if (!strncmp(this_opt, "mirror:", 7))
 			def_mirror = (simple_strtoul(this_opt + 7, NULL, 0));
 		else if (!strncmp(this_opt, "manual_update", 13))
-- 
1.5.3.2

