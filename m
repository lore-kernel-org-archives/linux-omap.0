From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 27/86] [ARM] omap: mcspi: new short connection id names
Date: Thu, 12 Mar 2009 11:27:37 -0700
Message-ID: <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327AbZCLSay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:54 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:52 -0700 (PDT)
In-Reply-To: <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

... rather than the clock names themselves.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c |   12 ++++++------
 arch/arm/mach-omap2/clock34xx.c |   16 ++++++++--------
 drivers/spi/omap2_mcspi.c       |    4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index aca4ca4..ac03803 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -149,12 +149,12 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK("omap-mcbsp.4", "mcbsp_fck", &mcbsp4_fck,	CK_243X),
 	CLK("omap-mcbsp.5", "mcbsp_ick", &mcbsp5_ick,	CK_243X),
 	CLK("omap-mcbsp.5", "mcbsp_fck", &mcbsp5_fck,	CK_243X),
-	CLK("omap2_mcspi.1", "mcspi_ick", &mcspi1_ick,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.1", "mcspi_fck", &mcspi1_fck,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.2", "mcspi_ick", &mcspi2_ick,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.2", "mcspi_fck", &mcspi2_fck,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.3", "mcspi_ick", &mcspi3_ick,	CK_243X),
-	CLK("omap2_mcspi.3", "mcspi_fck", &mcspi3_fck,	CK_243X),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_243X),
+	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_243X),
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index b3334b3..d0bfae5 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -147,10 +147,10 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK("omap-mcbsp.5", "mcbsp_fck", &mcbsp5_fck,	CK_343X),
 	CLK("omap-mcbsp.1", "mcbsp_fck", &mcbsp1_fck,	CK_343X),
 	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_343X),
-	CLK("omap2_mcspi.4", "mcspi_fck", &mcspi4_fck,	CK_343X),
-	CLK("omap2_mcspi.3", "mcspi_fck", &mcspi3_fck,	CK_343X),
-	CLK("omap2_mcspi.2", "mcspi_fck", &mcspi2_fck,	CK_343X),
-	CLK("omap2_mcspi.1", "mcspi_fck", &mcspi1_fck,	CK_343X),
+	CLK("omap2_mcspi.4", "fck",	&mcspi4_fck,	CK_343X),
+	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_343X),
+	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_343X),
+	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_343X),
 	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_343X),
 	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_343X),
 	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
@@ -175,10 +175,10 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK("mmci-omap-hs.0",	"mmchs_ick",	&mmchs1_ick,	CK_343X),
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
 	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_343X),
-	CLK("omap2_mcspi.4", "mcspi_ick", &mcspi4_ick,	CK_343X),
-	CLK("omap2_mcspi.3", "mcspi_ick", &mcspi3_ick,	CK_343X),
-	CLK("omap2_mcspi.2", "mcspi_ick", &mcspi2_ick,	CK_343X),
-	CLK("omap2_mcspi.1", "mcspi_ick", &mcspi1_ick,	CK_343X),
+	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_343X),
+	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_343X),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_343X),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_343X),
 	CLK("i2c_omap.3", "i2c_ick",	&i2c3_ick,	CK_343X),
 	CLK("i2c_omap.2", "i2c_ick",	&i2c2_ick,	CK_343X),
 	CLK("i2c_omap.1", "i2c_ick",	&i2c1_ick,	CK_343X),
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 454a271..b91ee1a 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1021,13 +1021,13 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	spin_lock_init(&mcspi->lock);
 	INIT_LIST_HEAD(&mcspi->msg_queue);
 
-	mcspi->ick = clk_get(&pdev->dev, "mcspi_ick");
+	mcspi->ick = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(mcspi->ick)) {
 		dev_dbg(&pdev->dev, "can't get mcspi_ick\n");
 		status = PTR_ERR(mcspi->ick);
 		goto err1a;
 	}
-	mcspi->fck = clk_get(&pdev->dev, "mcspi_fck");
+	mcspi->fck = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcspi->fck)) {
 		dev_dbg(&pdev->dev, "can't get mcspi_fck\n");
 		status = PTR_ERR(mcspi->fck);
-- 
1.6.1.2

