From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] drivers/video/fbdev/omap/lcd_mipid.c: add const to lcd_panel structure
Date: Fri, 14 Jul 2017 14:44:06 +0530
Message-ID: <1500023646-8846-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make lcd_panel structure const as it is only copied to some object.
As the only usage of this structure is a copy operation, so it can be
made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/video/fbdev/omap/lcd_mipid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index df9e6eb..e3a8543 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -496,7 +496,7 @@ static void mipid_cleanup(struct lcd_panel *panel)
 		mipid_esd_stop_check(md);
 }
 
-static struct lcd_panel mipid_panel = {
+static const struct lcd_panel mipid_panel = {
 	.config		= OMAP_LCDC_PANEL_TFT,
 
 	.bpp		= 16,
-- 
1.9.1
