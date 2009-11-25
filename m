From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] omap: dss2: Reintroduce Overo display support (DVI/HDMI)
Date: Wed, 25 Nov 2009 15:30:58 -0600
Message-ID: <20091125213058.GA4698@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:44789 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758906AbZKYV3t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 16:29:49 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, sakoman@gmail.com, tony@atomide.com

Refreshed version of previous patch from Tomi, so keeping his S-o-b.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Olof Johansson <olof@lixom.net>

---


I'm not 100% sure how to wire up the power supplies. I'm still missing
the one required for VENC to work.

Tomi, I also noticed that DSS2 seems a bit fragile; if one subsystem
doesn't initialize properly (VENC in this case), the console doesn't
come up at all. It would be nice if the rest of the console did come up
with what was available.


-Olof

 arch/arm/mach-omap2/board-overo.c |  133 ++++++++++++++++++++++++++++++++-----
 1 files changed, 117 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 52dfd51..b09dab2 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -40,6 +40,7 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/display.h>
 #include <mach/gpio.h>
 #include <plat/gpmc.h>
 #include <mach/hardware.h>
@@ -184,6 +185,120 @@ static inline void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif
 
+/* DSS */
+static int lcd_enabled;
+static int dvi_enabled;
+
+#define OVERO_GPIO_LCD_EN 144
+
+static int overo_panel_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (lcd_enabled) {
+		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
+		return -EINVAL;
+	}
+	dvi_enabled = 1;
+
+	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
+
+	return 0;
+}
+
+static void overo_panel_disable_dvi(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
+
+	dvi_enabled = 0;
+}
+
+static struct omap_dss_device overo_dvi_device = {
+	.name			= "dvi",
+	.driver_name		= "generic_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines     = 24,
+	.platform_enable	= overo_panel_enable_dvi,
+	.platform_disable       = overo_panel_disable_dvi,
+};
+
+static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (dvi_enabled) {
+		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
+		return -EINVAL;
+	}
+
+	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
+	lcd_enabled = 1;
+	return 0;
+}
+
+static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
+	lcd_enabled = 0;
+}
+
+static struct omap_dss_device overo_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "samsung_lte_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 24,
+	.platform_enable	= overo_panel_enable_lcd,
+	.platform_disable	= overo_panel_disable_lcd,
+};
+
+static struct omap_dss_device *overo_dss_devices[] = {
+	&overo_dvi_device,
+	&overo_lcd_device,
+};
+
+static struct omap_dss_board_info overo_dss_data = {
+	.num_devices	= ARRAY_SIZE(overo_dss_devices),
+	.devices	= overo_dss_devices,
+	.default_device = &overo_dvi_device,
+};
+
+static struct platform_device overo_dss_device = {
+	.name		= "omapdss",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &overo_dss_data,
+	},
+};
+
+static struct regulator_consumer_supply overo_vdda_dac_supply = {
+	.supply		= "vdda_dac",
+	.dev		= &overo_dss_device.dev,
+};
+
+
+static struct regulator_consumer_supply overo_vpll2_supplies[] = {
+	{
+		.supply	= "vdvi",
+		.dev	= &overo_lcd_device.dev,
+	},
+	{
+		.supply	= "vdds_dsi",
+		.dev	= &overo_dss_device.dev,
+	}
+};
+
+static struct regulator_init_data overo_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask       = REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(overo_vpll2_supplies),
+	.consumer_supplies      = overo_vpll2_supplies,
+};
+
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -347,6 +462,7 @@ static struct twl4030_platform_data overo_twldata = {
 	.usb		= &overo_usb_data,
 	.codec		= &overo_codec_data,
 	.vmmc1		= &overo_vmmc1,
+	.vpll2		= &overo_vpll2,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
@@ -367,23 +483,8 @@ static int __init overo_i2c_init(void)
 	return 0;
 }
 
-static struct platform_device overo_lcd_device = {
-	.name		= "overo_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config overo_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
-static struct omap_board_config_kernel overo_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&overo_lcd_config },
-};
-
 static void __init overo_init_irq(void)
 {
-	omap_board_config = overo_config;
-	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
@@ -391,7 +492,7 @@ static void __init overo_init_irq(void)
 }
 
 static struct platform_device *overo_devices[] __initdata = {
-	&overo_lcd_device,
+	&overo_dss_device,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-- 
1.6.3.3

