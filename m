From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/5] arm: omap: debug-leds: add a remove method
Date: Tue, 24 Jul 2012 11:54:01 +0300
Message-ID: <1343120042-16695-5-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:38898 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965Ab2GXI5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 04:57:24 -0400
Received: by lagz14 with SMTP id z14so788346lag.35
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 01:57:21 -0700 (PDT)
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

while at that, also convert to module_platform_driver

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 392daa8..08fbb85 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -251,6 +251,14 @@ static void __devinit newled_init(struct device *dev)
 	return;
 }
 
+static void __devexit newled_exit(void)
+{
+	unsigned	i;
+	struct dbg_led	*led;
+
+	for (i = 0, led = dbg_leds; i < ARRAY_SIZE(dbg_leds); i++, led++)
+		led_classdev_unregister(&led->cdev);
+}
 
 /*-------------------------------------------------------------------------*/
 
@@ -279,6 +287,16 @@ static int __devinit fpga_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __devexit fpga_remove(struct platform_device *pdev)
+{
+	if (new_led_api())
+		newled_exit();
+
+	iounmap(fpga);
+
+	return 0;
+}
+
 static int fpga_suspend_noirq(struct device *dev)
 {
 	__raw_writew(~0, &fpga->leds);
@@ -300,10 +318,7 @@ static struct platform_driver led_driver = {
 	.driver.name	= "omap_dbg_led",
 	.driver.pm	= &fpga_dev_pm_ops,
 	.probe		= fpga_probe,
+	.remove		= __devexit_p(fpga_remove),
 };
 
-static int __init fpga_init(void)
-{
-	return platform_driver_register(&led_driver);
-}
-module_init(fpga_init);
+module_platform_driver(led_driver);
-- 
1.7.11

