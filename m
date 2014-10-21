From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 5/5] ARM: OMAP2+: gpmc: Sanity check GPMC fck on probe
Date: Tue, 21 Oct 2014 15:41:49 +0300
Message-ID: <1413895309-9152-6-git-send-email-rogerq@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932523AbaJUMmF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 08:42:05 -0400
In-Reply-To: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>

This prevents potential division by zero errors
if GPMC fck turns out to be zero due to faulty clock
data.

Use resource managed clk_get() API.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 437fb6f..104bc2c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -204,11 +204,6 @@ static unsigned long gpmc_get_fclk_period(void)
 {
 	unsigned long rate = clk_get_rate(gpmc_l3_clk);
 
-	if (rate == 0) {
-		printk(KERN_WARNING "gpmc_l3_clk not enabled\n");
-		return 0;
-	}
-
 	rate /= 1000;
 	rate = 1000000000 / rate;	/* In picoseconds */
 
@@ -1692,13 +1687,18 @@ static int gpmc_probe(struct platform_device *pdev)
 	else
 		gpmc_irq = res->start;
 
-	gpmc_l3_clk = clk_get(&pdev->dev, "fck");
+	gpmc_l3_clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(gpmc_l3_clk)) {
-		dev_err(&pdev->dev, "error: clk_get\n");
+		dev_err(&pdev->dev, "Failed to get GPMC fck\n");
 		gpmc_irq = 0;
 		return PTR_ERR(gpmc_l3_clk);
 	}
 
+	if (!clk_get_rate(gpmc_l3_clk)) {
+		dev_err(&pdev->dev, "Invalid GPMC fck clock rate\n");
+		return -EINVAL;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -1741,7 +1741,6 @@ static int gpmc_probe(struct platform_device *pdev)
 	rc = gpmc_probe_dt(pdev);
 	if (rc < 0) {
 		pm_runtime_put_sync(&pdev->dev);
-		clk_put(gpmc_l3_clk);
 		dev_err(gpmc_dev, "failed to probe DT parameters\n");
 		return rc;
 	}
-- 
1.8.3.2

