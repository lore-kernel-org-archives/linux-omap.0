From: Pekon Gupta <pekon@ti.com>
Subject: [v4 2/3] arm: gpmc: Low power transition support
Date: Wed, 12 Jun 2013 15:55:07 +0530
Message-ID: <1371032708-9242-3-git-send-email-pekon@ti.com>
References: <1371032708-9242-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab3FLKZl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 06:25:41 -0400
In-Reply-To: <1371032708-9242-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
Cc: avinash philip <avinashphilip@ti.com>, Pekon Gupta <pekon@ti.com>

From: avinash philip <avinashphilip@ti.com>

With GPMC converted to platform driver recently, adds low power
transition support in driver itself.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1380cee..b5c4752 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1655,6 +1655,24 @@ static int gpmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int gpmc_suspend(struct device *dev)
+{
+	omap3_gpmc_save_context();
+	pm_runtime_put_sync(dev);
+	return 0;
+}
+
+static int gpmc_resume(struct device *dev)
+{
+	pm_runtime_get_sync(dev);
+	omap3_gpmc_restore_context();
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(gpmc_pm_ops, gpmc_suspend, gpmc_resume);
+
 static struct platform_driver gpmc_driver = {
 	.probe		= gpmc_probe,
 	.remove		= gpmc_remove,
@@ -1662,6 +1680,7 @@ static struct platform_driver gpmc_driver = {
 		.name	= DEVICE_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(gpmc_dt_ids),
+		.pm	= &gpmc_pm_ops,
 	},
 };
 
-- 
1.8.1

