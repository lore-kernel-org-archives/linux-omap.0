From: Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] drivers:video:fbdev:omap:lcd_mipid.c: Use time comparison kernel macros
Date: Sun, 30 Apr 2017 18:42:43 +0200
Message-ID: <1493570563-7188-1-git-send-email-karim.eshapa@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use time_before_eq time comparison defind kernel macro
that has safety check.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/video/fbdev/omap/lcd_mipid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index c81f150..df9e6eb 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -174,7 +174,7 @@ static void hw_guard_wait(struct mipid_device *md)
 {
 	unsigned long wait = md->hw_guard_end - jiffies;
 
-	if ((long)wait > 0 && wait <= md->hw_guard_wait) {
+	if ((long)wait > 0 && time_before_eq(wait,  md->hw_guard_wait)) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(wait);
 	}
-- 
2.7.4
