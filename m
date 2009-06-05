From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 06/07] usb: rework musb suspend()/resume_early()
Date: Fri, 05 Jun 2009 16:55:33 +0900
Message-ID: <20090605075533.14756.69837.sendpatchset@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:33932 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbZFEH6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 03:58:50 -0400
Received: by rv-out-0506.google.com with SMTP id f9so604462rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 00:58:53 -0700 (PDT)
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: pavel@ucw.cz, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, rjw@sisk.pl, stern@rowland.harvard.edu, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for musb from legacy callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend() -> suspend()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 drivers/i2c/busses/i2c-pxa.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- 0001/drivers/usb/musb/musb_core.c
+++ work/drivers/usb/musb/musb_core.c	2009-06-01 15:27:12.000000000 +0900
@@ -2168,8 +2168,9 @@ static int __devexit musb_remove(struct 
 
 #ifdef	CONFIG_PM
 
-static int musb_suspend(struct platform_device *pdev, pm_message_t message)
+static int musb_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	unsigned long	flags;
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 
@@ -2196,8 +2197,9 @@ static int musb_suspend(struct platform_
 	return 0;
 }
 
-static int musb_resume_early(struct platform_device *pdev)
+static int musb_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 
 	if (!musb->clock)
@@ -2215,9 +2217,14 @@ static int musb_resume_early(struct plat
 	return 0;
 }
 
+static struct dev_pm_ops musb_dev_pm_ops = {
+	.suspend	= musb_suspend,
+	.resume_noirq	= musb_resume_noirq,
+};
+
+#define MUSB_DEV_PM_OPS (&musb_dev_pm_ops)
 #else
-#define	musb_suspend	NULL
-#define	musb_resume_early	NULL
+#define	MUSB_DEV_PM_OPS	NULL
 #endif
 
 static struct platform_driver musb_driver = {
@@ -2225,11 +2232,10 @@ static struct platform_driver musb_drive
 		.name		= (char *)musb_driver_name,
 		.bus		= &platform_bus_type,
 		.owner		= THIS_MODULE,
+		.pm		= MUSB_DEV_PM_OPS,
 	},
 	.remove		= __devexit_p(musb_remove),
 	.shutdown	= musb_shutdown,
-	.suspend	= musb_suspend,
-	.resume_early	= musb_resume_early,
 };
 
 /*-------------------------------------------------------------------------*/
