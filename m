From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH -next] omap3: pandora: update regulator setup
Date: Sat,  6 Feb 2010 20:46:22 +0200
Message-ID: <1265481982-26357-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:13566 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0BFSq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Feb 2010 13:46:28 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1068557eyd.19
        for <linux-omap@vger.kernel.org>; Sat, 06 Feb 2010 10:46:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Update pandora's regulator setup:
- add new regulators: VAUX2, VAUX4 and VSIM
- add new consumers: ads7846, nub controllers, USB PHY, audio DAC
- use dev names instead of struct device pointers

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |  111 +++++++++++++++++++++---------
 1 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7ea3894..a0acf8d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -227,27 +227,6 @@ static struct platform_device pandora_dss_device = {
 	},
 };
 
-static struct regulator_consumer_supply pandora_vcc_lcd_supply = {
-	.supply		= "vcc",
-	.dev		= &pandora_lcd_device.dev,
-};
-
-static struct regulator_consumer_supply pandora_vdda_dac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &pandora_dss_device.dev,
-};
-
-static struct regulator_consumer_supply pandora_vdds_supplies[] = {
-	{
-		.supply		= "vdds_sdi",
-		.dev		= &pandora_dss_device.dev,
-	},
-	{
-		.supply		= "vdds_dsi",
-		.dev		= &pandora_dss_device.dev,
-	},
-};
-
 static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	{
 		.mmc		= 1,
@@ -273,14 +252,6 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply pandora_vmmc1_supply = {
-	.supply			= "vmmc",
-};
-
-static struct regulator_consumer_supply pandora_vmmc2_supply = {
-	.supply			= "vmmc",
-};
-
 static int omap3pandora_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -289,10 +260,6 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
 	omap2_hsmmc_init(omap3pandora_mmc);
 
-	/* link regulators to MMC adapters */
-	pandora_vmmc1_supply.dev = omap3pandora_mmc[0].dev;
-	pandora_vmmc2_supply.dev = omap3pandora_mmc[1].dev;
-
 	return 0;
 }
 
@@ -303,6 +270,36 @@ static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
 	.setup		= omap3pandora_twl_gpio_setup,
 };
 
+static struct regulator_consumer_supply pandora_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+
+static struct regulator_consumer_supply pandora_vmmc2_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+
+static struct regulator_consumer_supply pandora_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+
+static struct regulator_consumer_supply pandora_vdds_supplies[] = {
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+};
+
+static struct regulator_consumer_supply pandora_vcc_lcd_supply =
+	REGULATOR_SUPPLY("vcc", "display0");
+
+static struct regulator_consumer_supply pandora_usb_phy_supply =
+	REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
+
+/* ads7846 on SPI and 2 nub controllers on I2C */
+static struct regulator_consumer_supply pandora_vaux4_supplies[] = {
+	REGULATOR_SUPPLY("vcc", "spi1.0"),
+	REGULATOR_SUPPLY("vcc", "3-0066"),
+	REGULATOR_SUPPLY("vcc", "3-0067"),
+};
+
+static struct regulator_consumer_supply pandora_adac_supply =
+	REGULATOR_SUPPLY("vcc", "soc-audio");
+
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data pandora_vmmc1 = {
 	.constraints = {
@@ -378,6 +375,51 @@ static struct regulator_init_data pandora_vaux1 = {
 	.consumer_supplies	= &pandora_vcc_lcd_supply,
 };
 
+/* VAUX2 for USB host PHY */
+static struct regulator_init_data pandora_vaux2 = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &pandora_usb_phy_supply,
+};
+
+/* VAUX4 for ads7846 and nubs */
+static struct regulator_init_data pandora_vaux4 = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(pandora_vaux4_supplies),
+	.consumer_supplies	= pandora_vaux4_supplies,
+};
+
+/* VSIM for audio DAC */
+static struct regulator_init_data pandora_vsim = {
+	.constraints = {
+		.min_uV			= 2800000,
+		.max_uV			= 2800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &pandora_adac_supply,
+};
+
 static struct twl4030_usb_data omap3pandora_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -402,6 +444,9 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.vdac		= &pandora_vdac,
 	.vpll2		= &pandora_vpll2,
 	.vaux1		= &pandora_vaux1,
+	.vaux2		= &pandora_vaux2,
+	.vaux4		= &pandora_vaux4,
+	.vsim		= &pandora_vsim,
 	.keypad		= &pandora_kp_data,
 };
 
-- 
1.6.3.3

