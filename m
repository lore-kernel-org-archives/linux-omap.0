From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Mon, 16 May 2011 11:53:00 +0300
Message-ID: <1305535980.2002.34.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari>  <4DCB80DD.5090408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46829 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751915Ab1EPIxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 04:53:08 -0400
Received: by ewy10 with SMTP id 10so1314540ewy.9
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 01:53:05 -0700 (PDT)
In-Reply-To: <4DCB80DD.5090408@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On Thu, 2011-05-12 at 09:40 +0300, Igor Grinberg wrote:
> 
> On 05/11/11 09:32, Tomi Valkeinen wrote:
> 
> > On Wed, 2011-05-11 at 10:28 +0530, Janorkar, Mayuresh wrote:
> >
> >>> +static void __init ldp_display_init(void)
> >>> +{
> >>> +	int r;
> >>> +
> >>> +	struct gpio gpios[] = {
> >>> +		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
> >>> +		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
> >>> +		{LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
> >>> +		{LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD
> >>> BACKLIGHT"},
> >>> +	};
> >>> +
> >>> +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> >>> +	if (r) {
> >>> +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
> >>> +		return;
> >>> +	}
> >> If I test with this patch, this request is returning error.
> > Hmm. Well, the GPIOs are the same as in the old driver. However, the old
> > driver doesn't even seem to check if it manages to request the GPIOs, so
> > it may well be that it was failing also.
> >
> > Can you check from /sys/class/gpio/ if some of the GPIOs are already
> > allocated: 207, 199, 55, 56?
> >
> > The definition of two of those GPIOs look kinda funny to me: (15 +
> > OMAP_MAX_GPIO_LINES). I don't know what OMAP_MAX_GPIO_LINES means, but
> > it sure doesn't sound ok to have a GPIO number that is 15 over the
> > maximum =).
> >
> 
> This means that some kind of gpio expander is used.
> I bet those are twl gpios (or may be some other discrete chip).
> If those are twl gpios then you need to provide the .setup callback
> in struct twl4030_gpio_platform_data which will request and setup those gpios.

Here's an updated patch with the twl gpio code.

All the old omapfb porting patches, including new drivers for DSS2, can
be found from 

git://gitorious.org/linux-omap-dss2/linux.git old-omapfb-port

 Tomi

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e2ba779..ed78b9a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -44,6 +44,9 @@
 #include <asm/delay.h>
 #include <plat/usb.h>
 
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+
 #include "board-flash.h"
 #include "mux.h"
 #include "hsmmc.h"
@@ -275,19 +278,70 @@ static inline void __init ldp_init_smsc911x(void)
 	gpio_direction_input(eth_gpio);
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
+	gpio_direction_output(ldp_lcd_enable_gpio, 1);
+	gpio_direction_output(ldp_backlight_gpio, 1);
+
+	return 0;
+}
+
+static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(ldp_lcd_enable_gpio, 0);
+	gpio_direction_output(ldp_backlight_gpio, 0);
+}
+
+static struct panel_generic_dpi_data ldp_panel_data = {
+	.name			= "2430sdp",
+	.platform_enable	= ldp_panel_enable_lcd,
+	.platform_disable	= ldp_panel_disable_lcd,
+};
+
+static struct omap_dss_device ldp_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 16,
+	.data			= &ldp_panel_data,
 };
 
-static struct omap_lcd_config ldp_lcd_config __initdata = {
-	.ctrl_name	= "internal",
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
@@ -298,10 +352,30 @@ static struct twl4030_usb_data ldp_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
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
+	if (r)
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+
+	ldp_backlight_gpio = gpio + 15;
+	ldp_lcd_enable_gpio = gpio + 7;
+
+	return r;
+}
+
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.setup		= ldp_twl_gpio_setup,
 };
 
 static struct twl4030_madc_platform_data ldp_madc_data = {
@@ -347,6 +421,26 @@ static struct regulator_init_data ldp_vaux1 = {
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
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -356,6 +450,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	.usb		= &ldp_usb_data,
 	.vmmc1		= &ldp_vmmc1,
 	.vaux1		= &ldp_vaux1,
+	.vpll2		= &ldp_vpll2,
 	.gpio		= &ldp_gpio_data,
 	.keypad		= &ldp_kp_twl4030_data,
 };
@@ -390,7 +485,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_smsc911x_device,
-	&ldp_lcd_device,
 	&ldp_gpio_keys_device,
 };
 
@@ -441,8 +535,6 @@ static struct mtd_partition ldp_nand_partitions[] = {
 static void __init omap_ldp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = ldp_config;
-	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	ldp_init_smsc911x();
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
@@ -459,6 +551,8 @@ static void __init omap_ldp_init(void)
 	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
 	ldp_vmmc1_supply.dev = mmc[0].dev;
+
+	ldp_display_init();
 }
 
 MACHINE_START(OMAP_LDP, "OMAP LDP board")




