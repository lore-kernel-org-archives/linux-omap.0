From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH] pwm: pwm-tipwmss: Remove all pm_runtime gets and puts from the driver
Date: Mon, 8 Aug 2016 15:39:15 +0530
Message-ID: <20160808100915.30149-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jyri Sarha <jsarha@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Jyri Sarha <jsarha@ti.com>

Remove all pm_runtime gets and puts, and dummy pm_ops, from the
pwm-tipwmss driver as there is no direct hardware access. The runtime PM
needs to be enabled, so that the runtime PM framework takes care of
enabling/disabling of PWMSS clock when submodules of PWMSS (ECAP or
EHRPWM) call pm_runtime APIs. With this change PWMSS clock goes to
idle when none of the submodules are in use.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pwm/pwm-tipwmss.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/pwm/pwm-tipwmss.c b/drivers/pwm/pwm-tipwmss.c
index 829f4991c96f..7fa85a1604da 100644
--- a/drivers/pwm/pwm-tipwmss.c
+++ b/drivers/pwm/pwm-tipwmss.c
@@ -34,7 +34,6 @@ static int pwmss_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 
 	/* Populate all the child nodes here... */
 	ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
@@ -46,31 +45,13 @@ static int pwmss_probe(struct platform_device *pdev)
 
 static int pwmss_remove(struct platform_device *pdev)
 {
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pwmss_suspend(struct device *dev)
-{
-	pm_runtime_put_sync(dev);
-	return 0;
-}
-
-static int pwmss_resume(struct device *dev)
-{
-	pm_runtime_get_sync(dev);
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(pwmss_pm_ops, pwmss_suspend, pwmss_resume);
-
 static struct platform_driver pwmss_driver = {
 	.driver	= {
 		.name	= "pwmss",
-		.pm	= &pwmss_pm_ops,
 		.of_match_table	= pwmss_of_match,
 	},
 	.probe	= pwmss_probe,
-- 
2.9.2
