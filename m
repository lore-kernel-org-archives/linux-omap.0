From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] set data enable logic level to low
Date: Mon, 14 Oct 2013 00:44:33 +0200
Message-ID: <1381704273-31540-1-git-send-email-roel.kluin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/video/omap2/dss/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index fafe7c9..669a81f 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -266,7 +266,7 @@ void videomode_to_omap_video_timings(const struct videomode *vm,
 		OMAPDSS_SIG_ACTIVE_LOW;
 	ovt->de_level = vm->flags & DISPLAY_FLAGS_DE_HIGH ?
 		OMAPDSS_SIG_ACTIVE_HIGH :
-		OMAPDSS_SIG_ACTIVE_HIGH;
+		OMAPDSS_SIG_ACTIVE_LOW;
 	ovt->data_pclk_edge = vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE ?
 		OMAPDSS_DRIVE_SIG_RISING_EDGE :
 		OMAPDSS_DRIVE_SIG_FALLING_EDGE;
-- 
1.8.1.2
