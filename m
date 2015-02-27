From: <grygorii.strashko@linaro.org>
Subject: [PATCH 2/2] net: ti: cpsw: add hibernation callbacks
Date: Fri, 27 Feb 2015 13:19:45 +0200
Message-ID: <1425035985-8875-2-git-send-email-grygorii.strashko@linaro.org>
References: <1425035985-8875-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1425035985-8875-1-git-send-email-grygorii.strashko@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Felipe Balbi <balbi@ti.com>
Cc: nm@ti.com, sumit.semwal@linaro.org, Mugunthan V N <mugunthanvnm@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Setting a dev_pm_ops suspend/resume pair but not a set of
hibernation functions means those pm functions will not be
called upon hibernation.
Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
assigns the suspend and hibernation handlers and move
cpsw_suspend/resume calbacks under CONFIG_PM_SLEEP
to avoid build warnings.

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 8704954..b4fcf5f 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2805,6 +2805,7 @@ static int cpsw_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int cpsw_suspend(struct device *dev)
 {
 	struct platform_device	*pdev = to_platform_device(dev);
@@ -2857,11 +2858,9 @@ static int cpsw_resume(struct device *dev)
 	}
 	return 0;
 }
+#endif
 
-static const struct dev_pm_ops cpsw_pm_ops = {
-	.suspend	= cpsw_suspend,
-	.resume		= cpsw_resume,
-};
+static SIMPLE_DEV_PM_OPS(cpsw_pm_ops, cpsw_suspend, cpsw_resume);
 
 static const struct of_device_id cpsw_of_mtable[] = {
 	{ .compatible = "ti,cpsw", },
-- 
1.9.1
