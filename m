From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] omapfb: remove wrong scale call for gfx_plane
Date: Tue, 9 Sep 2008 03:43:31 -0400
Message-ID: <c656a4d20809090043g27d7a73eqf345588b4575c68d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:2959 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbYIIHnd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 03:43:33 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1152697tic.23
        for <linux-omap@vger.kernel.org>; Tue, 09 Sep 2008 00:43:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The gfx_plane doesn't support scaling.

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 drivers/video/omap/dispc.c       |    3 +--
 drivers/video/omap/omapfb_main.c |    6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 82ba030..ce4c4de 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -519,8 +519,7 @@ static int omap_dispc_set_scale(int plane,
 	if ((unsigned)plane > OMAPFB_PLANE_NUM)
 		return -ENODEV;

-	if (plane == OMAPFB_PLANE_GFX &&
-	    (out_width != orig_width || out_height != orig_height))
+	if (out_width != orig_width || out_height != orig_height)
 		return -EINVAL;

 	enable_lcd_clocks(1);
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 1ffe74c..d176a2c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -223,13 +223,15 @@ static int ctrl_change_mode(struct fb_info *fbi)
 		if((r = fbdev->ctrl->set_rotate(var->rotate)) < 0)
 			return r;

-	if (fbdev->ctrl->set_scale != NULL)
+	if ((fbdev->ctrl->set_scale != NULL) && (plane->idx > 0))
 		r = fbdev->ctrl->set_scale(plane->idx,
 				   var->xres, var->yres,
 				   plane->info.out_width,
 				   plane->info.out_height);
+	if (r < 0)
+		return r;

-	return r;
+	return 0;
 }

 /*
-- 
1.5.3.4
