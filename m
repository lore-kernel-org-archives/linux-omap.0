From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/07] i2c: rework i2c-s3c2410 suspend_late()/resume()
Date: Fri, 05 Jun 2009 16:55:24 +0900
Message-ID: <20090605075524.14756.96881.sendpatchset@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:33932 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbZFEH6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 03:58:41 -0400
Received: by rv-out-0506.google.com with SMTP id f9so604462rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 00:58:44 -0700 (PDT)
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, pavel@ucw.cz, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for i2c-s3c2410 from legacy callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume() -> resume()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 drivers/i2c/busses/i2c-s3c2410.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- 0001/drivers/i2c/busses/i2c-s3c2410.c
+++ work/drivers/i2c/busses/i2c-s3c2410.c	2009-06-01 15:26:38.000000000 +0900
@@ -944,17 +944,20 @@ static int s3c24xx_i2c_remove(struct pla
 }
 
 #ifdef CONFIG_PM
-static int s3c24xx_i2c_suspend_late(struct platform_device *dev,
-				    pm_message_t msg)
+static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 {
-	struct s3c24xx_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
+
 	i2c->suspended = 1;
+
 	return 0;
 }
 
-static int s3c24xx_i2c_resume(struct platform_device *dev)
+static int s3c24xx_i2c_resume(struct device *dev)
 {
-	struct s3c24xx_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c->suspended = 0;
 	s3c24xx_i2c_init(i2c);
@@ -962,9 +965,14 @@ static int s3c24xx_i2c_resume(struct pla
 	return 0;
 }
 
+static struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
+	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
+	.resume = s3c24xx_i2c_resume,
+};
+
+#define S3C24XX_DEV_PM_OPS (&s3c24xx_i2c_dev_pm_ops)
 #else
-#define s3c24xx_i2c_suspend_late NULL
-#define s3c24xx_i2c_resume NULL
+#define S3C24XX_DEV_PM_OPS NULL
 #endif
 
 /* device driver for platform bus bits */
@@ -972,22 +980,20 @@ static int s3c24xx_i2c_resume(struct pla
 static struct platform_driver s3c2410_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
-	.suspend_late	= s3c24xx_i2c_suspend_late,
-	.resume		= s3c24xx_i2c_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c2410-i2c",
+		.pm	= S3C24XX_DEV_PM_OPS,
 	},
 };
 
 static struct platform_driver s3c2440_i2c_driver = {
 	.probe		= s3c24xx_i2c_probe,
 	.remove		= s3c24xx_i2c_remove,
-	.suspend_late	= s3c24xx_i2c_suspend_late,
-	.resume		= s3c24xx_i2c_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c2440-i2c",
+		.pm	= S3C24XX_DEV_PM_OPS,
 	},
 };
 
