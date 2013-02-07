From: Philip Avinash <avinashphilip@ti.com>
Subject: [PATCH v2 1/4] arm: gpmc: Converts GPMC driver to pm_runtime capable
Date: Thu, 7 Feb 2013 18:06:55 +0530
Message-ID: <1360240618-11094-2-git-send-email-avinashphilip@ti.com>
References: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@ti.com, tony@atomide.com, linux@arm.linux.org.uk, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com
Cc: afzal@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, hvaibhav@ti.com, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

Support for pm_runtime add to GPMC driver.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2c57f81..b1cd6c1 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -29,6 +29,7 @@
 #include <linux/of_mtd.h>
 #include <linux/of_device.h>
 #include <linux/mtd/nand.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
 
@@ -1317,7 +1318,8 @@ static int gpmc_probe(struct platform_device *pdev)
 		return PTR_ERR(gpmc_l3_clk);
 	}
 
-	clk_prepare_enable(gpmc_l3_clk);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	gpmc_dev = &pdev->dev;
 
@@ -1329,7 +1331,7 @@ static int gpmc_probe(struct platform_device *pdev)
 
 	rc = gpmc_mem_init();
 	if (IS_ERR_VALUE(rc)) {
-		clk_disable_unprepare(gpmc_l3_clk);
+		pm_runtime_put_sync(&pdev->dev);
 		clk_put(gpmc_l3_clk);
 		dev_err(gpmc_dev, "failed to reserve memory\n");
 		return rc;
@@ -1340,7 +1342,7 @@ static int gpmc_probe(struct platform_device *pdev)
 
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
-		clk_disable_unprepare(gpmc_l3_clk);
+		pm_runtime_put_sync(&pdev->dev);
 		clk_put(gpmc_l3_clk);
 		dev_err(gpmc_dev, "failed to probe DT parameters\n");
 		return rc;
@@ -1353,6 +1355,8 @@ static __devexit int gpmc_remove(struct platform_device *pdev)
 {
 	gpmc_free_irq();
 	gpmc_mem_exit();
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	gpmc_dev = NULL;
 	return 0;
 }
-- 
1.7.9.5
