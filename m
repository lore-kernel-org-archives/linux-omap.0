From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/28] ARM: OMAP: OMAP3EVM: Kconfig option for the display options
Date: Thu, 28 Mar 2013 14:49:01 +0200
Message-ID: <1364474962-20439-8-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38199 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab3C1Mtx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:53 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Boards with multiple display options for the same video bus have all the
possible linux display devices present at the same time. Only one of
those devices should be used at a time, as the video bus cannot be
shared.

This model is hacky, and will be changed in the forthcoming DSS patches
to a model where only one display device can be present on a single
video bus.

This patch creates Kconfig options to select which of the display
devices is present on the board. While this model is also somewhat
hacky, and prevents us from using a single kernel image for all the
display options, it allows us to make the DSS driver changes for DT
adaptation. And with DT, the information about display devices can be
passed from the bootloader, solving the mess.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/Kconfig          |   13 ++++++++++
 arch/arm/mach-omap2/board-omap3evm.c |   46 +++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 940903e..4108d07 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -279,6 +279,19 @@ config MACH_OMAP3EVM
 	default y
 	select OMAP_PACKAGE_CBB
 
+choice
+	depends on MACH_OMAP3EVM
+	default MACH_OMAP3EVM_EXPANSION_LCD
+	prompt "OMAP 3530 EVM video output"
+
+config MACH_OMAP3EVM_EXPANSION_LCD
+	bool "OMAP 3530 EVM with LCD"
+
+config MACH_OMAP3EVM_EXPANSION_DVI
+	bool "OMAP 3530 EVM with DVI"
+
+endchoice
+
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index e86eb41..2050679 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -149,6 +149,14 @@ static inline void __init omap3evm_init_smsc911x(void)
 static inline void __init omap3evm_init_smsc911x(void) { return; }
 #endif
 
+static struct omap_dss_device omap3_evm_tv_device = {
+	.name			= "tv",
+	.driver_name		= "venc",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+#if defined(CONFIG_MACH_OMAP3EVM_EXPANSION_LCD)
 /*
  * OMAP3EVM LCD Panel control signals
  */
@@ -159,7 +167,6 @@ static inline void __init omap3evm_init_smsc911x(void) { return; }
 #define OMAP3EVM_LCD_PANEL_QVGA		154
 #define OMAP3EVM_LCD_PANEL_RESB		155
 #define OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO	210
-#define OMAP3EVM_DVI_PANEL_EN_GPIO	199
 
 static struct gpio omap3_evm_dss_gpios[] __initdata = {
 	{ OMAP3EVM_LCD_PANEL_RESB,  GPIOF_OUT_INIT_HIGH, "lcd_panel_resb"  },
@@ -170,9 +177,6 @@ static struct gpio omap3_evm_dss_gpios[] __initdata = {
 	{ OMAP3EVM_LCD_PANEL_ENVDD, GPIOF_OUT_INIT_LOW,  "lcd_panel_envdd" },
 };
 
-static int lcd_enabled;
-static int dvi_enabled;
-
 static void __init omap3_evm_display_init(void)
 {
 	int r;
@@ -185,10 +189,6 @@ static void __init omap3_evm_display_init(void)
 
 static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
 {
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
 	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 0);
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
@@ -196,7 +196,6 @@ static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
 	else
 		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 
-	lcd_enabled = 1;
 	return 0;
 }
 
@@ -208,8 +207,6 @@ static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
 		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
 	else
 		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
-
-	lcd_enabled = 0;
 }
 
 static struct omap_dss_device omap3_evm_lcd_device = {
@@ -221,13 +218,25 @@ static struct omap_dss_device omap3_evm_lcd_device = {
 	.platform_disable	= omap3_evm_disable_lcd,
 };
 
-static struct omap_dss_device omap3_evm_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct omap_dss_device *omap3_evm_dss_devices[] = {
+	&omap3_evm_lcd_device,
+	&omap3_evm_tv_device,
 };
 
+static struct omap_dss_board_info omap3_evm_dss_data = {
+	.num_devices	= ARRAY_SIZE(omap3_evm_dss_devices),
+	.devices	= omap3_evm_dss_devices,
+	.default_display_name = "lcd",
+};
+
+#elif defined(CONFIG_MACH_OMAP3EVM_EXPANSION_DVI)
+
+#define OMAP3EVM_DVI_PANEL_EN_GPIO	199
+
+static void __init omap3_evm_display_init(void)
+{
+}
+
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= OMAP3EVM_DVI_PANEL_EN_GPIO,
 	.i2c_bus_num		= -1,
@@ -242,7 +251,6 @@ static struct omap_dss_device omap3_evm_dvi_device = {
 };
 
 static struct omap_dss_device *omap3_evm_dss_devices[] = {
-	&omap3_evm_lcd_device,
 	&omap3_evm_tv_device,
 	&omap3_evm_dvi_device,
 };
@@ -250,9 +258,11 @@ static struct omap_dss_device *omap3_evm_dss_devices[] = {
 static struct omap_dss_board_info omap3_evm_dss_data = {
 	.num_devices	= ARRAY_SIZE(omap3_evm_dss_devices),
 	.devices	= omap3_evm_dss_devices,
-	.default_device	= &omap3_evm_lcd_device,
+	.default_display_name = "dvi",
 };
 
+#endif
+
 static struct regulator_consumer_supply omap3evm_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
-- 
1.7.10.4

