From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RESEND PATCH v3 4/6] watchdog: omap_wdt: convert ioremap() to devm_ioremap()
Date: Thu, 25 Oct 2012 18:19:10 +0300
Message-ID: <1351178352-3989-5-git-send-email-aaro.koskinen@iki.fi>
References: <1351178352-3989-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351178352-3989-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: wim@iguana.be, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Use devm_ioremap() to simplify the code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/watchdog/omap_wdt.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 45019b0..7e8d3e0 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -255,11 +255,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	wdev->wdt_trgr_pattern	= 0x1234;
 	mutex_init(&wdev->lock);
 
-	wdev->base = ioremap(res->start, resource_size(res));
-	if (!wdev->base) {
-		ret = -ENOMEM;
-		goto err_ioremap;
-	}
+	wdev->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!wdev->base)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, omap_wdt);
 
@@ -283,10 +281,6 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 err_misc:
 	pm_runtime_disable(wdev->dev);
 	platform_set_drvdata(pdev, NULL);
-	iounmap(wdev->base);
-
-err_ioremap:
-	wdev->base = NULL;
 
 	return ret;
 }
@@ -314,8 +308,6 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(wdog);
 	platform_set_drvdata(pdev, NULL);
 
-	iounmap(wdev->base);
-
 	return 0;
 }
 
-- 
1.7.2.5
