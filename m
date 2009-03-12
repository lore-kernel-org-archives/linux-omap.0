From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 29/86] [ARM] omap: i2c: use short connection ids
Date: Thu, 12 Mar 2009 11:27:39 -0700
Message-ID: <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576AbZCLSbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:03 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:01 -0700 (PDT)
In-Reply-To: <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c     |    4 ++--
 arch/arm/mach-omap2/clock24xx.c |   12 ++++++------
 arch/arm/mach-omap2/clock34xx.c |   12 ++++++------
 drivers/i2c/busses/i2c-omap.c   |    4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index b62da4c..382e09a 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -130,8 +130,8 @@ static struct omap_clk omap_clks[] = {
 	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
 	/* Virtual clocks */
 	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
-	CLK("i2c_omap.1", "i2c_fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
-	CLK("i2c_omap.1", "i2c_ick",	&i2c_ick,	CK_16XX),
+	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
+	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
 	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
 	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
 	CLK("omap-mcbsp.2", "ick",	&armper_ck.clk,	CK_16XX),
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index ea21d55..81c7b70 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -186,12 +186,12 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
 	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_243X | CK_242X),
-	CLK("i2c_omap.1", "i2c_ick",	&i2c1_ick,	CK_243X | CK_242X),
-	CLK("i2c_omap.1", "i2c_fck",	&i2c1_fck,	CK_242X),
-	CLK("i2c_omap.1", "i2c_fck",	&i2chs1_fck,	CK_243X),
-	CLK("i2c_omap.2", "i2c_ick",	&i2c2_ick,	CK_243X | CK_242X),
-	CLK("i2c_omap.2", "i2c_fck",	&i2c2_fck,	CK_242X),
-	CLK("i2c_omap.2", "i2c_fck",	&i2chs2_fck,	CK_243X),
+	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_243X | CK_242X),
+	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_242X),
+	CLK("i2c_omap.1", "fck",	&i2chs1_fck,	CK_243X),
+	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_243X | CK_242X),
+	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_242X),
+	CLK("i2c_omap.2", "fck",	&i2chs2_fck,	CK_243X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X | CK_242X),
 	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index a70aa2e..859ad1d 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -141,9 +141,9 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK("mmci-omap-hs.1",	"mmchs_fck",	&mmchs2_fck,	CK_343X),
 	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
 	CLK("mmci-omap-hs.0",	"mmchs_fck",	&mmchs1_fck,	CK_343X),
-	CLK("i2c_omap.3", "i2c_fck",	&i2c3_fck,	CK_343X),
-	CLK("i2c_omap.2", "i2c_fck",	&i2c2_fck,	CK_343X),
-	CLK("i2c_omap.1", "i2c_fck",	&i2c1_fck,	CK_343X),
+	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_343X),
+	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_343X),
+	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_343X),
 	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_343X),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_343X),
 	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_343X),
@@ -179,9 +179,9 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_343X),
 	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_343X),
 	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_343X),
-	CLK("i2c_omap.3", "i2c_ick",	&i2c3_ick,	CK_343X),
-	CLK("i2c_omap.2", "i2c_ick",	&i2c2_ick,	CK_343X),
-	CLK("i2c_omap.1", "i2c_ick",	&i2c1_ick,	CK_343X),
+	CLK("i2c_omap.3", "ick",	&i2c3_ick,	CK_343X),
+	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_343X),
+	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_343X),
 	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_343X),
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_343X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_343X),
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index be8ee2c..19f86e1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -194,14 +194,14 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		dev->iclk = clk_get(dev->dev, "i2c_ick");
+		dev->iclk = clk_get(dev->dev, "ick");
 		if (IS_ERR(dev->iclk)) {
 			dev->iclk = NULL;
 			return -ENODEV;
 		}
 	}
 
-	dev->fclk = clk_get(dev->dev, "i2c_fck");
+	dev->fclk = clk_get(dev->dev, "fck");
 	if (IS_ERR(dev->fclk)) {
 		if (dev->iclk != NULL) {
 			clk_put(dev->iclk);
-- 
1.6.1.2

