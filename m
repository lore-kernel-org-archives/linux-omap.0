From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/4] usb: musb: ux500: use SIMPLE_DEV_PM_OPS
Date: Sun, 22 Sep 2013 13:47:01 +0200
Message-ID: <1379850421-7966-4-git-send-email-zonque@gmail.com>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58055 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab3IVLrl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:47:41 -0400
In-Reply-To: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-ubs@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

Just a cosmetic change to bring this file in line with other musb
platform drivers.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/ux500.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 59256b1..819b884 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -377,10 +377,7 @@ static int ux500_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops ux500_pm_ops = {
-	.suspend	= ux500_suspend,
-	.resume		= ux500_resume,
-};
+static SIMPLE_DEV_PM_OPS(ux500_pm_ops, ux500_suspend, ux500_resume);
 
 #define DEV_PM_OPS	(&ux500_pm_ops)
 #else
-- 
1.8.3.1

