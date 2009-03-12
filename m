From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 26/86] [ARM] omap: MMC: provide a dummy ick for OMAP1
Date: Thu, 12 Mar 2009 11:27:36 -0700
Message-ID: <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311AbZCLSau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:50 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:49 -0700 (PDT)
In-Reply-To: <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Eliminate the OMAP1 vs OMAP2 clock knowledge in the MMC driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c |    2 ++
 drivers/mmc/host/omap.c     |   19 ++++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 3015e85..61ace02 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -125,7 +125,9 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"bclk",		&bclk_16xx,	CK_16XX),
 	CLK("mmci-omap.0", "fck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK("mmci-omap.0", "ick",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("mmci-omap.1", "fck",	&mmc2_ck,	CK_16XX),
+	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
 	/* Virtual clocks */
 	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
 	CLK("i2c_omap.1", "i2c_fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 15eb883..5570849 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1460,15 +1460,12 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	if (!host->virt_base)
 		goto err_ioremap;
 
-	if (cpu_is_omap24xx()) {
-		host->iclk = clk_get(&pdev->dev, "ick");
-		if (IS_ERR(host->iclk))
-			goto err_free_mmc_host;
-		clk_enable(host->iclk);
-	}
+	host->iclk = clk_get(&pdev->dev, "ick");
+	if (IS_ERR(host->iclk))
+		goto err_free_mmc_host;
+	clk_enable(host->iclk);
 
 	host->fclk = clk_get(&pdev->dev, "fck");
-
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
 		goto err_free_iclk;
@@ -1533,10 +1530,10 @@ static int mmc_omap_remove(struct platform_device *pdev)
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 
-	if (host->iclk && !IS_ERR(host->iclk))
-		clk_put(host->iclk);
-	if (host->fclk && !IS_ERR(host->fclk))
-		clk_put(host->fclk);
+	mmc_omap_fclk_enable(host, 0);
+	clk_put(host->fclk);
+	clk_disable(host->iclk);
+	clk_put(host->iclk);
 
 	iounmap(host->virt_base);
 	release_mem_region(pdev->resource[0].start,
-- 
1.6.1.2

