From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] RTC: rtc-twl: Convert to module_platform_driver() and relocate reg_map init
Date: Tue, 16 Apr 2013 09:44:22 +0200
Message-ID: <1366098262-20726-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Convert the driver to use module_platform_driver() to register the platform
driver and relocate the rtc_reg_map initialization to platform driver's
probe function.
In this way we can make sure that the twl-core has been already probed since
the core driver will create the device at the end of it's probe function.

Reported-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Tony, Alessandro, Christoph,

I think this patch is the correct solution for the issue Christoph reported:
http://www.spinics.net/lists/linux-omap/msg89980.html

We can make sure that the twl-core has been already probed and initialized when
the RTC driver tries to pick the correct register map.

Regards,
Peter

 drivers/rtc/rtc-twl.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 8bc6c80..22b2fd6 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -469,6 +469,12 @@ static int twl_rtc_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		goto out1;
 
+	/* Initialize the register map */
+	if (twl_class_is_4030())
+		rtc_reg_map = (u8 *)twl4030_rtc_reg_map;
+	else
+		rtc_reg_map = (u8 *)twl6030_rtc_reg_map;
+
 	ret = twl_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
 	if (ret < 0)
 		goto out1;
@@ -612,22 +618,7 @@ static struct platform_driver twl4030rtc_driver = {
 	},
 };
 
-static int __init twl_rtc_init(void)
-{
-	if (twl_class_is_4030())
-		rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
-	else
-		rtc_reg_map = (u8 *) twl6030_rtc_reg_map;
-
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
