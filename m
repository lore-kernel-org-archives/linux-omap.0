From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
Date: Fri, 05 Jun 2009 16:55:14 +0900
Message-ID: <20090605075514.14756.44434.sendpatchset@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:33932 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbZFEH6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 03:58:32 -0400
Received: by rv-out-0506.google.com with SMTP id f9so604462rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 00:58:34 -0700 (PDT)
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: pavel@ucw.cz, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for i2c-pxa from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 drivers/i2c/busses/i2c-pxa.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- 0001/drivers/i2c/busses/i2c-pxa.c
+++ work/drivers/i2c/busses/i2c-pxa.c	2009-06-01 15:26:06.000000000 +0900
@@ -1135,35 +1135,44 @@ static int __exit i2c_pxa_remove(struct 
 }
 
 #ifdef CONFIG_PM
-static int i2c_pxa_suspend_late(struct platform_device *dev, pm_message_t state)
+static int i2c_pxa_suspend_noirq(struct device *dev)
 {
-	struct pxa_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
+
 	clk_disable(i2c->clk);
+
 	return 0;
 }
 
-static int i2c_pxa_resume_early(struct platform_device *dev)
+static int i2c_pxa_resume_noirq(struct device *dev)
 {
-	struct pxa_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
 
 	clk_enable(i2c->clk);
 	i2c_pxa_reset(i2c);
 
 	return 0;
 }
+
+static struct dev_pm_ops i2c_pxa_dev_pm_ops = {
+	.suspend_noirq = i2c_pxa_suspend_noirq,
+	.resume_noirq = i2c_pxa_resume_noirq,
+};
+
+#define I2C_PXA_DEV_PM_OPS (&i2c_pxa_dev_pm_ops)
 #else
-#define i2c_pxa_suspend_late NULL
-#define i2c_pxa_resume_early NULL
+#define I2C_PXA_DEV_PM_OPS NULL
 #endif
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
 	.remove		= __exit_p(i2c_pxa_remove),
-	.suspend_late	= i2c_pxa_suspend_late,
-	.resume_early	= i2c_pxa_resume_early,
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
+		.pm	= I2C_PXA_DEV_PM_OPS,
 	},
 	.id_table	= i2c_pxa_id_table,
 };
