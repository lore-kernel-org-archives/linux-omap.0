From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 2/6] OMAP: omap_wdt: Fix interface clock existence check.
Date: Wed, 11 Mar 2009 17:29:34 +0200
Message-ID: <0fe7f2934f8416e9b5f05e2f18766362560116ee.1236609434.git.ext-atal.shargorodsky__32022.73656284$1236785582$gmane$org@nokia.com>
References: <>
 <1236785378-14640-1-git-send-email-ext-atal.shargorodsky@nokia.com>
 <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45622 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517AbZCKPbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:31:05 -0400
In-Reply-To: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
In-Reply-To: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
References: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

When enabling/disabling the iterface clock, the question
to be asked is if this clock exists rather than to
decide about it's existance by retrieving the chip version.
It can be done only once at init time.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 drivers/watchdog/omap_wdt.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 5b72c7c..05dc55a 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -145,7 +145,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (wdev->mpu_wdt_ick)
 		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
 
 	clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
@@ -177,7 +177,7 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (wdev->mpu_wdt_ick)
 		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
 
 	clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
@@ -344,7 +344,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdev);
 
 	/* enable clocks for register access */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (wdev->mpu_wdt_ick)
 		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
 
 	clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
@@ -369,7 +369,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
 	/* disable clocks since we don't need them now */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (wdev->mpu_wdt_ick)
 		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
 	clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
 
-- 
1.5.4.3

