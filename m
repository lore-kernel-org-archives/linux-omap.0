From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 1/4] MMC: OMAP HS-MMC: convert to dev_pm_ops
Date: Wed,  3 Feb 2010 16:51:25 -0800
Message-ID: <1265244688-4055-2-git-send-email-khilman@deeprootsystems.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:54207 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab0BDAvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:51:38 -0500
Received: by yxe27 with SMTP id 27so1717780yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:51:38 -0800 (PST)
In-Reply-To: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Convert PM operations to use dev_pm_ops.  This will facilitate
the runtime PM coversion which will add to dev_pm_ops hooks.

Note that dev_pm_ops version of the suspend hook no longer takes a
'state' argument.  However, the MMC core function mmc_suspend_host()
still takes a 'state' argument, but it is unused, so a dummy
state variable was created to pass to the MMC core.

In the future, the MMC core should be converted to drop this
state argument and the rest of the MMC drivers could be easily
converted to dev_pm_ops as well.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/mmc/host/omap_hsmmc.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index af37477..a05eae9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2238,10 +2238,12 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int omap_hsmmc_suspend(struct platform_device *pdev, pm_message_t state)
+static int omap_hsmmc_suspend(struct device *dev)
 {
 	int ret = 0;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
+	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
@@ -2290,9 +2292,10 @@ static int omap_hsmmc_suspend(struct platform_device *pdev, pm_message_t state)
 }
 
 /* Routine to resume the MMC device */
-static int omap_hsmmc_resume(struct platform_device *pdev)
+static int omap_hsmmc_resume(struct device *dev)
 {
 	int ret = 0;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
 
 	if (host && !host->suspended)
@@ -2343,13 +2346,17 @@ clk_en_err:
 #define omap_hsmmc_resume		NULL
 #endif
 
-static struct platform_driver omap_hsmmc_driver = {
-	.remove		= omap_hsmmc_remove,
+static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	.suspend	= omap_hsmmc_suspend,
 	.resume		= omap_hsmmc_resume,
+};
+
+static struct platform_driver omap_hsmmc_driver = {
+	.remove		= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.pm = &omap_hsmmc_dev_pm_ops,
 	},
 };
 
-- 
1.6.6

