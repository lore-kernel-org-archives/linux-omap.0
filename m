From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/7] usb: dwc3: exynos: remove DEV_PM_OPS hackery
Date: Thu, 12 Dec 2013 15:38:44 -0600
Message-ID: <1386884325-11440-7-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50152 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab3LLVjs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 16:39:48 -0500
In-Reply-To: <1386884325-11440-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

it's best to just remove all ifdefs and always
define our dev_pm_ops structure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 8b20c70..6ccfc64 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -184,7 +184,6 @@ static const struct of_device_id exynos_dwc3_match[] = {
 MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 static int dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
@@ -212,18 +211,13 @@ static const struct dev_pm_ops dwc3_exynos_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_exynos_suspend, dwc3_exynos_resume)
 };
 
-#define DEV_PM_OPS	(&dwc3_exynos_dev_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
-
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
 	.remove		= dwc3_exynos_remove,
 	.driver		= {
 		.name	= "exynos-dwc3",
 		.of_match_table = of_match_ptr(exynos_dwc3_match),
-		.pm	= DEV_PM_OPS,
+		.pm	= &dwc3_exynos_dev_pm_ops,
 	},
 };
 
-- 
1.8.4.GIT

