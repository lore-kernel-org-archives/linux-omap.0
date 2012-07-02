From: yegorslists@googlemail.com
Subject: [PATCH] da8xx-fb: add missing FB_BLANK operations
Date: Mon,  2 Jul 2012 09:11:13 +0200
Message-ID: <1341213073-2986-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:60170 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab2GBHLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 03:11:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, hvaibhav@ti.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
Otherwise X-server will complain about invalid parameter.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/video/da8xx-fb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 29577bf..9879edc 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -987,6 +987,9 @@ static int cfb_blank(int blank, struct fb_info *info)
 
 		lcd_enable_raster();
 		break;
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
-- 
1.7.7

