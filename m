From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] omap-rng: Use struct dev_pm_ops for power management
Date: Thu, 5 Jul 2012 00:00:56 +0200
Message-ID: <201207050000.56356.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53242 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755800Ab2GDVzY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jul 2012 17:55:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Deepak Saxena <dsaxena@plexity.net>, linux-omap@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the omap-rng driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct platform_driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/char/hw_random/omap-rng.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux/drivers/char/hw_random/omap-rng.c
===================================================================
--- linux.orig/drivers/char/hw_random/omap-rng.c
+++ linux/drivers/char/hw_random/omap-rng.c
@@ -162,22 +162,24 @@ static int __exit omap_rng_remove(struct
 
 #ifdef CONFIG_PM
 
-static int omap_rng_suspend(struct platform_device *pdev, pm_message_t message)
+static int omap_rng_suspend(struct device *dev)
 {
 	omap_rng_write_reg(RNG_MASK_REG, 0x0);
 	return 0;
 }
 
-static int omap_rng_resume(struct platform_device *pdev)
+static int omap_rng_resume(struct device *dev)
 {
 	omap_rng_write_reg(RNG_MASK_REG, 0x1);
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(omap_rng_pm, omap_rng_suspend, omap_rng_resume);
+#define	OMAP_RNG_PM	(&omap_rng_pm)
+
 #else
 
-#define	omap_rng_suspend	NULL
-#define	omap_rng_resume		NULL
+#define	OMAP_RNG_PM	NULL
 
 #endif
 
@@ -188,11 +190,10 @@ static struct platform_driver omap_rng_d
 	.driver = {
 		.name		= "omap_rng",
 		.owner		= THIS_MODULE,
+		.pm		= OMAP_RNG_PM,
 	},
 	.probe		= omap_rng_probe,
 	.remove		= __exit_p(omap_rng_remove),
-	.suspend	= omap_rng_suspend,
-	.resume		= omap_rng_resume
 };
 
 static int __init omap_rng_init(void)
