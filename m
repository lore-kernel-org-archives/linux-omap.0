From: green@linuxhacker.ru
Subject: [PATCH] cleanup regulator supply definitions in mach-omap2 to use REGULATOR_SUPPLY
Date: Sun, 22 May 2011 17:58:49 -0400
Message-ID: <1306101529-22013-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:38921 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755205Ab1EVWAn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 May 2011 18:00:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Oleg Drokin <green@linuxhacker.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Mikkel Christensen <mlc@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Oleg Drokin <green@linuxhacker.ru>

Also drop old style supply.dev assignments common in hsmmc init
as no longer needed.

CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Mike Rapoport <mike@compulab.co.il>
CC: Nishant Kamat <nskamat@ti.com>
CC: Steve Sakoman <steve@sakoman.com>
CC: Mikkel Christensen <mlc@ti.com>
CC: Felipe Balbi <balbi@ti.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 arch/arm/mach-omap2/board-4430sdp.c          |   17 ++++-----------
 arch/arm/mach-omap2/board-cm-t35.c           |   12 +++-------
 arch/arm/mach-omap2/board-ldp.c              |    7 +----
 arch/arm/mach-omap2/board-omap3beagle.c      |   14 +++---------
 arch/arm/mach-omap2/board-omap3evm.c         |   14 +++---------
 arch/arm/mach-omap2/board-omap3logic.c       |    7 +----
 arch/arm/mach-omap2/board-omap3stalker.c     |   14 +++---------
 arch/arm/mach-omap2/board-omap3touchbook.c   |   14 +++---------
 arch/arm/mach-omap2/board-omap4panda.c       |   14 +++---------
 arch/arm/mach-omap2/board-overo.c            |    7 +----
 arch/arm/mach-omap2/board-zoom-peripherals.c |   28 +++++++------------------
 11 files changed, 43 insertions(+), 105 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ae3153c..eaad6ec 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -331,18 +331,11 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
-	{
-		.supply = "vmmc",
-		.dev_name = "omap_hsmmc.1",
-	},
-};
-static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
-	{
-		.supply = "vmmc",
-		.dev_name = "omap_hsmmc.0",
-	},
-};
+static struct regulator_consumer_supply sdp4430_vaux_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
+
+static struct regulator_consumer_supply sdp4430_vmmc_supply[] =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 6063be8..9d5fddc 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -339,13 +339,11 @@ static void __init cm_t35_init_display(void)
 	}
 }
 
-static struct regulator_consumer_supply cm_t35_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply cm_t35_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply cm_t35_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
+static struct regulator_consumer_supply cm_t35_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0");
 
 static struct regulator_consumer_supply cm_t35_vdac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc");
@@ -484,8 +482,6 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	cm_t35_vmmc1_supply.dev = mmc[0].dev;
-	cm_t35_vsim_supply.dev = mmc[0].dev;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f7d6038..b519f2a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -213,9 +213,8 @@ static struct twl4030_madc_platform_data ldp_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct regulator_consumer_supply ldp_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply ldp_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data ldp_vmmc1 = {
@@ -341,8 +340,6 @@ static void __init omap_ldp_init(void)
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
 
 	omap2_hsmmc_init(mmc);
-	/* link regulators to MMC adapters */
-	ldp_vmmc1_supply.dev = mmc[0].dev;
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ff3a2c..552b44c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -238,13 +238,11 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply beagle_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply beagle_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply beagle_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
+static struct regulator_consumer_supply beagle_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0");
 
 static struct gpio_led gpio_leds[];
 
@@ -266,10 +264,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	beagle_vmmc1_supply.dev = mmc[0].dev;
-	beagle_vsim_supply.dev = mmc[0].dev;
-
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
 	 * high / others active low)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 02e1ad2..d444e85 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -273,13 +273,11 @@ static struct omap_dss_board_info omap3_evm_dss_data = {
 	.default_device	= &omap3_evm_lcd_device,
 };
 
-static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply omap3evm_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply omap3evm_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
+static struct regulator_consumer_supply omap3evm_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data omap3evm_vmmc1 = {
@@ -365,10 +363,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	omap3evm_vmmc1_supply.dev = mmc[0].dev;
-	omap3evm_vsim_supply.dev = mmc[0].dev;
-
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
 	 * the P2 connector; notably LEDA for the LCD backlight.
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 60d9be4..8c0dd69 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -55,9 +55,8 @@
 #define OMAP3_TORPEDO_MMC_GPIO_CD		127
 #define OMAP3_TORPEDO_SMSC911X_GPIO_IRQ		129
 
-static struct regulator_consumer_supply omap3logic_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply omap3logic_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data omap3logic_vmmc1 = {
@@ -130,8 +129,6 @@ static void __init board_mmc_init(void)
 	}
 
 	omap2_hsmmc_init(board_mmc_info);
-	/* link regulators to MMC adapters */
-	omap3logic_vmmc1_supply.dev = board_mmc_info[0].dev;
 }
 
 static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 085c60a..9d51e69 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -206,13 +206,11 @@ static struct omap_dss_board_info omap3_stalker_dss_data = {
 	.default_device	= &omap3_stalker_dvi_device,
 };
 
-static struct regulator_consumer_supply omap3stalker_vmmc1_supply = {
-	.supply		= "vmmc",
-};
+static struct regulator_consumer_supply omap3stalker_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply omap3stalker_vsim_supply = {
-	.supply		= "vmmc_aux",
-};
+static struct regulator_consumer_supply omap3stalker_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data omap3stalker_vmmc1 = {
@@ -321,10 +319,6 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	omap3stalker_vmmc1_supply.dev = mmc[0].dev;
-	omap3stalker_vsim_supply.dev = mmc[0].dev;
-
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
 	 * the P2 connector; notably LEDA for the LCD backlight.
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 82872d7..c8d7255 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -116,13 +116,11 @@ static struct omap_lcd_config omap3_touchbook_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct regulator_consumer_supply touchbook_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply touchbook_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply touchbook_vsim_supply = {
-	.supply			= "vmmc_aux",
-};
+static struct regulator_consumer_supply touchbook_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0");
 
 static struct gpio_led gpio_leds[];
 
@@ -139,10 +137,6 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	touchbook_vmmc1_supply.dev = mmc[0].dev;
-	touchbook_vsim_supply.dev = mmc[0].dev;
-
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 5d7c0a3..3e06b06 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -182,17 +182,11 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply omap4_panda_vmmc_supply[] = {
-	{
-		.supply = "vmmc",
-		.dev_name = "omap_hsmmc.0",
-	},
-};
+static struct regulator_consumer_supply omap4_panda_vmmc_supply[] =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 
-static struct regulator_consumer_supply omap4_panda_vmmc5_supply = {
-	.supply = "vmmc",
-	.dev_name = "omap_hsmmc.4",
-};
+static struct regulator_consumer_supply omap4_panda_vmmc5_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.4");
 
 static struct regulator_init_data panda_vmmc5 = {
 	.constraints = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index c03f92b..40abcfa 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -321,9 +321,8 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply overo_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply overo_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 #include <linux/leds.h>
@@ -417,8 +416,6 @@ static int overo_twl_gpio_setup(struct device *dev,
 {
 	omap2_hsmmc_init(mmc);
 
-	overo_vmmc1_supply.dev = mmc[0].dev;
-
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 118c6f5..5591c3f 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -105,22 +105,17 @@ static struct twl4030_keypad_data zoom_kp_twl4030_data = {
 	.rep		= 1,
 };
 
-static struct regulator_consumer_supply zoom_vmmc1_supply = {
-	.supply		= "vmmc",
-};
+static struct regulator_consumer_supply zoom_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply zoom_vsim_supply = {
-	.supply		= "vmmc_aux",
-};
+static struct regulator_consumer_supply zoom_vsim_supply =
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply zoom_vmmc2_supply = {
-	.supply		= "vmmc",
-};
+static struct regulator_consumer_supply zoom_vmmc2_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
 
-static struct regulator_consumer_supply zoom_vmmc3_supply = {
-	.supply		= "vmmc",
-	.dev_name	= "omap_hsmmc.2",
-};
+static struct regulator_consumer_supply zoom_vmmc3_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.2");
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data zoom_vmmc1 = {
@@ -270,13 +265,6 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters ... we "know" the
-	 * regulators will be set up only *after* we return.
-	*/
-	zoom_vmmc1_supply.dev = mmc[0].dev;
-	zoom_vsim_supply.dev = mmc[0].dev;
-	zoom_vmmc2_supply.dev = mmc[1].dev;
-
 	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
 			       "lcd enable");
 	if (ret)
-- 
1.7.4.4

