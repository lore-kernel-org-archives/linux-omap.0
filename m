From: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Subject: [PATCH] fbdev: da8xx-fb: fix videomodes of lcd panels
Date: Mon, 29 Feb 2016 18:42:19 +0530
Message-ID: <1456751539-19298-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sushaanth Srirangapathi <sushaanth.s@ti.com>
List-Id: linux-omap@vger.kernel.org

Commit 028cd86b794f4a ("video: da8xx-fb: fix the polarities of the
hsync/vsync pulse") fixes polarities of HSYNC/VSYNC pulse but
forgot to update known_lcd_panels[] which had sync values
according to old logic. This breaks LCD at least on DA850 EVM.

This patch fixes this issue and I have tested this for panel
"Sharp_LK043T1DG01" using DA850 EVM board.

Fixes: 028cd86b794f4a ("video: da8xx-fb: fix the polarities of the
hsync/vsync pulse")
Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 drivers/video/fbdev/da8xx-fb.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 6b2a06d..d8d583d 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -209,8 +209,7 @@ static struct fb_videomode known_lcd_panels[] = {
 		.lower_margin   = 2,
 		.hsync_len      = 0,
 		.vsync_len      = 0,
-		.sync           = FB_SYNC_CLK_INVERT |
-			FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.sync           = FB_SYNC_CLK_INVERT,
 	},
 	/* Sharp LK043T1DG01 */
 	[1] = {
@@ -224,7 +223,7 @@ static struct fb_videomode known_lcd_panels[] = {
 		.lower_margin   = 2,
 		.hsync_len      = 41,
 		.vsync_len      = 10,
-		.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.sync           = 0,
 		.flag           = 0,
 	},
 	[2] = {
@@ -239,7 +238,7 @@ static struct fb_videomode known_lcd_panels[] = {
 		.lower_margin   = 10,
 		.hsync_len      = 10,
 		.vsync_len      = 10,
-		.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.sync           = 0,
 		.flag           = 0,
 	},
 	[3] = {
-- 
1.7.9.5
