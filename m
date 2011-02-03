From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/2] omap3sdp: clean regulator supply mapping in board file
Date: Thu,  3 Feb 2011 17:01:45 +0530
Message-ID: <1296732705-12818-3-git-send-email-rnayak@ti.com>
References: <1296732705-12818-1-git-send-email-rnayak@ti.com>
 <1296732705-12818-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52271 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756249Ab1BCLbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 06:31:55 -0500
In-Reply-To: <1296732705-12818-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

clean the regulator supply mapping data in the 3430sdp
board file (which is spread all over) by moving all
of them together.
Also use the REGULATOR_SUPPLY macro and remove instances
of mapping dev pointers at run time.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   54 +++++++++++++----------------------
 1 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index dcdc718..6afee65 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -315,11 +315,6 @@ static struct platform_device sdp3430_dss_device = {
 	},
 };
 
-static struct regulator_consumer_supply sdp3430_vdda_dac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &sdp3430_dss_device.dev,
-};
-
 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_dss_device,
 };
@@ -370,18 +365,6 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply sdp3430_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply sdp3430_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
-
-static struct regulator_consumer_supply sdp3430_vmmc2_supply = {
-	.supply			= "vmmc",
-};
-
 static int sdp3430_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -392,13 +375,6 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	mmc[1].gpio_cd = gpio + 1;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters ... we "know" the
-	 * regulators will be set up only *after* we return.
-	 */
-	sdp3430_vmmc1_supply.dev = mmc[0].dev;
-	sdp3430_vsim_supply.dev = mmc[0].dev;
-	sdp3430_vmmc2_supply.dev = mmc[1].dev;
-
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request(gpio + 7, "sub_lcd_en_bkl");
 	gpio_direction_output(gpio + 7, 0);
@@ -427,10 +403,28 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 	.irq_line	= 1,
 };
 
+/* regulator consumer mappings */
+
 /* ads7846 on SPI */
 static struct regulator_consumer_supply sdp3430_vaux3_supply =
 	REGULATOR_SUPPLY("vcc", "spi1.0");
 
+static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+
+/* VPLL2 for digital video outputs */
+static struct regulator_consumer_supply sdp3430_vpll2_supplies =
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+
+static struct regulator_consumer_supply sdp3430_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+
+static struct regulator_consumer_supply sdp3430_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.0");
+
+static struct regulator_consumer_supply sdp3430_vmmc2_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+
 /*
  * Apply all the fixed voltages since most versions of U-Boot
  * don't bother with that initialization.
@@ -550,14 +544,6 @@ static struct regulator_init_data sdp3430_vdac = {
 	.consumer_supplies	= &sdp3430_vdda_dac_supply,
 };
 
-/* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
-	{
-		.supply		= "vdds_dsi",
-		.dev		= &sdp3430_dss_device.dev,
-	}
-};
-
 static struct regulator_init_data sdp3430_vpll2 = {
 	.constraints = {
 		.name			= "VDVI",
@@ -569,8 +555,8 @@ static struct regulator_init_data sdp3430_vpll2 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(sdp3430_vpll2_supplies),
-	.consumer_supplies	= sdp3430_vpll2_supplies,
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &sdp3430_vpll2_supplies,
 };
 
 static struct twl4030_codec_audio_data sdp3430_audio = {
-- 
1.7.0.4

