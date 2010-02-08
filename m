From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 05/13] OMAP: DSS2: OMAPFB: implement OMAPFB_GET_DISPLAY_INFO
Date: Mon,  8 Feb 2010 17:56:04 +0200
Message-ID: <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45698 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab0BHPxs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:53:48 -0500
In-Reply-To: <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Previously the only place to get the size of the display was from the
DSS's sysfs interface, making, for example, configuring overlays and doing
updates on manual displays more difficult.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   20 ++++++++++++++++++++
 include/linux/omapfb.h                    |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 5562a76..56e3ec2 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -525,6 +525,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 		struct omapfb_memory_read	memory_read;
 		struct omapfb_vram_info		vram_info;
 		struct omapfb_tearsync_info	tearsync_info;
+		struct omapfb_display_info	display_info;
 	} p;
 
 	int r = 0;
@@ -792,6 +793,25 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
+	case OMAPFB_GET_DISPLAY_INFO: {
+		DBG("ioctl GET_DISPLAY_INFO\n");
+
+		if (display == NULL) {
+			r = -ENODEV;
+			break;
+		}
+
+		p.display_info.xres = display->panel.timings.x_res;
+		p.display_info.yres = display->panel.timings.y_res;
+		p.display_info.width = 0;
+		p.display_info.height = 0;
+
+		if (copy_to_user((void __user *)arg, &p.display_info,
+					sizeof(p.display_info)))
+			r = -EFAULT;
+		break;
+	}
+
 	default:
 		dev_err(fbdev->dev, "Unknown ioctl 0x%x\n", cmd);
 		r = -EINVAL;
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index ef4c2cf..0381436 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -58,6 +58,7 @@
 #define OMAPFB_GET_VRAM_INFO	OMAP_IOR(61, struct omapfb_vram_info)
 #define OMAPFB_SET_TEARSYNC	OMAP_IOW(62, struct omapfb_tearsync_info)
 #define OMAPFB_RESERVE_BUFFER	OMAP_IOW(63, struct omapfb_res_buf_info)
+#define OMAPFB_GET_DISPLAY_INFO	OMAP_IOR(64, struct omapfb_display_info)
 
 #define OMAPFB_CAPS_GENERIC_MASK	0x00000fff
 #define OMAPFB_CAPS_LCDC_MASK		0x00fff000
@@ -216,6 +217,14 @@ struct omapfb_tearsync_info {
 	__u16 reserved2;
 };
 
+struct omapfb_display_info {
+	__u16 xres;
+	__u16 yres;
+	__u32 width;	/* phys width of the display in micrometers */
+	__u32 height;	/* phys height of the display in micrometers */
+	__u32 reserved[5];
+};
+
 #ifdef __KERNEL__
 
 #include <plat/board.h>
-- 
1.6.5

