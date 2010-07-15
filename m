From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH] omap4: fb: Adds missing display update call when panning
Date: Thu, 15 Jul 2010 18:07:02 +0530
Message-ID: <1279197422-23662-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41374 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756081Ab0GOMhN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jul 2010 08:37:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Gustavo Diaz Prado <x0083741@ti.com>, Mayuresh Janorkar <mayur@ti.com>

From: Gustavo Diaz Prado <x0083741@ti.com>

Adds the missing display update call when panning, this
is needed for the DSI panel when the auto-update feature is
not enabled.

Signed-off-by: Gustavo Diaz Prado <x0083741@ti.com>
Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4abb1d1..12d5382 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1068,7 +1068,8 @@ static int omapfb_pan_display(struct fb_var_screeninfo *var,
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct fb_var_screeninfo new_var;
-	int r;
+	int r = 0;
+	struct omap_dss_device *display = fb2display(fbi);
 
 	DBG("pan_display(%d)\n", FB2OFB(fbi)->id);
 
@@ -1086,6 +1087,11 @@ static int omapfb_pan_display(struct fb_var_screeninfo *var,
 
 	r = omapfb_apply_changes(fbi, 0);
 
+	if (display && display->driver->update &&
+		display->driver->get_update_mode(display)
+			== OMAP_DSS_UPDATE_MANUAL)
+		display->driver->update(display, 0, 0, var->xres, var->yres);
+
 	omapfb_put_mem_region(ofbi->region);
 
 	return r;
-- 
1.5.4.7

