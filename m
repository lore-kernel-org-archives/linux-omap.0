From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/4] usb: musb: omap2430: use SIMPLE_DEV_PM_OPS
Date: Sun, 22 Sep 2013 13:47:00 +0200
Message-ID: <1379850421-7966-3-git-send-email-zonque@gmail.com>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58054 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab3IVLrl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:47:41 -0400
In-Reply-To: <1379850421-7966-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-ubs@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

This makes omap2430_pm_ops const.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/omap2430.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 59d2245..ef53737 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -660,10 +660,9 @@ static int omap2430_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops omap2430_pm_ops = {
-	.runtime_suspend = omap2430_runtime_suspend,
-	.runtime_resume = omap2430_runtime_resume,
-};
+static SIMPLE_DEV_PM_OPS(omap2430_pm_ops,
+			 omap2430_runtime_suspend,
+			 omap2430_runtime_resume);
 
 #define DEV_PM_OPS	(&omap2430_pm_ops)
 #else
-- 
1.8.3.1

