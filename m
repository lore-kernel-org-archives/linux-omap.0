From: green@linuxhacker.ru
Subject: [PATCH 2/2] Remove old-style supply.dev assignments common in hsmmc init
Date: Mon,  6 Jun 2011 02:46:02 -0400
Message-ID: <1307342762-25363-3-git-send-email-green@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:51449 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753198Ab1FFGrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 02:47:32 -0400
In-Reply-To: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Oleg Drokin <green@linuxhacker.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Felipe Balbi <balbi@ti.com>

From: Oleg Drokin <green@linuxhacker.ru>

CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Mike Rapoport <mike@compulab.co.il>
CC: Nishant Kamat <nskamat@ti.com>
CC: Steve Sakoman <steve@sakoman.com>
CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 arch/arm/mach-omap2/board-cm-t35.c           |    2 --
 arch/arm/mach-omap2/board-ldp.c              |    2 --
 arch/arm/mach-omap2/board-omap3beagle.c      |    4 ----
 arch/arm/mach-omap2/board-omap3evm.c         |    4 ----
 arch/arm/mach-omap2/board-omap3logic.c       |    2 --
 arch/arm/mach-omap2/board-omap3stalker.c     |    4 ----
 arch/arm/mach-omap2/board-omap3touchbook.c   |    4 ----
 arch/arm/mach-omap2/board-overo.c            |    2 --
 arch/arm/mach-omap2/board-zoom-peripherals.c |    7 -------
 9 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 33855e4..a38cd70 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -480,8 +480,6 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	cm_t35_vmmc1_supply.dev = mmc[0].dev;
-	cm_t35_vsim_supply.dev = mmc[0].dev;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f9b48fa..b519f2a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -340,8 +340,6 @@ static void __init omap_ldp_init(void)
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
 
 	omap2_hsmmc_init(mmc);
-	/* link regulators to MMC adapters */
-	ldp_vmmc1_supply.dev = mmc[0].dev;
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index f72279f..21e9df5 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -265,10 +265,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
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
index 67d8a79..f648354 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -363,10 +363,6 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
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
index 4a37bf76f..8c0dd69 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -129,8 +129,6 @@ static void __init board_mmc_init(void)
 	}
 
 	omap2_hsmmc_init(board_mmc_info);
-	/* link regulators to MMC adapters */
-	omap3logic_vmmc1_supply.dev = board_mmc_info[0].dev;
 }
 
 static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 3bf67ab..8e79df2 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -319,10 +319,6 @@ omap3stalker_twl_gpio_setup(struct device *dev,
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
index 27840e8..7c45659 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -135,10 +135,6 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	touchbook_vmmc1_supply.dev = mmc[0].dev;
-	touchbook_vsim_supply.dev = mmc[0].dev;
-
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e6c6153..b87b8da 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -414,8 +414,6 @@ static int overo_twl_gpio_setup(struct device *dev,
 {
 	omap2_hsmmc_init(mmc);
 
-	overo_vmmc1_supply.dev = mmc[0].dev;
-
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index db77305..5591c3f 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -265,13 +265,6 @@ static int zoom_twl_gpio_setup(struct device *dev,
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

