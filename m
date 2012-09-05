From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/17] OMAPFB: clear framebuffers with CPU
Date: Wed,  5 Sep 2012 11:25:43 +0300
Message-ID: <1346833555-31258-6-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:45369 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758028Ab2IEI0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:23 -0400
Received: by lagy9 with SMTP id y9so139315lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:20 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently vram.c clears the allocated memory automatically using OMAP
system DMA. In an effort to reduce OMAP dependencies, we'll do the
memory clear with CPU from now on.

This patch implements clearing of the framebuffer in omapfb, using
cfb_fillrect() to do the actual clear.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index fc671d3..7afdfcf 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1592,6 +1592,20 @@ static int omapfb_allocate_all_fbs(struct omapfb2_device *fbdev)
 	return 0;
 }
 
+static void omapfb_clear_fb(struct fb_info *fbi)
+{
+	const struct fb_fillrect rect = {
+		.dx = 0,
+		.dy = 0,
+		.width = fbi->var.xres_virtual,
+		.height = fbi->var.yres_virtual,
+		.color = 0,
+		.rop = ROP_COPY,
+	};
+
+	cfb_fillrect(fbi, &rect);
+}
+
 int omapfb_realloc_fbmem(struct fb_info *fbi, unsigned long size, int type)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
@@ -1661,6 +1675,8 @@ int omapfb_realloc_fbmem(struct fb_info *fbi, unsigned long size, int type)
 			goto err;
 	}
 
+	omapfb_clear_fb(fbi);
+
 	return 0;
 err:
 	omapfb_free_fbmem(fbi);
@@ -1972,6 +1988,16 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 		}
 	}
 
+	for (i = 0; i < fbdev->num_fbs; i++) {
+		struct fb_info *fbi = fbdev->fbs[i];
+		struct omapfb_info *ofbi = FB2OFB(fbi);
+
+		if (ofbi->region->size == 0)
+			continue;
+
+		omapfb_clear_fb(fbi);
+	}
+
 	/* Enable fb0 */
 	if (fbdev->num_fbs > 0) {
 		struct omapfb_info *ofbi = FB2OFB(fbdev->fbs[0]);
-- 
1.7.9.5

