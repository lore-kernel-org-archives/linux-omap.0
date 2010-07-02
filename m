From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
Date: Fri,  2 Jul 2010 23:54:56 +0300
Message-ID: <1278104096-27809-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55102 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479Ab0GBUzA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 16:55:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

FBIO_WAITFORVSYNC is a stardard ioctl for waiting vsync, already
used by some userspace, so add it as an alias for OMAPFB_WAITFORVSYNC.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
Tomi,

I know I already sent this earlier, but as now FBIO_WAITFORVSYNC is a
standard ioctl, so why don't we support it? I know you might not like
that omapfb_ioctl will have one standard ioctl handler between all OMAP
specific ones, but that's something plenty of other drivers do.

 drivers/video/omap2/omapfb/omapfb-ioctl.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 9c73618..32fab5a 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -490,6 +490,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 		struct omapfb_vram_info		vram_info;
 		struct omapfb_tearsync_info	tearsync_info;
 		struct omapfb_display_info	display_info;
+		u32				crt;
 	} p;
 
 	int r = 0;
@@ -648,6 +649,17 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			r = -EFAULT;
 		break;
 
+	case FBIO_WAITFORVSYNC:
+		if (get_user(p.crt, (__u32 __user *)arg)) {
+			r = -EFAULT;
+			break;
+		}
+		if (p.crt != 0) {
+			r = -ENODEV;
+			break;
+		}
+		/* FALLTHROUGH */
+
 	case OMAPFB_WAITFORVSYNC:
 		DBG("ioctl WAITFORVSYNC\n");
 		if (!display) {
-- 
1.6.3.3

