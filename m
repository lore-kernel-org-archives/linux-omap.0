From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 7/8] OMAP: DSS2: OMAPFB: remove dead code
Date: Thu, 12 May 2011 14:40:12 +0300
Message-ID: <1305200413-23697-8-git-send-email-tomi.valkeinen@ti.com>
References: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50029 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755723Ab1ELLki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:40:38 -0400
In-Reply-To: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
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
index eba90b3..9a5b4bc 100644
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

