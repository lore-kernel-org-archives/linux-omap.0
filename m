From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] This patch adds VRFB based rotation support to omapfb
Date: Mon, 21 Apr 2008 15:40:02 +0530
Message-ID: <c656a4d20804210310x4b4a032agd2f91e35399b1be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11342_16100655.1208772602749"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:60036 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbYDUKKX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 06:10:23 -0400
Received: by yw-out-2324.google.com with SMTP id 5so964247ywb.1
        for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2008 03:10:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_11342_16100655.1208772602749
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I am resending the patch with changes as suggested by felipe balbi

I also have attached the patch with this mail.( because i think my email program
introduces some unnecessary formatting stuff into patch)

########################################

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



Regards,
Arun c

------=_Part_11342_16100655.1208772602749
Content-Type: text/x-patch;
 name=0001-This-patch-adds-VRFB-based-rotation-support-to-omapf.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffauqn4v0
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
dW5tYXBwaW5nIHRoZSBWUkZCIHJlZ2lvbnMpCi0tLQogZHJpdmVycy92aWRlby9vbWFwL2Rpc3Bj
LmMgICAgICAgfCAgMjA1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBk
cml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYyB8ICAgMjMgKysrLS0KIDIgZmlsZXMgY2hh
bmdlZCwgMjIwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aWRlby9vbWFwL2Rpc3BjLmMgYi9kcml2ZXJzL3ZpZGVvL29tYXAvZGlzcGMuYwppbmRl
eCA0YzA1NWEyLi5mN2Q0YWNkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL29tYXAvZGlzcGMu
YworKysgYi9kcml2ZXJzL3ZpZGVvL29tYXAvZGlzcGMuYwpAQCAtMTQ4LDYgKzE0OCw0MyBAQAog
I2RlZmluZSBSRVNNQVBfTUFTSyhfcGFnZV9ucikJCQkJCQlcCiAJKDEgPDwgKChfcGFnZV9ucikg
JiAoc2l6ZW9mKHVuc2lnbmVkIGxvbmcpICogOCAtIDEpKSkKIAorLyogUm90YXRpb24gdXNpbmcg
VlJGQiAqLworI2RlZmluZSBST1RBVElPTl9URVNUCQkxCisjZGVmaW5lIFNNU19ST1RfVklSVF9C
QVNFKGNvbnRleHQsIGRlZ3JlZSkJKDB4NzAwMDAwMDAJCVwKKwkJCQkJCXwgMHg0MDAwMDAwICog
KGNvbnRleHQpCVwKKwkJCQkJCXwgMHgxMDAwMDAwICogKGRlZ3JlZS85MCkpCisjZGVmaW5lIFZS
RkJfU0laRQkJKDIwNDggKiA2NDAgKiAoMTYvOCkpCisjZGVmaW5lIFBBR0VfV0lEVEhfRVhQCQk1
IC8qIEFzc3VtaW5nIFNEUkFNIHBhZ2VzaXplPSAxMDI0ICovCisjZGVmaW5lIFBBR0VfSEVJR0hU
X0VYUAkJNSAvKiAxMDI0ID0gMl41ICogMl41ICovCisjZGVmaW5lIFNNU19JTUFHRUhFSUdIVF9P
RkZTRVQJMTYKKyNkZWZpbmUgU01TX0lNQUdFV0lEVEhfT0ZGU0VUCTAKKyNkZWZpbmUgU01TX1BI
X09GRlNFVAkJOAorI2RlZmluZSBTTVNfUFdfT0ZGU0VUCQk0CisjZGVmaW5lIFNNU19QU19PRkZT
RVQJCTAKKyNkZWZpbmUgUk9UX0xJTkVfTEVOR1RICQkyMDQ4CisKKyNkZWZpbmUgT01BUF9TTVNf
QkFTRQkJKDB4NkMwMDAwMDApCisjZGVmaW5lIFNNU19ST1QwX1BIWVNJQ0FMX0JBKGNvbnRleHQp
CV9fUkVHMzIoT01BUF9TTVNfQkFTRSArIDB4MTg4IFwKKwkJCQkJCSsgMHgxMCAqIGNvbnRleHQp
CisjZGVmaW5lIFNNU19ST1RfQ09OVFJPTChjb250ZXh0KQlfX1JFRzMyKE9NQVBfU01TX0JBU0Ug
KyAweDE4MCBcCisJCQkJCQkrIDB4MTAgKiBjb250ZXh0KQorI2RlZmluZSBTTVNfUk9UMF9TSVpF
KGNvbnRleHQpCQlfX1JFRzMyKE9NQVBfU01TX0JBU0UgKyAweDE4NCBcCisJCQkJCQkrIDB4MTAg
KiBjb250ZXh0KQorCitkbWFfYWRkcl90IHNhdmVfcGFkZHI7Cit1bnNpZ25lZCBsb25nIHNhdmVf
dmFkZHI7Cit1bnNpZ25lZCBsb25nIHNhdmVfb2Zmc2V0OworaW50IHZyZmJfcm90YXRpb247CisK
K3N0YXRpYyBzdHJ1Y3QgeworCWRtYV9hZGRyX3QJcGFkZHJbNF07CisJdW5zaWduZWQgbG9uZwl2
YWRkcls0XTsKKwl1MzIgeG9mZnNldDsKKwl1MzIgeW9mZnNldDsKK30gdnJmYjsKKworc3RhdGlj
IGludCBvbWFwMl9kaXNwX3NldF92cmZiKHUzMiB3aWR0aCwgdTMyIGhlaWdodCwgdTMyIGJ5dGVz
X3Blcl9waXhlbCk7CisKIHN0cnVjdCByZXNtYXAgewogCXVuc2lnbmVkIGxvbmcJc3RhcnQ7CiAJ
dW5zaWduZWQJcGFnZV9jbnQ7CkBAIC00NDksNiArNDg2LDcgQEAgc3RhdGljIGludCBvbWFwX2Rp
c3BjX3NldHVwX3BsYW5lKGludCBwbGFuZSwgaW50IGNoYW5uZWxfb3V0LAogCiAJaWYgKCh1bnNp
Z25lZClwbGFuZSA+IGRpc3BjLm1lbV9kZXNjLnJlZ2lvbl9jbnQpCiAJCXJldHVybiAtRUlOVkFM
OworCXNhdmVfb2Zmc2V0ID0gb2Zmc2V0OwogCXBhZGRyID0gZGlzcGMubWVtX2Rlc2MucmVnaW9u
W3BsYW5lXS5wYWRkciArIG9mZnNldDsKIAllbmFibGVfbGNkX2Nsb2NrcygxKTsKIAlyID0gX3Nl
dHVwX3BsYW5lKHBsYW5lLCBjaGFubmVsX291dCwgcGFkZHIsCkBAIC00NTgsNiArNDk2LDExMSBA
QCBzdGF0aWMgaW50IG9tYXBfZGlzcGNfc2V0dXBfcGxhbmUoaW50IHBsYW5lLCBpbnQgY2hhbm5l
bF9vdXQsCiAJcmV0dXJuIHI7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdTMyCitjYWxjX3ZyZmJfZGl2
KHUzMiBpbWdfc2lkZSwgdTMyIHBhZ2VfZXhwKQoreworCXUzMiBkaXY7CisJZGl2ID0gaW1nX3Np
ZGUgLyBwYWdlX2V4cDsKKwlpZiAoKGRpdiAqIHBhZ2VfZXhwKSA8IGltZ19zaWRlKQorCQlyZXR1
cm4gZGl2ICsgMTsKKwllbHNlCisJCXJldHVybiBkaXY7Cit9CisKK3N0YXRpYyBpbnQgb21hcDJf
ZGlzcF9zZXRfdnJmYih1MzIgd2lkdGgsIHUzMiBoZWlnaHQsIHUzMiBieXRlc19wZXJfcGl4ZWwp
Cit7CisJaW50IHBhZ2Vfd2lkdGhfZXhwLCBwYWdlX2hlaWdodF9leHAsIHBpeGVsX3NpemVfZXhw
OworCWludCBjb250ZXh0ID0gMDsKKwlpbnQgZGl2OworCXUzMiB2cmZiX3dpZHRoOworCXUzMiB2
cmZiX2hlaWdodDsKKworCXBhZ2Vfd2lkdGhfZXhwID0gUEFHRV9XSURUSF9FWFA7CisJcGFnZV9o
ZWlnaHRfZXhwID0gUEFHRV9IRUlHSFRfRVhQOworCXBpeGVsX3NpemVfZXhwID0gYnl0ZXNfcGVy
X3BpeGVsID4+IDE7CisKKwlkaXYgPSBjYWxjX3ZyZmJfZGl2KHdpZHRoICogYnl0ZXNfcGVyX3Bp
eGVsLCAxIDw8IHBhZ2Vfd2lkdGhfZXhwKTsKKwl2cmZiX3dpZHRoID0gKGRpdiAqICgxIDw8IHBh
Z2Vfd2lkdGhfZXhwKSkgLyBieXRlc19wZXJfcGl4ZWw7CisKKwlkaXYgPSBjYWxjX3ZyZmJfZGl2
KGhlaWdodCwgMSA8PCBwYWdlX2hlaWdodF9leHApOworCXZyZmJfaGVpZ2h0ID0gZGl2ICogKDEg
PDwgcGFnZV9oZWlnaHRfZXhwKTsKKworCVNNU19ST1QwX1BIWVNJQ0FMX0JBKGNvbnRleHQpID0g
c2F2ZV9wYWRkcjsKKwlTTVNfUk9UMF9TSVpFKGNvbnRleHQpID0gMDsKKwlTTVNfUk9UMF9TSVpF
KGNvbnRleHQpCXw9ICh2cmZiX3dpZHRoIDw8IFNNU19JTUFHRVdJRFRIX09GRlNFVCkKKwkJCQl8
ICh2cmZiX2hlaWdodCA8PCBTTVNfSU1BR0VIRUlHSFRfT0ZGU0VUKTsKKwlTTVNfUk9UX0NPTlRS
T0woY29udGV4dCkgPSAwOworCVNNU19ST1RfQ09OVFJPTChjb250ZXh0KSB8PSBwaXhlbF9zaXpl
X2V4cCA8PCBTTVNfUFNfT0ZGU0VUCisJCQl8IHBhZ2Vfd2lkdGhfZXhwICA8PCBTTVNfUFdfT0ZG
U0VUCisJCQl8IHBhZ2VfaGVpZ2h0X2V4cCA8PCBTTVNfUEhfT0ZGU0VUOworCisJdnJmYi54b2Zm
c2V0ID0gdnJmYl93aWR0aCAtIHdpZHRoOworCXZyZmIueW9mZnNldCA9IHZyZmJfaGVpZ2h0IC0g
aGVpZ2h0OworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IG9tYXBfZGlzcGNfc2V0X3JvdGF0
ZShpbnQgYW5nbGUpCit7CisJY29uc3QgdTMyIGJhX3JlZ1tdID0geyBESVNQQ19HRlhfQkEwIH07
CisJY29uc3QgdTMyIHJpX3JlZ1tdID0geyBESVNQQ19HRlhfUk9XX0lOQyB9OworCWNvbnN0IHUz
MiBwaV9yZWdbXSA9IHsgRElTUENfR0ZYX1BJWEVMX0lOQyB9OworCWludCB3aWR0aCwgaGVpZ2h0
OworCXUzMiBhZGRyX2Jhc2U7CisJdTMyIEJwcDsKKworCWlmICh2cmZiX3JvdGF0aW9uICE9IDEp
CisJCXJldHVybiAwOworCisJd2lkdGggPSBkaXNwYy5mYmRldi0+ZmJfaW5mb1swXS0+dmFyLnhy
ZXM7CisJaGVpZ2h0ID0gZGlzcGMuZmJkZXYtPmZiX2luZm9bMF0tPnZhci55cmVzOworCUJwcCA9
IGRpc3BjLmZiZGV2LT5mYl9pbmZvWzBdLT52YXIuYml0c19wZXJfcGl4ZWwgLyA4OworCisJZW5h
YmxlX2xjZF9jbG9ja3MoMSk7CisKKwlzd2l0Y2ggKGFuZ2xlKSB7CisJY2FzZSAwOgorCQlvbWFw
Ml9kaXNwX3NldF92cmZiKHdpZHRoLCBoZWlnaHQsIEJwcCk7CisJCWFkZHJfYmFzZSA9IFNNU19S
T1RfVklSVF9CQVNFKDAsIDApICsgc2F2ZV9vZmZzZXQ7CisJCWRpc3BjX3dyaXRlX3JlZyhiYV9y
ZWdbMF0sIGFkZHJfYmFzZSk7CisJCWRpc3BjX3dyaXRlX3JlZyhwaV9yZWdbMF0sIDEpOworCQlk
aXNwY193cml0ZV9yZWcocmlfcmVnWzBdLCAoUk9UX0xJTkVfTEVOR1RIIC0gd2lkdGgpICogQnBw
ICsgMSk7CisJCWJyZWFrOworCWNhc2UgOTA6CisJCW9tYXAyX2Rpc3Bfc2V0X3ZyZmIoaGVpZ2h0
LCB3aWR0aCwgQnBwKTsKKwkJYWRkcl9iYXNlID0gU01TX1JPVF9WSVJUX0JBU0UoMCwgOTApICsg
c2F2ZV9vZmZzZXQKKwkJCQkJKyB2cmZiLnlvZmZzZXQgKiBCcHA7CisKKwkJZGlzcGNfd3JpdGVf
cmVnKGJhX3JlZ1swXSwgYWRkcl9iYXNlKTsKKwkJZGlzcGNfd3JpdGVfcmVnKHBpX3JlZ1swXSwg
MSk7CisJCWRpc3BjX3dyaXRlX3JlZyhyaV9yZWdbMF0sIChST1RfTElORV9MRU5HVEggLSB3aWR0
aCkgKiBCcHAgKyAxKTsKKwkJYnJlYWs7CisJY2FzZSAxODA6CisJCW9tYXAyX2Rpc3Bfc2V0X3Zy
ZmIod2lkdGgsIGhlaWdodCwgQnBwKTsKKwkJYWRkcl9iYXNlID0gU01TX1JPVF9WSVJUX0JBU0Uo
MCwgMTgwKSArIHNhdmVfb2Zmc2V0CisJCQkJCSsgdnJmYi54b2Zmc2V0ICogQnBwCisJCQkJCSsg
Uk9UX0xJTkVfTEVOR1RIICogdnJmYi55b2Zmc2V0ICogQnBwOworCisJCWRpc3BjX3dyaXRlX3Jl
ZyhiYV9yZWdbMF0sIGFkZHJfYmFzZSk7CisJCWRpc3BjX3dyaXRlX3JlZyhwaV9yZWdbMF0sIDEp
OworCQlkaXNwY193cml0ZV9yZWcocmlfcmVnWzBdLCAoUk9UX0xJTkVfTEVOR1RIIC0gd2lkdGgp
ICogQnBwICsgMSk7CisJCWJyZWFrOworCWNhc2UgMjcwOgorCQlvbWFwMl9kaXNwX3NldF92cmZi
KGhlaWdodCwgd2lkdGgsIEJwcCk7CisJCWFkZHJfYmFzZSA9IFNNU19ST1RfVklSVF9CQVNFKDAs
IDI3MCkgKyBzYXZlX29mZnNldAorCQkJCSsgUk9UX0xJTkVfTEVOR1RIICogdnJmYi54b2Zmc2V0
ICogQnBwOworCisJCWRpc3BjX3dyaXRlX3JlZyhiYV9yZWdbMF0sIGFkZHJfYmFzZSk7CisJCWRp
c3BjX3dyaXRlX3JlZyhwaV9yZWdbMF0sIDEpOworCQlkaXNwY193cml0ZV9yZWcocmlfcmVnWzBd
LCAoUk9UX0xJTkVfTEVOR1RIIC0gd2lkdGgpICogQnBwICsgMSk7CisJCWJyZWFrOworCX0KKwor
CU1PRF9SRUdfRkxEKERJU1BDX0NPTlRST0wsIDB4MjAsIDApOyAvKiBTZXRzICYgY2xlYXJzIHRo
ZSBHT0xDRCBiaXQgKi8KKwlNT0RfUkVHX0ZMRChESVNQQ19DT05UUk9MLCAweDIwLCAweDIwKTsK
KwllbmFibGVfbGNkX2Nsb2NrcygwKTsKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIHZvaWQgd3Jp
dGVfZmlyaF9yZWcoaW50IHBsYW5lLCBpbnQgcmVnLCB1MzIgdmFsdWUpCiB7CiAJdTMyIGJhc2U7
CkBAIC0xNDIyLDkgKzE1NjUsNzAgQEAgc3RhdGljIGludCBvbWFwX2Rpc3BjX2luaXQoc3RydWN0
IG9tYXBmYl9kZXZpY2UgKmZiZGV2LCBpbnQgZXh0X21vZGUsCiAJaWYgKChyID0gYWxsb2NfcGFs
ZXR0ZV9yYW0oKSkgPCAwKQogCQlnb3RvIGZhaWwyOwogCisjaWZkZWYgUk9UQVRJT05fVEVTVAor
CW1lbXNldCgmdnJmYiwgMCwgc2l6ZW9mKHZyZmIpKTsKKwl2cmZiX3JvdGF0aW9uID0gMTsKKwl2
cmZiLnBhZGRyWzBdID0gU01TX1JPVF9WSVJUX0JBU0UoMCwgMCk7CisJdnJmYi5wYWRkclsxXSA9
IFNNU19ST1RfVklSVF9CQVNFKDAsIDkwKTsKKwl2cmZiLnBhZGRyWzJdID0gU01TX1JPVF9WSVJU
X0JBU0UoMCwgMTgwKTsKKwl2cmZiLnBhZGRyWzNdID0gU01TX1JPVF9WSVJUX0JBU0UoMCwgMjcw
KTsKKworCWlmICghcmVxdWVzdF9tZW1fcmVnaW9uKHZyZmIucGFkZHJbMF0sCisJCQkgIHJlcV92
cmFtLT5yZWdpb25bMF0uc2l6ZSwgIm9tYXBmYiIpKSB7CisJCXByaW50ayhLRVJOX0VSUiAib21h
cGZiOiBjYW4ndCByZXNlcnZlIFZSRkIwIGFyZWFcbiIpOworCQl2cmZiX3JvdGF0aW9uKys7CisJ
fQorCisJaWYgKCFyZXF1ZXN0X21lbV9yZWdpb24odnJmYi5wYWRkclsxXSwKKwkJCSAgcmVxX3Zy
YW0tPnJlZ2lvblswXS5zaXplLCAib21hcGZiIikpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJvbWFw
ZmI6IGNhbid0IHJlc2VydmUgVlJGQjkwIGFyZWFcbiIpOworCQl2cmZiX3JvdGF0aW9uKys7CisJ
fQorCisJaWYgKCFyZXF1ZXN0X21lbV9yZWdpb24odnJmYi5wYWRkclsyXSwKKwkJCSAgcmVxX3Zy
YW0tPnJlZ2lvblswXS5zaXplLCAib21hcGZiIikpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJvbWFw
ZmI6IGNhbid0IHJlc2VydmUgVlJGQjE4MCBhcmVhXG4iKTsKKwkJdnJmYl9yb3RhdGlvbisrOwor
CX0KKworCWlmICghcmVxdWVzdF9tZW1fcmVnaW9uKHZyZmIucGFkZHJbM10sCisJCQkgIHJlcV92
cmFtLT5yZWdpb25bMF0uc2l6ZSwgIm9tYXBmYiIpKSB7CisJCXByaW50ayhLRVJOX0VSUiAib21h
cGZiOiBjYW4ndCByZXNlcnZlIFZSRkIyNzAgYXJlYVxuIik7CisJCXZyZmJfcm90YXRpb24rKzsK
Kwl9CisKKwl2cmZiLnZhZGRyWzBdID0gKHVuc2lnbmVkIGxvbmcpaW9yZW1hcCh2cmZiLnBhZGRy
WzBdLAorCQkJCQkJcmVxX3ZyYW0tPnJlZ2lvblswXS5zaXplKTsKKwl2cmZiLnZhZGRyWzFdID0g
KHVuc2lnbmVkIGxvbmcpaW9yZW1hcCh2cmZiLnBhZGRyWzFdLAorCQkJCQkJcmVxX3ZyYW0tPnJl
Z2lvblswXS5zaXplKTsKKwl2cmZiLnZhZGRyWzJdID0gKHVuc2lnbmVkIGxvbmcpaW9yZW1hcCh2
cmZiLnBhZGRyWzJdLAorCQkJCQkJcmVxX3ZyYW0tPnJlZ2lvblswXS5zaXplKTsKKwl2cmZiLnZh
ZGRyWzNdID0gKHVuc2lnbmVkIGxvbmcpaW9yZW1hcCh2cmZiLnBhZGRyWzNdLAorCQkJCQkJcmVx
X3ZyYW0tPnJlZ2lvblswXS5zaXplKTsKKwlpZiAoKCF2cmZiLnZhZGRyWzBdKSB8fCAoIXZyZmIu
dmFkZHJbMV0pIHx8ICghdnJmYi52YWRkclsyXSkKKwkJCQkJCXx8ICghdnJmYi52YWRkclszXSkp
IHsKKwkJcHJpbnRrKEtFUk5fRVJSICJvbWFwZmI6IGNhbid0IG1hcCByb3RhdGVkIHZpZXcocylc
biIpOworCQl2cmZiX3JvdGF0aW9uKys7CisJfQorI2VuZGlmCisKIAlpZiAoKHIgPSBzZXR1cF9m
Ym1lbShyZXFfdnJhbSkpIDwgMCkKIAkJZ290byBmYWlsMzsKIAorCWlmICh2cmZiX3JvdGF0aW9u
ID09IDEpIHsKKwkJc2F2ZV9wYWRkciA9IGRpc3BjLm1lbV9kZXNjLnJlZ2lvblswXS5wYWRkcjsK
KwkJc2F2ZV92YWRkciA9ICh1bnNpZ25lZCBsb25nKWRpc3BjLm1lbV9kZXNjLnJlZ2lvblswXS52
YWRkcjsKKworCQlkaXNwYy5tZW1fZGVzYy5yZWdpb25bMF0udmFkZHIgPSAodm9pZCAqKXZyZmIu
dmFkZHJbMF07CisJCWRpc3BjLm1lbV9kZXNjLnJlZ2lvblswXS5wYWRkciA9IHZyZmIucGFkZHJb
MF07CisJCWRpc3BjLmZiZGV2LT5tZW1fZGVzYy5yZWdpb25bMF0udmFkZHIgPQorCQkJCQkJKHZv
aWQgKil2cmZiLnZhZGRyWzBdOworCisJCWRpc3BjLmZiZGV2LT5tZW1fZGVzYy5yZWdpb25bMF0u
cGFkZHIgPSB2cmZiLnBhZGRyWzBdOworCQlvbWFwMl9kaXNwX3NldF92cmZiKHBhbmVsLT54X3Jl
cywgcGFuZWwtPnlfcmVzLAorCQkJCQkJCSBwYW5lbC0+YnBwIC8gOCk7CisJfQorCiAJaWYgKCFz
a2lwX2luaXQpIHsKIAkJZm9yIChpID0gMDsgaSA8IGRpc3BjLm1lbV9kZXNjLnJlZ2lvbl9jbnQ7
IGkrKykgewogCQkJbWVtc2V0KGRpc3BjLm1lbV9kZXNjLnJlZ2lvbltpXS52YWRkciwgMCwKQEAg
LTE1MDMsNCArMTcwNyw1IEBAIGNvbnN0IHN0cnVjdCBsY2RfY3RybCBvbWFwMl9pbnRfY3RybCA9
IHsKIAkuc2V0X2NvbG9yX2tleQkJPSBvbWFwX2Rpc3BjX3NldF9jb2xvcl9rZXksCiAJLmdldF9j
b2xvcl9rZXkJCT0gb21hcF9kaXNwY19nZXRfY29sb3Jfa2V5LAogCS5tbWFwCQkJPSBvbWFwX2Rp
c3BjX21tYXBfdXNlciwKKwkuc2V0X3JvdGF0ZQkJPSBvbWFwX2Rpc3BjX3NldF9yb3RhdGUsCiB9
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9vbWFwL29tYXBmYl9tYWluLmMgYi9kcml2ZXJz
L3ZpZGVvL29tYXAvb21hcGZiX21haW4uYwppbmRleCA0MThlZDlmLi4yYTk1MDBiIDEwMDY0NAot
LS0gYS9kcml2ZXJzL3ZpZGVvL29tYXAvb21hcGZiX21haW4uYworKysgYi9kcml2ZXJzL3ZpZGVv
L29tYXAvb21hcGZiX21haW4uYwpAQCAtMzIsNiArMzIsOCBAQAogI2luY2x1ZGUgPGFzbS9hcmNo
L29tYXBmYi5oPgogCiAjZGVmaW5lIE1PRFVMRV9OQU1FCSJvbWFwZmIiCisjZGVmaW5lCVJPVEFU
SU9OX1RFU1QJMQorI2RlZmluZQlST1RfTElORV9MRU5HVEgJMjA0OAogCiBzdGF0aWMgdW5zaWdu
ZWQgaW50CWRlZl9hY2NlbDsKIHN0YXRpYyB1bnNpZ25lZCBsb25nCWRlZl92cmFtW09NQVBGQl9Q
TEFORV9OVU1dOwpAQCAtNDIyLDcgKzQyNCwxMSBAQCBzdGF0aWMgdm9pZCBzZXRfZmJfZml4KHN0
cnVjdCBmYl9pbmZvICpmYmkpCiAJCWJyZWFrOwogCX0KIAlmaXgtPmFjY2VsCQk9IEZCX0FDQ0VM
X09NQVAxNjEwOworI2lmZGVmIFJPVEFUSU9OX1RFU1QKKwlmaXgtPmxpbmVfbGVuZ3RoCT0gUk9U
X0xJTkVfTEVOR1RIICogYnBwIC8gODsKKyNlbHNlCiAJZml4LT5saW5lX2xlbmd0aAk9IHZhci0+
eHJlc192aXJ0dWFsICogYnBwIC8gODsKKyNlbmRpZgogfQogCiBzdGF0aWMgaW50IHNldF9jb2xv
cl9tb2RlKHN0cnVjdCBvbWFwZmJfcGxhbmVfc3RydWN0ICpwbGFuZSwKQEAgLTQ5NSwxMyArNTAx
LDE0IEBAIHN0YXRpYyBpbnQgc2V0X2ZiX3ZhcihzdHJ1Y3QgZmJfaW5mbyAqZmJpLAogCWlmIChw
bGFuZS0+Y29sb3JfbW9kZSA9PSBPTUFQRkJfQ09MT1JfUkdCNDQ0KQogCQlicHAgPSAxNjsKIAor
CXhyZXNfbWluID0gT01BUEZCX1BMQU5FX1hSRVNfTUlOOworCXhyZXNfbWF4ID0gcGFuZWwtPnhf
cmVzOworCXlyZXNfbWluID0gT01BUEZCX1BMQU5FX1lSRVNfTUlOOworCXlyZXNfbWF4ID0gcGFu
ZWwtPnlfcmVzOworCiAJc3dpdGNoICh2YXItPnJvdGF0ZSkgewogCWNhc2UgMDoKIAljYXNlIDE4
MDoKLQkJeHJlc19taW4gPSBPTUFQRkJfUExBTkVfWFJFU19NSU47Ci0JCXhyZXNfbWF4ID0gcGFu
ZWwtPnhfcmVzOwotCQl5cmVzX21pbiA9IE9NQVBGQl9QTEFORV9ZUkVTX01JTjsKLQkJeXJlc19t
YXggPSBwYW5lbC0+eV9yZXM7CiAJCWlmIChjcHVfaXNfb21hcDE1eHgoKSkgewogCQkJdmFyLT54
cmVzID0gcGFuZWwtPnhfcmVzOwogCQkJdmFyLT55cmVzID0gcGFuZWwtPnlfcmVzOwpAQCAtNTA5
LDEwICs1MTYsNiBAQCBzdGF0aWMgaW50IHNldF9mYl92YXIoc3RydWN0IGZiX2luZm8gKmZiaSwK
IAkJYnJlYWs7CiAJY2FzZSA5MDoKIAljYXNlIDI3MDoKLQkJeHJlc19taW4gPSBPTUFQRkJfUExB
TkVfWVJFU19NSU47Ci0JCXhyZXNfbWF4ID0gcGFuZWwtPnlfcmVzOwotCQl5cmVzX21pbiA9IE9N
QVBGQl9QTEFORV9YUkVTX01JTjsKLQkJeXJlc19tYXggPSBwYW5lbC0+eF9yZXM7CiAJCWlmIChj
cHVfaXNfb21hcDE1eHgoKSkgewogCQkJdmFyLT54cmVzID0gcGFuZWwtPnlfcmVzOwogCQkJdmFy
LT55cmVzID0gcGFuZWwtPnhfcmVzOwpAQCAtMTcxNSw3ICsxNzE4LDExIEBAIHN0YXRpYyBpbnQg
b21hcGZiX2RvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCiAKIAlwcl9pbmZv
KCJvbWFwZmI6IGNvbmZpZ3VyZWQgZm9yIHBhbmVsICVzXG4iLCBmYmRldi0+cGFuZWwtPm5hbWUp
OwogCisjaWZkZWYgUk9UQVRJT05fVEVTVAorCWRlZl92eHJlcyA9IFJPVF9MSU5FX0xFTkdUSDsK
KyNlbHNlCiAJZGVmX3Z4cmVzID0gZGVmX3Z4cmVzID8gOiBmYmRldi0+cGFuZWwtPnhfcmVzOwor
I2VuZGlmCiAJZGVmX3Z5cmVzID0gZGVmX3Z5cmVzID8gOiBmYmRldi0+cGFuZWwtPnlfcmVzOwog
CiAJaW5pdF9zdGF0ZSsrOwotLSAKMS41LjMuNAoK
------=_Part_11342_16100655.1208772602749--
