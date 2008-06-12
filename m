From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] ARM:OMAP: fix driver MODULE_ALIAS()
Date: Thu, 12 Jun 2008 10:40:14 +0300
Message-ID: <1213256414-12309-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26425 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbYFLHke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2008 03:40:34 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5C7eAPi005697
	for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2008 02:40:32 -0500
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5C7eEOj010698
	for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2008 10:40:15 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Add a correct MODULE_ALIAS() entry for this driver to enable udev module
loading.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/input/keyboard/omap-twl4030keypad.c |    2 ++
 drivers/input/touchscreen/tsc2005.c         |    2 +-
 drivers/mmc/host/omap_hsmmc.c               |    3 ++-
 drivers/rtc/rtc-twl4030.c                   |    2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 0344b4c..fc5d44e 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -350,6 +350,7 @@ static struct platform_driver omap_kp_driver = {
 	.remove		= omap_kp_remove,
 	.driver		= {
 		.name	= "omap_twl4030keypad",
+		.owner	= THIS_MODULE,
 	},
 };
 
@@ -371,3 +372,4 @@ module_exit(omap_kp_exit);
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap_twl4030keypad");
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index fa01799..93dc3c5 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -734,4 +734,4 @@ module_exit(tsc2005_exit);
 
 MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("platform:tsc2005");
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9c18c15..d399dca 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1106,6 +1106,7 @@ static struct platform_driver omap_mmc_driver = {
 	.resume		= omap_mmc_resume,
 	.driver		= {
 		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
 	},
 };
 
@@ -1126,5 +1127,5 @@ module_exit(omap_mmc_cleanup);
 
 MODULE_DESCRIPTION("OMAP High Speed Multimedia Card driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS(DRIVER_NAME);
+MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index ef0e175..7b0a4c5 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -624,7 +624,7 @@ static int twl4030_rtc_resume(struct platform_device *pdev)
 #define twl4030_rtc_resume  NULL
 #endif
 
-MODULE_ALIAS("twl4030_rtc");
+MODULE_ALIAS("platform:twl4030_rtc");
 static struct platform_driver twl4030rtc_driver = {
 	.probe 		= twl4030_rtc_probe,
 	.remove 	= __devexit_p(twl4030_rtc_remove),
-- 
1.5.5.1.357.g1af8b

