From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 36/86] [ARM] omap: hsmmc: new short connection id names
Date: Thu, 12 Mar 2009 11:27:46 -0700
Message-ID: <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632AbZCLSbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:24 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:22 -0700 (PDT)
In-Reply-To: <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

... rather than the clock names themselves.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c |    8 ++++----
 arch/arm/mach-omap2/clock34xx.c |   12 ++++++------
 arch/arm/mach-omap2/devices.c   |    4 ++--
 drivers/mmc/host/omap_hsmmc.c   |    4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index d190b6a..bd77ef2 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -205,10 +205,10 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"usbhs_ick",	&usbhs_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "mmchs_ick",	&mmchs1_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "mmchs_fck",	&mmchs1_fck,	CK_243X),
-	CLK("mmci-omap-hs.1", "mmchs_ick",	&mmchs2_ick,	CK_243X),
-	CLK("mmci-omap-hs.1", "mmchs_fck",	&mmchs2_fck,	CK_243X),
+	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
+	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
+	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
+	CLK("mmci-omap-hs.1", "fck",	&mmchs2_fck,	CK_243X),
 	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
 	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 07e3308..245a7b9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -137,10 +137,10 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_343X),
-	CLK("mmci-omap-hs.2",	"mmchs_fck",	&mmchs3_fck,	CK_3430ES2),
-	CLK("mmci-omap-hs.1",	"mmchs_fck",	&mmchs2_fck,	CK_343X),
+	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2),
+	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_343X),
 	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
-	CLK("mmci-omap-hs.0",	"mmchs_fck",	&mmchs1_fck,	CK_343X),
+	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_343X),
 	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_343X),
 	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_343X),
 	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_343X),
@@ -166,13 +166,13 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_343X),
 	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_343X),
 	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2),
-	CLK("mmci-omap-hs.2",	"mmchs_ick",	&mmchs3_ick,	CK_3430ES2),
+	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
 	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_343X),
 	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_343X),
 	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
-	CLK("mmci-omap-hs.1",	"mmchs_ick",	&mmchs2_ick,	CK_343X),
-	CLK("mmci-omap-hs.0",	"mmchs_ick",	&mmchs1_ick,	CK_343X),
+	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_343X),
+	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_343X),
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_343X),
 	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_343X),
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9730404..8075f58 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -349,11 +349,11 @@ static void __init omap_hsmmc_reset(void)
 
 		dummy_pdev.id = i;
 		dev_set_name(&dummy_pdev.dev, "mmci-omap-hs.%d", i);
-		iclk = clk_get(dev, "mmchs_ick");
+		iclk = clk_get(dev, "ick");
 		if (iclk && clk_enable(iclk))
 			iclk = NULL;
 
-		fclk = clk_get(dev, "mmchs_fck");
+		fclk = clk_get(dev, "fck");
 		if (fclk && clk_enable(fclk))
 			fclk = NULL;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index db37490..65e0743 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -920,13 +920,13 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 
 	sema_init(&host->sem, 1);
 
-	host->iclk = clk_get(&pdev->dev, "mmchs_ick");
+	host->iclk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(host->iclk)) {
 		ret = PTR_ERR(host->iclk);
 		host->iclk = NULL;
 		goto err1;
 	}
-	host->fclk = clk_get(&pdev->dev, "mmchs_fck");
+	host->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
 		host->fclk = NULL;
-- 
1.6.1.2

