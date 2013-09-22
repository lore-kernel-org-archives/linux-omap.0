From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/4] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Sun, 22 Sep 2013 13:46:58 +0200
Message-ID: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58052 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab3IVLrl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:47:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-ubs@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

This makes am35x_pm_ops const.

Also, checkpatch.pl complains about the use of DEV_PM_OPS:

  ERROR: Macros with complex values should be enclosed in parenthesis

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/am35x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 5c310c6..df32a29 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -616,12 +616,9 @@ static int am35x_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops am35x_pm_ops = {
-	.suspend	= am35x_suspend,
-	.resume		= am35x_resume,
-};
+static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
 
-#define DEV_PM_OPS	&am35x_pm_ops
+#define DEV_PM_OPS	(&am35x_pm_ops)
 #else
 #define DEV_PM_OPS	NULL
 #endif
-- 
1.8.3.1

