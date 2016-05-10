From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] rtc: rename so the tps6586x-rtc module can be autoloaded at boot
Date: Tue, 10 May 2016 12:26:42 +0200
Message-ID: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This module is loaded by the related mfd driver which has
the needed MODULE_DEVICE_TABLE(i2c,...).

This patch fix the modalias when the rtc driver is built
as a module, so the right name is used.
Everything operates correctly when this module is builtin.

Signed-off-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/rtc/rtc-tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index e404faa..a3418a8 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -344,7 +344,7 @@ static struct platform_driver tps6586x_rtc_driver = {
 };
 module_platform_driver(tps6586x_rtc_driver);
 
-MODULE_ALIAS("platform:rtc-tps6586x");
+MODULE_ALIAS("platform:tps6586x-rtc");
 MODULE_DESCRIPTION("TI TPS6586x RTC driver");
 MODULE_AUTHOR("Laxman dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.4.11
