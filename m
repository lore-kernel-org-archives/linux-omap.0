From: Daniel Stone <daniel.stone@nokia.com>
Subject: [PATCH 2/2] FB: OMAP: Blizzard: Properly disable zoom when necessary
Date: Thu,  9 Oct 2008 12:52:14 +0300
Message-ID: <1223545934-18445-2-git-send-email-daniel.stone@nokia.com>
References: <20081009094224.GK6212@intune.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42636 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbYJIJtb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 05:49:31 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m999mUvh008081
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 04:49:28 -0500
Received: from intune.research.nokia.com (intune.research.nokia.com [172.21.50.54])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m999nMjZ027822
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 12:49:22 +0300
In-Reply-To: <20081009094224.GK6212@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

The problem is related to the following notice in the documentation:
"Once a destructive window with up-scaling is created, it can only be
disabled by creating a background window.". With the current omapfb
driver code, if you try to do a partial screen update (show menu or
dialog) after a scaled screen update (video overlay), scaling setting
are not reset properly and you see this "magnifying glass" effect if a
part of new update overlaps previously scaled area.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
---
 drivers/video/omap/blizzard.c |   56 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index 6031b89..f60a233 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -163,6 +163,10 @@ struct blizzard_struct {
 	int			vid_scaled;
 	int			last_color_mode;
 	int			zoom_on;
+	int			zoom_area_gx1;
+	int			zoom_area_gx2;
+	int			zoom_area_gy1;
+	int			zoom_area_gy2;
 	int			screen_width;
 	int			screen_height;
 	unsigned		te_connected:1;
@@ -514,6 +518,12 @@ static int do_full_screen_update(struct blizzard_request *req)
 	return REQ_PENDING;
 }
 
+static int check_1d_intersect(int a1, int a2, int b1, int b2)
+{
+    if (a2 <= b1 || b2 <= a1) return 0;
+    return 1;
+}
+
 /* Setup all planes with an overlapping area with the update window. */
 static int do_partial_update(struct blizzard_request *req, int plane,
 			     int x, int y, int w, int h,
@@ -526,6 +536,7 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 	int color_mode;
 	int flags;
 	int zoom_off;
+	int have_zoom_for_this_update = 0;
 
 	/* Global coordinates, relative to pixel 0,0 of the LCD */
 	gx1 = x + blizzard.plane[plane].pos_x;
@@ -545,10 +556,6 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 		gx2_out = gx1_out + w_out;
 		gy2_out = gy1_out + h_out;
 	}
-	zoom_off = blizzard.zoom_on && gx1 == 0 && gy1 == 0 &&
-		w == blizzard.screen_width && h == blizzard.screen_height;
-	blizzard.zoom_on = (!zoom_off && blizzard.zoom_on) ||
-			   (w < w_out || h < h_out);
 
 	for (i = 0; i < OMAPFB_PLANE_NUM; i++) {
 		struct plane_info *p = &blizzard.plane[i];
@@ -654,8 +661,49 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 	else
 		disable_tearsync();
 
+	if ((gx2_out - gx1_out) != (gx2 - gx1) ||
+	    (gy2_out - gy1_out) != (gy2 - gy1))
+		have_zoom_for_this_update = 1;
+
+	/* 'background' type of screen update (as opposed to 'destructive') 
+	   can be used to disable scaling if scaling is active */
+	zoom_off = blizzard.zoom_on && !have_zoom_for_this_update &&
+	    (gx1_out == 0) && (gx2_out == blizzard.screen_width) &&
+	    (gy1_out == 0) && (gy2_out == blizzard.screen_height) &&
+	    (gx1 == 0) && (gy1 == 0);
+
+	if (blizzard.zoom_on && !have_zoom_for_this_update && !zoom_off &&
+	    check_1d_intersect(blizzard.zoom_area_gx1, blizzard.zoom_area_gx2,
+	                       gx1_out, gx2_out) &&
+	    check_1d_intersect(blizzard.zoom_area_gy1, blizzard.zoom_area_gy2,
+	                       gy1_out, gy2_out)) {
+		/* Previous screen update was using scaling, current update
+		 * is not using it. Additionally, current screen update is
+		 * going to overlap with the scaled area. Scaling needs to be
+		 * disabled in order to avoid 'magnifying glass' effect.
+		 * Dummy setup of background window can be used for this.
+		 */
+		set_window_regs(0, 0, blizzard.screen_width,
+				blizzard.screen_height,
+				0, 0, blizzard.screen_width,
+				blizzard.screen_height,
+				BLIZZARD_COLOR_RGB565, 1, flags);
+		blizzard.zoom_on = 0;
+	}
+
+	/* remember scaling settings if we have scaled update */
+	if (have_zoom_for_this_update) {
+		blizzard.zoom_on = 1;
+		blizzard.zoom_area_gx1 = gx1_out;
+		blizzard.zoom_area_gx2 = gx2_out;
+		blizzard.zoom_area_gy1 = gy1_out;
+		blizzard.zoom_area_gy2 = gy2_out;
+	}
+
 	set_window_regs(gx1, gy1, gx2, gy2, gx1_out, gy1_out, gx2_out, gy2_out,
 			color_mode, zoom_off, flags);
+	if (zoom_off)
+		blizzard.zoom_on = 0;
 
 	blizzard.extif->set_bits_per_cycle(16);
 	/* set_window_regs has left the register index at the right
-- 
1.5.6.3

