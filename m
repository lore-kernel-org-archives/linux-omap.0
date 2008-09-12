From: rajesh k <hirajeshk@yahoo.com>
Subject: omap-sdp3430_Rotation patch
Date: Fri, 12 Sep 2008 05:00:21 -0700 (PDT)
Message-ID: <759850.3803.qm@web32003.mail.mud.yahoo.com>
Reply-To: hirajeshk@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web32003.mail.mud.yahoo.com ([68.142.207.100]:48879 "HELO
	web32003.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752812AbYILMHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2008 08:07:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: krajesh@ti.com

>From Rajesh K krajesh<krajesh@ti.com>

OMAP FBDEV: VRFB framebuffer rotation support for OMAP SDP 3430

This patch provides rotation support OMAP SDP 3430. You will have to append
video=omapfb:rotate=0 parameters to your u-boot arguments to get this working.
This supports 0,90,180 and 270 degree rotations.

Signed-off-by: Rajesh  K     < krajesh@ti.com >
               Iqbal shareef < iqbal@ti.com >
---
 arch/arm/plat-omap/include/mach/omapfb.h |    2 +-
 drivers/video/omap/dispc.c               |  167 +++++++++++++++++++++++++++++-
 drivers/video/omap/dispc.h               |   31 ++++++
 drivers/video/omap/omapfb_main.c         |   27 +++---
 4 files changed, 208 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index a4a84f3..6abc327 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
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
index ce4c4de..f882db4 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -24,11 +24,9 @@
 #include <linux/vmalloc.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-
 #include <mach/sram.h>
 #include <mach/omapfb.h>
 #include <mach/board.h>
-
 #include "dispc.h"
 
 #define MODULE_NAME			"dispc"
@@ -149,6 +147,20 @@
 #define RESMAP_MASK(_page_nr)						\
 	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))
 
+dma_addr_t save_paddr;
+unsigned long save_vaddr;
+
+struct {
+	dma_addr_t      paddr[4];
+	unsigned long   vaddr[4];
+	u32 xoffset;
+	u32 yoffset;
+	unsigned long size_val;
+	unsigned long control_val;
+} vrfb;
+
+static int omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel);
+
 struct resmap {
 	unsigned long	start;
 	unsigned	page_cnt;
@@ -459,6 +471,108 @@ static int omap_dispc_setup_plane(int plane, int channel_out,
 	return r;
 }
 
+/*
+* function: pages_per_side : Will provide page height & width
+*      @ img_side : img_side
+*      @ page_exp : page_exp
+*      Return Value: Will return an integer.
+*/
+static inline u32
+pages_per_side(u32 img_side, u32 page_exp)
+{
+	return (u32) (img_side + (1<<page_exp) - 1) >> page_exp;
+}
+
+/*
+*      omap2_disp_set_vrfb : Will configure VRFB Support.Its a rotation engine
+*      which will supports rotations of 0,90,180,270 degrees.
+*      @width: Width of the  image
+*      @height : height of the image
+*      @bytes_per_pixel : color depth of the image
+*      return value :  will return an integer value
+*/
+static int omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel)
+{
+	int page_width_exp, page_height_exp, pixel_size_exp;
+	int context = 0;
+	vrfb.size_val = 0;
+	vrfb.control_val = 0;
+	pixel_size_exp = bytes_per_pixel >> 1;
+	page_width_exp = PAGE_WIDTH_EXP;
+	page_height_exp = PAGE_HEIGHT_EXP;
+	width = ((1<<page_width_exp) *
+			(pages_per_side(width * bytes_per_pixel,
+			page_width_exp))) >> pixel_size_exp;
+	height = (1<<page_height_exp) *
+			(pages_per_side(height, page_height_exp));
+	__raw_writel(save_paddr, SMS_ROT0_PHYSICAL_BA(context));
+	__raw_writel(0, SMS_ROT0_SIZE(context));
+	vrfb.size_val |= (width << SMS_IMAGEWIDTH_OFFSET)|
+			(height << SMS_IMAGEHEIGHT_OFFSET);
+	__raw_writel(vrfb.size_val, SMS_ROT0_SIZE(context));
+	__raw_writel(0, SMS_ROT_CONTROL(context));
+	vrfb.control_val |= pixel_size_exp << SMS_PS_OFFSET
+			| (page_width_exp - pixel_size_exp) << SMS_PW_OFFSET
+			| page_height_exp << SMS_PH_OFFSET;
+	__raw_writel(vrfb.control_val, SMS_ROT_CONTROL(context));
+	return 0;
+}
+
+/*
+*      omap_dispc_set_rotate : configuring rotation registers based on angle.
+*      @ plane: graphics or video pipe line
+*      @ angle: Rotation angle.
+*      Return Value: Returns an integer.
+*/
+int omap_dispc_set_rotate(int plane, int angle)
+{
+	int width, height;
+	u32 addr_base;
+	u32 Bpp;
+	width = dispc.fbdev->fb_info[0]->var.xres;
+	height = dispc.fbdev->fb_info[0]->var.yres;
+	Bpp = dispc.fbdev->fb_info[0]->var.bits_per_pixel / 8;
+	if (plane == OMAPFB_PLANE_GFX) {
+		enable_lcd_clocks(1);
+		/* clear GOLCD bit */
+		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0);
+		omap2_disp_set_vrfb(width, height, Bpp);
+		switch (angle) {
+		case 0:
+			addr_base = vrfb.paddr[0];
+			dispc_write_reg(DISPC_GFX_BA0, addr_base);
+			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+			dispc_write_reg(DISPC_GFX_ROW_INC,
+				(ROT_LINE_LENGTH - width) * Bpp + 1);
+			break;
+		case 90:
+			addr_base = vrfb.paddr[1];
+			dispc_write_reg(DISPC_GFX_BA0, addr_base);
+			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+			dispc_write_reg(DISPC_GFX_ROW_INC,
+				(ROT_LINE_LENGTH - height) * Bpp + 1);
+			break;
+		case 180:
+			addr_base = vrfb.paddr[2];
+			dispc_write_reg(DISPC_GFX_BA0, addr_base);
+			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+			dispc_write_reg(DISPC_GFX_ROW_INC,
+				(ROT_LINE_LENGTH - width) * Bpp + 1);
+			break;
+		case 270:
+			addr_base = vrfb.paddr[3];
+			dispc_write_reg(DISPC_GFX_BA0, addr_base);
+			dispc_write_reg(DISPC_GFX_PIXEL_INC, 1);
+			dispc_write_reg(DISPC_GFX_ROW_INC,
+				(ROT_LINE_LENGTH - height) * Bpp + 1);
+			break;
+		}
+		MOD_REG_FLD(DISPC_CONTROL, 0x20, 0x20);
+		enable_lcd_clocks(0);
+	}
+	return 0;
+}
+
 static void write_firh_reg(int plane, int reg, u32 value)
 {
 	u32 base;
@@ -1340,6 +1454,49 @@ static void cleanup_fbmem(void)
 	}
 }
 
+static void omap2_alloc_vrfb_mem(struct omapfb_mem_desc *req_vram)
+{
+	memset(&vrfb, 0, sizeof(vrfb));
+	vrfb.paddr[0] = SMS_ROT_VIRT_BASE(0, 0);
+	vrfb.paddr[1] = SMS_ROT_VIRT_BASE(0, 90);
+	vrfb.paddr[2] = SMS_ROT_VIRT_BASE(0, 180);
+	vrfb.paddr[3] = SMS_ROT_VIRT_BASE(0, 270);
+
+	if (!request_mem_region(vrfb.paddr[0],
+		req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB0 area\n");
+	}
+
+	if (!request_mem_region(vrfb.paddr[1],
+		req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB90 area\n");
+	}
+
+	if (!request_mem_region(vrfb.paddr[2],
+		req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB180 area\n");
+	}
+
+	if (!request_mem_region(vrfb.paddr[3],
+		req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB270 area\n");
+	}
+
+	vrfb.vaddr[0] = (unsigned long)ioremap(vrfb.paddr[0],
+			req_vram->region[0].size);
+	vrfb.vaddr[1] = (unsigned long)ioremap(vrfb.paddr[1],
+			req_vram->region[0].size);
+	vrfb.vaddr[2] = (unsigned long)ioremap(vrfb.paddr[2],
+			req_vram->region[0].size);
+	vrfb.vaddr[3] = (unsigned long)ioremap(vrfb.paddr[3],
+			req_vram->region[0].size);
+	if ((!vrfb.vaddr[0]) || (!vrfb.vaddr[1]) || (!vrfb.vaddr[2])
+				|| (!vrfb.vaddr[3])) {
+		printk(KERN_ERR "omapfb: can't map rotated view(s)\n");
+	}
+
+}
+
 static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 			   struct omapfb_mem_desc *req_vram)
 {
@@ -1425,10 +1582,11 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 
 	if ((r = alloc_palette_ram()) < 0)
 		goto fail2;
-
+	omap2_alloc_vrfb_mem(req_vram);
 	if ((r = setup_fbmem(req_vram)) < 0)
 		goto fail3;
-
+	save_paddr = dispc.mem_desc.region[0].paddr;
+	dispc.fbdev->mem_desc.region[0].vaddr = (void *)vrfb.vaddr[0];
 	if (!skip_init) {
 		for (i = 0; i < dispc.mem_desc.region_cnt; i++) {
 			memset(dispc.mem_desc.region[i].vaddr, 0,
@@ -1507,4 +1665,5 @@ const struct lcd_ctrl omap2_int_ctrl = {
 	.set_color_key		= omap_dispc_set_color_key,
 	.get_color_key		= omap_dispc_get_color_key,
 	.mmap			= omap_dispc_mmap_user,
+	.set_rotate             = omap_dispc_set_rotate,
 };
diff --git a/drivers/video/omap/dispc.h b/drivers/video/omap/dispc.h
index ef720a7..5f470b4 100644
--- a/drivers/video/omap/dispc.h
+++ b/drivers/video/omap/dispc.h
@@ -2,6 +2,7 @@
 #define _DISPC_H
 
 #include <linux/interrupt.h>
+#include <mach/hardware.h>
 
 #define DISPC_PLANE_GFX			0
 #define DISPC_PLANE_VID1		1
@@ -32,6 +33,36 @@
 #define DISPC_TFT_DATA_LINES_18		2
 #define DISPC_TFT_DATA_LINES_24		3
 
+/* Rotation using VRFB */
+#define SMS_ROT_VIRT_BASE(context, degree)      (0x70000000            \
+				| 0x4000000 * (context) \
+				| 0x1000000 * (degree/90))
+#define VRFB_SIZE               (2048 * 640 * (16/8))
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
+						+ 0x10 * context)
+#define SMS_ROT_CONTROL(context)        OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x180 \
+						+ 0x10 * context)
+#define SMS_ROT0_SIZE(context)          OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x184 \
+						+ 0x10 * context)
+
 extern void omap_dispc_set_lcd_size(int width, int height);
 
 extern void omap_dispc_enable_lcd_out(int enable);
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index d176a2c..92d571c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -36,6 +36,7 @@
 
 #define MODULE_NAME	"omapfb"
 
+#define ROT_LINE_LENGTH         2048
 static unsigned int	def_accel;
 static unsigned long	def_vram[OMAPFB_PLANE_NUM];
 static unsigned int	def_vram_cnt;
@@ -219,10 +220,11 @@ static int ctrl_change_mode(struct fb_info *fbi)
 	if (r < 0)
 		return r;
 
-	if (fbdev->ctrl->set_rotate != NULL)
-		if((r = fbdev->ctrl->set_rotate(var->rotate)) < 0)
+	if (fbdev->ctrl->set_rotate != NULL) {
+		r = fbdev->ctrl->set_rotate(0, var->rotate);
+		if (r < 0)
 			return r;
-
+	}
 	if ((fbdev->ctrl->set_scale != NULL) && (plane->idx > 0))
 		r = fbdev->ctrl->set_scale(plane->idx,
 				   var->xres, var->yres,
@@ -425,7 +427,7 @@ static void set_fb_fix(struct fb_info *fbi)
 		break;
 	}
 	fix->accel		= FB_ACCEL_OMAP1610;
-	fix->line_length	= var->xres_virtual * bpp / 8;
+	fix->line_length        = ROT_LINE_LENGTH * bpp / 8;
 }
 
 static int set_color_mode(struct omapfb_plane_struct *plane,
@@ -497,14 +499,14 @@ static int set_fb_var(struct fb_info *fbi,
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
+
 		if (cpu_is_omap15xx()) {
 			var->xres = panel->x_res;
 			var->yres = panel->y_res;
@@ -512,10 +514,7 @@ static int set_fb_var(struct fb_info *fbi,
 		break;
 	case 90:
 	case 270:
-		xres_min = OMAPFB_PLANE_YRES_MIN;
-		xres_max = panel->y_res;
-		yres_min = OMAPFB_PLANE_XRES_MIN;
-		yres_max = panel->x_res;
+
 		if (cpu_is_omap15xx()) {
 			var->xres = panel->y_res;
 			var->yres = panel->x_res;
@@ -1718,7 +1717,7 @@ static int omapfb_do_probe(struct platform_device *pdev,
 
 	pr_info("omapfb: configured for panel %s\n", fbdev->panel->name);
 
-	def_vxres = def_vxres ? : fbdev->panel->x_res;
+	def_vxres = ROT_LINE_LENGTH;
 	def_vyres = def_vyres ? : fbdev->panel->y_res;
 
 	init_state++;
-- 
1.5.3.2



      
