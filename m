From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 3/6] OMAP: omap_wdt: Remove non-explanatory comments.
Date: Wed, 11 Mar 2009 17:29:35 +0200
Message-ID: <7992fd993e5b420f9c2aac55f6e674169b36c666.1236609434.git.ext-atal.shargorodsky__21258.5871843205$1236785566$gmane$org@nokia.com>
References: <>
 <1236785378-14640-1-git-send-email-ext-atal.shargorodsky@nokia.com>
 <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
 <0fe7f2934f8416e9b5f05e2f18766362560116ee.1236609434.git.ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28511 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCKPay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:30:54 -0400
In-Reply-To: <0fe7f2934f8416e9b5f05e2f18766362560116ee.1236609434.git.ext-atal.shargorodsky@nokia.com>
In-Reply-To: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
References: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

The call to clk_disable does need a trivial
comment like /* Disable the clock */.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 05dc55a..1364d7e 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -146,9 +146,9 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 		return -EBUSY;
 
 	if (wdev->mpu_wdt_ick)
-		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
+		clk_enable(wdev->mpu_wdt_ick);
 
-	clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
+	clk_enable(wdev->mpu_wdt_fck);
 
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
@@ -178,9 +178,9 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 	omap_wdt_disable(wdev);
 
 	if (wdev->mpu_wdt_ick)
-		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
+		clk_disable(wdev->mpu_wdt_ick);
 
-	clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
+	clk_disable(wdev->mpu_wdt_fck);
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
@@ -345,9 +345,9 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 
 	/* enable clocks for register access */
 	if (wdev->mpu_wdt_ick)
-		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
+		clk_enable(wdev->mpu_wdt_ick);
 
-	clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
+	clk_enable(wdev->mpu_wdt_fck);
 
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
@@ -370,8 +370,8 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 
 	/* disable clocks since we don't need them now */
 	if (wdev->mpu_wdt_ick)
-		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
-	clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
+		clk_disable(wdev->mpu_wdt_ick);
+	clk_disable(wdev->mpu_wdt_fck);
 
 	omap_wdt_dev = pdev;
 
-- 
1.5.4.3

