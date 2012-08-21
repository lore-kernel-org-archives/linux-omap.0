From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] OMAPFB: fix framebuffer console colors
Date: Tue, 21 Aug 2012 09:09:48 +0300
Message-ID: <1345529388-3509-3-git-send-email-tomi.valkeinen@ti.com>
References: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43707 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753505Ab2HUGKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:10:37 -0400
Received: by lbao2 with SMTP id o2so3113695lba.10
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 23:10:34 -0700 (PDT)
In-Reply-To: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Grazvydas Ignotas <notasas@gmail.com>

omapfb does not currently set pseudo palette correctly for color depths
above 16bpp, making red text invisible, command like
  echo -e '\e[0;31mRED' > /dev/tty1
will display nothing on framebuffer console in 24bpp mode.
This is because temporary variable is declared incorrectly, fix it.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Cc: stable@vger.kernel.org # v3.x
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 08ec1a7..fc671d3 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1192,7 +1192,7 @@ static int _setcolreg(struct fb_info *fbi, u_int regno, u_int red, u_int green,
 			break;
 
 		if (regno < 16) {
-			u16 pal;
+			u32 pal;
 			pal = ((red >> (16 - var->red.length)) <<
 					var->red.offset) |
 				((green >> (16 - var->green.length)) <<
-- 
1.7.9.5

