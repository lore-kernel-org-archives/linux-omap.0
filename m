From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 3/3] OMAP3:WDT:Enable clk in probe, trigger timer reload
Date: Mon,  8 Jun 2009 16:08:13 -0500
Message-ID: <1244495293-17244-4-git-send-email-ubh@ti.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
 <1244495293-17244-2-git-send-email-ubh@ti.com>
 <1244495293-17244-3-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34065 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755598AbZFHVCQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Jun 2009 17:02:16 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n58L2DgS031519
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2009 16:02:18 -0500
In-Reply-To: <1244495293-17244-3-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

This patch contains two bugfixes:

1)In omap_wdt_probe() the watchdog is reset and disabled. This
requires register access and the clks needs to be enabled temporarily

2)In omap_wdt_open() the timer register needs to be reloaded
to trigger a new timer value (the default of 60s)

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
---
 drivers/watchdog/omap_wdt.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 26935c7..cb580a8 100755
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -179,6 +179,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	file->private_data = (void *) wdev;
 
 	omap_wdt_set_timeout(wdev);
+	omap_wdt_ping(wdev); /* trigger loading of new timeout value */
 	omap_wdt_enable(wdev);
 
 	return nonseekable_open(inode, file);
@@ -334,6 +335,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdev);
 
+	clk_enable(wdev->ick);
+	clk_enable(wdev->fck);
+
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
 
@@ -359,6 +363,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	/* autogate OCP interface clock */
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
+	clk_disable(wdev->ick);
+	clk_disable(wdev->fck);
+
 	/* keep track of the wdt platform devices in local device array */
 	omap_wdt_dev[pdev->id - 1] = pdev;
 
-- 
1.5.4.3

