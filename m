From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] RTC: rtc-twl: Cleanup with module_platform_driver() conversion
Date: Tue, 16 Apr 2013 10:30:13 +0200
Message-ID: <1366101013-21183-2-git-send-email-peter.ujfalusi@ti.com>
References: <1366101013-21183-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366101013-21183-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomi Valkeinen <tomi.valkeinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Use module_platform_driver() to register the platform driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/rtc/rtc-twl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index c385e9b..22b2fd6 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -618,17 +618,7 @@ static struct platform_driver twl4030rtc_driver = {
 	},
 };
 
-static int __init twl_rtc_init(void)
-{
-	return platform_driver_register(&twl4030rtc_driver);
-}
-module_init(twl_rtc_init);
-
-static void __exit twl_rtc_exit(void)
-{
-	platform_driver_unregister(&twl4030rtc_driver);
-}
-module_exit(twl_rtc_exit);
+module_platform_driver(twl4030rtc_driver);
 
 MODULE_AUTHOR("Texas Instruments, MontaVista Software");
 MODULE_LICENSE("GPL");
-- 
1.8.1.5
