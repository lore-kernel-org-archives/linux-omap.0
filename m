From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/8] OMAP: DSS2: OMAPFB: remove dead code
Date: Tue, 10 May 2011 19:24:15 +0300
Message-ID: <1305044656-31512-8-git-send-email-tomi.valkeinen@ti.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37697 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932986Ab1EJQYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 12:24:42 -0400
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove old unused code lying inside #if 0.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 1f9cb3a..30c958b 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -757,35 +757,6 @@ static int omapfb_open(struct fb_info *fbi, int user)
 
 static int omapfb_release(struct fb_info *fbi, int user)
 {
-#if 0
-	struct omapfb_info *ofbi = FB2OFB(fbi);
-	struct omapfb2_device *fbdev = ofbi->fbdev;
-	struct omap_dss_device *display = fb2display(fbi);
-
-	DBG("Closing fb with plane index %d\n", ofbi->id);
-
-	omapfb_lock(fbdev);
-
-	if (display && display->get_update_mode && display->update) {
-		/* XXX this update should be removed, I think. But it's
-		 * good for debugging */
-		if (display->get_update_mode(display) ==
-				OMAP_DSS_UPDATE_MANUAL) {
-			u16 w, h;
-
-			if (display->sync)
-				display->sync(display);
-
-			display->get_resolution(display, &w, &h);
-			display->update(display, 0, 0, w, h);
-		}
-	}
-
-	if (display && display->sync)
-		display->sync(display);
-
-	omapfb_unlock(fbdev);
-#endif
 	return 0;
 }
 
-- 
1.7.4.1

