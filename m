From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Patch to fix swapping of front and back porches when reading from
 modedb.c
Date: Wed, 08 Sep 2010 15:39:27 +0200
Message-ID: <4C87920F.9050005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090709080409010506080808"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62560 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0IHNe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 09:34:56 -0400
Received: by eyb6 with SMTP id 6so29363eyb.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 06:34:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090709080409010506080808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Hi list :-)

I had trouble getting a standard 800x600@60Hz VGA signal to display correctly on my monitors. Measuring the output showed that the front and back porches were swapped both for hsync and vsync. After reading the source I think I found the error in drivers/video/omap2/omapfb/omapfb-main.c. Patch attached.

http://www.xfree86.org/3.3.6/fbdev6.html shows the way it should be, but todays code sets:

hfp = left margin
hbp = right margin
vfp = upper margin
vbp = lower margin

I tested a patched kernel with 800x600@60Hz on two different monitors and a vga grabber, and it solved my issues.

Regards,
Tassle




--------------090709080409010506080808
Content-Type: text/x-patch;
 name="0001-swap-front-and-back-porches-for-both-hsync-and-vsync.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-swap-front-and-back-porches-for-both-hsync-and-vsync.pa";
 filename*1="tch"

>From f6a0d18c16bfc827e18356b11c4e3cd96b836787 Mon Sep 17 00:00:00 2001
From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Date: Wed, 8 Sep 2010 12:46:14 +0200
Subject: [PATCH] swap front and back porches for both hsync and vsync

---
 drivers/video/omap2/omapfb/omapfb-main.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 015831b..69e6a08 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -711,10 +711,10 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 		var->pixclock = timings.pixel_clock != 0 ?
 			KHZ2PICOS(timings.pixel_clock) :
 			0;
-		var->left_margin = timings.hfp;
-		var->right_margin = timings.hbp;
-		var->upper_margin = timings.vfp;
-		var->lower_margin = timings.vbp;
+		var->left_margin = timings.hbp;
+		var->right_margin = timings.hfp;
+		var->upper_margin = timings.vbp;
+		var->lower_margin = timings.vfp;
 		var->hsync_len = timings.hsw;
 		var->vsync_len = timings.vsw;
 	} else {
@@ -1992,10 +1992,10 @@ static int omapfb_mode_to_timings(const char *mode_str,
 
 	if (r != 0) {
 		timings->pixel_clock = PICOS2KHZ(var.pixclock);
-		timings->hfp = var.left_margin;
-		timings->hbp = var.right_margin;
-		timings->vfp = var.upper_margin;
-		timings->vbp = var.lower_margin;
+		timings->hbp = var.left_margin;
+		timings->hfp = var.right_margin;
+		timings->vbp = var.upper_margin;
+		timings->vfp = var.lower_margin;
 		timings->hsw = var.hsync_len;
 		timings->vsw = var.vsync_len;
 		timings->x_res = var.xres;
-- 
1.7.0.4


--------------090709080409010506080808--
