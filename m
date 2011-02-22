From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH] OMAPFB: Adding a check for timings in set_def_mode
Date: Tue, 22 Feb 2011 19:05:13 +0530
Message-ID: <1298381713-13624-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1BVNHA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 08:07:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, lethal@linux-sh.org, tomi.valkeinen@ti.com
Cc: Mayuresh Janorkar <mayur@ti.com>

When omapfb.mode is passed through bootargs, when omapfb is setting mode,
it would check if timings passed are fine for panel attached to it.
It makes use of check_timing API provided by the panel.

In current code if check_timing API is not available for attached panel,
OMAPFB would return -EINVAL and BPP sent via bootargs will not have any effect.

In case of panels like TAAL panel, omapfb or any other driver should not be allowed to
change the timings. So bpps sent via bootargs will not have an effect.

In such case we can check only the x_res and y_res with the panels resolution
and if they match go ahead and set the bpps.
The bpp value sent via bootarg would have an effect.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
BASE: git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git
	HEAD: dss2

 drivers/video/omap2/omapfb/omapfb-main.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4fdab8e..505ec66 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2090,7 +2090,7 @@ static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
 {
 	int r;
 	u8 bpp;
-	struct omap_video_timings timings;
+	struct omap_video_timings timings, temp_timings;
 
 	r = omapfb_mode_to_timings(mode_str, &timings, &bpp);
 	if (r)
@@ -2100,14 +2100,23 @@ static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
 	fbdev->bpp_overrides[fbdev->num_bpp_overrides].bpp = bpp;
 	++fbdev->num_bpp_overrides;
 
-	if (!display->driver->check_timings || !display->driver->set_timings)
-		return -EINVAL;
+	if (display->driver->check_timings) {
+		r = display->driver->check_timings(display, &timings);
+		if (r)
+			return r;
+	} else {
+		/* If check_timings is not present compare xres and yres */
+		if (display->driver->get_timings) {
+			display->driver->get_timings(display, &temp_timings);
 
-	r = display->driver->check_timings(display, &timings);
-	if (r)
-		return r;
+			if (temp_timings.x_res != timings.x_res ||
+				temp_timings.y_res != timings.y_res)
+				return -EINVAL;
+		}
+	}
 
-	display->driver->set_timings(display, &timings);
+	if (display->driver->set_timings)
+			display->driver->set_timings(display, &timings);
 
 	return 0;
 }
-- 
1.7.1

