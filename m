From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 06/17] OMAP2,3 board files DSS Driver register moved to devices.c
Date: Mon, 29 Nov 2010 17:21:32 +0530
Message-ID: <1291031503-21036-7-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34156 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577Ab0K2Lv6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 06:51:58 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move DSS driver register from board file to devices.c
Regulator initialisation done with driver name instead
of device structure name.
Changed driver name from omapdss to omap_display as the
driver takes care of panel information.
Board files that have dss registeration are updated.
3430sdp, am3517evm, cm-t35, devkit8000, igep0020,
omap3evm, omap3pandora, omap3stalker, rx-51

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |   25 ++++---------------------
 arch/arm/mach-omap2/board-am3517evm.c        |   14 +-------------
 arch/arm/mach-omap2/board-cm-t35.c           |   22 +++++-----------------
 arch/arm/mach-omap2/board-devkit8000.c       |   12 ++----------
 arch/arm/mach-omap2/board-igep0020.c         |   20 +++-----------------
 arch/arm/mach-omap2/board-omap3beagle.c      |   14 +++-----------
 arch/arm/mach-omap2/board-omap3evm.c         |   22 ++++------------------
 arch/arm/mach-omap2/board-omap3pandora.c     |   16 ++++------------
 arch/arm/mach-omap2/board-omap3stalker.c     |   16 +++-------------
 arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +--------
 arch/arm/mach-omap2/board-rx51-video.c       |   15 +--------------
 11 files changed, 31 insertions(+), 154 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4e3742c..7ff747e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -301,22 +301,8 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 	.default_device	= &sdp3430_lcd_device,
 };
 
-static struct platform_device sdp3430_dss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &sdp3430_dss_data,
-	},
-};
-
-static struct regulator_consumer_supply sdp3430_vdda_dac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &sdp3430_dss_device.dev,
-};
-
-static struct platform_device *sdp3430_devices[] __initdata = {
-	&sdp3430_dss_device,
-};
+static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
@@ -540,10 +526,7 @@ static struct regulator_init_data sdp3430_vdac = {
 
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
-	{
-		.supply		= "vdds_dsi",
-		.dev		= &sdp3430_dss_device.dev,
-	}
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display"),
 };
 
 static struct regulator_init_data sdp3430_vpll2 = {
@@ -797,7 +780,7 @@ static void __init omap_3430sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3430_i2c_init();
-	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
+	omap_display_init(&sdp3430_dss_data);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 0739950..19a8be7 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -367,23 +367,12 @@ static struct omap_dss_board_info am3517_evm_dss_data = {
 	.default_device	= &am3517_evm_lcd_device,
 };
 
-static struct platform_device am3517_evm_dss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &am3517_evm_dss_data,
-	},
-};
-
 /*
  * Board initialization
  */
 static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
 };
 
-static struct platform_device *am3517_evm_devices[] __initdata = {
-	&am3517_evm_dss_device,
-};
 
 static void __init am3517_evm_init_irq(void)
 {
@@ -487,8 +476,7 @@ static void __init am3517_evm_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	am3517_evm_i2c_init();
-	platform_add_devices(am3517_evm_devices,
-				ARRAY_SIZE(am3517_evm_devices));
+	omap_display_init(&am3517_evm_dss_data);
 
 	omap_serial_init();
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 63f764e..fac5fe1 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -390,14 +390,6 @@ static struct omap_dss_board_info cm_t35_dss_data = {
 	.default_device	= &cm_t35_dvi_device,
 };
 
-static struct platform_device cm_t35_dss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &cm_t35_dss_data,
-	},
-};
-
 static struct omap2_mcspi_device_config tdo24m_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
@@ -457,7 +449,7 @@ static void __init cm_t35_init_display(void)
 	msleep(50);
 	gpio_set_value(lcd_en_gpio, 1);
 
-	err = platform_device_register(&cm_t35_dss_device);
+	err = omap_display_init(&cm_t35_dss_data);
 	if (err) {
 		pr_err("CM-T35: failed to register DSS device\n");
 		goto err_dev_reg;
@@ -484,15 +476,11 @@ static struct regulator_consumer_supply cm_t35_vsim_supply = {
 	.supply			= "vmmc_aux",
 };
 
-static struct regulator_consumer_supply cm_t35_vdac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &cm_t35_dss_device.dev,
-};
+static struct regulator_consumer_supply cm_t35_vdac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
-static struct regulator_consumer_supply cm_t35_vdvi_supply = {
-	.supply		= "vdvi",
-	.dev		= &cm_t35_dss_device.dev,
-};
+static struct regulator_consumer_supply cm_t35_vdvi_supply =
+	REGULATOR_SUPPLY("vdvi", "omap_display");
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
 static struct regulator_init_data cm_t35_vmmc1 = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 53ac762..cbc3330 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -188,16 +188,8 @@ static struct omap_dss_board_info devkit8000_dss_data = {
 	.default_device = &devkit8000_lcd_device,
 };
 
-static struct platform_device devkit8000_dss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &devkit8000_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply devkit8000_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_1),
@@ -561,7 +553,6 @@ static void __init omap_dm9000_init(void)
 }
 
 static struct platform_device *devkit8000_devices[] __initdata = {
-	&devkit8000_dss_device,
 	&leds_gpio,
 	&keys_gpio,
 	&omap_dm9000_dev,
@@ -783,6 +774,7 @@ static void __init devkit8000_init(void)
 	platform_add_devices(devkit8000_devices,
 			ARRAY_SIZE(devkit8000_devices));
 
+	omap_display_init(&devkit8000_dss_data);
 	spi_register_board_info(devkit8000_spi_board_info,
 	ARRAY_SIZE(devkit8000_spi_board_info));
 
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index fe76b59..3acdcfd 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -441,18 +441,8 @@ static struct omap_dss_board_info igep2_dss_data = {
 	.default_device	= &igep2_dvi_device,
 };
 
-static struct platform_device igep2_dss_device = {
-	.name	= "omapdss",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &igep2_dss_data,
-	},
-};
-
-static struct regulator_consumer_supply igep2_vpll2_supply = {
-	.supply	= "vdds_dsi",
-	.dev	= &igep2_dss_device.dev,
-};
+static struct regulator_consumer_supply igep2_vpll2_supply =
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display");
 
 static struct regulator_init_data igep2_vpll2 = {
 	.constraints = {
@@ -476,10 +466,6 @@ static void __init igep2_display_init(void)
 		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
 }
 
-static struct platform_device *igep2_devices[] __initdata = {
-	&igep2_dss_device,
-};
-
 static void __init igep2_init_irq(void)
 {
 	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
@@ -620,7 +606,7 @@ static void __init igep2_init(void)
 	igep2_get_revision();
 	/* Register I2C busses and drivers */
 	igep2_i2c_init();
-	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
+	omap_display_init(&igep2_dss_data);
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..d3866ca 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -222,19 +222,11 @@ static struct omap_dss_board_info beagle_dss_data = {
 	.default_device = &beagle_dvi_device,
 };
 
-static struct platform_device beagle_dss_device = {
-	.name          = "omapdss",
-	.id            = -1,
-	.dev            = {
-		.platform_data = &beagle_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply beagle_vdac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 static struct regulator_consumer_supply beagle_vdvi_supply =
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display");
 
 static void __init beagle_display_init(void)
 {
@@ -496,7 +488,6 @@ static void __init omap3_beagle_init_irq(void)
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
-	&beagle_dss_device,
 };
 
 static void __init omap3beagle_flash_init(void)
@@ -565,6 +556,7 @@ static void __init omap3_beagle_init(void)
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
+	omap_display_init(&beagle_dss_data);
 	omap_serial_init();
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b04365c..b230f8e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -322,14 +322,6 @@ static struct omap_dss_board_info omap3_evm_dss_data = {
 	.default_device	= &omap3_evm_lcd_device,
 };
 
-static struct platform_device omap3_evm_dss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &omap3_evm_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -494,10 +486,8 @@ static struct twl4030_codec_data omap3evm_codec_data = {
 	.audio = &omap3evm_audio_data,
 };
 
-static struct regulator_consumer_supply omap3_evm_vdda_dac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &omap3_evm_dss_device.dev,
-};
+static struct regulator_consumer_supply omap3_evm_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 /* VDAC for DSS driving S-Video */
 static struct regulator_init_data omap3_evm_vdac = {
@@ -516,7 +506,7 @@ static struct regulator_init_data omap3_evm_vdac = {
 
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply omap3_evm_vpll2_supply =
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display");
 
 static struct regulator_init_data omap3_evm_vpll2 = {
 	.constraints = {
@@ -628,10 +618,6 @@ static void __init omap3_evm_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct platform_device *omap3_evm_devices[] __initdata = {
-	&omap3_evm_dss_device,
-};
-
 static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
@@ -671,7 +657,7 @@ static void __init omap3_evm_init(void)
 
 	omap3_evm_i2c_init();
 
-	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
+	omap_display_init(&omap3_evm_dss_data);
 
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 89ed1be..391c92b 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -253,14 +253,6 @@ static struct omap_dss_board_info pandora_dss_data = {
 	.default_device	= &pandora_lcd_device,
 };
 
-static struct platform_device pandora_dss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &pandora_dss_data,
-	},
-};
-
 static void pandora_wl1251_init_card(struct mmc_card *card)
 {
 	/*
@@ -350,11 +342,11 @@ static struct regulator_consumer_supply pandora_vmmc3_supply =
 	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.2");
 
 static struct regulator_consumer_supply pandora_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 static struct regulator_consumer_supply pandora_vdds_supplies[] = {
-	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_sdi", "omap_display"),
+	REGULATOR_SUPPLY("vdds_dsi", "omap_display"),
 };
 
 static struct regulator_consumer_supply pandora_vcc_lcd_supply =
@@ -690,7 +682,6 @@ fail:
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
-	&pandora_dss_device,
 	&pandora_wl1251_data,
 	&pandora_vwlan_device,
 };
@@ -728,6 +719,7 @@ static void __init omap3pandora_init(void)
 	pandora_wl1251_init();
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
+	omap_display_init(&pandora_dss_data);
 	omap_serial_init();
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f252721..b50c4a6 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -229,14 +229,6 @@ static struct omap_dss_board_info omap3_stalker_dss_data = {
 	.default_device	= &omap3_stalker_dvi_device,
 };
 
-static struct platform_device omap3_stalker_dss_device = {
-	.name	= "omapdss",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &omap3_stalker_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply omap3stalker_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -437,10 +429,8 @@ static struct twl4030_codec_data omap3stalker_codec_data = {
 	.audio		= &omap3stalker_audio_data,
 };
 
-static struct regulator_consumer_supply omap3_stalker_vdda_dac_supply = {
-	.supply		= "vdda_dac",
-	.dev		= &omap3_stalker_dss_device.dev,
-};
+static struct regulator_consumer_supply omap3_stalker_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
 /* VDAC for DSS driving S-Video */
 static struct regulator_init_data omap3_stalker_vdac = {
@@ -593,7 +583,6 @@ static void __init omap3_stalker_init_irq(void)
 }
 
 static struct platform_device *omap3_stalker_devices[] __initdata = {
-	&omap3_stalker_dss_device,
 	&keys_gpio,
 };
 
@@ -635,6 +624,7 @@ static void __init omap3_stalker_init(void)
 	platform_add_devices(omap3_stalker_devices,
 			     ARRAY_SIZE(omap3_stalker_devices));
 
+	omap_display_init(&omap3_stalker_dss_data);
 	spi_register_board_info(omap3stalker_spi_board_info,
 				ARRAY_SIZE(omap3stalker_spi_board_info));
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3fda20d..e75d1f8 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -356,16 +356,9 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	REGULATOR_SUPPLY("DVDD", "2-0018"),
 };
 
-#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
-extern struct platform_device rx51_display_device;
-#endif
-
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
-	{
-		.supply	= "vdds_sdi",
-		.dev	= &rx51_display_device.dev,
-	},
+	REGULATOR_SUPPLY("vdds_sdi", "omap_display"),
 #endif
 };
 
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 85503fe..e989588 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -59,18 +59,6 @@ static struct omap_dss_board_info rx51_dss_board_info = {
 	.default_device	= &rx51_lcd_device,
 };
 
-struct platform_device rx51_display_device = {
-	.name	= "omapdss",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &rx51_dss_board_info,
-	},
-};
-
-static struct platform_device *rx51_video_devices[] __initdata = {
-	&rx51_display_device,
-};
-
 static int __init rx51_video_init(void)
 {
 	if (!machine_is_nokia_rx51())
@@ -88,8 +76,7 @@ static int __init rx51_video_init(void)
 
 	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
 
-	platform_add_devices(rx51_video_devices,
-				ARRAY_SIZE(rx51_video_devices));
+	omap_display_init(&rx51_dss_board_info);
 	return 0;
 }
 
-- 
1.6.3.3

