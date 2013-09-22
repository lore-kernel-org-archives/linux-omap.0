From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/4] usb: musb: blackfin: use SIMPLE_DEV_PM_OPS
Date: Sun, 22 Sep 2013 13:46:59 +0200
Message-ID: <1379850421-7966-2-git-send-email-zonque@gmail.com>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58053 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab3IVLrl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:47:41 -0400
In-Reply-To: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-ubs@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

This makes bfin_pm_ops const.

Also, checkpatch.pl complains about the use of DEV_PM_OPS:

  ERROR: Macros with complex values should be enclosed in parenthesis

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/blackfin.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 72e2056..7db75c9 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -562,12 +562,9 @@ static int bfin_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops bfin_pm_ops = {
-	.suspend	= bfin_suspend,
-	.resume		= bfin_resume,
-};
+static SIMPLE_DEV_PM_OPS(bfin_pm_ops, bfin_suspend, bfin_resume);
 
-#define DEV_PM_OPS	&bfin_pm_ops
+#define DEV_PM_OPS	(&bfin_pm_ops)
 #else
 #define DEV_PM_OPS	NULL
 #endif
-- 
1.8.3.1

