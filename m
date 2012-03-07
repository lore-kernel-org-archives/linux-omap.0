From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/21] OMAPFB: add __init & __exit
Date: Wed,  7 Mar 2012 14:44:49 +0200
Message-ID: <1331124290-6285-21-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59341 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758604Ab2CGMqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:46:52 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so10212971lah.37
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:46:50 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change omapfb to use platform_driver_probe and add __init & __exit.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

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
1.7.4.1

