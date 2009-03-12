From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 25/86] [ARM] omap: MMC: convert clocks to match by devid and conid
Date: Thu, 12 Mar 2009 11:27:35 -0700
Message-ID: <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbZCLSar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:47 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:46 -0700 (PDT)
In-Reply-To: <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Convert OMAP MMC driver to match clocks using the device ID and a
connection ID rather than a clock name.  This allows us to eliminate
the OMAP1/OMAP2 differences for the function clock.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c     |    4 ++--
 arch/arm/mach-omap2/clock24xx.c |    4 ++--
 drivers/mmc/host/omap.c         |    7 ++-----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 758abaa..3015e85 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -124,8 +124,8 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"mclk",		&mclk_16xx,	CK_16XX),
 	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
 	CLK(NULL,	"bclk",		&bclk_16xx,	CK_16XX),
-	CLK("mmci-omap.0", "mmc_ck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
-	CLK("mmci-omap.1", "mmc_ck",	&mmc2_ck,	CK_16XX),
+	CLK("mmci-omap.0", "fck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK("mmci-omap.1", "fck",	&mmc2_ck,	CK_16XX),
 	/* Virtual clocks */
 	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
 	CLK("i2c_omap.1", "i2c_fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 6a6278e..aca4ca4 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -178,8 +178,8 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"mmc_ick",	&mmc_ick,	CK_242X),
-	CLK(NULL,	"mmc_fck",	&mmc_fck,	CK_242X),
+	CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
+	CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
 	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 67d7b7f..15eb883 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1461,16 +1461,13 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		goto err_ioremap;
 
 	if (cpu_is_omap24xx()) {
-		host->iclk = clk_get(&pdev->dev, "mmc_ick");
+		host->iclk = clk_get(&pdev->dev, "ick");
 		if (IS_ERR(host->iclk))
 			goto err_free_mmc_host;
 		clk_enable(host->iclk);
 	}
 
-	if (!cpu_is_omap24xx())
-		host->fclk = clk_get(&pdev->dev, "mmc_ck");
-	else
-		host->fclk = clk_get(&pdev->dev, "mmc_fck");
+	host->fclk = clk_get(&pdev->dev, "fck");
 
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
-- 
1.6.1.2

