From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 14:20:46 +0300
Message-ID: <1315826448-27891-5-git-send-email-tomi.valkeinen@ti.com>
References: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:47882 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755147Ab1ILLVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:09 -0400
Received: by bkbzv15 with SMTP id zv15so2324304bkb.32
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:06 -0700 (PDT)
In-Reply-To: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Igor Grinberg <grinberg@compulab.co.il>

Port the old omapfb panel driver to DSS2. This patch changes the board
file only, the driver is ported in separate patch.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Acked-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c |  123 +++++++++++++++++++++++++++++++++++----
 1 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 218764c..76f02a9 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/mmc/host.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -34,7 +35,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/mcspi.h>
-#include <mach/gpio.h>
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
@@ -44,6 +44,9 @@
 #include <plat/usb.h>
 #include <plat/gpmc-smsc911x.h>
 
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+
 #include "board-flash.h"
 #include "mux.h"
 #include "hsmmc.h"
@@ -180,29 +183,108 @@ static inline void __init ldp_init_smsc911x(void)
 	gpmc_smsc911x_init(&smsc911x_cfg);
 }
 
-static struct platform_device ldp_lcd_device = {
-	.name		= "ldp_lcd",
-	.id		= -1,
+/* LCD */
+
+static int ldp_backlight_gpio;
+static int ldp_lcd_enable_gpio;
+
+#define LCD_PANEL_RESET_GPIO		55
+#define LCD_PANEL_QVGA_GPIO		56
+
+static int ldp_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (gpio_is_valid(ldp_lcd_enable_gpio))
+		gpio_direction_output(ldp_lcd_enable_gpio, 1);
+	if (gpio_is_valid(ldp_backlight_gpio))
+		gpio_direction_output(ldp_backlight_gpio, 1);
+
+	return 0;
+}
+
+static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	if (gpio_is_valid(ldp_lcd_enable_gpio))
+		gpio_direction_output(ldp_lcd_enable_gpio, 0);
+	if (gpio_is_valid(ldp_backlight_gpio))
+		gpio_direction_output(ldp_backlight_gpio, 0);
+}
+
+static struct panel_generic_dpi_data ldp_panel_data = {
+	.name			= "2430sdp",
+	.platform_enable	= ldp_panel_enable_lcd,
+	.platform_disable	= ldp_panel_disable_lcd,
 };
 
-static struct omap_lcd_config ldp_lcd_config __initdata = {
-	.ctrl_name	= "internal",
+static struct omap_dss_device ldp_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 18,
+	.data			= &ldp_panel_data,
+};
+
+static struct omap_dss_device *ldp_dss_devices[] = {
+	&ldp_lcd_device,
 };
 
-static struct omap_board_config_kernel ldp_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&ldp_lcd_config },
+static struct omap_dss_board_info ldp_dss_data = {
+	.num_devices	= ARRAY_SIZE(ldp_dss_devices),
+	.devices	= ldp_dss_devices,
+	.default_device	= &ldp_lcd_device,
 };
 
+static void __init ldp_display_init(void)
+{
+	int r;
+
+	static struct gpio gpios[] __initdata = {
+		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
+		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
+	};
+
+	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (r) {
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+		return;
+	}
+
+	omap_display_init(&ldp_dss_data);
+}
+
 static void __init omap_ldp_init_early(void)
 {
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(NULL, NULL);
 }
 
+static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
+{
+	int r;
+
+	struct gpio gpios[] = {
+		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
+		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
+	};
+
+	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (r) {
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+		ldp_backlight_gpio = -EINVAL;
+		ldp_lcd_enable_gpio = -EINVAL;
+		return r;
+	}
+
+	ldp_backlight_gpio = gpio + 15;
+	ldp_lcd_enable_gpio = gpio + 7;
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.setup		= ldp_twl_gpio_setup,
 };
 
 static struct regulator_consumer_supply ldp_vmmc1_supply[] = {
@@ -244,10 +326,31 @@ static struct regulator_init_data ldp_vaux1 = {
 	.consumer_supplies		= ldp_vaux1_supplies,
 };
 
+static struct regulator_consumer_supply ldp_vpll2_supplies[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+};
+
+static struct regulator_init_data ldp_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(ldp_vpll2_supplies),
+	.consumer_supplies	= ldp_vpll2_supplies,
+};
+
 static struct twl4030_platform_data ldp_twldata = {
 	/* platform_data for children goes here */
 	.vmmc1		= &ldp_vmmc1,
 	.vaux1		= &ldp_vaux1,
+	.vpll2		= &ldp_vpll2,
 	.gpio		= &ldp_gpio_data,
 	.keypad		= &ldp_kp_twl4030_data,
 };
@@ -273,7 +376,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 };
 
 static struct platform_device *ldp_devices[] __initdata = {
-	&ldp_lcd_device,
 	&ldp_gpio_keys_device,
 };
 
@@ -318,8 +420,6 @@ static struct mtd_partition ldp_nand_partitions[] = {
 static void __init omap_ldp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = ldp_config;
-	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	ldp_init_smsc911x();
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
@@ -330,6 +430,7 @@ static void __init omap_ldp_init(void)
 		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS, 0);
 
 	omap2_hsmmc_init(mmc);
+	ldp_display_init();
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")
-- 
1.7.4.1

