From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: omap: fix cleanup regression
Date: Tue, 14 Jul 2015 14:10:47 +0200
Message-ID: <1436875847-18700-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Patch "i2c: omap: abolish variable name confusion" triggered a
coccinelle warning which we fix here:

drivers/i2c/busses/i2c-omap.c:1333:5-24: pm_runtime_get_sync returns < 0 as error. Unecessary IS_ERR_VALUE at line 1334

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 133dd0db6f5b76..edc4261191ba4d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1331,7 +1331,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(omap->dev);
 
 	r = pm_runtime_get_sync(omap->dev);
-	if (IS_ERR_VALUE(r))
+	if (r < 0)
 		goto err_free_mem;
 
 	/*
-- 
2.1.4
