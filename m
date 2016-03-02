From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] thermal: ti-soc-thermal: clean up the error handling a bit
Date: Wed, 2 Mar 2016 13:00:55 +0300
Message-ID: <20160302100055.GA5533@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We don't need to initialize "ret".  We can move the IS_ERR() checks into
the if condition instead of doing an assignment first.  Also there is a
check for "ret" when we know it is zero so we can remove that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 1e34a1e..06ea976 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1265,7 +1265,7 @@ static
 int ti_bandgap_probe(struct platform_device *pdev)
 {
 	struct ti_bandgap *bgp;
-	int clk_rate, ret = 0, i;
+	int clk_rate, ret, i;
 
 	bgp = ti_bandgap_build(pdev);
 	if (IS_ERR(bgp)) {
@@ -1288,16 +1288,14 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	}
 
 	bgp->fclock = clk_get(NULL, bgp->conf->fclock_name);
-	ret = IS_ERR(bgp->fclock);
-	if (ret) {
+	if (IS_ERR(bgp->fclock)) {
 		dev_err(&pdev->dev, "failed to request fclock reference\n");
 		ret = PTR_ERR(bgp->fclock);
 		goto free_irqs;
 	}
 
 	bgp->div_clk = clk_get(NULL, bgp->conf->div_ck_name);
-	ret = IS_ERR(bgp->div_clk);
-	if (ret) {
+	if (IS_ERR(bgp->div_clk)) {
 		dev_err(&pdev->dev, "failed to request div_ts_ck clock ref\n");
 		ret = PTR_ERR(bgp->div_clk);
 		goto free_irqs;
@@ -1314,7 +1312,7 @@ int ti_bandgap_probe(struct platform_device *pdev)
 		 * may not be accurate
 		 */
 		val = ti_bandgap_readl(bgp, tsr->bgap_efuse);
-		if (ret || !val)
+		if (!val)
 			dev_info(&pdev->dev,
 				 "Non-trimmed BGAP, Temp not accurate\n");
 	}
