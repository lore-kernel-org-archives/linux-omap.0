From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] rtc: rtc-twl: fix initialization sequence
Date: Wed, 5 Jun 2013 14:19:22 +0300
Message-ID: <1370431162-24185-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rtc-linux@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

The twl-rtc has the following dependencies from other drivers during the boot:
pinctrl
|-i2c-omap
  |- twl-core
     |- twl-rtc

The i2c-omap probe may be deferred because pinctrl iss not ready yet. As result,
i2c-omap will be probed at late init time. Which, in turn, will delay twl-core
initialization till late init time too.

But, the twl-rtc driver is registered from finction twl_rtc_init() at
module(device) init time and contains part of its initialization code within it.
Unfortunatelly, this code depends on twl-core which may be not ready at that
moment and, as result, wrong register map will be selected
(on OMAP3 twl6030_rtc_reg_map will be selected instead of twl4030_rtc_reg_map).

static int __init twl_rtc_init(void)
{
    if (twl_class_is_4030()) <--- twl-core might be not ready here
                             <--- and twl_class_is_4030() will return 0
        rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
    else
        rtc_reg_map = (u8 *) twl6030_rtc_reg_map;

    return platform_driver_register(&twl4030rtc_driver);
}

Hence, move register map selection code in twl_rtc_probe() to solve this issue.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/rtc/rtc-twl.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index bbda0fd..1698115 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -481,6 +481,11 @@ static int twl_rtc_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		goto out1;
 
+	if (twl_class_is_4030())
+		rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
+	else
+		rtc_reg_map = (u8 *) twl6030_rtc_reg_map;
+
 	ret = twl_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
 	if (ret < 0)
 		goto out1;
@@ -622,11 +627,6 @@ static struct platform_driver twl4030rtc_driver = {
 
 static int __init twl_rtc_init(void)
 {
-	if (twl_class_is_4030())
-		rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
-	else
-		rtc_reg_map = (u8 *) twl6030_rtc_reg_map;
-
 	return platform_driver_register(&twl4030rtc_driver);
 }
 module_init(twl_rtc_init);
-- 
1.7.9.5
