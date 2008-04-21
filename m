From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] This patch adds VRFB based rotation support to omapfb
Date: Mon, 21 Apr 2008 17:14:29 +0530
Message-ID: <c656a4d20804210444k6139042m80ec967111e16017@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:3272 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbYDULoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 07:44:44 -0400
Received: by yw-out-2324.google.com with SMTP id 5so984260ywb.1
        for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2008 04:44:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 8d3405d3388bb8daef285ba1adf5f582e27dab91 Mon Sep 17 00:00:00 2001
From: arun <arunedarath@mistralsolutions.com>
Date: Mon, 21 Apr 2008 14:49:29 +0530
Subject: [PATCH] This patch adds VRFB based rotation support to omapfb

The features are:

a) Processor and applications writes to VRFB0 space and the display
   controller reads from different VRFB space according to degree of
   rotation.

b) Pass video=omapfb:rotate:<degree> to see the penguin rotate.

c) Clean up code is not implemented as of now(like unmapping the VRFB regions)

Signed-off-by: arun <arunedarath@mistralsolutions.com>
---
 drivers/video/omap/dispc.c       |  205 ++++++++++++++++++++++++++++++++++++++
 drivers/video/omap/omapfb_main.c |   23 +++--
 2 files changed, 220 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 4c055a2..f7d4acd 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -148,6 +148,43 @@
 #define RESMAP_MASK(_page_nr)						\
 	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))

+/* Rotation using VRFB */
+#define ROTATION_TEST		1
+#define SMS_ROT_VIRT_BASE(context, degree)	(0x70000000		\
+						| 0x4000000 * (context)	\
+						| 0x1000000 * (degree/90))
+#define VRFB_SIZE		(2048 * 640 * (16/8))
+#define PAGE_WIDTH_EXP		5 /* Assuming SDRAM pagesize= 1024 */
+#define PAGE_HEIGHT_EXP		5 /* 1024 = 2^5 * 2^5 */
+#define SMS_IMAGEHEIGHT_OFFSET	16
+#define SMS_IMAGEWIDTH_OFFSET	0
+#define SMS_PH_OFFSET		8
+#define SMS_PW_OFFSET		4
+#define SMS_PS_OFFSET		0
+#define ROT_LINE_LENGTH		2048
+
+#define OMAP_SMS_BASE		(0x6C000000)
+#define SMS_ROT0_PHYSICAL_BA(context)	__REG32(OMAP_SMS_BASE + 0x188 \
+						+ 0x10 * context)
+#define SMS_ROT_CONTROL(context)	__REG32(OMAP_SMS_BASE + 0x180 \
+						+ 0x10 * context)
+#define SMS_ROT0_SIZE(context)		__REG32(OMAP_SMS_BASE + 0x184 \
+						+ 0x10 * context)
+
+dma_addr_t save_paddr;
+unsigned long save_vaddr;
+unsigned long save_offset;
+int vrfb_rotation;
+
+static struct {
+	dma_addr_t	paddr[4];
+	unsigned long	vaddr[4];
+	u32 xoffset;
+	u32 yoffset;
+} vrfb;
+
+static int omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel);
+
 struct resmap {
 	unsigned long	start;
 	unsigned	page_cnt;
@@ -449,6 +486,7 @@ static int omap_dispc_setup_plane(int plane, int
channel_out,

 	if ((unsigned)plane > dispc.mem_desc.region_cnt)
 		return -EINVAL;
+	save_offset = offset;
 	paddr = dispc.mem_desc.region[plane].paddr + offset;
 	enable_lcd_clocks(1);
 	r = _setup_plane(plane, channel_out, paddr,
@@ -458,6 +496,111 @@ static int omap_dispc_setup_plane(int plane, int
channel_out,
 	return r;
 }

+static inline u32
+calc_vrfb_div(u32 img_side, u32 page_exp)
+{
+	u32 div;
+	div = img_side / page_exp;
+	if ((div * page_exp) < img_side)
+		return div + 1;
+	else
+		return div;
+}
+
+static int omap2_disp_set_vrfb(u32 width, u32 height, u32 bytes_per_pixel)
+{
+	int page_width_exp, page_height_exp, pixel_size_exp;
+	int context = 0;
+	int div;
+	u32 vrfb_width;
+	u32 vrfb_height;
+
+	page_width_exp = PAGE_WIDTH_EXP;
+	page_height_exp = PAGE_HEIGHT_EXP;
+	pixel_size_exp = bytes_per_pixel >> 1;
+
+	div = calc_vrfb_div(width * bytes_per_pixel, 1 << page_width_exp);
+	vrfb_width = (div * (1 << page_width_exp)) / bytes_per_pixel;
+
+	div = calc_vrfb_div(height, 1 << page_height_exp);
+	vrfb_height = div * (1 << page_height_exp);
+
+	SMS_ROT0_PHYSICAL_BA(context) = save_paddr;
+	SMS_ROT0_SIZE(context) = 0;
+	SMS_ROT0_SIZE(context)	|= (vrfb_width << SMS_IMAGEWIDTH_OFFSET)
+				| (vrfb_height << SMS_IMAGEHEIGHT_OFFSET);
+	SMS_ROT_CONTROL(context) = 0;
+	SMS_ROT_CONTROL(context) |= pixel_size_exp << SMS_PS_OFFSET
+			| page_width_exp  << SMS_PW_OFFSET
+			| page_height_exp << SMS_PH_OFFSET;
+
+	vrfb.xoffset = vrfb_width - width;
+	vrfb.yoffset = vrfb_height - height;
+	return 0;
+}
+
+static int omap_dispc_set_rotate(int angle)
+{
+	const u32 ba_reg[] = { DISPC_GFX_BA0 };
+	const u32 ri_reg[] = { DISPC_GFX_ROW_INC };
+	const u32 pi_reg[] = { DISPC_GFX_PIXEL_INC };
+	int width, height;
+	u32 addr_base;
+	u32 Bpp;
+
+	if (vrfb_rotation != 1)
+		return 0;
+
+	width = dispc.fbdev->fb_info[0]->var.xres;
+	height = dispc.fbdev->fb_info[0]->var.yres;
+	Bpp = dispc.fbdev->fb_info[0]->var.bits_per_pixel / 8;
+
+	enable_lcd_clocks(1);
+
+	switch (angle) {
+	case 0:
+		omap2_disp_set_vrfb(width, height, Bpp);
+		addr_base = SMS_ROT_VIRT_BASE(0, 0) + save_offset;
+		dispc_write_reg(ba_reg[0], addr_base);
+		dispc_write_reg(pi_reg[0], 1);
+		dispc_write_reg(ri_reg[0], (ROT_LINE_LENGTH - width) * Bpp + 1);
+		break;
+	case 90:
+		omap2_disp_set_vrfb(height, width, Bpp);
+		addr_base = SMS_ROT_VIRT_BASE(0, 90) + save_offset
+					+ vrfb.yoffset * Bpp;
+
+		dispc_write_reg(ba_reg[0], addr_base);
+		dispc_write_reg(pi_reg[0], 1);
+		dispc_write_reg(ri_reg[0], (ROT_LINE_LENGTH - width) * Bpp + 1);
+		break;
+	case 180:
+		omap2_disp_set_vrfb(width, height, Bpp);
+		addr_base = SMS_ROT_VIRT_BASE(0, 180) + save_offset
+					+ vrfb.xoffset * Bpp
+					+ ROT_LINE_LENGTH * vrfb.yoffset * Bpp;
+
+		dispc_write_reg(ba_reg[0], addr_base);
+		dispc_write_reg(pi_reg[0], 1);
+		dispc_write_reg(ri_reg[0], (ROT_LINE_LENGTH - width) * Bpp + 1);
+		break;
+	case 270:
+		omap2_disp_set_vrfb(height, width, Bpp);
+		addr_base = SMS_ROT_VIRT_BASE(0, 270) + save_offset
+				+ ROT_LINE_LENGTH * vrfb.xoffset * Bpp;
+
+		dispc_write_reg(ba_reg[0], addr_base);
+		dispc_write_reg(pi_reg[0], 1);
+		dispc_write_reg(ri_reg[0], (ROT_LINE_LENGTH - width) * Bpp + 1);
+		break;
+	}
+
+	MOD_REG_FLD(DISPC_CONTROL, 0x20, 0); /* Sets & clears the GOLCD bit */
+	MOD_REG_FLD(DISPC_CONTROL, 0x20, 0x20);
+	enable_lcd_clocks(0);
+	return 0;
+}
+
 static void write_firh_reg(int plane, int reg, u32 value)
 {
 	u32 base;
@@ -1422,9 +1565,70 @@ static int omap_dispc_init(struct omapfb_device
*fbdev, int ext_mode,
 	if ((r = alloc_palette_ram()) < 0)
 		goto fail2;

+#ifdef ROTATION_TEST
+	memset(&vrfb, 0, sizeof(vrfb));
+	vrfb_rotation = 1;
+	vrfb.paddr[0] = SMS_ROT_VIRT_BASE(0, 0);
+	vrfb.paddr[1] = SMS_ROT_VIRT_BASE(0, 90);
+	vrfb.paddr[2] = SMS_ROT_VIRT_BASE(0, 180);
+	vrfb.paddr[3] = SMS_ROT_VIRT_BASE(0, 270);
+
+	if (!request_mem_region(vrfb.paddr[0],
+			  req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB0 area\n");
+		vrfb_rotation++;
+	}
+
+	if (!request_mem_region(vrfb.paddr[1],
+			  req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB90 area\n");
+		vrfb_rotation++;
+	}
+
+	if (!request_mem_region(vrfb.paddr[2],
+			  req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB180 area\n");
+		vrfb_rotation++;
+	}
+
+	if (!request_mem_region(vrfb.paddr[3],
+			  req_vram->region[0].size, "omapfb")) {
+		printk(KERN_ERR "omapfb: can't reserve VRFB270 area\n");
+		vrfb_rotation++;
+	}
+
+	vrfb.vaddr[0] = (unsigned long)ioremap(vrfb.paddr[0],
+						req_vram->region[0].size);
+	vrfb.vaddr[1] = (unsigned long)ioremap(vrfb.paddr[1],
+						req_vram->region[0].size);
+	vrfb.vaddr[2] = (unsigned long)ioremap(vrfb.paddr[2],
+						req_vram->region[0].size);
+	vrfb.vaddr[3] = (unsigned long)ioremap(vrfb.paddr[3],
+						req_vram->region[0].size);
+	if ((!vrfb.vaddr[0]) || (!vrfb.vaddr[1]) || (!vrfb.vaddr[2])
+						|| (!vrfb.vaddr[3])) {
+		printk(KERN_ERR "omapfb: can't map rotated view(s)\n");
+		vrfb_rotation++;
+	}
+#endif
+
 	if ((r = setup_fbmem(req_vram)) < 0)
 		goto fail3;

+	if (vrfb_rotation == 1) {
+		save_paddr = dispc.mem_desc.region[0].paddr;
+		save_vaddr = (unsigned long)dispc.mem_desc.region[0].vaddr;
+
+		dispc.mem_desc.region[0].vaddr = (void *)vrfb.vaddr[0];
+		dispc.mem_desc.region[0].paddr = vrfb.paddr[0];
+		dispc.fbdev->mem_desc.region[0].vaddr =
+						(void *)vrfb.vaddr[0];
+
+		dispc.fbdev->mem_desc.region[0].paddr = vrfb.paddr[0];
+		omap2_disp_set_vrfb(panel->x_res, panel->y_res,
+							 panel->bpp / 8);
+	}
+
 	if (!skip_init) {
 		for (i = 0; i < dispc.mem_desc.region_cnt; i++) {
 			memset(dispc.mem_desc.region[i].vaddr, 0,
@@ -1503,4 +1707,5 @@ const struct lcd_ctrl omap2_int_ctrl = {
 	.set_color_key		= omap_dispc_set_color_key,
 	.get_color_key		= omap_dispc_get_color_key,
 	.mmap			= omap_dispc_mmap_user,
+	.set_rotate		= omap_dispc_set_rotate,
 };
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 418ed9f..2a9500b 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -32,6 +32,8 @@
 #include <asm/arch/omapfb.h>

 #define MODULE_NAME	"omapfb"
+#define	ROTATION_TEST	1
+#define	ROT_LINE_LENGTH	2048

 static unsigned int	def_accel;
 static unsigned long	def_vram[OMAPFB_PLANE_NUM];
@@ -422,7 +424,11 @@ static void set_fb_fix(struct fb_info *fbi)
 		break;
 	}
 	fix->accel		= FB_ACCEL_OMAP1610;
+#ifdef ROTATION_TEST
+	fix->line_length	= ROT_LINE_LENGTH * bpp / 8;
+#else
 	fix->line_length	= var->xres_virtual * bpp / 8;
+#endif
 }

 static int set_color_mode(struct omapfb_plane_struct *plane,
@@ -495,13 +501,14 @@ static int set_fb_var(struct fb_info *fbi,
 	if (plane->color_mode == OMAPFB_COLOR_RGB444)
 		bpp = 16;

+	xres_min = OMAPFB_PLANE_XRES_MIN;
+	xres_max = panel->x_res;
+	yres_min = OMAPFB_PLANE_YRES_MIN;
+	yres_max = panel->y_res;
+
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
@@ -509,10 +516,6 @@ static int set_fb_var(struct fb_info *fbi,
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
@@ -1715,7 +1718,11 @@ static int omapfb_do_probe(struct platform_device *pdev,

 	pr_info("omapfb: configured for panel %s\n", fbdev->panel->name);

+#ifdef ROTATION_TEST
+	def_vxres = ROT_LINE_LENGTH;
+#else
 	def_vxres = def_vxres ? : fbdev->panel->x_res;
+#endif
 	def_vyres = def_vyres ? : fbdev->panel->y_res;

 	init_state++;
-- 
1.5.3.4
