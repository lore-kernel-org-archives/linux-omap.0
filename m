From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH] omapfb: Reorder Register_framebuffer call
Date: Sat, 12 Sep 2009 19:34:09 +0300
Message-ID: <1252773249-24444-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:62107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbZILQeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Sep 2009 12:34:14 -0400
Received: by fg-out-1718.google.com with SMTP id 22so194962fge.1
        for <linux-omap@vger.kernel.org>; Sat, 12 Sep 2009 09:34:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

This fixes the issue in which mm_lock mutex was attempted to be
used without initializing previously.

Thanks to the testers!
 - OMAP3430 SDP (Anand Gadiyar)
 - OMAP3530 EVM (Vaibhav Hiremath)
 - LogicPD's OMAP boards (Peter Brada)
 - Beagleboard Rev. C2 (Eric Witcher)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Anand Gadiyar <gadiyar@ti.com>
Tested-by: Peter Barada <peterb@logicpd.com>
Tested-by: Eric Witcher <ewitcher@mindspring.com>
---
 drivers/video/omap/omapfb_main.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 125e605..60f9482 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1503,12 +1503,21 @@ static int fbinfo_init(struct omapfb_device *fbdev, struct fb_info *info)
 	var->rotate	  = def_rotate;
 	var->bits_per_pixel = fbdev->panel->bpp;
 
+	r = register_framebuffer(info);
+	if (r != 0) {
+		dev_err(fbdev->dev,
+			"registering framebuffer failed\n");
+		return r;
+	}
+
 	set_fb_var(info, var);
 	set_fb_fix(info);
 
 	r = fb_alloc_cmap(&info->cmap, 16, 0);
-	if (r != 0)
+	if (r != 0) {
 		dev_err(fbdev->dev, "unable to allocate color map memory\n");
+		unregister_framebuffer(info);
+	}
 
 	return r;
 }
@@ -1773,15 +1782,8 @@ static int omapfb_do_probe(struct platform_device *pdev,
 	init_state++;
 
 	vram = 0;
-	for (i = 0; i < fbdev->mem_desc.region_cnt; i++) {
-		r = register_framebuffer(fbdev->fb_info[i]);
-		if (r != 0) {
-			dev_err(fbdev->dev,
-				"registering framebuffer %d failed\n", i);
-			goto cleanup;
-		}
+	for (i = 0; i < fbdev->mem_desc.region_cnt; i++)
 		vram += fbdev->mem_desc.region[i].size;
-	}
 
 	fbdev->state = OMAPFB_ACTIVE;
 
-- 
1.6.3.2

