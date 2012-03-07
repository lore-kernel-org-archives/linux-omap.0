From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/21] OMAP: board-files: remove custom PD GPIO handling for DVI output
Date: Wed,  7 Mar 2012 14:44:31 +0200
Message-ID: <1331124290-6285-3-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52931 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757137Ab2CGMpR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:17 -0500
Received: by lahe6 with SMTP id e6so9564384lah.32
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:12 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

Now that the panel-dvi driver handles the PD (power-down) GPIO, we can
remove the custom PD handling from the board files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c      |   32 +----------------------------
 arch/arm/mach-omap2/board-am3517evm.c    |   19 +----------------
 arch/arm/mach-omap2/board-cm-t35.c       |   24 +--------------------
 arch/arm/mach-omap2/board-devkit8000.c   |   24 +--------------------
 arch/arm/mach-omap2/board-igep0020.c     |   26 +---------------------
 arch/arm/mach-omap2/board-omap3beagle.c  |   31 +--------------------------
 arch/arm/mach-omap2/board-omap3evm.c     |   23 +--------------------
 arch/arm/mach-omap2/board-omap3stalker.c |   23 +--------------------
 arch/arm/mach-omap2/board-omap4panda.c   |   33 +----------------------------
 arch/arm/mach-omap2/board-overo.c        |   19 +----------------
 drivers/video/omap2/displays/panel-dvi.c |   13 -----------
 include/video/omap-panel-dvi.h           |    4 ---
 12 files changed, 14 insertions(+), 257 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 383717b..7105005 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -113,9 +113,6 @@ static struct gpio sdp3430_dss_gpios[] __initdata = {
 	{SDP3430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD Backlight"},
 };
 
-static int lcd_enabled;
-static int dvi_enabled;
-
 static void __init sdp3430_display_init(void)
 {
 	int r;
@@ -129,44 +126,18 @@ static void __init sdp3430_display_init(void)
 
 static int sdp3430_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-
 	gpio_direction_output(SDP3430_LCD_PANEL_ENABLE_GPIO, 1);
 	gpio_direction_output(SDP3430_LCD_PANEL_BACKLIGHT_GPIO, 1);
 
-	lcd_enabled = 1;
-
 	return 0;
 }
 
 static void sdp3430_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
-	lcd_enabled = 0;
-
 	gpio_direction_output(SDP3430_LCD_PANEL_ENABLE_GPIO, 0);
 	gpio_direction_output(SDP3430_LCD_PANEL_BACKLIGHT_GPIO, 0);
 }
 
-static int sdp3430_panel_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (lcd_enabled) {
-		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
-		return -EINVAL;
-	}
-
-	dvi_enabled = 1;
-
-	return 0;
-}
-
-static void sdp3430_panel_disable_dvi(struct omap_dss_device *dssdev)
-{
-	dvi_enabled = 0;
-}
-
 static int sdp3430_panel_enable_tv(struct omap_dss_device *dssdev)
 {
 	return 0;
@@ -187,8 +158,7 @@ static struct omap_dss_device sdp3430_lcd_device = {
 };
 
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable	= sdp3430_panel_enable_dvi,
-	.platform_disable	= sdp3430_panel_disable_dvi,
+	.power_down_gpio	= -1,
 };
 
 static struct omap_dss_device sdp3430_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 4b1cfe3..958dd97 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -320,25 +320,8 @@ static struct omap_dss_device am3517_evm_tv_device = {
 	.platform_disable	= am3517_evm_panel_disable_tv,
 };
 
-static int am3517_evm_panel_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (lcd_enabled) {
-		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
-		return -EINVAL;
-	}
-	dvi_enabled = 1;
-
-	return 0;
-}
-
-static void am3517_evm_panel_disable_dvi(struct omap_dss_device *dssdev)
-{
-	dvi_enabled = 0;
-}
-
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable	= am3517_evm_panel_enable_dvi,
-	.platform_disable	= am3517_evm_panel_disable_dvi,
+	.power_down_gpio	= -1,
 };
 
 static struct omap_dss_device am3517_evm_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index d73316e..5a361c9 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -202,25 +202,6 @@ static void cm_t35_panel_disable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(CM_T35_LCD_EN_GPIO, 0);
 }
 
-static int cm_t35_panel_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (lcd_enabled) {
-		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
-		return -EINVAL;
-	}
-
-	gpio_set_value(CM_T35_DVI_EN_GPIO, 0);
-	dvi_enabled = 1;
-
-	return 0;
-}
-
-static void cm_t35_panel_disable_dvi(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(CM_T35_DVI_EN_GPIO, 1);
-	dvi_enabled = 0;
-}
-
 static int cm_t35_panel_enable_tv(struct omap_dss_device *dssdev)
 {
 	return 0;
@@ -245,8 +226,7 @@ static struct omap_dss_device cm_t35_lcd_device = {
 };
 
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable	= cm_t35_panel_enable_dvi,
-	.platform_disable	= cm_t35_panel_disable_dvi,
+	.power_down_gpio	= CM_T35_DVI_EN_GPIO,
 };
 
 static struct omap_dss_device cm_t35_dvi_device = {
@@ -301,7 +281,6 @@ static struct spi_board_info cm_t35_lcd_spi_board_info[] __initdata = {
 static struct gpio cm_t35_dss_gpios[] __initdata = {
 	{ CM_T35_LCD_EN_GPIO, GPIOF_OUT_INIT_LOW,  "lcd enable"    },
 	{ CM_T35_LCD_BL_GPIO, GPIOF_OUT_INIT_LOW,  "lcd bl enable" },
-	{ CM_T35_DVI_EN_GPIO, GPIOF_OUT_INIT_HIGH, "dvi enable"    },
 };
 
 static void __init cm_t35_init_display(void)
@@ -320,7 +299,6 @@ static void __init cm_t35_init_display(void)
 
 	gpio_export(CM_T35_LCD_EN_GPIO, 0);
 	gpio_export(CM_T35_LCD_BL_GPIO, 0);
-	gpio_export(CM_T35_DVI_EN_GPIO, 0);
 
 	msleep(50);
 	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e873063..07edb6d 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -117,19 +117,6 @@ static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
 }
 
-static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value_cansleep(dssdev->reset_gpio, 1);
-	return 0;
-}
-
-static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
-}
-
 static struct regulator_consumer_supply devkit8000_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -154,8 +141,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 };
 
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable        = devkit8000_panel_enable_dvi,
-	.platform_disable       = devkit8000_panel_disable_dvi,
+	.power_down_gpio	= -1,
 };
 
 static struct omap_dss_device devkit8000_dvi_device = {
@@ -243,13 +229,7 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	}
 
 	/* gpio + 7 is "DVI_PD" (out, active low) */
-	devkit8000_dvi_device.reset_gpio = gpio + 7;
-	ret = gpio_request_one(devkit8000_dvi_device.reset_gpio,
-			       GPIOF_OUT_INIT_LOW, "DVI PowerDown");
-	if (ret < 0) {
-		devkit8000_dvi_device.reset_gpio = -EINVAL;
-		printk(KERN_ERR "Failed to request GPIO for DVI PowerDown\n");
-	}
+	dvi_panel.power_down_gpio = gpio + 7;
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a59ace0..21188f8 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -443,22 +443,9 @@ static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 	.setup		= igep_twl_gpio_setup,
 };
 
-static int igep2_enable_dvi(struct omap_dss_device *dssdev)
-{
-	gpio_direction_output(IGEP2_GPIO_DVI_PUP, 1);
-
-	return 0;
-}
-
-static void igep2_disable_dvi(struct omap_dss_device *dssdev)
-{
-	gpio_direction_output(IGEP2_GPIO_DVI_PUP, 0);
-}
-
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable	= igep2_enable_dvi,
-	.platform_disable	= igep2_disable_dvi,
-	.i2c_bus_num = 3,
+	.i2c_bus_num		= 3,
+	.power_down_gpio	= IGEP2_GPIO_DVI_PUP,
 };
 
 static struct omap_dss_device igep2_dvi_device = {
@@ -479,14 +466,6 @@ static struct omap_dss_board_info igep2_dss_data = {
 	.default_device	= &igep2_dvi_device,
 };
 
-static void __init igep2_display_init(void)
-{
-	int err = gpio_request_one(IGEP2_GPIO_DVI_PUP, GPIOF_OUT_INIT_HIGH,
-				   "GPIO_DVI_PUP");
-	if (err)
-		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
-}
-
 static struct platform_device *igep_devices[] __initdata = {
 	&igep_vwlan_device,
 };
@@ -658,7 +637,6 @@ static void __init igep_init(void)
 
 	if (machine_is_igep0020()) {
 		omap_display_init(&igep2_dss_data);
-		igep2_display_init();
 		igep2_init_smsc911x();
 		usbhs_init(&igep2_usbhs_bdata);
 	} else {
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7ffcd28..26c9df4 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -189,24 +189,9 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 
 /* DSS */
 
-static int beagle_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 1);
-
-	return 0;
-}
-
-static void beagle_disable_dvi(struct omap_dss_device *dssdev)
-{
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 0);
-}
-
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable = beagle_enable_dvi,
-	.platform_disable = beagle_disable_dvi,
 	.i2c_bus_num = 3,
+	.power_down_gpio = -1,
 };
 
 static struct omap_dss_device beagle_dvi_device = {
@@ -215,7 +200,6 @@ static struct omap_dss_device beagle_dvi_device = {
 	.driver_name = "dvi",
 	.data = &dvi_panel,
 	.phy.dpi.data_lines = 24,
-	.reset_gpio = -EINVAL,
 };
 
 static struct omap_dss_device beagle_tv_device = {
@@ -236,16 +220,6 @@ static struct omap_dss_board_info beagle_dss_data = {
 	.default_device = &beagle_dvi_device,
 };
 
-static void __init beagle_display_init(void)
-{
-	int r;
-
-	r = gpio_request_one(beagle_dvi_device.reset_gpio, GPIOF_OUT_INIT_LOW,
-			     "DVI reset");
-	if (r < 0)
-		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
-}
-
 #include "sdram-micron-mt46h32m32lf-6.h"
 
 static struct omap2_hsmmc_info mmc[] = {
@@ -310,7 +284,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
-	beagle_dvi_device.reset_gpio = beagle_config.reset_gpio;
+	dvi_panel.power_down_gpio = beagle_config.reset_gpio;
 
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
 			"nEN_USB_PWR");
@@ -548,7 +522,6 @@ static void __init omap3_beagle_init(void)
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
-	beagle_display_init();
 	beagle_opp_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c877236..1467fbf 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -228,29 +228,8 @@ static struct omap_dss_device omap3_evm_tv_device = {
 	.platform_disable	= omap3_evm_disable_tv,
 };
 
-static int omap3_evm_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (lcd_enabled) {
-		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
-		return -EINVAL;
-	}
-
-	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
-
-	dvi_enabled = 1;
-	return 0;
-}
-
-static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
-{
-	gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
-
-	dvi_enabled = 0;
-}
-
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable	= omap3_evm_enable_dvi,
-	.platform_disable	= omap3_evm_disable_dvi,
+	.power_down_gpio	= OMAP3EVM_DVI_PANEL_EN_GPIO,
 };
 
 static struct omap_dss_device omap3_evm_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index cb089a4..22444c2 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -100,9 +100,6 @@ static inline void __init omap3stalker_init_eth(void)
 #define LCD_PANEL_BKLIGHT_GPIO	210
 #define ENABLE_VPLL2_DEV_GRP	0xE0
 
-static int lcd_enabled;
-static int dvi_enabled;
-
 static void __init omap3_stalker_display_init(void)
 {
 	return;
@@ -130,26 +127,8 @@ static struct omap_dss_device omap3_stalker_tv_device = {
 	.platform_disable	= omap3_stalker_disable_tv,
 };
 
-static int omap3_stalker_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (lcd_enabled) {
-		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
-		return -EINVAL;
-	}
-	gpio_set_value(DSS_ENABLE_GPIO, 1);
-	dvi_enabled = 1;
-	return 0;
-}
-
-static void omap3_stalker_disable_dvi(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(DSS_ENABLE_GPIO, 0);
-	dvi_enabled = 0;
-}
-
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable	= omap3_stalker_enable_dvi,
-	.platform_disable	= omap3_stalker_disable_dvi,
+	.power_down_gpio	= DSS_ENABLE_GPIO,
 };
 
 static struct omap_dss_device omap3_stalker_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 28fc271..e773f28 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -372,22 +372,10 @@ static struct omap_board_mux board_mux[] __initdata = {
 /* Display DVI */
 #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
 
-static int omap4_panda_enable_dvi(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(dssdev->reset_gpio, 1);
-	return 0;
-}
-
-static void omap4_panda_disable_dvi(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(dssdev->reset_gpio, 0);
-}
-
 /* Using generic display panel */
 static struct panel_dvi_platform_data omap4_dvi_panel = {
-	.platform_enable	= omap4_panda_enable_dvi,
-	.platform_disable	= omap4_panda_disable_dvi,
-	.i2c_bus_num = 3,
+	.i2c_bus_num		= 3,
+	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
 };
 
 struct omap_dss_device omap4_panda_dvi_device = {
@@ -400,18 +388,6 @@ struct omap_dss_device omap4_panda_dvi_device = {
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-int __init omap4_panda_dvi_init(void)
-{
-	int r;
-
-	/* Requesting TFP410 DVI GPIO and disabling it, at bootup */
-	r = gpio_request_one(omap4_panda_dvi_device.reset_gpio,
-				GPIOF_OUT_INIT_LOW, "DVI PD");
-	if (r)
-		pr_err("Failed to get DVI powerdown GPIO\n");
-
-	return r;
-}
 
 static struct gpio panda_hdmi_gpios[] = {
 	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
@@ -463,11 +439,6 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
 
 void omap4_panda_display_init(void)
 {
-	int r;
-
-	r = omap4_panda_dvi_init();
-	if (r)
-		pr_err("error initializing panda DVI\n");
 
 	omap_display_init(&omap4_panda_dss_data);
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 52c0cef..21e900e 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -167,26 +167,9 @@ static void __init overo_display_init(void)
 	gpio_export(OVERO_GPIO_LCD_BL, 0);
 }
 
-static int overo_panel_enable_dvi(struct omap_dss_device *dssdev)
-{
-	if (lcd_enabled) {
-		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
-		return -EINVAL;
-	}
-	dvi_enabled = 1;
-
-	return 0;
-}
-
-static void overo_panel_disable_dvi(struct omap_dss_device *dssdev)
-{
-	dvi_enabled = 0;
-}
-
 static struct panel_dvi_platform_data dvi_panel = {
-	.platform_enable	= overo_panel_enable_dvi,
-	.platform_disable	= overo_panel_disable_dvi,
 	.i2c_bus_num		= 3,
+	.power_down_gpio	= -1,
 };
 
 static struct omap_dss_device overo_dvi_device = {
diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video/omap2/displays/panel-dvi.c
index 876b798..7e8cadd 100644
--- a/drivers/video/omap2/displays/panel-dvi.c
+++ b/drivers/video/omap2/displays/panel-dvi.c
@@ -58,7 +58,6 @@ static inline struct panel_dvi_platform_data
 static int panel_dvi_power_on(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
 	int r;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
@@ -68,18 +67,10 @@ static int panel_dvi_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err0;
 
-	if (pdata->platform_enable) {
-		r = pdata->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
 	if (gpio_is_valid(ddata->pd_gpio))
 		gpio_set_value(ddata->pd_gpio, 1);
 
 	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
 err0:
 	return r;
 }
@@ -87,7 +78,6 @@ err0:
 static void panel_dvi_power_off(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
-	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
@@ -95,9 +85,6 @@ static void panel_dvi_power_off(struct omap_dss_device *dssdev)
 	if (gpio_is_valid(ddata->pd_gpio))
 		gpio_set_value(ddata->pd_gpio, 0);
 
-	if (pdata->platform_disable)
-		pdata->platform_disable(dssdev);
-
 	omapdss_dpi_display_disable(dssdev);
 }
 
diff --git a/include/video/omap-panel-dvi.h b/include/video/omap-panel-dvi.h
index 4ad41fc..a782124 100644
--- a/include/video/omap-panel-dvi.h
+++ b/include/video/omap-panel-dvi.h
@@ -24,14 +24,10 @@ struct omap_dss_device;
 
 /**
  * struct panel_dvi_platform_data - panel driver configuration data
- * @platform_enable: platform specific panel enable function
- * @platform_disable: platform specific panel disable function
  * @i2c_bus_num: i2c bus id for the panel
  * @power_down_gpio: gpio number for PD pin (or -1 if not available)
  */
 struct panel_dvi_platform_data {
-	int (*platform_enable)(struct omap_dss_device *dssdev);
-	void (*platform_disable)(struct omap_dss_device *dssdev);
 	u16 i2c_bus_num;
 	int power_down_gpio;
 };
-- 
1.7.4.1

