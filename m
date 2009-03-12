From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 32/86] [ARM] omap: w1: convert omap HDQ clocks to match by devid and conid
Date: Thu, 12 Mar 2009 11:27:42 -0700
Message-ID: <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581AbZCLSbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:12 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:11 -0700 (PDT)
In-Reply-To: <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c |    4 ++--
 arch/arm/mach-omap2/clock34xx.c |    4 ++--
 drivers/w1/masters/omap_hdq.c   |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 81c7b70..f835880 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -184,8 +184,8 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
 	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
-	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_243X | CK_242X),
+	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X | CK_242X),
+	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X | CK_242X),
 	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_243X | CK_242X),
 	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_242X),
 	CLK("i2c_omap.1", "fck",	&i2chs1_fck,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 859ad1d..1a4bc33 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -155,7 +155,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_343X),
 	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
 	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_343X),
-	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_343X),
+	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_343X),
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck,	CK_343X),
 	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck,	CK_343X),
 	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
@@ -174,7 +174,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK("mmci-omap-hs.1",	"mmchs_ick",	&mmchs2_ick,	CK_343X),
 	CLK("mmci-omap-hs.0",	"mmchs_ick",	&mmchs1_ick,	CK_343X),
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
-	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_343X),
+	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_343X),
 	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_343X),
 	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_343X),
 	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_343X),
diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index c973889..a7e3b70 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -590,8 +590,8 @@ static int __init omap_hdq_probe(struct platform_device *pdev)
 	}
 
 	/* get interface & functional clock objects */
-	hdq_data->hdq_ick = clk_get(&pdev->dev, "hdq_ick");
-	hdq_data->hdq_fck = clk_get(&pdev->dev, "hdq_fck");
+	hdq_data->hdq_ick = clk_get(&pdev->dev, "ick");
+	hdq_data->hdq_fck = clk_get(&pdev->dev, "fck");
 
 	if (IS_ERR(hdq_data->hdq_ick) || IS_ERR(hdq_data->hdq_fck)) {
 		dev_dbg(&pdev->dev, "Can't get HDQ clock objects\n");
-- 
1.6.1.2

