From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 1/1] watchdog: OMAP fixes: enable clock in probe, trigger timer reload
Date: Fri, 12 Jun 2009 16:18:32 -0500
Message-ID: <1244841512-12013-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57013 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757584AbZFLVOB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jun 2009 17:14:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wim@iguana.be
Cc: linux-omap@vger.kernel.org, Ulrik Bech Hald <ubh@ti.com>

This patch contains two bugfixes:

1)In omap_wdt_probe() the watchdog is reset and disabled. This
requires register access and the clks needs to be enabled temporarily

2)In omap_wdt_open() the timer register needs to be reloaded
to trigger a new timer value (the default of 60s)

Tested on OMAP34xx platform (Zoom1)

Reviewed-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
---
 drivers/watchdog/omap_wdt.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 drivers/watchdog/omap_wdt.c

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
old mode 100644
new mode 100755
index f271385..3ed571a
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -159,6 +159,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	file->private_data = (void *) wdev;
 
 	omap_wdt_set_timeout(wdev);
+	omap_wdt_ping(wdev); /* trigger loading of new timeout value */
 	omap_wdt_enable(wdev);
 
 	return nonseekable_open(inode, file);
@@ -313,6 +314,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdev);
 
+	clk_enable(wdev->ick);
+	clk_enable(wdev->fck);
+
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
 
@@ -332,6 +336,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	/* autogate OCP interface clock */
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
+	clk_disable(wdev->ick);
+	clk_disable(wdev->fck);
+
 	omap_wdt_dev = pdev;
 
 	return 0;
-- 
1.5.4.3

