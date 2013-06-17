From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v5 1/3] ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable
Date: Tue, 18 Jun 2013 00:16:37 +0530
Message-ID: <1371494799-11876-2-git-send-email-pekon@ti.com>
References: <1371494799-11876-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43010 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836Ab3FQSrU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 14:47:20 -0400
In-Reply-To: <1371494799-11876-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@linaro.org, avinash philip <avinashphilip@ti.com>, Pekon Gupta <pekon@ti.com>

From: avinash philip <avinashphilip@ti.com>

Support for pm_runtime add to GPMC driver.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Signed-off-by: Pekon Gupta <pekon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index fb6f241..1380cee 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -30,6 +30,7 @@
 #include <linux/of_mtd.h>
 #include <linux/of_device.h>
 #include <linux/mtd/nand.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
 
@@ -1594,7 +1595,8 @@ static int gpmc_probe(struct platform_device *pdev)
 		return PTR_ERR(gpmc_l3_clk);
 	}
 
-	clk_prepare_enable(gpmc_l3_clk);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	gpmc_dev = &pdev->dev;
 
@@ -1634,7 +1636,7 @@ static int gpmc_probe(struct platform_device *pdev)
 
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
-		clk_disable_unprepare(gpmc_l3_clk);
+		pm_runtime_put_sync(&pdev->dev);
 		clk_put(gpmc_l3_clk);
 		dev_err(gpmc_dev, "failed to probe DT parameters\n");
 		return rc;
@@ -1647,6 +1649,8 @@ static int gpmc_remove(struct platform_device *pdev)
 {
 	gpmc_free_irq();
 	gpmc_mem_exit();
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	gpmc_dev = NULL;
 	return 0;
 }
-- 
1.8.1

