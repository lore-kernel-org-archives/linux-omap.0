From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 4/8] cbus: retu: avoid section mismatch
Date: Tue, 14 Sep 2010 11:30:12 +0300
Message-ID: <1284453016-8295-5-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42769 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab0INIac (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 04:30:32 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

... by removing __init reference from platform_driver
structure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-headset.c   |    3 +--
 drivers/cbus/retu-pwrbutton.c |    9 ++++-----
 drivers/cbus/retu-rtc.c       |    7 +++----
 drivers/cbus/retu-wdt.c       |    7 +++----
 drivers/cbus/retu.c           |    9 ++++-----
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index c86c665..f5fb50c 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -321,7 +321,6 @@ static int retu_headset_resume(struct platform_device *pdev)
 }
 
 static struct platform_driver retu_headset_driver = {
-	.probe		= retu_headset_probe,
 	.remove		= retu_headset_remove,
 	.suspend	= retu_headset_suspend,
 	.resume		= retu_headset_resume,
@@ -332,7 +331,7 @@ static struct platform_driver retu_headset_driver = {
 
 static int __init retu_headset_init(void)
 {
-	return platform_driver_register(&retu_headset_driver);
+	return platform_driver_probe(&retu_headset_driver, retu_headset_probe);
 }
 
 static void __exit retu_headset_exit(void)
diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index f0cd056..6b8dfa9 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -85,7 +85,7 @@ static void retubutton_irq(unsigned long arg)
  * Init function.
  * Allocates interrupt for power button and registers itself to input layer.
  */
-static int __devinit retubutton_probe(struct platform_device *pdev)
+static int __init retubutton_probe(struct platform_device *pdev)
 {
 	struct retu_pwrbutton		*pwr;
 	int				ret = 0;
@@ -143,7 +143,7 @@ err0:
 /**
  * Cleanup function which is called when driver is unloaded
  */
-static int __devexit retubutton_remove(struct platform_device *pdev)
+static int __exit retubutton_remove(struct platform_device *pdev)
 {
 	struct retu_pwrbutton		*pwr = platform_get_drvdata(pdev);
 
@@ -157,8 +157,7 @@ static int __devexit retubutton_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver retu_pwrbutton_driver = {
-	.probe		= retubutton_probe,
-	.remove		= __devexit_p(retubutton_remove),
+	.remove		= __exit_p(retubutton_remove),
 	.driver		= {
 		.name	= "retu-pwrbutton",
 	},
@@ -166,7 +165,7 @@ static struct platform_driver retu_pwrbutton_driver = {
 
 static int __init retubutton_init(void)
 {
-	return platform_driver_register(&retu_pwrbutton_driver);
+	return platform_driver_probe(&retu_pwrbutton_driver, retubutton_probe);
 }
 module_init(retubutton_init);
 
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index b3974e2..c0fe481 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -273,7 +273,7 @@ static struct rtc_class_ops retu_rtc_ops = {
 	.set_alarm		= retu_rtc_set_alarm,
 };
 
-static int __devinit retu_rtc_probe(struct platform_device *pdev)
+static int __init retu_rtc_probe(struct platform_device *pdev)
 {
 	struct retu_rtc		*rtc;
 	int			r;
@@ -350,8 +350,7 @@ static int __devexit retu_rtc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver retu_rtc_driver = {
-	.probe		= retu_rtc_probe,
-	.remove		= __devexit_p(retu_rtc_remove),
+	.remove		= __exit_p(retu_rtc_remove),
 	.driver		= {
 		.name	= "retu-rtc",
 	},
@@ -359,7 +358,7 @@ static struct platform_driver retu_rtc_driver = {
 
 static int __init retu_rtc_init(void)
 {
-	return platform_driver_register(&retu_rtc_driver);
+	return platform_driver_probe(&retu_rtc_driver, retu_rtc_probe);
 }
 
 static void __exit retu_rtc_exit(void)
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 3d83cdc..8b87ae9 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -253,7 +253,7 @@ static const struct file_operations retu_wdt_fops = {
 
 /*----------------------------------------------------------------------------*/
 
-static int __devinit retu_wdt_probe(struct platform_device *pdev)
+static int __init retu_wdt_probe(struct platform_device *pdev)
 {
 	struct retu_wdt_dev *wdev;
 	int ret;
@@ -340,8 +340,7 @@ static int __devexit retu_wdt_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver retu_wdt_driver = {
-	.probe		= retu_wdt_probe,
-	.remove		= __devexit_p(retu_wdt_remove),
+	.remove		= __exit_p(retu_wdt_remove),
 	.driver		= {
 		.name	= "retu-wdt",
 	},
@@ -349,7 +348,7 @@ static struct platform_driver retu_wdt_driver = {
 
 static int __init retu_wdt_init(void)
 {
-	return platform_driver_register(&retu_wdt_driver);
+	return platform_driver_probe(&retu_wdt_driver, retu_wdt_probe);
 }
 
 static void __exit retu_wdt_exit(void)
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 67b663e..1397366 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -395,7 +395,7 @@ static int retu_allocate_children(struct device *parent)
  * Probe for the Retu ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit retu_probe(struct platform_device *pdev)
+static int __init retu_probe(struct platform_device *pdev)
 {
 	int rev, ret;
 	int irq;
@@ -453,7 +453,7 @@ static int __devinit retu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit retu_remove(struct platform_device *pdev)
+static int __exit retu_remove(struct platform_device *pdev)
 {
 	int irq;
 
@@ -471,8 +471,7 @@ static int __devexit retu_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver retu_driver = {
-	.probe		= retu_probe,
-	.remove		= __devexit_p(retu_remove),
+	.remove		= __exit_p(retu_remove),
 	.driver		= {
 		.name	= "retu",
 	},
@@ -532,7 +531,7 @@ static int __init retu_init(void)
 	/* Set up correct gpio number on struct resource */
 	retu_resource[0].start = gpio_to_irq(retu_irq_pin);
 
-	ret = platform_driver_register(&retu_driver);
+	ret = platform_driver_probe(&retu_driver, retu_probe);
 	if (ret < 0)
 		goto err1;
 
-- 
1.7.3.rc0.35.g8ac8c

