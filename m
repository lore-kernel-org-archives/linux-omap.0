From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 1/2] OMAP: DSS2: OMAPFB: implement OMAPFB_RESERVE_BUFFER
Date: Thu,  4 Feb 2010 17:31:25 +0200
Message-ID: <1265297486-22438-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29599 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221Ab0BDP26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 10:28:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Currently applications can reserve fb memory with OMAPFB_SETUP_MEM
ioctl, which takes the size in bytes as an argument. This falls apart
when using VRFB, as the memory need for VRFB is not trivial

This patch implements OMAPFB_RESERVE_BUFFER ioctl, which reserves memory
just like SETUP_MEM, but takes width, height and bytes per pixel as
arguments. This will let omapfb driver allocate the memory more
intelligently.

The "size" entry in sysfs now also supports writing the size in
"width,height,bytespp" format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   51 +++++++++++++++++++++++++++++
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   13 +++++++-
 include/linux/omapfb.h                    |   10 ++++++
 3 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 4c4bafd..5562a76 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -155,6 +155,47 @@ static int omapfb_query_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 	return 0;
 }
 
+static int omapfb_reserve_buffer(struct fb_info *fbi,
+		struct omapfb_res_buf_info *bi)
+{
+	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
+	struct omapfb2_mem_region *rg;
+	int r, i;
+	size_t size;
+	unsigned w = bi->width;
+	unsigned h = bi->height;
+
+	if (bi->type > OMAPFB_MEMTYPE_MAX)
+		return -EINVAL;
+
+	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
+		size = max(omap_vrfb_min_phys_size(w, h, bi->bytespp),
+				omap_vrfb_min_phys_size(h, w, bi->bytespp));
+	} else {
+		size = w * h * bi->bytespp;
+	}
+
+	size = PAGE_ALIGN(size);
+
+	rg = &ofbi->region;
+
+	for (i = 0; i < ofbi->num_overlays; i++) {
+		if (ofbi->overlays[i]->info.enabled)
+			return -EBUSY;
+	}
+
+	if (rg->size != size || rg->type != bi->type) {
+		r = omapfb_realloc_fbmem(fbi, size, bi->type);
+		if (r) {
+			dev_err(fbdev->dev, "realloc fbmem failed\n");
+			return r;
+		}
+	}
+
+	return 0;
+}
+
 static int omapfb_update_window_nolock(struct fb_info *fbi,
 		u32 x, u32 y, u32 w, u32 h)
 {
@@ -476,6 +517,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 		struct omapfb_plane_info	plane_info;
 		struct omapfb_caps		caps;
 		struct omapfb_mem_info          mem_info;
+		struct omapfb_res_buf_info	res_buf_info;
 		struct omapfb_color_key		color_key;
 		struct omapfb_ovl_colormode	ovl_colormode;
 		enum omapfb_update_mode		update_mode;
@@ -572,6 +614,15 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			r = -EFAULT;
 		break;
 
+	case OMAPFB_RESERVE_BUFFER:
+		DBG("ioctl RESERVE_BUFFER\n");
+		if (copy_from_user(&p.res_buf_info, (void __user *)arg,
+					sizeof(p.res_buf_info)))
+			r = -EFAULT;
+		else
+			r = omapfb_reserve_buffer(fbi, &p.res_buf_info);
+		break;
+
 	case OMAPFB_GET_CAPS:
 		DBG("ioctl GET_CAPS\n");
 		if (!display) {
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 62bb88f..9cd7957 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -413,8 +413,19 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 	unsigned long size;
 	int r;
 	int i;
+	unsigned w, h, bytespp;
+
+	if (sscanf(buf, "%u,%u,%u", &w, &h, &bytespp) == 3) {
+		if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
+			size = max(omap_vrfb_min_phys_size(w, h, bytespp),
+					omap_vrfb_min_phys_size(h, w, bytespp));
+		else
+			size = w * h * bytespp;
+	} else {
+		size = simple_strtoul(buf, NULL, 0);
+	}
 
-	size = PAGE_ALIGN(simple_strtoul(buf, NULL, 0));
+	size = PAGE_ALIGN(size);
 
 	lock_fb_info(fbi);
 
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index f46c40a..ef4c2cf 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -57,6 +57,7 @@
 #define OMAPFB_WAITFORGO	OMAP_IO(60)
 #define OMAPFB_GET_VRAM_INFO	OMAP_IOR(61, struct omapfb_vram_info)
 #define OMAPFB_SET_TEARSYNC	OMAP_IOW(62, struct omapfb_tearsync_info)
+#define OMAPFB_RESERVE_BUFFER	OMAP_IOW(63, struct omapfb_res_buf_info)
 
 #define OMAPFB_CAPS_GENERIC_MASK	0x00000fff
 #define OMAPFB_CAPS_LCDC_MASK		0x00fff000
@@ -147,6 +148,15 @@ struct omapfb_mem_info {
 	__u8  reserved[3];
 };
 
+struct omapfb_res_buf_info {
+	__u16	width;
+	__u16	height;
+	__u8	bytespp;
+	__u8	type;
+	__u8	reserved[2];
+	__u32	reserved2[6];
+};
+
 struct omapfb_caps {
 	__u32 ctrl;
 	__u32 plane_color;
-- 
1.6.5

