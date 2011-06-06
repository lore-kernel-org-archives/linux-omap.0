From: green@linuxhacker.ru
Subject: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2 to use REGULATOR_SUPPLY
Date: Mon,  6 Jun 2011 02:46:01 -0400
Message-ID: <1307342762-25363-2-git-send-email-green@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:51448 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752983Ab1FFGrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 02:47:31 -0400
In-Reply-To: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Oleg Drokin <green@linuxhacker.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Oleg Drokin <green@linuxhacker.ru>

CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Mike Rapoport <mike@compulab.co.il>
CC: Nishant Kamat <nskamat@ti.com>
CC: Steve Sakoman <steve@sakoman.com>
CC: Felipe Balbi <balbi@ti.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 arch/arm/mach-omap2/board-4430sdp.c          |   16 +++++-----------
 arch/arm/mach-omap2/board-cm-t35.c           |   10 ++++------
 arch/arm/mach-omap2/board-ldp.c              |    5 ++---
 arch/arm/mach-omap2/board-omap3beagle.c      |   10 ++++------
 arch/arm/mach-omap2/board-omap3evm.c         |   10 ++++------
 arch/arm/mach-omap2/board-omap3logic.c       |    5 ++---
 arch/arm/mach-omap2/board-omap3stalker.c     |   10 ++++------
 arch/arm/mach-omap2/board-omap3touchbook.c   |   10 ++++------
 arch/arm/mach-omap2/board-omap4panda.c       |   16 +++++-----------
 arch/arm/mach-omap2/board-overo.c            |    5 ++---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   21 ++++++++-------------
 11 files changed, 44 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..914885a 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -332,17 +332,11 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
-	{
-		.supply = "vmmc",
-		.dev_name = "omap_hsmmc.1",
-	},
-};
+static struct regulator_consumer_supply sdp4430_vaux_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
+
 static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
-	{
-		.supply = "vmmc",
-		.dev_name = "omap_hsmmc.0",
-	},
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
@@ -400,7 +394,7 @@ static struct regulator_init_data sdp4430_vaux1 = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = sdp4430_vaux_supply,
+	.consumer_supplies      = &sdp4430_vaux_supply,
 };
 
 static struct regulator_init_data sdp4430_vaux2 = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 77456de..33855e4 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -337,13 +337,11 @@ static void __init cm_t35_init_display(void)
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
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f7d6038..f9b48fa 100644
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
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7f21d24..f72279f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -239,13 +239,11 @@ static struct omap2_hsmmc_info mmc[] = {
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
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b4d4346..67d8a79 100644
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
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 60d9be4..4a37bf76f 100644
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
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 0c108a2..3bf67ab 100644
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
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 5f649fa..27840e8 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -114,13 +114,11 @@ static struct omap_lcd_config omap3_touchbook_lcd_config __initdata = {
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
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 0cfe200..37823e4 100644
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
+static struct regulator_consumer_supply omap4_panda_vmmc_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
-static struct regulator_consumer_supply omap4_panda_vmmc5_supply = {
-	.supply = "vmmc",
-	.dev_name = "omap_hsmmc.4",
-};
+static struct regulator_consumer_supply omap4_panda_vmmc5_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.4");
 
 static struct regulator_init_data panda_vmmc5 = {
 	.constraints = {
@@ -313,7 +307,7 @@ static struct regulator_init_data omap4_panda_vmmc = {
 					| REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = 1,
-	.consumer_supplies      = omap4_panda_vmmc_supply,
+	.consumer_supplies      = &omap4_panda_vmmc_supply,
 };
 
 static struct regulator_init_data omap4_panda_vpp = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 175e1ab..e6c6153 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -319,9 +319,8 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct regulator_consumer_supply overo_vmmc1_supply = {
-	.supply			= "vmmc",
-};
+static struct regulator_consumer_supply overo_vmmc1_supply =
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 #include <linux/leds.h>
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 118c6f5..db77305 100644
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
-- 
1.7.4.4

