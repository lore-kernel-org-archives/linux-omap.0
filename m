From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap -> omap_i2c
Date: Thu, 9 Dec 2010 15:24:16 +0100
Message-ID: <1291904657-32729-2-git-send-email-b-cousson@ti.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab0LIOY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 09:24:57 -0500
In-Reply-To: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Ben Dooks <ben-i2c@fluff.org>

The convention for omap device naming is omap_XXX.

Rename the device and driver name in order to stick
to this naming convention.

Change device name in clock nodes as well.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
c: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Ben Dooks <ben-i2c@fluff.org>
---
 arch/arm/mach-omap1/clock_data.c     |    6 +++---
 arch/arm/mach-omap2/clock2420_data.c |    8 ++++----
 arch/arm/mach-omap2/clock2430_data.c |    8 ++++----
 arch/arm/mach-omap2/clock3xxx_data.c |   12 ++++++------
 arch/arm/mach-omap2/clock44xx_data.c |   16 ++++++++--------
 arch/arm/plat-omap/i2c.c             |    2 +-
 drivers/i2c/busses/i2c-omap.c        |    4 ++--
 7 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index af54114..aa6dd67 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -736,9 +736,9 @@ static struct omap_clk omap_clks[] = {
 	CLK("mmci-omap.1", "ick",	&armper_ck.clk,	CK_16XX),
 	/* Virtual clocks */
 	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
-	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
-	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310 | CK_7XX),
+	CLK("omap_i2c.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
+	CLK("omap_i2c.1", "ick",	&i2c_ick,	CK_16XX),
+	CLK("omap_i2c.1", "ick",	&dummy_ck,	CK_1510 | CK_310 | CK_7XX),
 	CLK("omap1_spi100k.1", "fck",	&dummy_ck,	CK_7XX),
 	CLK("omap1_spi100k.1", "ick",	&dummy_ck,	CK_7XX),
 	CLK("omap1_spi100k.2", "fck",	&dummy_ck,	CK_7XX),
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 21f8562..ed61ac2 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1862,10 +1862,10 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_242X),
 	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_242X),
-	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_242X),
-	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_242X),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_242X),
-	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_242X),
+	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_242X),
+	CLK("omap_i2c.1", "fck",	&i2c1_fck,	CK_242X),
+	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_242X),
+	CLK("omap_i2c.2", "fck",	&i2c2_fck,	CK_242X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_242X),
 	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_242X),
 	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index e32afcb..1bded4e 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1969,10 +1969,10 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X),
 	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X),
-	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_243X),
-	CLK("i2c_omap.1", "fck",	&i2chs1_fck,	CK_243X),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_243X),
-	CLK("i2c_omap.2", "fck",	&i2chs2_fck,	CK_243X),
+	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_243X),
+	CLK("omap_i2c.1", "fck",	&i2chs1_fck,	CK_243X),
+	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_243X),
+	CLK("omap_i2c.2", "fck",	&i2chs2_fck,	CK_243X),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X),
 	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X),
 	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d85ecd5..ee8aa39 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3285,9 +3285,9 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_3XXX),
 	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
 	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_3XXX),
-	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_3XXX),
-	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_3XXX),
-	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_3XXX),
+	CLK("omap_i2c.3", "fck",	&i2c3_fck,	CK_3XXX),
+	CLK("omap_i2c.2", "fck",	&i2c2_fck,	CK_3XXX),
+	CLK("omap_i2c.1", "fck",	&i2c1_fck,	CK_3XXX),
 	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_3XXX),
 	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_3XXX),
 	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_3XXX),
@@ -3326,9 +3326,9 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_3XXX),
 	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_3XXX),
 	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_3XXX),
-	CLK("i2c_omap.3", "ick",	&i2c3_ick,	CK_3XXX),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_3XXX),
-	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_3XXX),
+	CLK("omap_i2c.3", "ick",	&i2c3_ick,	CK_3XXX),
+	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_3XXX),
+	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_3XXX),
 	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_3XXX),
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_3XXX),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 1599836..217cce4 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2872,10 +2872,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"gpu_fck",			&gpu_fck,	CK_443X),
 	CLK("omap2_hdq.0",	"fck",				&hdq1w_fck,	CK_443X),
 	CLK(NULL,	"hsi_fck",			&hsi_fck,	CK_443X),
-	CLK("i2c_omap.1",	"fck",				&i2c1_fck,	CK_443X),
-	CLK("i2c_omap.2",	"fck",				&i2c2_fck,	CK_443X),
-	CLK("i2c_omap.3",	"fck",				&i2c3_fck,	CK_443X),
-	CLK("i2c_omap.4",	"fck",				&i2c4_fck,	CK_443X),
+	CLK("omap_i2c.1",	"fck",				&i2c1_fck,	CK_443X),
+	CLK("omap_i2c.2",	"fck",				&i2c2_fck,	CK_443X),
+	CLK("omap_i2c.3",	"fck",				&i2c3_fck,	CK_443X),
+	CLK("omap_i2c.4",	"fck",				&i2c4_fck,	CK_443X),
 	CLK(NULL,	"ipu_fck",			&ipu_fck,	CK_443X),
 	CLK(NULL,	"iss_ctrlclk",			&iss_ctrlclk,	CK_443X),
 	CLK(NULL,	"iss_fck",			&iss_fck,	CK_443X),
@@ -2975,10 +2975,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"gpt9_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt10_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt11_ick",			&dummy_ck,	CK_443X),
-	CLK("i2c_omap.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("i2c_omap.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("i2c_omap.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("i2c_omap.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_i2c.1",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_i2c.4",	"ick",				&dummy_ck,	CK_443X),
 	CLK("mmci-omap-hs.0",	"ick",				&dummy_ck,	CK_443X),
 	CLK("mmci-omap-hs.1",	"ick",				&dummy_ck,	CK_443X),
 	CLK("mmci-omap-hs.2",	"ick",				&dummy_ck,	CK_443X),
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a5bff9c..0a271ad 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -40,7 +40,7 @@
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
 
-static const char name[] = "i2c_omap";
+static const char name[] = "omap_i2c";
 
 #define I2C_RESOURCE_BUILDER(base, irq)			\
 	{						\
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 760b8be..9d09083 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1139,7 +1139,7 @@ static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
 	.driver		= {
-		.name	= "i2c_omap",
+		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -1161,4 +1161,4 @@ module_exit(omap_i2c_exit_driver);
 MODULE_AUTHOR("MontaVista Software, Inc. (and others)");
 MODULE_DESCRIPTION("TI OMAP I2C bus adapter");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:i2c_omap");
+MODULE_ALIAS("platform:omap_i2c");
-- 
1.7.0.4

