From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAPDSS: OMAPFB: fix framebuffer console colors
Date: Sat,  4 Aug 2012 19:19:13 +0300
Message-ID: <1344097153-13903-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40860 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab2HDQTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Aug 2012 12:19:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

omapfb does not currently set pseudo palette correctly for color depths
above 16bpp, making red text invisible, command like
  echo -e '\e[0;31mRED' > /dev/tty1
will display nothing on framebuffer console in 24bpp mode.
This is because temporary variable is declared incorrectly, fix it.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 70aa47d..f7c1753 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1183,7 +1183,7 @@ static int _setcolreg(struct fb_info *fbi, u_int regno, u_int red, u_int green,
 			break;
 
 		if (regno < 16) {
-			u16 pal;
+			u32 pal;
 			pal = ((red >> (16 - var->red.length)) <<
 					var->red.offset) |
 				((green >> (16 - var->green.length)) <<
-- 
1.7.0.4

