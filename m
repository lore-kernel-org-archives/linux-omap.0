From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/9] OMAP: DSS2: OMAPFB: Remove implicit display update on unblank
Date: Thu, 31 Mar 2011 13:11:05 +0300
Message-ID: <1301566266-11187-9-git-send-email-tomi.valkeinen@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37277 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933884Ab1CaKLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 06:11:35 -0400
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Currently omapfb does an implicit display update (for manual update
displays) on unblank.

There is no guarantee that the framebuffer contains a valid image when
unblank is called. When using manual update displays it is the
responsibility of the user space to update the display, and so it should
be in this case also.

This patch removes the implicit display update on unblank.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
[tomi.valkeinen@ti.com: improved description]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 1b89e28..1f9cb3a 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1271,7 +1271,6 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omap_dss_device *display = fb2display(fbi);
-	int do_update = 0;
 	int r = 0;
 
 	if (!display)
@@ -1287,11 +1286,6 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (display->driver->resume)
 			r = display->driver->resume(display);
 
-		if (r == 0 && display->driver->get_update_mode &&
-				display->driver->get_update_mode(display) ==
-				OMAP_DSS_UPDATE_MANUAL)
-			do_update = 1;
-
 		break;
 
 	case FB_BLANK_NORMAL:
@@ -1315,13 +1309,6 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 exit:
 	omapfb_unlock(fbdev);
 
-	if (r == 0 && do_update && display->driver->update) {
-		u16 w, h;
-		display->driver->get_resolution(display, &w, &h);
-
-		r = display->driver->update(display, 0, 0, w, h);
-	}
-
 	return r;
 }
 
-- 
1.7.1

