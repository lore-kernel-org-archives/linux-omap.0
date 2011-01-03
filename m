From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 06/17] OMAP2,3 DSS2 Move DSS driver register from board file to devices.c
Date: Mon,  3 Jan 2011 18:20:58 +0530
Message-ID: <1294059069-26737-7-git-send-email-svadivu@ti.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48209 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab1ACMv2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 07:51:28 -0500
In-Reply-To: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

omap_display_init function is introduced in devices.c to do the DSS driver
registration.  So replace platform_device_register or platform_add_devices of
DSS with omap_display_init().

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c       |   14 +-----------
 arch/arm/mach-omap2/board-am3517evm.c     |   16 +-------------
 arch/arm/mach-omap2/board-cm-t35.c        |   10 +--------
 arch/arm/mach-omap2/board-devkit8000.c    |   10 +--------
 arch/arm/mach-omap2/board-igep0020.c      |   10 +--------
 arch/arm/mach-omap2/board-omap3beagle.c   |   10 +--------
 arch/arm/mach-omap2/board-omap3evm.c      |   14 +-----------
 arch/arm/mach-omap2/board-omap3pandora.c  |   10 +--------
 arch/arm/mach-omap2/board-omap3stalker.c  |   10 +--------
 arch/arm/mach-omap2/board-rx51-video.c    |   15 +------------
 arch/arm/mach-omap2/devices.c             |   32 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    4 +++
 12 files changed, 46 insertions(+), 109 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 29e56a2..e1a3318 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -301,21 +301,9 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 	.default_device	= &sdp3430_lcd_device,
 };
 
-static struct platform_device sdp3430_dss_device = {
-	.name		= "omap_display",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &sdp3430_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
-static struct platform_device *sdp3430_devices[] __initdata = {
-	&sdp3430_dss_device,
-};
-
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
 
@@ -790,7 +778,7 @@ static void __init omap_3430sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3430_i2c_init();
-	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
+	omap_display_init(&sdp3430_dss_data);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 2b37dcf..782d270 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -367,24 +367,12 @@ static struct omap_dss_board_info am3517_evm_dss_data = {
 	.default_device	= &am3517_evm_lcd_device,
 };
 
-static struct platform_device am3517_evm_dss_device = {
-	.name		= "omap_display",
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
-
 static void __init am3517_evm_init_irq(void)
 {
 	omap_board_config = am3517_evm_config;
@@ -484,9 +472,7 @@ static void __init am3517_evm_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	am3517_evm_i2c_init();
-	platform_add_devices(am3517_evm_devices,
-				ARRAY_SIZE(am3517_evm_devices));
-
+	omap_display_init(&am3517_evm_dss_data);
 	omap_serial_init();
 
 	/* Configure GPIO for EHCI port */
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 307e93a..c5e80ad 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -390,14 +390,6 @@ static struct omap_dss_board_info cm_t35_dss_data = {
 	.default_device	= &cm_t35_dvi_device,
 };
 
-static struct platform_device cm_t35_dss_device = {
-	.name		= "omap_display",
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
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index f948435..78f2951 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -188,14 +188,6 @@ static struct omap_dss_board_info devkit8000_dss_data = {
 	.default_device = &devkit8000_lcd_device,
 };
 
-static struct platform_device devkit8000_dss_device = {
-	.name		= "omap_display",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &devkit8000_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply devkit8000_vdda_dac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
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
index 3b8b0d0..6d45efd 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -478,14 +478,6 @@ static struct omap_dss_board_info igep2_dss_data = {
 	.default_device	= &igep2_dvi_device,
 };
 
-static struct platform_device igep2_dss_device = {
-	.name	= "omap_display",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &igep2_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply igep2_vpll2_supply =
 	REGULATOR_SUPPLY("vdds_dsi", "omap_display");
 
@@ -512,7 +504,6 @@ static void __init igep2_display_init(void)
 }
 
 static struct platform_device *igep2_devices[] __initdata = {
-	&igep2_dss_device,
 	&igep2_vwlan_device,
 };
 
@@ -656,6 +647,7 @@ static void __init igep2_init(void)
 	/* Register I2C busses and drivers */
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
+	omap_display_init(&igep2_dss_data);
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ebfddb8..b82e677 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -222,14 +222,6 @@ static struct omap_dss_board_info beagle_dss_data = {
 	.default_device = &beagle_dvi_device,
 };
 
-static struct platform_device beagle_dss_device = {
-	.name          = "omap_display",
-	.id            = -1,
-	.dev            = {
-		.platform_data = &beagle_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply beagle_vdac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omap_display");
 
@@ -496,7 +488,6 @@ static void __init omap3_beagle_init_irq(void)
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
-	&beagle_dss_device,
 };
 
 static void __init omap3beagle_flash_init(void)
@@ -563,6 +554,7 @@ static void __init omap3_beagle_init(void)
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
+	omap_display_init(&beagle_dss_data);
 	omap_serial_init();
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8f9dece..a7406e9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -322,14 +322,6 @@ static struct omap_dss_board_info omap3_evm_dss_data = {
 	.default_device	= &omap3_evm_lcd_device,
 };
 
-static struct platform_device omap3_evm_dss_device = {
-	.name		= "omap_display",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &omap3_evm_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply omap3evm_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -626,10 +618,6 @@ static void __init omap3_evm_init_irq(void)
 	omap_init_irq();
 }
 
-static struct platform_device *omap3_evm_devices[] __initdata = {
-	&omap3_evm_dss_device,
-};
-
 static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
@@ -667,7 +655,7 @@ static void __init omap3_evm_init(void)
 
 	omap3_evm_i2c_init();
 
-	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
+	omap_display_init(&omap3_evm_dss_data);
 
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 5d69320..a13afb9 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -253,14 +253,6 @@ static struct omap_dss_board_info pandora_dss_data = {
 	.default_device	= &pandora_lcd_device,
 };
 
-static struct platform_device pandora_dss_device = {
-	.name		= "omap_display",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &pandora_dss_data,
-	},
-};
-
 static void pandora_wl1251_init_card(struct mmc_card *card)
 {
 	/*
@@ -690,7 +682,6 @@ fail:
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
-	&pandora_dss_device,
 	&pandora_wl1251_data,
 	&pandora_vwlan_device,
 };
@@ -726,6 +717,7 @@ static void __init omap3pandora_init(void)
 	pandora_wl1251_init();
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
+	omap_display_init(&pandora_dss_data);
 	omap_serial_init();
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 085ec27..0eed665 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -229,14 +229,6 @@ static struct omap_dss_board_info omap3_stalker_dss_data = {
 	.default_device	= &omap3_stalker_dvi_device,
 };
 
-static struct platform_device omap3_stalker_dss_device = {
-	.name	= "omap_display",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &omap3_stalker_dss_data,
-	},
-};
-
 static struct regulator_consumer_supply omap3stalker_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -591,7 +583,6 @@ static void __init omap3_stalker_init_irq(void)
 }
 
 static struct platform_device *omap3_stalker_devices[] __initdata = {
-	&omap3_stalker_dss_device,
 	&keys_gpio,
 };
 
@@ -631,6 +622,7 @@ static void __init omap3_stalker_init(void)
 	platform_add_devices(omap3_stalker_devices,
 			     ARRAY_SIZE(omap3_stalker_devices));
 
+	omap_display_init(&omap3_stalker_dss_data);
 	spi_register_board_info(omap3stalker_spi_board_info,
 				ARRAY_SIZE(omap3stalker_spi_board_info));
 
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 8140d05..89a66db 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -66,18 +66,6 @@ static struct omap_dss_board_info rx51_dss_board_info = {
 	.default_device	= &rx51_lcd_device,
 };
 
-struct platform_device rx51_display_device = {
-	.name	= "omap_display",
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
@@ -95,8 +83,7 @@ static int __init rx51_video_init(void)
 
 	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
 
-	platform_add_devices(rx51_video_devices,
-				ARRAY_SIZE(rx51_video_devices));
+	omap_display_init(&rx51_dss_board_info);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 381f4eb..27d1505 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -28,6 +28,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/display.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
@@ -927,6 +928,37 @@ static inline void omap_hdq_init(void) {}
 #endif
 
 /*---------------------------------------------------------------------------*/
+#ifdef CONFIG_OMAP2_DSS
+
+static struct platform_device omap_display_device = {
+	.name          = "omap_display",
+	.id            = -1,
+	.dev            = {
+		.platform_data = NULL,
+	},
+};
+
+int __init omap_display_init(struct omap_dss_board_info
+					*board_data)
+{
+	int r = 0;
+	omap_display_device.dev.platform_data = board_data;
+
+	r = platform_device_register(&omap_display_device);
+	if (r < 0)
+		printk(KERN_ERR "Unable to register OMAP-Display device\n");
+
+	return r;
+}
+
+#else
+int __init omap_display_init(struct omap_dss_board_info *board_data)
+{
+return 0;
+}
+#endif
+
+/*---------------------------------------------------------------------------*/
 
 #if defined(CONFIG_VIDEO_OMAP2_VOUT) || \
 	defined(CONFIG_VIDEO_OMAP2_VOUT_MODULE)
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c915a66..871bbae 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <asm/atomic.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
@@ -220,6 +221,9 @@ struct omap_dss_board_info {
 	struct omap_dss_device *default_device;
 };
 
+/* Init with the board info */
+extern int omap_display_init(struct omap_dss_board_info *board_data);
+
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
1.6.3.3

