From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] This patch adds VRFB based rotation support to omapfb
Date: Mon, 21 Apr 2008 17:17:19 +0530
Message-ID: <c656a4d20804210447t13ca24c1w54ed07f10762d96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11629_8224857.1208778439656"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:9380 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbYDULr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 07:47:29 -0400
Received: by yw-out-2324.google.com with SMTP id 5so985011ywb.1
        for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2008 04:47:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_11629_8224857.1208778439656
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

Sorry forgotten to put message in the last mail,
I have added signed off line to the patch.

##################################
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

------=_Part_11629_8224857.1208778439656
Content-Type: text/x-patch;
 name=0001-This-patch-adds-VRFB-based-rotation-support-to-omapf.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffay79n00
Content-Disposition: attachment;
 filename=0001-This-patch-adds-VRFB-based-rotation-support-to-omapf.patch

RnJvbSA4ZDM0MDVkMzM4OGJiOGRhZWYyODViYTFhZGY1ZjU4MmUyN2RhYjkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhcnVuIDxhcnVuZWRhcmF0aEBtaXN0cmFsc29sdXRpb25zLmNv
bT4KRGF0ZTogTW9uLCAyMSBBcHIgMjAwOCAxNDo0OToyOSArMDUzMApTdWJqZWN0OiBbUEFUQ0hd
IFRoaXMgcGF0Y2ggYWRkcyBWUkZCIGJhc2VkIHJvdGF0aW9uIHN1cHBvcnQgdG8gb21hcGZiCgpU
aGUgZmVhdHVyZXMgYXJlOgoKYSkgUHJvY2Vzc29yIGFuZCBhcHBsaWNhdGlvbnMgd3JpdGVzIHRv
IFZSRkIwIHNwYWNlIGFuZCB0aGUgZGlzcGxheQogICBjb250cm9sbGVyIHJlYWRzIGZyb20gZGlm
ZmVyZW50IFZSRkIgc3BhY2UgYWNjb3JkaW5nIHRvIGRlZ3JlZSBvZgogICByb3RhdGlvbi4KCmIp
IFBhc3MgdmlkZW89b21hcGZiOnJvdGF0ZTo8ZGVncmVlPiB0byBzZWUgdGhlIHBlbmd1aW4gcm90
YXRlLgoKYykgQ2xlYW4gdXAgY29kZSBpcyBub3QgaW1wbGVtZW50ZWQgYXMgb2Ygbm93KGxpa2Ug
dW5tYXBwaW5nIHRoZSBWUkZCIHJlZ2lvbnMpCgpTaWduZWQtb2ZmLWJ5OiBhcnVuIDxhcnVuZWRh
cmF0aEBtaXN0cmFsc29sdXRpb25zLmNvbT4KLS0tCiBkcml2ZXJzL3ZpZGVvL29tYXAvZGlzcGMu
YyAgICAgICB8ICAyMDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRy
aXZlcnMvdmlkZW8vb21hcC9vbWFwZmJfbWFpbi5jIHwgICAyMyArKystLQogMiBmaWxlcyBjaGFu
Z2VkLCAyMjAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpZGVvL29tYXAvZGlzcGMuYyBiL2RyaXZlcnMvdmlkZW8vb21hcC9kaXNwYy5jCmluZGV4
IDRjMDU1YTIuLmY3ZDRhY2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vb21hcC9kaXNwYy5j
CisrKyBiL2RyaXZlcnMvdmlkZW8vb21hcC9kaXNwYy5jCkBAIC0xNDgsNiArMTQ4LDQzIEBACiAj
ZGVmaW5lIFJFU01BUF9NQVNLKF9wYWdlX25yKQkJCQkJCVwKIAkoMSA8PCAoKF9wYWdlX25yKSAm
IChzaXplb2YodW5zaWduZWQgbG9uZykgKiA4IC0gMSkpKQogCisvKiBSb3RhdGlvbiB1c2luZyBW
UkZCICovCisjZGVmaW5lIFJPVEFUSU9OX1RFU1QJCTEKKyNkZWZpbmUgU01TX1JPVF9WSVJUX0JB
U0UoY29udGV4dCwgZGVncmVlKQkoMHg3MDAwMDAwMAkJXAorCQkJCQkJfCAweDQwMDAwMDAgKiAo
Y29udGV4dCkJXAorCQkJCQkJfCAweDEwMDAwMDAgKiAoZGVncmVlLzkwKSkKKyNkZWZpbmUgVlJG
Ql9TSVpFCQkoMjA0OCAqIDY0MCAqICgxNi84KSkKKyNkZWZpbmUgUEFHRV9XSURUSF9FWFAJCTUg
LyogQXNzdW1pbmcgU0RSQU0gcGFnZXNpemU9IDEwMjQgKi8KKyNkZWZpbmUgUEFHRV9IRUlHSFRf
RVhQCQk1IC8qIDEwMjQgPSAyXjUgKiAyXjUgKi8KKyNkZWZpbmUgU01TX0lNQUdFSEVJR0hUX09G
RlNFVAkxNgorI2RlZmluZSBTTVNfSU1BR0VXSURUSF9PRkZTRVQJMAorI2RlZmluZSBTTVNfUEhf
T0ZGU0VUCQk4CisjZGVmaW5lIFNNU19QV19PRkZTRVQJCTQKKyNkZWZpbmUgU01TX1BTX09GRlNF
VAkJMAorI2RlZmluZSBST1RfTElORV9MRU5HVEgJCTIwNDgKKworI2RlZmluZSBPTUFQX1NNU19C
QVNFCQkoMHg2QzAwMDAwMCkKKyNkZWZpbmUgU01TX1JPVDBfUEhZU0lDQUxfQkEoY29udGV4dCkJ
X19SRUczMihPTUFQX1NNU19CQVNFICsgMHgxODggXAorCQkJCQkJKyAweDEwICogY29udGV4dCkK
KyNkZWZpbmUgU01TX1JPVF9DT05UUk9MKGNvbnRleHQpCV9fUkVHMzIoT01BUF9TTVNfQkFTRSAr
IDB4MTgwIFwKKwkJCQkJCSsgMHgxMCAqIGNvbnRleHQpCisjZGVmaW5lIFNNU19ST1QwX1NJWkUo
Y29udGV4dCkJCV9fUkVHMzIoT01BUF9TTVNfQkFTRSArIDB4MTg0IFwKKwkJCQkJCSsgMHgxMCAq
IGNvbnRleHQpCisKK2RtYV9hZGRyX3Qgc2F2ZV9wYWRkcjsKK3Vuc2lnbmVkIGxvbmcgc2F2ZV92
YWRkcjsKK3Vuc2lnbmVkIGxvbmcgc2F2ZV9vZmZzZXQ7CitpbnQgdnJmYl9yb3RhdGlvbjsKKwor
c3RhdGljIHN0cnVjdCB7CisJZG1hX2FkZHJfdAlwYWRkcls0XTsKKwl1bnNpZ25lZCBsb25nCXZh
ZGRyWzRdOworCXUzMiB4b2Zmc2V0OworCXUzMiB5b2Zmc2V0OworfSB2cmZiOworCitzdGF0aWMg
aW50IG9tYXAyX2Rpc3Bfc2V0X3ZyZmIodTMyIHdpZHRoLCB1MzIgaGVpZ2h0LCB1MzIgYnl0ZXNf
cGVyX3BpeGVsKTsKKwogc3RydWN0IHJlc21hcCB7CiAJdW5zaWduZWQgbG9uZwlzdGFydDsKIAl1
bnNpZ25lZAlwYWdlX2NudDsKQEAgLTQ0OSw2ICs0ODYsNyBAQCBzdGF0aWMgaW50IG9tYXBfZGlz
cGNfc2V0dXBfcGxhbmUoaW50IHBsYW5lLCBpbnQgY2hhbm5lbF9vdXQsCiAKIAlpZiAoKHVuc2ln
bmVkKXBsYW5lID4gZGlzcGMubWVtX2Rlc2MucmVnaW9uX2NudCkKIAkJcmV0dXJuIC1FSU5WQUw7
CisJc2F2ZV9vZmZzZXQgPSBvZmZzZXQ7CiAJcGFkZHIgPSBkaXNwYy5tZW1fZGVzYy5yZWdpb25b
cGxhbmVdLnBhZGRyICsgb2Zmc2V0OwogCWVuYWJsZV9sY2RfY2xvY2tzKDEpOwogCXIgPSBfc2V0
dXBfcGxhbmUocGxhbmUsIGNoYW5uZWxfb3V0LCBwYWRkciwKQEAgLTQ1OCw2ICs0OTYsMTExIEBA
IHN0YXRpYyBpbnQgb21hcF9kaXNwY19zZXR1cF9wbGFuZShpbnQgcGxhbmUsIGludCBjaGFubmVs
X291dCwKIAlyZXR1cm4gcjsKIH0KIAorc3RhdGljIGlubGluZSB1MzIKK2NhbGNfdnJmYl9kaXYo
dTMyIGltZ19zaWRlLCB1MzIgcGFnZV9leHApCit7CisJdTMyIGRpdjsKKwlkaXYgPSBpbWdfc2lk
ZSAvIHBhZ2VfZXhwOworCWlmICgoZGl2ICogcGFnZV9leHApIDwgaW1nX3NpZGUpCisJCXJldHVy
biBkaXYgKyAxOworCWVsc2UKKwkJcmV0dXJuIGRpdjsKK30KKworc3RhdGljIGludCBvbWFwMl9k
aXNwX3NldF92cmZiKHUzMiB3aWR0aCwgdTMyIGhlaWdodCwgdTMyIGJ5dGVzX3Blcl9waXhlbCkK
K3sKKwlpbnQgcGFnZV93aWR0aF9leHAsIHBhZ2VfaGVpZ2h0X2V4cCwgcGl4ZWxfc2l6ZV9leHA7
CisJaW50IGNvbnRleHQgPSAwOworCWludCBkaXY7CisJdTMyIHZyZmJfd2lkdGg7CisJdTMyIHZy
ZmJfaGVpZ2h0OworCisJcGFnZV93aWR0aF9leHAgPSBQQUdFX1dJRFRIX0VYUDsKKwlwYWdlX2hl
aWdodF9leHAgPSBQQUdFX0hFSUdIVF9FWFA7CisJcGl4ZWxfc2l6ZV9leHAgPSBieXRlc19wZXJf
cGl4ZWwgPj4gMTsKKworCWRpdiA9IGNhbGNfdnJmYl9kaXYod2lkdGggKiBieXRlc19wZXJfcGl4
ZWwsIDEgPDwgcGFnZV93aWR0aF9leHApOworCXZyZmJfd2lkdGggPSAoZGl2ICogKDEgPDwgcGFn
ZV93aWR0aF9leHApKSAvIGJ5dGVzX3Blcl9waXhlbDsKKworCWRpdiA9IGNhbGNfdnJmYl9kaXYo
aGVpZ2h0LCAxIDw8IHBhZ2VfaGVpZ2h0X2V4cCk7CisJdnJmYl9oZWlnaHQgPSBkaXYgKiAoMSA8
PCBwYWdlX2hlaWdodF9leHApOworCisJU01TX1JPVDBfUEhZU0lDQUxfQkEoY29udGV4dCkgPSBz
YXZlX3BhZGRyOworCVNNU19ST1QwX1NJWkUoY29udGV4dCkgPSAwOworCVNNU19ST1QwX1NJWkUo
Y29udGV4dCkJfD0gKHZyZmJfd2lkdGggPDwgU01TX0lNQUdFV0lEVEhfT0ZGU0VUKQorCQkJCXwg
KHZyZmJfaGVpZ2h0IDw8IFNNU19JTUFHRUhFSUdIVF9PRkZTRVQpOworCVNNU19ST1RfQ09OVFJP
TChjb250ZXh0KSA9IDA7CisJU01TX1JPVF9DT05UUk9MKGNvbnRleHQpIHw9IHBpeGVsX3NpemVf
ZXhwIDw8IFNNU19QU19PRkZTRVQKKwkJCXwgcGFnZV93aWR0aF9leHAgIDw8IFNNU19QV19PRkZT
RVQKKwkJCXwgcGFnZV9oZWlnaHRfZXhwIDw8IFNNU19QSF9PRkZTRVQ7CisKKwl2cmZiLnhvZmZz
ZXQgPSB2cmZiX3dpZHRoIC0gd2lkdGg7CisJdnJmYi55b2Zmc2V0ID0gdnJmYl9oZWlnaHQgLSBo
ZWlnaHQ7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgb21hcF9kaXNwY19zZXRfcm90YXRl
KGludCBhbmdsZSkKK3sKKwljb25zdCB1MzIgYmFfcmVnW10gPSB7IERJU1BDX0dGWF9CQTAgfTsK
Kwljb25zdCB1MzIgcmlfcmVnW10gPSB7IERJU1BDX0dGWF9ST1dfSU5DIH07CisJY29uc3QgdTMy
IHBpX3JlZ1tdID0geyBESVNQQ19HRlhfUElYRUxfSU5DIH07CisJaW50IHdpZHRoLCBoZWlnaHQ7
CisJdTMyIGFkZHJfYmFzZTsKKwl1MzIgQnBwOworCisJaWYgKHZyZmJfcm90YXRpb24gIT0gMSkK
KwkJcmV0dXJuIDA7CisKKwl3aWR0aCA9IGRpc3BjLmZiZGV2LT5mYl9pbmZvWzBdLT52YXIueHJl
czsKKwloZWlnaHQgPSBkaXNwYy5mYmRldi0+ZmJfaW5mb1swXS0+dmFyLnlyZXM7CisJQnBwID0g
ZGlzcGMuZmJkZXYtPmZiX2luZm9bMF0tPnZhci5iaXRzX3Blcl9waXhlbCAvIDg7CisKKwllbmFi
bGVfbGNkX2Nsb2NrcygxKTsKKworCXN3aXRjaCAoYW5nbGUpIHsKKwljYXNlIDA6CisJCW9tYXAy
X2Rpc3Bfc2V0X3ZyZmIod2lkdGgsIGhlaWdodCwgQnBwKTsKKwkJYWRkcl9iYXNlID0gU01TX1JP
VF9WSVJUX0JBU0UoMCwgMCkgKyBzYXZlX29mZnNldDsKKwkJZGlzcGNfd3JpdGVfcmVnKGJhX3Jl
Z1swXSwgYWRkcl9iYXNlKTsKKwkJZGlzcGNfd3JpdGVfcmVnKHBpX3JlZ1swXSwgMSk7CisJCWRp
c3BjX3dyaXRlX3JlZyhyaV9yZWdbMF0sIChST1RfTElORV9MRU5HVEggLSB3aWR0aCkgKiBCcHAg
KyAxKTsKKwkJYnJlYWs7CisJY2FzZSA5MDoKKwkJb21hcDJfZGlzcF9zZXRfdnJmYihoZWlnaHQs
IHdpZHRoLCBCcHApOworCQlhZGRyX2Jhc2UgPSBTTVNfUk9UX1ZJUlRfQkFTRSgwLCA5MCkgKyBz
YXZlX29mZnNldAorCQkJCQkrIHZyZmIueW9mZnNldCAqIEJwcDsKKworCQlkaXNwY193cml0ZV9y
ZWcoYmFfcmVnWzBdLCBhZGRyX2Jhc2UpOworCQlkaXNwY193cml0ZV9yZWcocGlfcmVnWzBdLCAx
KTsKKwkJZGlzcGNfd3JpdGVfcmVnKHJpX3JlZ1swXSwgKFJPVF9MSU5FX0xFTkdUSCAtIHdpZHRo
KSAqIEJwcCArIDEpOworCQlicmVhazsKKwljYXNlIDE4MDoKKwkJb21hcDJfZGlzcF9zZXRfdnJm
Yih3aWR0aCwgaGVpZ2h0LCBCcHApOworCQlhZGRyX2Jhc2UgPSBTTVNfUk9UX1ZJUlRfQkFTRSgw
LCAxODApICsgc2F2ZV9vZmZzZXQKKwkJCQkJKyB2cmZiLnhvZmZzZXQgKiBCcHAKKwkJCQkJKyBS
T1RfTElORV9MRU5HVEggKiB2cmZiLnlvZmZzZXQgKiBCcHA7CisKKwkJZGlzcGNfd3JpdGVfcmVn
KGJhX3JlZ1swXSwgYWRkcl9iYXNlKTsKKwkJZGlzcGNfd3JpdGVfcmVnKHBpX3JlZ1swXSwgMSk7
CisJCWRpc3BjX3dyaXRlX3JlZyhyaV9yZWdbMF0sIChST1RfTElORV9MRU5HVEggLSB3aWR0aCkg
KiBCcHAgKyAxKTsKKwkJYnJlYWs7CisJY2FzZSAyNzA6CisJCW9tYXAyX2Rpc3Bfc2V0X3ZyZmIo
aGVpZ2h0LCB3aWR0aCwgQnBwKTsKKwkJYWRkcl9iYXNlID0gU01TX1JPVF9WSVJUX0JBU0UoMCwg
MjcwKSArIHNhdmVfb2Zmc2V0CisJCQkJKyBST1RfTElORV9MRU5HVEggKiB2cmZiLnhvZmZzZXQg
KiBCcHA7CisKKwkJZGlzcGNfd3JpdGVfcmVnKGJhX3JlZ1swXSwgYWRkcl9iYXNlKTsKKwkJZGlz
cGNfd3JpdGVfcmVnKHBpX3JlZ1swXSwgMSk7CisJCWRpc3BjX3dyaXRlX3JlZyhyaV9yZWdbMF0s
IChST1RfTElORV9MRU5HVEggLSB3aWR0aCkgKiBCcHAgKyAxKTsKKwkJYnJlYWs7CisJfQorCisJ
TU9EX1JFR19GTEQoRElTUENfQ09OVFJPTCwgMHgyMCwgMCk7IC8qIFNldHMgJiBjbGVhcnMgdGhl
IEdPTENEIGJpdCAqLworCU1PRF9SRUdfRkxEKERJU1BDX0NPTlRST0wsIDB4MjAsIDB4MjApOwor
CWVuYWJsZV9sY2RfY2xvY2tzKDApOworCXJldHVybiAwOworfQorCiBzdGF0aWMgdm9pZCB3cml0
ZV9maXJoX3JlZyhpbnQgcGxhbmUsIGludCByZWcsIHUzMiB2YWx1ZSkKIHsKIAl1MzIgYmFzZTsK
QEAgLTE0MjIsOSArMTU2NSw3MCBAQCBzdGF0aWMgaW50IG9tYXBfZGlzcGNfaW5pdChzdHJ1Y3Qg
b21hcGZiX2RldmljZSAqZmJkZXYsIGludCBleHRfbW9kZSwKIAlpZiAoKHIgPSBhbGxvY19wYWxl
dHRlX3JhbSgpKSA8IDApCiAJCWdvdG8gZmFpbDI7CiAKKyNpZmRlZiBST1RBVElPTl9URVNUCisJ
bWVtc2V0KCZ2cmZiLCAwLCBzaXplb2YodnJmYikpOworCXZyZmJfcm90YXRpb24gPSAxOworCXZy
ZmIucGFkZHJbMF0gPSBTTVNfUk9UX1ZJUlRfQkFTRSgwLCAwKTsKKwl2cmZiLnBhZGRyWzFdID0g
U01TX1JPVF9WSVJUX0JBU0UoMCwgOTApOworCXZyZmIucGFkZHJbMl0gPSBTTVNfUk9UX1ZJUlRf
QkFTRSgwLCAxODApOworCXZyZmIucGFkZHJbM10gPSBTTVNfUk9UX1ZJUlRfQkFTRSgwLCAyNzAp
OworCisJaWYgKCFyZXF1ZXN0X21lbV9yZWdpb24odnJmYi5wYWRkclswXSwKKwkJCSAgcmVxX3Zy
YW0tPnJlZ2lvblswXS5zaXplLCAib21hcGZiIikpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJvbWFw
ZmI6IGNhbid0IHJlc2VydmUgVlJGQjAgYXJlYVxuIik7CisJCXZyZmJfcm90YXRpb24rKzsKKwl9
CisKKwlpZiAoIXJlcXVlc3RfbWVtX3JlZ2lvbih2cmZiLnBhZGRyWzFdLAorCQkJICByZXFfdnJh
bS0+cmVnaW9uWzBdLnNpemUsICJvbWFwZmIiKSkgeworCQlwcmludGsoS0VSTl9FUlIgIm9tYXBm
YjogY2FuJ3QgcmVzZXJ2ZSBWUkZCOTAgYXJlYVxuIik7CisJCXZyZmJfcm90YXRpb24rKzsKKwl9
CisKKwlpZiAoIXJlcXVlc3RfbWVtX3JlZ2lvbih2cmZiLnBhZGRyWzJdLAorCQkJICByZXFfdnJh
bS0+cmVnaW9uWzBdLnNpemUsICJvbWFwZmIiKSkgeworCQlwcmludGsoS0VSTl9FUlIgIm9tYXBm
YjogY2FuJ3QgcmVzZXJ2ZSBWUkZCMTgwIGFyZWFcbiIpOworCQl2cmZiX3JvdGF0aW9uKys7CisJ
fQorCisJaWYgKCFyZXF1ZXN0X21lbV9yZWdpb24odnJmYi5wYWRkclszXSwKKwkJCSAgcmVxX3Zy
YW0tPnJlZ2lvblswXS5zaXplLCAib21hcGZiIikpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJvbWFw
ZmI6IGNhbid0IHJlc2VydmUgVlJGQjI3MCBhcmVhXG4iKTsKKwkJdnJmYl9yb3RhdGlvbisrOwor
CX0KKworCXZyZmIudmFkZHJbMF0gPSAodW5zaWduZWQgbG9uZylpb3JlbWFwKHZyZmIucGFkZHJb
MF0sCisJCQkJCQlyZXFfdnJhbS0+cmVnaW9uWzBdLnNpemUpOworCXZyZmIudmFkZHJbMV0gPSAo
dW5zaWduZWQgbG9uZylpb3JlbWFwKHZyZmIucGFkZHJbMV0sCisJCQkJCQlyZXFfdnJhbS0+cmVn
aW9uWzBdLnNpemUpOworCXZyZmIudmFkZHJbMl0gPSAodW5zaWduZWQgbG9uZylpb3JlbWFwKHZy
ZmIucGFkZHJbMl0sCisJCQkJCQlyZXFfdnJhbS0+cmVnaW9uWzBdLnNpemUpOworCXZyZmIudmFk
ZHJbM10gPSAodW5zaWduZWQgbG9uZylpb3JlbWFwKHZyZmIucGFkZHJbM10sCisJCQkJCQlyZXFf
dnJhbS0+cmVnaW9uWzBdLnNpemUpOworCWlmICgoIXZyZmIudmFkZHJbMF0pIHx8ICghdnJmYi52
YWRkclsxXSkgfHwgKCF2cmZiLnZhZGRyWzJdKQorCQkJCQkJfHwgKCF2cmZiLnZhZGRyWzNdKSkg
eworCQlwcmludGsoS0VSTl9FUlIgIm9tYXBmYjogY2FuJ3QgbWFwIHJvdGF0ZWQgdmlldyhzKVxu
Iik7CisJCXZyZmJfcm90YXRpb24rKzsKKwl9CisjZW5kaWYKKwogCWlmICgociA9IHNldHVwX2Zi
bWVtKHJlcV92cmFtKSkgPCAwKQogCQlnb3RvIGZhaWwzOwogCisJaWYgKHZyZmJfcm90YXRpb24g
PT0gMSkgeworCQlzYXZlX3BhZGRyID0gZGlzcGMubWVtX2Rlc2MucmVnaW9uWzBdLnBhZGRyOwor
CQlzYXZlX3ZhZGRyID0gKHVuc2lnbmVkIGxvbmcpZGlzcGMubWVtX2Rlc2MucmVnaW9uWzBdLnZh
ZGRyOworCisJCWRpc3BjLm1lbV9kZXNjLnJlZ2lvblswXS52YWRkciA9ICh2b2lkICopdnJmYi52
YWRkclswXTsKKwkJZGlzcGMubWVtX2Rlc2MucmVnaW9uWzBdLnBhZGRyID0gdnJmYi5wYWRkclsw
XTsKKwkJZGlzcGMuZmJkZXYtPm1lbV9kZXNjLnJlZ2lvblswXS52YWRkciA9CisJCQkJCQkodm9p
ZCAqKXZyZmIudmFkZHJbMF07CisKKwkJZGlzcGMuZmJkZXYtPm1lbV9kZXNjLnJlZ2lvblswXS5w
YWRkciA9IHZyZmIucGFkZHJbMF07CisJCW9tYXAyX2Rpc3Bfc2V0X3ZyZmIocGFuZWwtPnhfcmVz
LCBwYW5lbC0+eV9yZXMsCisJCQkJCQkJIHBhbmVsLT5icHAgLyA4KTsKKwl9CisKIAlpZiAoIXNr
aXBfaW5pdCkgewogCQlmb3IgKGkgPSAwOyBpIDwgZGlzcGMubWVtX2Rlc2MucmVnaW9uX2NudDsg
aSsrKSB7CiAJCQltZW1zZXQoZGlzcGMubWVtX2Rlc2MucmVnaW9uW2ldLnZhZGRyLCAwLApAQCAt
MTUwMyw0ICsxNzA3LDUgQEAgY29uc3Qgc3RydWN0IGxjZF9jdHJsIG9tYXAyX2ludF9jdHJsID0g
ewogCS5zZXRfY29sb3Jfa2V5CQk9IG9tYXBfZGlzcGNfc2V0X2NvbG9yX2tleSwKIAkuZ2V0X2Nv
bG9yX2tleQkJPSBvbWFwX2Rpc3BjX2dldF9jb2xvcl9rZXksCiAJLm1tYXAJCQk9IG9tYXBfZGlz
cGNfbW1hcF91c2VyLAorCS5zZXRfcm90YXRlCQk9IG9tYXBfZGlzcGNfc2V0X3JvdGF0ZSwKIH07
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYyBiL2RyaXZlcnMv
dmlkZW8vb21hcC9vbWFwZmJfbWFpbi5jCmluZGV4IDQxOGVkOWYuLjJhOTUwMGIgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvdmlkZW8vb21hcC9vbWFwZmJfbWFpbi5jCisrKyBiL2RyaXZlcnMvdmlkZW8v
b21hcC9vbWFwZmJfbWFpbi5jCkBAIC0zMiw2ICszMiw4IEBACiAjaW5jbHVkZSA8YXNtL2FyY2gv
b21hcGZiLmg+CiAKICNkZWZpbmUgTU9EVUxFX05BTUUJIm9tYXBmYiIKKyNkZWZpbmUJUk9UQVRJ
T05fVEVTVAkxCisjZGVmaW5lCVJPVF9MSU5FX0xFTkdUSAkyMDQ4CiAKIHN0YXRpYyB1bnNpZ25l
ZCBpbnQJZGVmX2FjY2VsOwogc3RhdGljIHVuc2lnbmVkIGxvbmcJZGVmX3ZyYW1bT01BUEZCX1BM
QU5FX05VTV07CkBAIC00MjIsNyArNDI0LDExIEBAIHN0YXRpYyB2b2lkIHNldF9mYl9maXgoc3Ry
dWN0IGZiX2luZm8gKmZiaSkKIAkJYnJlYWs7CiAJfQogCWZpeC0+YWNjZWwJCT0gRkJfQUNDRUxf
T01BUDE2MTA7CisjaWZkZWYgUk9UQVRJT05fVEVTVAorCWZpeC0+bGluZV9sZW5ndGgJPSBST1Rf
TElORV9MRU5HVEggKiBicHAgLyA4OworI2Vsc2UKIAlmaXgtPmxpbmVfbGVuZ3RoCT0gdmFyLT54
cmVzX3ZpcnR1YWwgKiBicHAgLyA4OworI2VuZGlmCiB9CiAKIHN0YXRpYyBpbnQgc2V0X2NvbG9y
X21vZGUoc3RydWN0IG9tYXBmYl9wbGFuZV9zdHJ1Y3QgKnBsYW5lLApAQCAtNDk1LDEzICs1MDEs
MTQgQEAgc3RhdGljIGludCBzZXRfZmJfdmFyKHN0cnVjdCBmYl9pbmZvICpmYmksCiAJaWYgKHBs
YW5lLT5jb2xvcl9tb2RlID09IE9NQVBGQl9DT0xPUl9SR0I0NDQpCiAJCWJwcCA9IDE2OwogCisJ
eHJlc19taW4gPSBPTUFQRkJfUExBTkVfWFJFU19NSU47CisJeHJlc19tYXggPSBwYW5lbC0+eF9y
ZXM7CisJeXJlc19taW4gPSBPTUFQRkJfUExBTkVfWVJFU19NSU47CisJeXJlc19tYXggPSBwYW5l
bC0+eV9yZXM7CisKIAlzd2l0Y2ggKHZhci0+cm90YXRlKSB7CiAJY2FzZSAwOgogCWNhc2UgMTgw
OgotCQl4cmVzX21pbiA9IE9NQVBGQl9QTEFORV9YUkVTX01JTjsKLQkJeHJlc19tYXggPSBwYW5l
bC0+eF9yZXM7Ci0JCXlyZXNfbWluID0gT01BUEZCX1BMQU5FX1lSRVNfTUlOOwotCQl5cmVzX21h
eCA9IHBhbmVsLT55X3JlczsKIAkJaWYgKGNwdV9pc19vbWFwMTV4eCgpKSB7CiAJCQl2YXItPnhy
ZXMgPSBwYW5lbC0+eF9yZXM7CiAJCQl2YXItPnlyZXMgPSBwYW5lbC0+eV9yZXM7CkBAIC01MDks
MTAgKzUxNiw2IEBAIHN0YXRpYyBpbnQgc2V0X2ZiX3ZhcihzdHJ1Y3QgZmJfaW5mbyAqZmJpLAog
CQlicmVhazsKIAljYXNlIDkwOgogCWNhc2UgMjcwOgotCQl4cmVzX21pbiA9IE9NQVBGQl9QTEFO
RV9ZUkVTX01JTjsKLQkJeHJlc19tYXggPSBwYW5lbC0+eV9yZXM7Ci0JCXlyZXNfbWluID0gT01B
UEZCX1BMQU5FX1hSRVNfTUlOOwotCQl5cmVzX21heCA9IHBhbmVsLT54X3JlczsKIAkJaWYgKGNw
dV9pc19vbWFwMTV4eCgpKSB7CiAJCQl2YXItPnhyZXMgPSBwYW5lbC0+eV9yZXM7CiAJCQl2YXIt
PnlyZXMgPSBwYW5lbC0+eF9yZXM7CkBAIC0xNzE1LDcgKzE3MTgsMTEgQEAgc3RhdGljIGludCBv
bWFwZmJfZG9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKIAogCXByX2luZm8o
Im9tYXBmYjogY29uZmlndXJlZCBmb3IgcGFuZWwgJXNcbiIsIGZiZGV2LT5wYW5lbC0+bmFtZSk7
CiAKKyNpZmRlZiBST1RBVElPTl9URVNUCisJZGVmX3Z4cmVzID0gUk9UX0xJTkVfTEVOR1RIOwor
I2Vsc2UKIAlkZWZfdnhyZXMgPSBkZWZfdnhyZXMgPyA6IGZiZGV2LT5wYW5lbC0+eF9yZXM7Cisj
ZW5kaWYKIAlkZWZfdnlyZXMgPSBkZWZfdnlyZXMgPyA6IGZiZGV2LT5wYW5lbC0+eV9yZXM7CiAK
IAlpbml0X3N0YXRlKys7Ci0tIAoxLjUuMy40Cgo=
------=_Part_11629_8224857.1208778439656--
