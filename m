From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 1/4] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Sun, 22 Sep 2013 16:43:16 +0200
Message-ID: <1379860999-7106-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58490 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3IVOn2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 10:43:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

This makes am35x_pm_ops const and will stub the struct out in case
CONFIG_PM_SLEEP is not set.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---

I'm resending this series because I've just learned that
SIMPLE_DEV_PM_OPS will stub itself out in case CONFIG_PM_SLEEP is
not set. That makes the the code even smaller.

 drivers/usb/musb/am35x.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 5c310c6..7f1e990 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -615,23 +615,16 @@ static int am35x_resume(struct device *dev)
 
 	return 0;
 }
-
-static struct dev_pm_ops am35x_pm_ops = {
-	.suspend	= am35x_suspend,
-	.resume		= am35x_resume,
-};
-
-#define DEV_PM_OPS	&am35x_pm_ops
-#else
-#define DEV_PM_OPS	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
+
 static struct platform_driver am35x_driver = {
 	.probe		= am35x_probe,
 	.remove		= am35x_remove,
 	.driver		= {
 		.name	= "musb-am35x",
-		.pm	= DEV_PM_OPS,
+		.pm	= &am35x_pm_ops,
 	},
 };
 
-- 
1.8.3.1

