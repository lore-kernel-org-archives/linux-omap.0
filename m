From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] musb: musb: dsps: determine the number of instances at runtime
Date: Mon, 17 Jun 2013 17:13:34 +0200
Message-ID: <1371482014-5244-3-git-send-email-bigeasy@linutronix.de>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39763 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab3FQPNr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 11:13:47 -0400
In-Reply-To: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

There is no need to hardcode the number of instances here. It is better to
determine them at runtime. Even if the device provides two instances one
might only want to use one of them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/usb/musb/musb_dsps.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index d9ff390..0ac9934 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -110,8 +110,6 @@ struct dsps_musb_wrapper {
 	/* miscellaneous stuff */
 	u32		musb_core_offset;
 	u8		poll_seconds;
-	/* number of musb instances */
-	u8		instances;
 };
 
 /**
@@ -124,6 +122,7 @@ struct dsps_glue {
 	struct timer_list timer[2];	/* otg_workaround timer */
 	unsigned long last_timer[2];    /* last timer data for each instance */
 	u32 __iomem *usb_ctrl[2];
+	u8 instances;
 };
 
 #define	DSPS_AM33XX_CONTROL_MODULE_PHYS_0	0x44e10620
@@ -646,6 +645,23 @@ static int dsps_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, glue);
 
+	i = 1;
+	do {
+		iomem = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!iomem) {
+			i--;
+			break;
+		}
+		i++;
+	} while (1);
+
+	glue->instances = i;
+	if (glue->instances < 1) {
+		dev_err(&pdev->dev, "Need atleast iomem for one port.\n");
+		ret = -EINVAL;
+		goto err1_5;
+	}
+
 	/* enable the usbss clocks */
 	pm_runtime_enable(&pdev->dev);
 
@@ -656,7 +672,7 @@ static int dsps_probe(struct platform_device *pdev)
 	}
 
 	/* create the child platform device for all instances of musb */
-	for (i = 0; i < wrp->instances ; i++) {
+	for (i = 0; i < glue->instances; i++) {
 		ret = dsps_create_musb_pdev(glue, i);
 		if (ret != 0) {
 			dev_err(&pdev->dev, "failed to create child pdev\n");
@@ -673,6 +689,7 @@ static int dsps_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 err2:
 	pm_runtime_disable(&pdev->dev);
+err1_5:
 	kfree(glue->wrp);
 err1:
 	kfree(glue);
@@ -682,11 +699,10 @@ static int dsps_probe(struct platform_device *pdev)
 static int dsps_remove(struct platform_device *pdev)
 {
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	int i;
 
 	/* delete the child platform device */
-	for (i = 0; i < wrp->instances ; i++)
+	for (i = 0; i < glue->instances; i++)
 		platform_device_unregister(glue->musb[i]);
 
 	/* disable usbss clocks */
@@ -702,10 +718,9 @@ static int dsps_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev->parent);
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	int i;
 
-	for (i = 0; i < wrp->instances; i++)
+	for (i = 0; i < glue->instances; i++)
 		musb_dsps_phy_control(glue, i, 0);
 
 	return 0;
@@ -715,10 +730,9 @@ static int dsps_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev->parent);
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	int i;
 
-	for (i = 0; i < wrp->instances; i++)
+	for (i = 0; i < glue->instances; i++)
 		musb_dsps_phy_control(glue, i, 1);
 
 	return 0;
@@ -755,7 +769,6 @@ static const struct dsps_musb_wrapper ti81xx_driver_data = {
 	.rxep_bitmap		= (0xfffe << 16),
 	.musb_core_offset	= 0x400,
 	.poll_seconds		= 2,
-	.instances		= 1,
 };
 
 static const struct platform_device_id musb_dsps_id_table[] = {
-- 
1.8.3.1

