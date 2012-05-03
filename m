From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/25] OMAPFB: add __init & __exit
Date: Thu,  3 May 2012 16:57:55 +0300
Message-ID: <1336053481-25433-20-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:44574 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756245Ab2ECN6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:51 -0400
Received: by lbbgo11 with SMTP id go11so1185932lbb.3
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:48 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change omapfb to use platform_driver_probe and add __init & __exit.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index b00db40..a0967dc 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2307,7 +2307,7 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 	return 0;
 }
 
-static int omapfb_probe(struct platform_device *pdev)
+static int __init omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
 	int r = 0;
@@ -2448,7 +2448,7 @@ err0:
 	return r;
 }
 
-static int omapfb_remove(struct platform_device *pdev)
+static int __exit omapfb_remove(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = platform_get_drvdata(pdev);
 
@@ -2462,8 +2462,7 @@ static int omapfb_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omapfb_driver = {
-	.probe          = omapfb_probe,
-	.remove         = omapfb_remove,
+	.remove         = __exit_p(omapfb_remove),
 	.driver         = {
 		.name   = "omapfb",
 		.owner  = THIS_MODULE,
@@ -2474,7 +2473,7 @@ static int __init omapfb_init(void)
 {
 	DBG("omapfb_init\n");
 
-	if (platform_driver_register(&omapfb_driver)) {
+	if (platform_driver_probe(&omapfb_driver, omapfb_probe)) {
 		printk(KERN_ERR "failed to register omapfb driver\n");
 		return -ENODEV;
 	}
-- 
1.7.9.5

