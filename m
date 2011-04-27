From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
Date: Wed, 27 Apr 2011 12:05:53 +0300
Message-ID: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:37515
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754822Ab1D0JGN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 05:06:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

use gpio_request_<one|array>() instead of multiple gpiolib calls,
remove unneeded variables, etc.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
Boot tested on cm-t35 and compile tested for others.

This patch depends on previous patches from me:
[PATCH v2 1/2] arm: omap: fix bug with multiple smsc911x devices
[PATCH v2 2/2] arm: omap: gpmc-smsc911x: minor style fixes

and conflicts with patch series from Mike:
[PATCH 0/4] omap: cleanup board files

once we get either of the series to Tony, we can rebase the other.
Also, if this is approved, I can try to do the same for mach-omap1
and may be some other mach|plat-*


 arch/arm/mach-omap2/board-2430sdp.c          |    7 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   50 +++------
 arch/arm/mach-omap2/board-4430sdp.c          |   98 ++++--------------
 arch/arm/mach-omap2/board-am3517crane.c      |   10 +--
 arch/arm/mach-omap2/board-am3517evm.c        |   54 +++-------
 arch/arm/mach-omap2/board-apollon.c          |   29 +++---
 arch/arm/mach-omap2/board-cm-t35.c           |   85 +++++----------
 arch/arm/mach-omap2/board-cm-t3517.c         |    9 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   24 ++---
 arch/arm/mach-omap2/board-igep0020.c         |  143 +++++++++++++-------------
 arch/arm/mach-omap2/board-igep0030.c         |   93 ++++++++---------
 arch/arm/mach-omap2/board-ldp.c              |    5 +-
 arch/arm/mach-omap2/board-n8x0.c             |   62 ++++--------
 arch/arm/mach-omap2/board-omap3beagle.c      |  128 ++++++++---------------
 arch/arm/mach-omap2/board-omap3evm.c         |  105 ++++++-------------
 arch/arm/mach-omap2/board-omap3pandora.c     |   29 +-----
 arch/arm/mach-omap2/board-omap3stalker.c     |   15 ++--
 arch/arm/mach-omap2/board-omap3touchbook.c   |   23 ++---
 arch/arm/mach-omap2/board-omap4panda.c       |   62 ++++--------
 arch/arm/mach-omap2/board-overo.c            |   63 ++++++------
 arch/arm/mach-omap2/board-rx51-peripherals.c |   29 ++----
 arch/arm/mach-omap2/board-rx51-video.c       |    5 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    9 +-
 arch/arm/mach-omap2/board-zoom-display.c     |   31 ++----
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 +-
 arch/arm/mach-omap2/gpmc-smc91x.c            |   11 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c          |    7 +-
 arch/arm/mach-omap2/usb-tusb6010.c           |    3 +-
 28 files changed, 436 insertions(+), 761 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 1fa6bb8..d586c7d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -240,8 +240,6 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 static void __init omap_2430sdp_init(void)
 {
-	int ret;
-
 	omap2430_mux_init(board_mux, OMAP_PACKAGE_ZAC);
 
 	omap_board_config = sdp2430_config;
@@ -260,9 +258,8 @@ static void __init omap_2430sdp_init(void)
 	board_smc91x_init();
 
 	/* Turn off secondary LCD backlight */
-	ret = gpio_request(SECONDARY_LCD_GPIO, "Secondary LCD backlight");
-	if (ret == 0)
-		gpio_direction_output(SECONDARY_LCD_GPIO, 0);
+	gpio_request_one(SECONDARY_LCD_GPIO, GPIOF_OUT_INIT_LOW,
+			 "Secondary LCD backlight");
 }
 
 static void __init omap_2430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..1903afc 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -132,12 +132,11 @@ static int ts_gpio;	/* Needed for ads7846_get_pendown_state */
  */
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(ts_gpio, "ADS7846 pendown") < 0) {
+	if (gpio_request_one(ts_gpio, GPIOF_IN, "ADS7846 pendown") < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 		return;
 	}
 
-	gpio_direction_input(ts_gpio);
 	gpio_set_debounce(ts_gpio, 310);
 }
 
@@ -178,8 +177,11 @@ static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
 #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	8
 #define SDP3430_LCD_PANEL_ENABLE_GPIO		5
 
-static unsigned backlight_gpio;
-static unsigned enable_gpio;
+static struct gpio sdp3430_dss_gpios[] __initdata = {
+	{SDP3430_LCD_PANEL_ENABLE_GPIO,    GPIOF_OUT_INIT_LOW, "LCD reset"    },
+	{SDP3430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD Backlight"},
+};
+
 static int lcd_enabled;
 static int dvi_enabled;
 
@@ -187,29 +189,11 @@ static void __init sdp3430_display_init(void)
 {
 	int r;
 
-	enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
-	backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
-
-	r = gpio_request(enable_gpio, "LCD reset");
-	if (r) {
-		printk(KERN_ERR "failed to get LCD reset GPIO\n");
-		goto err0;
-	}
-
-	r = gpio_request(backlight_gpio, "LCD Backlight");
-	if (r) {
-		printk(KERN_ERR "failed to get LCD backlight GPIO\n");
-		goto err1;
-	}
-
-	gpio_direction_output(enable_gpio, 0);
-	gpio_direction_output(backlight_gpio, 0);
+	r = gpio_request_array(sdp3430_dss_gpios,
+			       ARRAY_SIZE(sdp3430_dss_gpios));
+	if (r)
+		printk(KERN_ERR "failed to get LCD control GPIOs\n");
 
-	return;
-err1:
-	gpio_free(enable_gpio);
-err0:
-	return;
 }
 
 static int sdp3430_panel_enable_lcd(struct omap_dss_device *dssdev)
@@ -219,8 +203,8 @@ static int sdp3430_panel_enable_lcd(struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
-	gpio_direction_output(enable_gpio, 1);
-	gpio_direction_output(backlight_gpio, 1);
+	gpio_direction_output(SDP3430_LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(SDP3430_LCD_PANEL_BACKLIGHT_GPIO, 1);
 
 	lcd_enabled = 1;
 
@@ -231,8 +215,8 @@ static void sdp3430_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 	lcd_enabled = 0;
 
-	gpio_direction_output(enable_gpio, 0);
-	gpio_direction_output(backlight_gpio, 0);
+	gpio_direction_output(SDP3430_LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(SDP3430_LCD_PANEL_BACKLIGHT_GPIO, 0);
 }
 
 static int sdp3430_panel_enable_dvi(struct omap_dss_device *dssdev)
@@ -360,12 +344,10 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	omap2_hsmmc_init(mmc);
 
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
-	gpio_request(gpio + 7, "sub_lcd_en_bkl");
-	gpio_direction_output(gpio + 7, 0);
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "sub_lcd_en_bkl");
 
 	/* gpio + 15 is "sub_lcd_nRST" (output) */
-	gpio_request(gpio + 15, "sub_lcd_nRST");
-	gpio_direction_output(gpio + 15, 0);
+	gpio_request_one(gpio + 15, GPIOF_OUT_INIT_LOW, "sub_lcd_nRST");
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 56702c5..32fefa6 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -251,58 +251,22 @@ static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
 	},
 };
 
+static struct gpio sdp4430_eth_gpios[] __initdata = {
+	{ ETH_KS8851_POWER_ON,	GPIOF_OUT_INIT_HIGH,	"eth_power"	},
+	{ ETH_KS8851_QUART,	GPIOF_OUT_INIT_HIGH,	"quart"		},
+	{ ETH_KS8851_IRQ,	GPIOF_IN,		"eth_irq"	},
+};
+
 static int omap_ethernet_init(void)
 {
 	int status;
 
 	/* Request of GPIO lines */
+	status = gpio_request_array(sdp4430_eth_gpios,
+				    ARRAY_SIZE(sdp4430_eth_gpios));
+	if (status)
+		pr_err("Cannot request ETH GPIOs\n");
 
-	status = gpio_request(ETH_KS8851_POWER_ON, "eth_power");
-	if (status) {
-		pr_err("Cannot request GPIO %d\n", ETH_KS8851_POWER_ON);
-		return status;
-	}
-
-	status = gpio_request(ETH_KS8851_QUART, "quart");
-	if (status) {
-		pr_err("Cannot request GPIO %d\n", ETH_KS8851_QUART);
-		goto error1;
-	}
-
-	status = gpio_request(ETH_KS8851_IRQ, "eth_irq");
-	if (status) {
-		pr_err("Cannot request GPIO %d\n", ETH_KS8851_IRQ);
-		goto error2;
-	}
-
-	/* Configuration of requested GPIO lines */
-
-	status = gpio_direction_output(ETH_KS8851_POWER_ON, 1);
-	if (status) {
-		pr_err("Cannot set output GPIO %d\n", ETH_KS8851_IRQ);
-		goto error3;
-	}
-
-	status = gpio_direction_output(ETH_KS8851_QUART, 1);
-	if (status) {
-		pr_err("Cannot set output GPIO %d\n", ETH_KS8851_QUART);
-		goto error3;
-	}
-
-	status = gpio_direction_input(ETH_KS8851_IRQ);
-	if (status) {
-		pr_err("Cannot set input GPIO %d\n", ETH_KS8851_IRQ);
-		goto error3;
-	}
-
-	return 0;
-
-error3:
-	gpio_free(ETH_KS8851_IRQ);
-error2:
-	gpio_free(ETH_KS8851_QUART);
-error1:
-	gpio_free(ETH_KS8851_POWER_ON);
 	return status;
 }
 
@@ -614,21 +578,13 @@ static int __init omap4_i2c_init(void)
 
 static void __init omap_sfh7741prox_init(void)
 {
-	int  error;
+	int error;
 
-	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
-	if (error < 0) {
+	error = gpio_request_one(OMAP4_SFH7741_ENABLE_GPIO,
+				 GPIOF_OUT_INIT_LOW, "sfh7741");
+	if (error < 0)
 		pr_err("%s:failed to request GPIO %d, error %d\n",
 			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
-		return;
-	}
-
-	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 0);
-	if (error < 0) {
-		pr_err("%s: GPIO configuration failed: GPIO %d,error %d\n",
-			 __func__, OMAP4_SFH7741_ENABLE_GPIO, error);
-		gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
-	}
 }
 
 static void sdp4430_hdmi_mux_init(void)
@@ -645,27 +601,19 @@ static void sdp4430_hdmi_mux_init(void)
 			OMAP_PIN_INPUT_PULLUP);
 }
 
+static struct gpio sdp4430_hdmi_gpios[] = {
+	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_hpd"   },
+	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
+};
+
 static int sdp4430_panel_enable_hdmi(struct omap_dss_device *dssdev)
 {
 	int status;
 
-	status = gpio_request_one(HDMI_GPIO_HPD, GPIOF_OUT_INIT_HIGH,
-							"hdmi_gpio_hpd");
-	if (status) {
-		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_HPD);
-		return status;
-	}
-	status = gpio_request_one(HDMI_GPIO_LS_OE, GPIOF_OUT_INIT_HIGH,
-							"hdmi_gpio_ls_oe");
-	if (status) {
-		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_LS_OE);
-		goto error1;
-	}
-
-	return 0;
-
-error1:
-	gpio_free(HDMI_GPIO_HPD);
+	status = gpio_request_array(sdp4430_hdmi_gpios,
+				    ARRAY_SIZE(sdp4430_hdmi_gpios));
+	if (status)
+		pr_err("%s: Cannot request HDMI GPIOs\n", __func__);
 
 	return status;
 }
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index a890d24..5e438a7 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -89,19 +89,13 @@ static void __init am3517_crane_init(void)
 		return;
 	}
 
-	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
+	ret = gpio_request_one(GPIO_USB_POWER, GPIOF_OUT_INIT_HIGH,
+			       "usb_ehci_enable");
 	if (ret < 0) {
 		pr_err("Can not request GPIO %d\n", GPIO_USB_POWER);
 		return;
 	}
 
-	ret = gpio_direction_output(GPIO_USB_POWER, 1);
-	if (ret < 0) {
-		gpio_free(GPIO_USB_POWER);
-		pr_err("Unable to initialize EHCI power\n");
-		return;
-	}
-
 	usbhs_init(&usbhs_bdata);
 }
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ce7d5e6..6c47060 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -174,19 +174,14 @@ static void __init am3517_evm_rtc_init(void)
 	int r;
 
 	omap_mux_init_gpio(GPIO_RTCS35390A_IRQ, OMAP_PIN_INPUT_PULLUP);
-	r = gpio_request(GPIO_RTCS35390A_IRQ, "rtcs35390a-irq");
+
+	r = gpio_request_one(GPIO_RTCS35390A_IRQ, GPIOF_IN, "rtcs35390a-irq");
 	if (r < 0) {
 		printk(KERN_WARNING "failed to request GPIO#%d\n",
 				GPIO_RTCS35390A_IRQ);
 		return;
 	}
-	r = gpio_direction_input(GPIO_RTCS35390A_IRQ);
-	if (r < 0) {
-		printk(KERN_WARNING "GPIO#%d cannot be configured as input\n",
-				GPIO_RTCS35390A_IRQ);
-		gpio_free(GPIO_RTCS35390A_IRQ);
-		return;
-	}
+
 	am3517evm_i2c1_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
 }
 
@@ -242,6 +237,15 @@ static int dvi_enabled;
 
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
 		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
+static struct gpio am3517_evm_dss_gpios[] __initdata = {
+	/* GPIO 182 = LCD Backlight Power */
+	{ LCD_PANEL_BKLIGHT_PWR, GPIOF_OUT_INIT_HIGH, "lcd_backlight_pwr" },
+	/* GPIO 181 = LCD Panel PWM */
+	{ LCD_PANEL_PWM,	 GPIOF_OUT_INIT_HIGH, "lcd bl enable"	  },
+	/* GPIO 176 = LCD Panel Power enable pin */
+	{ LCD_PANEL_PWR,	 GPIOF_OUT_INIT_HIGH, "dvi enable"	  },
+};
+
 static void __init am3517_evm_display_init(void)
 {
 	int r;
@@ -249,41 +253,15 @@ static void __init am3517_evm_display_init(void)
 	omap_mux_init_gpio(LCD_PANEL_PWR, OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_gpio(LCD_PANEL_BKLIGHT_PWR, OMAP_PIN_INPUT_PULLDOWN);
 	omap_mux_init_gpio(LCD_PANEL_PWM, OMAP_PIN_INPUT_PULLDOWN);
-	/*
-	 * Enable GPIO 182 = LCD Backlight Power
-	 */
-	r = gpio_request(LCD_PANEL_BKLIGHT_PWR, "lcd_backlight_pwr");
+
+	r = gpio_request_array(am3517_evm_dss_gpios,
+			       ARRAY_SIZE(am3517_evm_dss_gpios));
 	if (r) {
-		printk(KERN_ERR "failed to get lcd_backlight_pwr\n");
+		printk(KERN_ERR "failed to get DSS panel control GPIOs\n");
 		return;
 	}
-	gpio_direction_output(LCD_PANEL_BKLIGHT_PWR, 1);
-	/*
-	 * Enable GPIO 181 = LCD Panel PWM
-	 */
-	r = gpio_request(LCD_PANEL_PWM, "lcd_pwm");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_pwm\n");
-		goto err_1;
-	}
-	gpio_direction_output(LCD_PANEL_PWM, 1);
-	/*
-	 * Enable GPIO 176 = LCD Panel Power enable pin
-	 */
-	r = gpio_request(LCD_PANEL_PWR, "lcd_panel_pwr");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_panel_pwr\n");
-		goto err_2;
-	}
-	gpio_direction_output(LCD_PANEL_PWR, 1);
 
 	printk(KERN_INFO "Display initialized successfully\n");
-	return;
-
-err_2:
-	gpio_free(LCD_PANEL_PWM);
-err_1:
-	gpio_free(LCD_PANEL_BKLIGHT_PWR);
 }
 #else
 static void __init am3517_evm_display_init(void) {}
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index f4f8374..f3beb8e 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -202,6 +202,7 @@ static inline void __init apollon_init_smc91x(void)
 	unsigned int rate;
 	struct clk *gpmc_fck;
 	int eth_cs;
+	int err;
 
 	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
 	if (IS_ERR(gpmc_fck)) {
@@ -245,15 +246,13 @@ static inline void __init apollon_init_smc91x(void)
 	apollon_smc91x_resources[0].end   = base + 0x30f;
 	udelay(100);
 
-	omap_mux_init_gpio(74, 0);
-	if (gpio_request(APOLLON_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
+	omap_mux_init_gpio(APOLLON_ETHR_GPIO_IRQ, 0);
+	err = gpio_request_one(APOLLON_ETHR_GPIO_IRQ, GPIOF_IN, "SMC91x irq");
+	if (err) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			APOLLON_ETHR_GPIO_IRQ);
 		gpmc_cs_free(APOLLON_ETH_CS);
-		goto out;
 	}
-	gpio_direction_input(APOLLON_ETHR_GPIO_IRQ);
-
 out:
 	clk_disable(gpmc_fck);
 	clk_put(gpmc_fck);
@@ -280,20 +279,19 @@ static void __init omap_apollon_init_early(void)
 	omap2_init_common_devices(NULL, NULL);
 }
 
+static struct gpio apollon_gpio_leds[] __initdata = {
+	{ LED0_GPIO13, GPIOF_OUT_INIT_LOW, "LED0" }, /* LED0 - AA10 */
+	{ LED1_GPIO14, GPIOF_OUT_INIT_LOW, "LED1" }, /* LED1 - AA6  */
+	{ LED2_GPIO15, GPIOF_OUT_INIT_LOW, "LED2" }, /* LED2 - AA4  */
+};
+
 static void __init apollon_led_init(void)
 {
-	/* LED0 - AA10 */
 	omap_mux_init_signal("vlynq_clk.gpio_13", 0);
-	gpio_request(LED0_GPIO13, "LED0");
-	gpio_direction_output(LED0_GPIO13, 0);
-	/* LED1  - AA6 */
 	omap_mux_init_signal("vlynq_rx1.gpio_14", 0);
-	gpio_request(LED1_GPIO14, "LED1");
-	gpio_direction_output(LED1_GPIO14, 0);
-	/* LED2  - AA4 */
 	omap_mux_init_signal("vlynq_rx0.gpio_15", 0);
-	gpio_request(LED2_GPIO15, "LED2");
-	gpio_direction_output(LED2_GPIO15, 0);
+
+	gpio_request_array(apollon_gpio_leds, ARRAY_SIZE(apollon_gpio_leds));
 }
 
 static void __init apollon_usb_init(void)
@@ -301,8 +299,7 @@ static void __init apollon_usb_init(void)
 	/* USB device */
 	/* DEVICE_SUSPEND */
 	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
-	gpio_request(12, "USB suspend");
-	gpio_direction_output(12, 0);
+	gpio_request_one(12, GPIOF_OUT_INIT_LOW, "USB suspend");
 	omap2_usbfs_init(&apollon_usb_config);
 }
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 7c70f56..0ac81fb 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -217,14 +217,17 @@ static struct spi_board_info cm_t35_spi_board_info[] __initdata = {
 
 static void __init cm_t35_init_ads7846(void)
 {
-	if ((gpio_request(CM_T35_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
-	    (gpio_direction_input(CM_T35_GPIO_PENDOWN) == 0)) {
-		gpio_export(CM_T35_GPIO_PENDOWN, 0);
-	} else {
+	int err;
+
+	err = gpio_request_one(CM_T35_GPIO_PENDOWN, GPIOF_IN,
+			       "ADS7846_PENDOWN");
+	if (err) {
 		pr_err("CM-T35: could not obtain gpio for ADS7846_PENDOWN\n");
 		return;
 	}
 
+	gpio_export(CM_T35_GPIO_PENDOWN, 0);
+
 	spi_register_board_info(cm_t35_spi_board_info,
 				ARRAY_SIZE(cm_t35_spi_board_info));
 }
@@ -236,10 +239,6 @@ static inline void cm_t35_init_ads7846(void) {}
 #define CM_T35_LCD_BL_GPIO 58
 #define CM_T35_DVI_EN_GPIO 54
 
-static int lcd_bl_gpio;
-static int lcd_en_gpio;
-static int dvi_en_gpio;
-
 static int lcd_enabled;
 static int dvi_enabled;
 
@@ -250,8 +249,8 @@ static int cm_t35_panel_enable_lcd(struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
-	gpio_set_value(lcd_en_gpio, 1);
-	gpio_set_value(lcd_bl_gpio, 1);
+	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
+	gpio_set_value(CM_T35_LCD_BL_GPIO, 1);
 
 	lcd_enabled = 1;
 
@@ -262,8 +261,8 @@ static void cm_t35_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 	lcd_enabled = 0;
 
-	gpio_set_value(lcd_bl_gpio, 0);
-	gpio_set_value(lcd_en_gpio, 0);
+	gpio_set_value(CM_T35_LCD_BL_GPIO, 0);
+	gpio_set_value(CM_T35_LCD_EN_GPIO, 0);
 }
 
 static int cm_t35_panel_enable_dvi(struct omap_dss_device *dssdev)
@@ -273,7 +272,7 @@ static int cm_t35_panel_enable_dvi(struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
-	gpio_set_value(dvi_en_gpio, 0);
+	gpio_set_value(CM_T35_DVI_EN_GPIO, 0);
 	dvi_enabled = 1;
 
 	return 0;
@@ -281,7 +280,7 @@ static int cm_t35_panel_enable_dvi(struct omap_dss_device *dssdev)
 
 static void cm_t35_panel_disable_dvi(struct omap_dss_device *dssdev)
 {
-	gpio_set_value(dvi_en_gpio, 1);
+	gpio_set_value(CM_T35_DVI_EN_GPIO, 1);
 	dvi_enabled = 0;
 }
 
@@ -363,62 +362,38 @@ static struct spi_board_info cm_t35_lcd_spi_board_info[] __initdata = {
 	},
 };
 
+static struct gpio cm_t35_dss_gpios[] __initdata = {
+	{ CM_T35_LCD_EN_GPIO, GPIOF_OUT_INIT_LOW,  "lcd enable"    },
+	{ CM_T35_LCD_BL_GPIO, GPIOF_OUT_INIT_LOW,  "lcd bl enable" },
+	{ CM_T35_DVI_EN_GPIO, GPIOF_OUT_INIT_HIGH, "dvi enable"    },
+};
+
 static void __init cm_t35_init_display(void)
 {
 	int err;
 
-	lcd_en_gpio = CM_T35_LCD_EN_GPIO;
-	lcd_bl_gpio = CM_T35_LCD_BL_GPIO;
-	dvi_en_gpio = CM_T35_DVI_EN_GPIO;
-
 	spi_register_board_info(cm_t35_lcd_spi_board_info,
 				ARRAY_SIZE(cm_t35_lcd_spi_board_info));
 
-	err = gpio_request(lcd_en_gpio, "LCD RST");
-	if (err) {
-		pr_err("CM-T35: failed to get LCD reset GPIO\n");
-		goto out;
-	}
-
-	err = gpio_request(lcd_bl_gpio, "LCD BL");
-	if (err) {
-		pr_err("CM-T35: failed to get LCD backlight control GPIO\n");
-		goto err_lcd_bl;
-	}
-
-	err = gpio_request(dvi_en_gpio, "DVI EN");
+	err = gpio_request_array(cm_t35_dss_gpios,
+				 ARRAY_SIZE(cm_t35_dss_gpios));
 	if (err) {
-		pr_err("CM-T35: failed to get DVI reset GPIO\n");
-		goto err_dvi_en;
+		pr_err("CM-T35: failed to request DSS control GPIOs\n");
+		return;
 	}
 
-	gpio_export(lcd_en_gpio, 0);
-	gpio_export(lcd_bl_gpio, 0);
-	gpio_export(dvi_en_gpio, 0);
-	gpio_direction_output(lcd_en_gpio, 0);
-	gpio_direction_output(lcd_bl_gpio, 0);
-	gpio_direction_output(dvi_en_gpio, 1);
+	gpio_export(CM_T35_LCD_EN_GPIO, 0);
+	gpio_export(CM_T35_LCD_BL_GPIO, 0);
+	gpio_export(CM_T35_DVI_EN_GPIO, 0);
 
 	msleep(50);
-	gpio_set_value(lcd_en_gpio, 1);
+	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
 
 	err = omap_display_init(&cm_t35_dss_data);
 	if (err) {
 		pr_err("CM-T35: failed to register DSS device\n");
-		goto err_dev_reg;
+		gpio_free_array(cm_t35_dss_gpios, ARRAY_SIZE(cm_t35_dss_gpios));
 	}
-
-	return;
-
-err_dev_reg:
-	gpio_free(dvi_en_gpio);
-err_dvi_en:
-	gpio_free(lcd_bl_gpio);
-err_lcd_bl:
-	gpio_free(lcd_en_gpio);
-out:
-
-	return;
 }
 
 static struct regulator_consumer_supply cm_t35_vmmc1_supply = {
@@ -551,10 +526,8 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 {
 	int wlan_rst = gpio + 2;
 
-	if ((gpio_request(wlan_rst, "WLAN RST") == 0) &&
-	    (gpio_direction_output(wlan_rst, 1) == 0)) {
+	if (gpio_request_one(wlan_rst, GPIOF_OUT_INIT_HIGH, "WLAN RST") == 0) {
 		gpio_export(wlan_rst, 0);
-
 		udelay(10);
 		gpio_set_value(wlan_rst, 0);
 		udelay(10);
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 802cb60..30e9c6b 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -148,14 +148,13 @@ static void __init cm_t3517_init_rtc(void)
 {
 	int err;
 
-	err = gpio_request(RTC_CS_EN_GPIO, "rtc cs en");
+	err = gpio_request_one(RTC_CS_EN_GPIO, GPIOF_OUT_INIT_HIGH,
+			       "rtc cs en");
 	if (err) {
 		pr_err("CM-T3517: rtc cs en gpio request failed: %d\n", err);
 		return;
 	}
 
-	gpio_direction_output(RTC_CS_EN_GPIO, 1);
-
 	platform_device_register(&cm_t3517_rtc_device);
 }
 #else
@@ -182,11 +181,11 @@ static int __init cm_t3517_init_usbh(void)
 {
 	int err;
 
-	err = gpio_request(USB_HUB_RESET_GPIO, "usb hub rst");
+	err = gpio_request_one(USB_HUB_RESET_GPIO, GPIOF_OUT_INIT_LOW,
+			       "usb hub rst");
 	if (err) {
 		pr_err("CM-T3517: usb hub rst gpio request failed: %d\n", err);
 	} else {
-		gpio_direction_output(USB_HUB_RESET_GPIO, 0);
 		udelay(10);
 		gpio_set_value(USB_HUB_RESET_GPIO, 1);
 		msleep(1);
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 65f9fde..4caedae 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -249,7 +249,7 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
 	devkit8000_lcd_device.reset_gpio = gpio + TWL4030_GPIO_MAX + 0;
 	ret = gpio_request_one(devkit8000_lcd_device.reset_gpio,
-			GPIOF_DIR_OUT | GPIOF_INIT_LOW, "LCD_PWREN");
+			       GPIOF_OUT_INIT_LOW, "LCD_PWREN");
 	if (ret < 0) {
 		devkit8000_lcd_device.reset_gpio = -EINVAL;
 		printk(KERN_ERR "Failed to request GPIO for LCD_PWRN\n");
@@ -258,7 +258,7 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	/* gpio + 7 is "DVI_PD" (out, active low) */
 	devkit8000_dvi_device.reset_gpio = gpio + 7;
 	ret = gpio_request_one(devkit8000_dvi_device.reset_gpio,
-			GPIOF_DIR_OUT | GPIOF_INIT_LOW, "DVI PowerDown");
+			       GPIOF_OUT_INIT_LOW, "DVI PowerDown");
 	if (ret < 0) {
 		devkit8000_dvi_device.reset_gpio = -EINVAL;
 		printk(KERN_ERR "Failed to request GPIO for DVI PowerDown\n");
@@ -465,17 +465,13 @@ static void __init devkit8000_init_irq(void)
 
 static void __init devkit8000_ads7846_init(void)
 {
-	int gpio = OMAP3_DEVKIT_TS_GPIO;
 	int ret;
 
-	ret = gpio_request(gpio, "ads7846_pen_down");
-	if (ret < 0) {
+	ret = gpio_request_one(OMAP3_DEVKIT_TS_GPIO, GPIOF_IN,
+			       "ads7846_pen_down");
+	if (ret < 0)
 		printk(KERN_ERR "Failed to request GPIO %d for "
-				"ads7846 pen down IRQ\n", gpio);
-		return;
-	}
-
-	gpio_direction_input(gpio);
+				"ads7846 pen down IRQ\n", OMAP3_DEVKIT_TS_GPIO);
 }
 
 static int ads7846_get_pendown_state(void)
@@ -550,14 +546,14 @@ static void __init omap_dm9000_init(void)
 {
 	unsigned char *eth_addr = omap_dm9000_platdata.dev_addr;
 	struct omap_die_id odi;
+	int ret;
 
-	if (gpio_request(OMAP_DM9000_GPIO_IRQ, "dm9000 irq") < 0) {
+	ret = gpio_request_one(OMAP_DM9000_GPIO_IRQ, GPIOF_IN, "dm9000 irq");
+	if (ret < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
 			OMAP_DM9000_GPIO_IRQ);
 		return;
-		}
-
-	gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
+	}
 
 	/* init the mac address using DIE id */
 	omap_get_die_id(&odi);
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5b9bde7..641671b 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -77,22 +77,22 @@ static void __init igep2_get_revision(void)
 
 	omap_mux_init_gpio(IGEP2_GPIO_LED1_RED, OMAP_PIN_INPUT);
 
-	if ((gpio_request(IGEP2_GPIO_LED1_RED, "GPIO_HW0_REV") == 0) &&
-	    (gpio_direction_input(IGEP2_GPIO_LED1_RED) == 0)) {
-		ret = gpio_get_value(IGEP2_GPIO_LED1_RED);
-		if (ret == 0) {
-			pr_info("IGEP2: Hardware Revision C (B-NON compatible)\n");
-			hwrev = IGEP2_BOARD_HWREV_C;
-		} else if (ret ==  1) {
-			pr_info("IGEP2: Hardware Revision B/C (B compatible)\n");
-			hwrev = IGEP2_BOARD_HWREV_B;
-		} else {
-			pr_err("IGEP2: Unknown Hardware Revision\n");
-			hwrev = -1;
-		}
-	} else {
+	if (gpio_request_one(IGEP2_GPIO_LED1_RED, GPIOF_IN, "GPIO_HW0_REV")) {
 		pr_warning("IGEP2: Could not obtain gpio GPIO_HW0_REV\n");
 		pr_err("IGEP2: Unknown Hardware Revision\n");
+		return;
+	}
+
+	ret = gpio_get_value(IGEP2_GPIO_LED1_RED);
+	if (ret == 0) {
+		pr_info("IGEP2: Hardware Revision C (B-NON compatible)\n");
+		hwrev = IGEP2_BOARD_HWREV_C;
+	} else if (ret ==  1) {
+		pr_info("IGEP2: Hardware Revision B/C (B compatible)\n");
+		hwrev = IGEP2_BOARD_HWREV_B;
+	} else {
+		pr_err("IGEP2: Unknown Hardware Revision\n");
+		hwrev = -1;
 	}
 
 	gpio_free(IGEP2_GPIO_LED1_RED);
@@ -338,32 +338,35 @@ static void __init igep2_leds_init(void)
 }
 
 #else
+static struct gpio igep2_gpio_leds[] __initdata = {
+	{ IGEP2_GPIO_LED0_RED,	 GPIOF_OUT_INIT_LOW, "gpio-led:red:d0"   },
+	{ IGEP2_GPIO_LED0_GREEN, GPIOF_OUT_INIT_LOW, "gpio-led:green:d0" },
+	{ IGEP2_GPIO_LED1_RED,	 GPIOF_OUT_INIT_LOW, "gpio-led:red:d1"   },
+};
+
 static inline void igep2_leds_init(void)
 {
-	if ((gpio_request(IGEP2_GPIO_LED0_RED, "gpio-led:red:d0") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_LED0_RED, 0) == 0))
-		gpio_export(IGEP2_GPIO_LED0_RED, 0);
-	else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED0_RED\n");
-
-	if ((gpio_request(IGEP2_GPIO_LED0_GREEN, "gpio-led:green:d0") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_LED0_GREEN, 0) == 0))
-		gpio_export(IGEP2_GPIO_LED0_GREEN, 0);
-	else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED0_GREEN\n");
-
-	if ((gpio_request(IGEP2_GPIO_LED1_RED, "gpio-led:red:d1") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_LED1_RED, 0) == 0))
-		gpio_export(IGEP2_GPIO_LED1_RED, 0);
-	else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_RED\n");
+	if (gpio_request_array(igep2_gpio_leds, ARRAY_SIZE(igep2_gpio_leds))) {
+		pr_warning("IGEP v2: Could not obtain leds gpios\n");
+		return;
+	}
 
+	gpio_export(IGEP2_GPIO_LED0_RED, 0);
+	gpio_export(IGEP2_GPIO_LED0_GREEN, 0);
+	gpio_export(IGEP2_GPIO_LED1_RED, 0);
 }
 #endif
 
+static struct gpio igep2_twl_gpios[] = {
+	{ -EINVAL, GPIOF_IN,		"GPIO_EHCI_NOC"  },
+	{ -EINVAL, GPIOF_OUT_INIT_LOW,	"GPIO_USBH_CPEN" },
+};
+
 static int igep2_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int ret;
+
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
@@ -372,22 +375,20 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	 * REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
-	if ((gpio_request(gpio + 1, "GPIO_EHCI_NOC") < 0) ||
-	    (gpio_direction_input(gpio + 1) < 0))
-		pr_err("IGEP2: Could not obtain gpio for EHCI NOC");
+	igep2_twl_gpios[0].gpio = gpio + 1;
 
-	/*
-	 * TWL4030_GPIO_MAX + 0 == ledA, GPIO_USBH_CPEN
-	 * (out, active low)
-	 */
-	if ((gpio_request(gpio + TWL4030_GPIO_MAX, "GPIO_USBH_CPEN") < 0) ||
-	    (gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0) < 0))
+	/* TWL4030_GPIO_MAX + 0 == ledA, GPIO_USBH_CPEN (out, active low) */
+	igep2_twl_gpios[1].gpio = gpio + TWL4030_GPIO_MAX;
+
+	ret = gpio_request_array(igep2_twl_gpios, ARRAY_SIZE(igep2_twl_gpios));
+	if (ret < 0)
 		pr_err("IGEP2: Could not obtain gpio for USBH_CPEN");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
-	if ((gpio_request(gpio+TWL4030_GPIO_MAX+1, "gpio-led:green:d1") == 0)
-	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 1) == 0))
+	ret = gpio_request_one(gpio + TWL4030_GPIO_MAX + 1, GPIOF_OUT_INIT_HIGH,
+			       "gpio-led:green:d1");
+	if (ret == 0)
 		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
 	else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_GREEN\n");
@@ -468,8 +469,9 @@ static struct regulator_init_data igep2_vpll2 = {
 
 static void __init igep2_display_init(void)
 {
-	if (gpio_request(IGEP2_GPIO_DVI_PUP, "GPIO_DVI_PUP") &&
-	    gpio_direction_output(IGEP2_GPIO_DVI_PUP, 1))
+	int err = gpio_request_one(IGEP2_GPIO_DVI_PUP, GPIOF_OUT_INIT_HIGH,
+				   "GPIO_DVI_PUP");
+	if (err)
 		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
 }
 
@@ -594,44 +596,43 @@ static struct omap_board_mux board_mux[] __initdata = {
 #endif
 
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
+static struct gpio igep2_wlan_bt_gpios[] __initdata = {
+	{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_WIFI_NPD"	   },
+	{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_WIFI_NRESET" },
+	{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_BT_NRESET"   },
+};
 
 static void __init igep2_wlan_bt_init(void)
 {
-	unsigned npd, wreset, btreset;
+	int err;
 
 	/* GPIO's for WLAN-BT combo depends on hardware revision */
 	if (hwrev == IGEP2_BOARD_HWREV_B) {
-		npd = IGEP2_RB_GPIO_WIFI_NPD;
-		wreset = IGEP2_RB_GPIO_WIFI_NRESET;
-		btreset = IGEP2_RB_GPIO_BT_NRESET;
+		igep2_wlan_bt_gpios[0].gpio = IGEP2_RB_GPIO_WIFI_NPD;
+		igep2_wlan_bt_gpios[1].gpio = IGEP2_RB_GPIO_WIFI_NRESET;
+		igep2_wlan_bt_gpios[2].gpio = IGEP2_RB_GPIO_BT_NRESET;
 	} else if (hwrev == IGEP2_BOARD_HWREV_C) {
-		npd = IGEP2_RC_GPIO_WIFI_NPD;
-		wreset = IGEP2_RC_GPIO_WIFI_NRESET;
-		btreset = IGEP2_RC_GPIO_BT_NRESET;
+		igep2_wlan_bt_gpios[0].gpio = IGEP2_RC_GPIO_WIFI_NPD;
+		igep2_wlan_bt_gpios[1].gpio = IGEP2_RC_GPIO_WIFI_NRESET;
+		igep2_wlan_bt_gpios[2].gpio = IGEP2_RC_GPIO_BT_NRESET;
 	} else
 		return;
 
-	/* Set GPIO's for  WLAN-BT combo module */
-	if ((gpio_request(npd, "GPIO_WIFI_NPD") == 0) &&
-	    (gpio_direction_output(npd, 1) == 0)) {
-		gpio_export(npd, 0);
-	} else
-		pr_warning("IGEP2: Could not obtain gpio GPIO_WIFI_NPD\n");
-
-	if ((gpio_request(wreset, "GPIO_WIFI_NRESET") == 0) &&
-	    (gpio_direction_output(wreset, 1) == 0)) {
-		gpio_export(wreset, 0);
-		gpio_set_value(wreset, 0);
-		udelay(10);
-		gpio_set_value(wreset, 1);
-	} else
-		pr_warning("IGEP2: Could not obtain gpio GPIO_WIFI_NRESET\n");
+	err = gpio_request_array(igep2_wlan_bt_gpios,
+				 ARRAY_SIZE(igep2_wlan_bt_gpios));
+	if (err) {
+		pr_warning("IGEP2: Could not obtain WIFI/BT gpios\n");
+		return;
+	}
+
+	gpio_export(igep2_wlan_bt_gpios[0].gpio, 0);
+	gpio_export(igep2_wlan_bt_gpios[1].gpio, 0);
+	gpio_export(igep2_wlan_bt_gpios[2].gpio, 0);
+
+	gpio_set_value(igep2_wlan_bt_gpios[1].gpio, 0);
+	udelay(10);
+	gpio_set_value(igep2_wlan_bt_gpios[1].gpio, 1);
 
-	if ((gpio_request(btreset, "GPIO_BT_NRESET") == 0) &&
-	    (gpio_direction_output(btreset, 1) == 0)) {
-		gpio_export(btreset, 0);
-	} else
-		pr_warning("IGEP2: Could not obtain gpio GPIO_BT_NRESET\n");
 }
 #else
 static inline void __init igep2_wlan_bt_init(void) { }
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 2cf86c3..fe9b029 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -268,49 +268,43 @@ static void __init igep3_leds_init(void)
 }
 
 #else
+static struct gpio igep3_gpio_leds[] __initdata = {
+	{ IGEP3_GPIO_LED0_RED,	 GPIOF_OUT_INIT_HIGH, "gpio-led:red:d0"	  },
+	{ IGEP3_GPIO_LED0_GREEN, GPIOF_OUT_INIT_HIGH, "gpio-led:green:d0" },
+	{ IGEP3_GPIO_LED1_RED,	 GPIOF_OUT_INIT_HIGH, "gpio-led:red:d1"	  },
+};
+
 static inline void igep3_leds_init(void)
 {
-	if ((gpio_request(IGEP3_GPIO_LED0_RED, "gpio-led:red:d0") == 0) &&
-	    (gpio_direction_output(IGEP3_GPIO_LED0_RED, 1) == 0)) {
-		gpio_export(IGEP3_GPIO_LED0_RED, 0);
-		gpio_set_value(IGEP3_GPIO_LED0_RED, 1);
-	} else
-		pr_warning("IGEP3: Could not obtain gpio GPIO_LED0_RED\n");
-
-	if ((gpio_request(IGEP3_GPIO_LED0_GREEN, "gpio-led:green:d0") == 0) &&
-	    (gpio_direction_output(IGEP3_GPIO_LED0_GREEN, 1) == 0)) {
-		gpio_export(IGEP3_GPIO_LED0_GREEN, 0);
-		gpio_set_value(IGEP3_GPIO_LED0_GREEN, 1);
-	} else
-		pr_warning("IGEP3: Could not obtain gpio GPIO_LED0_GREEN\n");
-
-	if ((gpio_request(IGEP3_GPIO_LED1_RED, "gpio-led:red:d1") == 0) &&
-		(gpio_direction_output(IGEP3_GPIO_LED1_RED, 1) == 0)) {
-		gpio_export(IGEP3_GPIO_LED1_RED, 0);
-		gpio_set_value(IGEP3_GPIO_LED1_RED, 1);
-	} else
-		pr_warning("IGEP3: Could not obtain gpio GPIO_LED1_RED\n");
+	if (gpio_request_array(igep3_gpio_leds, ARRAY_SIZE(igep3_gpio_leds))) {
+		pr_warning("IGEP3: Could not obtain leds gpios\n");
+		return;
+	}
+	gpio_export(IGEP3_GPIO_LED0_RED, 0);
+	gpio_export(IGEP3_GPIO_LED0_GREEN, 0);
+	gpio_export(IGEP3_GPIO_LED1_RED, 0);
 }
 #endif
 
 static int igep3_twl4030_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap2_hsmmc_init(mmc);
+#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
+	int ret;
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
-#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
-	if ((gpio_request(gpio+TWL4030_GPIO_MAX+1, "gpio-led:green:d1") == 0)
-	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 1) == 0)) {
-		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
-		gpio_set_value(gpio + TWL4030_GPIO_MAX + 1, 0);
-	} else
+	ret = gpio_request_one(gpio + TWL4030_GPIO_MAX + 1, GPIOF_OUT_INIT_HIGH,
+			       "gpio-led:green:d1");
+	if (ret)
 		pr_warning("IGEP3: Could not obtain gpio GPIO_LED1_GREEN\n");
+	else
+		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
 #else
 	igep3_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
 #endif
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	mmc[0].gpio_cd = gpio + 0;
+	omap2_hsmmc_init(mmc);
 
 	return 0;
 };
@@ -373,35 +367,36 @@ static struct omap_musb_board_data musb_board_data = {
 };
 
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
+static struct gpio igep3_wlan_bt_gpios[] __initdata = {
+	{ IGEP3_GPIO_WIFI_NPD,	  GPIOF_OUT_INIT_HIGH, "GPIO_WIFI_NPD"	  },
+	{ IGEP3_GPIO_WIFI_NRESET, GPIOF_OUT_INIT_HIGH, "GPIO_WIFI_NRESET" },
+	{ IGEP3_GPIO_BT_NRESET,	  GPIOF_OUT_INIT_HIGH, "GPIO_BT_NRESET"	  },
+};
 
 static void __init igep3_wifi_bt_init(void)
 {
+	int err;
+
 	/* Configure MUX values for W-LAN + Bluetooth GPIO's */
 	omap_mux_init_gpio(IGEP3_GPIO_WIFI_NPD, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(IGEP3_GPIO_WIFI_NRESET, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(IGEP3_GPIO_BT_NRESET, OMAP_PIN_OUTPUT);
 
 	/* Set GPIO's for  W-LAN + Bluetooth combo module */
-	if ((gpio_request(IGEP3_GPIO_WIFI_NPD, "GPIO_WIFI_NPD") == 0) &&
-	    (gpio_direction_output(IGEP3_GPIO_WIFI_NPD, 1) == 0)) {
-		gpio_export(IGEP3_GPIO_WIFI_NPD, 0);
-	} else
-		pr_warning("IGEP3: Could not obtain gpio GPIO_WIFI_NPD\n");
-
-	if ((gpio_request(IGEP3_GPIO_WIFI_NRESET, "GPIO_WIFI_NRESET") == 0) &&
-	    (gpio_direction_output(IGEP3_GPIO_WIFI_NRESET, 1) == 0)) {
-		gpio_export(IGEP3_GPIO_WIFI_NRESET, 0);
-		gpio_set_value(IGEP3_GPIO_WIFI_NRESET, 0);
-		udelay(10);
-		gpio_set_value(IGEP3_GPIO_WIFI_NRESET, 1);
-	} else
-		pr_warning("IGEP3: Could not obtain gpio GPIO_WIFI_NRESET\n");
-
-	if ((gpio_request(IGEP3_GPIO_BT_NRESET, "GPIO_BT_NRESET") == 0) &&
-	    (gpio_direction_output(IGEP3_GPIO_BT_NRESET, 1) == 0)) {
-		gpio_export(IGEP3_GPIO_BT_NRESET, 0);
-	} else
-		pr_warning("IGEP3: Could not obtain gpio GPIO_BT_NRESET\n");
+	err = gpio_request_array(igep3_wlan_bt_gpios,
+				 ARRAY_SIZE(igep3_wlan_bt_gpios));
+	if (err) {
+		pr_warning("IGEP3: Could not obtain WIFI/BT gpios\n");
+		return;
+	}
+
+	gpio_export(IGEP3_GPIO_WIFI_NPD, 0);
+	gpio_export(IGEP3_GPIO_WIFI_NRESET, 0);
+	gpio_export(IGEP3_GPIO_BT_NRESET, 0);
+
+	gpio_set_value(IGEP3_GPIO_WIFI_NRESET, 0);
+	udelay(10);
+	gpio_set_value(IGEP3_GPIO_WIFI_NRESET, 1);
 }
 #else
 void __init igep3_wifi_bt_init(void) {}
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea9f049..e81042b 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -177,12 +177,11 @@ static int ts_gpio;
  */
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(ts_gpio, "ads7846 irq") < 0) {
-		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
+	if (gpio_request_one(ts_gpio, GPIOF_IN, "ads7846 irq") < 0) {
+		pr_err("%s: can't get ads746 pen down GPIO\n", __func__);
 		return;
 	}
 
-	gpio_direction_input(ts_gpio);
 	gpio_set_debounce(ts_gpio, 310);
 }
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 9ae6dff..8f604b6 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -109,14 +109,13 @@ static void __init n8x0_usb_init(void)
 	static char	announce[] __initdata = KERN_INFO "TUSB 6010\n";
 
 	/* PM companion chip power control pin */
-	ret = gpio_request(TUSB6010_GPIO_ENABLE, "TUSB6010 enable");
+	ret = gpio_request_one(TUSB6010_GPIO_ENABLE, GPIOF_OUT_INIT_LOW,
+			       "TUSB6010 enable");
 	if (ret != 0) {
 		printk(KERN_ERR "Could not get TUSB power GPIO%i\n",
 		       TUSB6010_GPIO_ENABLE);
 		return;
 	}
-	gpio_direction_output(TUSB6010_GPIO_ENABLE, 0);
-
 	tusb_set_power(0);
 
 	ret = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
@@ -255,22 +254,20 @@ static struct platform_device tahvo_usb_device = {
 	.id		= -1,
 };
 
+static struct gpio n8x0_cbus_gpios[] __initdata = {
+	{ 108, GPIOF_IN,  "RETU irq"  },
+	{ 111, GPIOF_IN,  "TAHVO irq" },
+};
+
 static void __init n8x0_cbus_init(void)
 {
-	int		ret;
+	int ret;
 
 	platform_device_register(&n8x0_cbus_device);
 
-	ret = gpio_request(108, "RETU irq");
-	if (ret < 0) {
-		pr_err("retu: Unable to reserve IRQ GPIO\n");
-		return;
-	}
-
-	ret = gpio_direction_input(108);
+	ret = gpio_request_array(n8x0_cbus_gpios, ARRAY_SIZE(n8x0_cbus_gpios));
 	if (ret < 0) {
-		pr_err("retu: Unable to change gpio direction\n");
-		gpio_free(108);
+		pr_err("retu/tahvo: Unable to reserve IRQ GPIOs\n");
 		return;
 	}
 
@@ -278,22 +275,6 @@ static void __init n8x0_cbus_init(void)
 	retu_resource[0].start = gpio_to_irq(108);
 	platform_device_register(&retu_device);
 
-	ret = gpio_request(111, "TAHVO irq");
-	if (ret) {
-		pr_err("tahvo: Unable to reserve IRQ GPIO\n");
-		gpio_free(108);
-		return;
-	}
-
-	/* Set the pin as input */
-	ret = gpio_direction_input(111);
-	if (ret) {
-		pr_err("tahvo: Unable to change direction\n");
-		gpio_free(108);
-		gpio_free(111);
-		return;
-	}
-
 	tahvo_resource[0].start = gpio_to_irq(111);
 	platform_device_register(&tahvo_device);
 	platform_device_register(&tahvo_usb_device);
@@ -605,8 +586,12 @@ static struct omap_mmc_platform_data mmc1_data = {
 
 static struct omap_mmc_platform_data *mmc_data[OMAP24XX_NR_MMC];
 
-static void __init n8x0_mmc_init(void)
+static struct gpio n810_emmc_gpios[] __initdata = {
+	{ N810_EMMC_VSD_GPIO, GPIOF_OUT_INIT_LOW,  "MMC slot 2 Vddf" },
+	{ N810_EMMC_VIO_GPIO, GPIOF_OUT_INIT_LOW,  "MMC slot 2 Vdd"  },
+};
 
+static void __init n8x0_mmc_init(void)
 {
 	int err;
 
@@ -623,27 +608,18 @@ static void __init n8x0_mmc_init(void)
 		mmc1_data.slots[1].ban_openended = 1;
 	}
 
-	err = gpio_request(N8X0_SLOT_SWITCH_GPIO, "MMC slot switch");
+	err = gpio_request_one(N8X0_SLOT_SWITCH_GPIO, GPIOF_OUT_INIT_LOW,
+			       "MMC slot switch");
 	if (err)
 		return;
 
-	gpio_direction_output(N8X0_SLOT_SWITCH_GPIO, 0);
-
 	if (machine_is_nokia_n810()) {
-		err = gpio_request(N810_EMMC_VSD_GPIO, "MMC slot 2 Vddf");
-		if (err) {
-			gpio_free(N8X0_SLOT_SWITCH_GPIO);
-			return;
-		}
-		gpio_direction_output(N810_EMMC_VSD_GPIO, 0);
-
-		err = gpio_request(N810_EMMC_VIO_GPIO, "MMC slot 2 Vdd");
+		err = gpio_request_array(n810_emmc_gpios,
+					 ARRAY_SIZE(n810_emmc_gpios));
 		if (err) {
 			gpio_free(N8X0_SLOT_SWITCH_GPIO);
-			gpio_free(N810_EMMC_VSD_GPIO);
 			return;
 		}
-		gpio_direction_output(N810_EMMC_VIO_GPIO, 0);
 	}
 
 	mmc_data[0] = &mmc1_data;
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 33007fd..dcd9ff1 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -79,6 +79,12 @@ static u8 omap3_beagle_get_rev(void)
 	return omap3_beagle_version;
 }
 
+static struct gpio omap3_beagle_rev_gpios[] __initdata = {
+	{ 171, GPIOF_IN, "rev_id_0"    },
+	{ 172, GPIOF_IN, "rev_id_1" },
+	{ 173, GPIOF_IN, "rev_id_2"    },
+};
+
 static void __init omap3_beagle_init_rev(void)
 {
 	int ret;
@@ -88,21 +94,13 @@ static void __init omap3_beagle_init_rev(void)
 	omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);
 
-	ret = gpio_request(171, "rev_id_0");
-	if (ret < 0)
-		goto fail0;
-
-	ret = gpio_request(172, "rev_id_1");
-	if (ret < 0)
-		goto fail1;
-
-	ret = gpio_request(173, "rev_id_2");
-	if (ret < 0)
-		goto fail2;
-
-	gpio_direction_input(171);
-	gpio_direction_input(172);
-	gpio_direction_input(173);
+	ret = gpio_request_array(omap3_beagle_rev_gpios,
+				 ARRAY_SIZE(omap3_beagle_rev_gpios));
+	if (ret < 0) {
+		printk(KERN_ERR "Unable to get revision detection GPIO pins\n");
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
+		return;
+	}
 
 	beagle_rev = gpio_get_value(171) | (gpio_get_value(172) << 1)
 			| (gpio_get_value(173) << 2);
@@ -128,18 +126,6 @@ static void __init omap3_beagle_init_rev(void)
 		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
 	}
-
-	return;
-
-fail2:
-	gpio_free(172);
-fail1:
-	gpio_free(171);
-fail0:
-	printk(KERN_ERR "Unable to get revision detection GPIO pins\n");
-	omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
-
-	return;
 }
 
 static struct mtd_partition omap3beagle_nand_partitions[] = {
@@ -243,13 +229,10 @@ static void __init beagle_display_init(void)
 {
 	int r;
 
-	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
-	if (r < 0) {
+	r = gpio_request_one(beagle_dvi_device.reset_gpio, GPIOF_OUT_INIT_LOW,
+			     "DVI reset");
+	if (r < 0)
 		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
-		return;
-	}
-
-	gpio_direction_output(beagle_dvi_device.reset_gpio, 0);
 }
 
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -276,7 +259,7 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	int r;
+	int r, usb_pwr_level;
 
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
 		mmc[0].gpio_wp = -EINVAL;
@@ -295,66 +278,46 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	beagle_vmmc1_supply.dev = mmc[0].dev;
 	beagle_vsim_supply.dev = mmc[0].dev;
 
-	/* REVISIT: need ehci-omap hooks for external VBUS
-	 * power switch and overcurrent detect
-	 */
-	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
-		r = gpio_request(gpio + 1, "EHCI_nOC");
-		if (!r) {
-			r = gpio_direction_input(gpio + 1);
-			if (r)
-				gpio_free(gpio + 1);
-		}
-		if (r)
-			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
-	}
-
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
 	 * high / others active low)
-	 */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
-		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
-	else
-		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
-
-	/* DVI reset GPIO is different between beagle revisions */
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
-		beagle_dvi_device.reset_gpio = 129;
-	else
-		beagle_dvi_device.reset_gpio = 170;
-
-	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
-	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
-
-	/*
-	 * gpio + 1 on Xm controls the TFP410's enable line (active low)
-	 * gpio + 2 control varies depending on the board rev as follows:
-	 * P7/P8 revisions(prototype): Camera EN
-	 * A2+ revisions (production): LDO (supplies DVI, serial, led blocks)
+	 * DVI reset GPIO is different between beagle revisions
 	 */
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
-		r = gpio_request(gpio + 1, "nDVI_PWR_EN");
-		if (!r) {
-			r = gpio_direction_output(gpio + 1, 0);
-			if (r)
-				gpio_free(gpio + 1);
-		}
+		usb_pwr_level = GPIOF_OUT_INIT_HIGH;
+		beagle_dvi_device.reset_gpio = 129;
+		/*
+		 * gpio + 1 on Xm controls the TFP410's enable line (active low)
+		 * gpio + 2 control varies depending on the board rev as below:
+		 * P7/P8 revisions(prototype): Camera EN
+		 * A2+ revisions (production): LDO (DVI, serial, led blocks)
+		 */
+		r = gpio_request_one(gpio + 1, GPIOF_OUT_INIT_LOW,
+				     "nDVI_PWR_EN");
 		if (r)
 			pr_err("%s: unable to configure nDVI_PWR_EN\n",
 				__func__);
-		r = gpio_request(gpio + 2, "DVI_LDO_EN");
-		if (!r) {
-			r = gpio_direction_output(gpio + 2, 1);
-			if (r)
-				gpio_free(gpio + 2);
-		}
+		r = gpio_request_one(gpio + 2, GPIOF_OUT_INIT_HIGH,
+				     "DVI_LDO_EN");
 		if (r)
 			pr_err("%s: unable to configure DVI_LDO_EN\n",
 				__func__);
+	} else {
+		usb_pwr_level = GPIOF_OUT_INIT_LOW;
+		beagle_dvi_device.reset_gpio = 170;
+		/*
+		 * REVISIT: need ehci-omap hooks for external VBUS
+		 * power switch and overcurrent detect
+		 */
+		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
+			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
 
+	gpio_request_one(gpio + TWL4030_GPIO_MAX, usb_pwr_level, "nEN_USB_PWR");
+
+	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
+	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
 	return 0;
 }
 
@@ -665,9 +628,8 @@ static void __init omap3_beagle_init(void)
 	omap_serial_init();
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(170, true);
+	gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
 
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3fc85c6..df43031 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -148,6 +148,15 @@ static inline void __init omap3evm_init_smsc911x(void) { return; }
 #define OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO	210
 #define OMAP3EVM_DVI_PANEL_EN_GPIO	199
 
+static struct gpio omap3_evm_dss_gpios[] __initdata = {
+	{ OMAP3EVM_LCD_PANEL_RESB,  GPIOF_OUT_INIT_HIGH, "lcd_panel_resb"  },
+	{ OMAP3EVM_LCD_PANEL_INI,   GPIOF_OUT_INIT_HIGH, "lcd_panel_ini"   },
+	{ OMAP3EVM_LCD_PANEL_QVGA,  GPIOF_OUT_INIT_LOW,  "lcd_panel_qvga"  },
+	{ OMAP3EVM_LCD_PANEL_LR,    GPIOF_OUT_INIT_HIGH, "lcd_panel_lr"    },
+	{ OMAP3EVM_LCD_PANEL_UD,    GPIOF_OUT_INIT_HIGH, "lcd_panel_ud"    },
+	{ OMAP3EVM_LCD_PANEL_ENVDD, GPIOF_OUT_INIT_LOW,  "lcd_panel_envdd" },
+};
+
 static int lcd_enabled;
 static int dvi_enabled;
 
@@ -155,61 +164,10 @@ static void __init omap3_evm_display_init(void)
 {
 	int r;
 
-	r = gpio_request(OMAP3EVM_LCD_PANEL_RESB, "lcd_panel_resb");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_panel_resb\n");
-		return;
-	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_RESB, 1);
-
-	r = gpio_request(OMAP3EVM_LCD_PANEL_INI, "lcd_panel_ini");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_panel_ini\n");
-		goto err_1;
-	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_INI, 1);
-
-	r = gpio_request(OMAP3EVM_LCD_PANEL_QVGA, "lcd_panel_qvga");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_panel_qvga\n");
-		goto err_2;
-	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_QVGA, 0);
-
-	r = gpio_request(OMAP3EVM_LCD_PANEL_LR, "lcd_panel_lr");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_panel_lr\n");
-		goto err_3;
-	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_LR, 1);
-
-	r = gpio_request(OMAP3EVM_LCD_PANEL_UD, "lcd_panel_ud");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_panel_ud\n");
-		goto err_4;
-	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_UD, 1);
-
-	r = gpio_request(OMAP3EVM_LCD_PANEL_ENVDD, "lcd_panel_envdd");
-	if (r) {
-		printk(KERN_ERR "failed to get lcd_panel_envdd\n");
-		goto err_5;
-	}
-	gpio_direction_output(OMAP3EVM_LCD_PANEL_ENVDD, 0);
-
-	return;
-
-err_5:
-	gpio_free(OMAP3EVM_LCD_PANEL_UD);
-err_4:
-	gpio_free(OMAP3EVM_LCD_PANEL_LR);
-err_3:
-	gpio_free(OMAP3EVM_LCD_PANEL_QVGA);
-err_2:
-	gpio_free(OMAP3EVM_LCD_PANEL_INI);
-err_1:
-	gpio_free(OMAP3EVM_LCD_PANEL_RESB);
-
+	r = gpio_request_array(omap3_evm_dss_gpios,
+			       ARRAY_SIZE(omap3_evm_dss_gpios));
+	if (r)
+		printk(KERN_ERR "failed to get lcd_panel_* gpios\n");
 }
 
 static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
@@ -399,7 +357,7 @@ static struct platform_device leds_gpio = {
 static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	int r;
+	int r, lcd_bl_en;
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
@@ -416,16 +374,14 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	 */
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
-	r = gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
-	if (!r)
-		r = gpio_direction_output(gpio + TWL4030_GPIO_MAX,
-			(get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) ? 1 : 0);
+	lcd_bl_en = get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2 ?
+		GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
+	r = gpio_request_one(gpio + TWL4030_GPIO_MAX, lcd_bl_en, "EN_LCD_BKL");
 	if (r)
 		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
 
 	/* gpio + 7 == DVI Enable */
-	gpio_request(gpio + 7, "EN_DVI");
-	gpio_direction_output(gpio + 7, 0);
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -632,10 +588,12 @@ static int __init omap3_evm_i2c_init(void)
 
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
+	int ret;
+
+	ret = gpio_request_one(OMAP3_EVM_TS_GPIO, GPIOF_IN, "ADS7846 pendown");
+	if (ret < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
-	gpio_direction_input(OMAP3_EVM_TS_GPIO);
 	gpio_set_debounce(OMAP3_EVM_TS_GPIO, 310);
 }
 
@@ -776,6 +734,11 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static struct gpio omap3_evm_ehci_gpios[] __initdata = {
+	{ OMAP3_EVM_EHCI_VBUS,	 GPIOF_OUT_INIT_HIGH,  "enable EHCI VBUS" },
+	{ OMAP3_EVM_EHCI_SELECT, GPIOF_OUT_INIT_LOW,   "select EHCI port" },
+};
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_get_revision();
@@ -802,16 +765,12 @@ static void __init omap3_evm_init(void)
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
 		/* enable EHCI VBUS using GPIO22 */
-		omap_mux_init_gpio(22, OMAP_PIN_INPUT_PULLUP);
-		gpio_request(OMAP3_EVM_EHCI_VBUS, "enable EHCI VBUS");
-		gpio_direction_output(OMAP3_EVM_EHCI_VBUS, 0);
-		gpio_set_value(OMAP3_EVM_EHCI_VBUS, 1);
-
+		omap_mux_init_gpio(OMAP3_EVM_EHCI_VBUS, OMAP_PIN_INPUT_PULLUP);
 		/* Select EHCI port on main board */
-		omap_mux_init_gpio(61, OMAP_PIN_INPUT_PULLUP);
-		gpio_request(OMAP3_EVM_EHCI_SELECT, "select EHCI port");
-		gpio_direction_output(OMAP3_EVM_EHCI_SELECT, 0);
-		gpio_set_value(OMAP3_EVM_EHCI_SELECT, 0);
+		omap_mux_init_gpio(OMAP3_EVM_EHCI_SELECT,
+				   OMAP_PIN_INPUT_PULLUP);
+		gpio_request_array(omap3_evm_ehci_gpios,
+				   ARRAY_SIZE(omap3_evm_ehci_gpios));
 
 		/* setup EHCI phy reset config */
 		omap_mux_init_gpio(21, OMAP_PIN_INPUT_PULLUP);
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 07dba88..9016f43 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -305,24 +305,13 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 
 	/* gpio + 13 drives 32kHz buffer for wifi module */
 	gpio_32khz = gpio + 13;
-	ret = gpio_request(gpio_32khz, "wifi 32kHz");
+	ret = gpio_request_one(gpio_32khz, GPIOF_OUT_INIT_HIGH, "wifi 32kHz");
 	if (ret < 0) {
 		pr_err("Cannot get GPIO line %d, ret=%d\n", gpio_32khz, ret);
-		goto fail;
-	}
-
-	ret = gpio_direction_output(gpio_32khz, 1);
-	if (ret < 0) {
-		pr_err("Cannot set GPIO line %d, ret=%d\n", gpio_32khz, ret);
-		goto fail_direction;
+		return -ENODEV;
 	}
 
 	return 0;
-
-fail_direction:
-	gpio_free(gpio_32khz);
-fail:
-	return -ENODEV;
 }
 
 static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
@@ -575,14 +564,10 @@ static void __init omap3pandora_ads7846_init(void)
 	int gpio = OMAP3_PANDORA_TS_GPIO;
 	int ret;
 
-	ret = gpio_request(gpio, "ads7846_pen_down");
-	if (ret < 0) {
+	ret = gpio_request_one(gpio, GPIOF_IN, "ads7846_pen_down");
+	if (ret < 0)
 		printk(KERN_ERR "Failed to request GPIO %d for "
 				"ads7846 pen down IRQ\n", gpio);
-		return;
-	}
-
-	gpio_direction_input(gpio);
 }
 
 static int ads7846_get_pendown_state(void)
@@ -639,14 +624,10 @@ static void __init pandora_wl1251_init(void)
 
 	memset(&pandora_wl1251_pdata, 0, sizeof(pandora_wl1251_pdata));
 
-	ret = gpio_request(PANDORA_WIFI_IRQ_GPIO, "wl1251 irq");
+	ret = gpio_request_one(PANDORA_WIFI_IRQ_GPIO, GPIOF_IN, "wl1251 irq");
 	if (ret < 0)
 		goto fail;
 
-	ret = gpio_direction_input(PANDORA_WIFI_IRQ_GPIO);
-	if (ret < 0)
-		goto fail_irq;
-
 	pandora_wl1251_pdata.irq = gpio_to_irq(PANDORA_WIFI_IRQ_GPIO);
 	if (pandora_wl1251_pdata.irq < 0)
 		goto fail_irq;
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 848016c..1a09b51 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -331,12 +331,11 @@ omap3stalker_twl_gpio_setup(struct device *dev,
 	 */
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	gpio_request_one(gpio + TWL4030_GPIO_MAX, GPIOF_OUT_INIT_LOW,
+			 "EN_LCD_BKL");
 
 	/* gpio + 7 == DVI Enable */
-	gpio_request(gpio + 7, "EN_DVI");
-	gpio_direction_output(gpio + 7, 0);
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, mmc0) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -500,11 +499,13 @@ static int __init omap3_stalker_i2c_init(void)
 #define OMAP3_STALKER_TS_GPIO	175
 static void ads7846_dev_init(void)
 {
-	if (gpio_request(OMAP3_STALKER_TS_GPIO, "ADS7846 pendown") < 0)
+	int ret, ts_gpio = OMAP3_STALKER_TS_GPIO;
+
+	ret = gpio_request_one(ts_gpio, GPIOF_OUT_INIT_HIGH, "ADS7846 pendown");
+	if (ret < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
-	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
-	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
+	gpio_set_debounce(ts_gpio, 310);
 }
 
 static int ads7846_get_pendown_state(void)
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 127cb17..7d04402 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -154,13 +154,11 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
-
-	gpio_request(gpio + 1, "EHCI_nOC");
-	gpio_direction_input(gpio + 1);
+	gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC");
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	gpio_request_one(gpio + TWL4030_GPIO_MAX, GPIOF_OUT_INIT_LOW,
+			 "nEN_USB_PWR");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
@@ -303,13 +301,12 @@ static int __init omap3_touchbook_i2c_init(void)
 
 static void __init omap3_ads7846_init(void)
 {
-	if (gpio_request(OMAP3_TS_GPIO, "ads7846_pen_down")) {
+	if (gpio_request_one(OMAP3_TS_GPIO, GPIOF_IN, "ads7846_pen_down")) {
 		printk(KERN_ERR "Failed to request GPIO %d for "
 				"ads7846 pen down IRQ\n", OMAP3_TS_GPIO);
 		return;
 	}
 
-	gpio_direction_input(OMAP3_TS_GPIO);
 	gpio_set_debounce(OMAP3_TS_GPIO, 310);
 }
 
@@ -481,15 +478,10 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
 static void omap3_touchbook_poweroff(void)
 {
-	int r;
+	int pwr_off = TB_KILL_POWER_GPIO;
 
-	r = gpio_request(TB_KILL_POWER_GPIO, "DVI reset");
-	if (r < 0) {
+	if (gpio_request_one(pwr_off, GPIOF_OUT_INIT_LOW, "DVI reset") < 0)
 		printk(KERN_ERR "Unable to get kill power GPIO\n");
-		return;
-	}
-
-	gpio_direction_output(TB_KILL_POWER_GPIO, 0);
 }
 
 static int __init early_touchbook_revision(char *p)
@@ -521,9 +513,8 @@ static void __init omap3_touchbook_init(void)
 	omap_serial_init();
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	gpio_request(176, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(176, true);
+	gpio_request_one(176, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
 
 	/* Touchscreen and accelerometer */
 	spi_register_board_info(omap3_ads7846_spi_board_info,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index f3a7b10..36c0ea2 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -111,6 +111,11 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+static struct gpio panda_ehci_gpios[] __initdata = {
+	{ GPIO_HUB_POWER,	GPIOF_OUT_INIT_LOW,  "hub_power"  },
+	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
+};
+
 static void __init omap4_ehci_init(void)
 {
 	int ret;
@@ -120,44 +125,27 @@ static void __init omap4_ehci_init(void)
 	phy_ref_clk = clk_get(NULL, "auxclk3_ck");
 	if (IS_ERR(phy_ref_clk)) {
 		pr_err("Cannot request auxclk3\n");
-		goto error1;
+		return;
 	}
 	clk_set_rate(phy_ref_clk, 19200000);
 	clk_enable(phy_ref_clk);
 
-	/* disable the power to the usb hub prior to init */
-	ret = gpio_request(GPIO_HUB_POWER, "hub_power");
+	/* disable the power to the usb hub prior to init and reset phy+hub */
+	ret = gpio_request_array(panda_ehci_gpios,
+				 ARRAY_SIZE(panda_ehci_gpios));
 	if (ret) {
-		pr_err("Cannot request GPIO %d\n", GPIO_HUB_POWER);
-		goto error1;
+		pr_err("Unable to initialize EHCI power/reset\n");
+		return;
 	}
-	gpio_export(GPIO_HUB_POWER, 0);
-	gpio_direction_output(GPIO_HUB_POWER, 0);
-	gpio_set_value(GPIO_HUB_POWER, 0);
 
-	/* reset phy+hub */
-	ret = gpio_request(GPIO_HUB_NRESET, "hub_nreset");
-	if (ret) {
-		pr_err("Cannot request GPIO %d\n", GPIO_HUB_NRESET);
-		goto error2;
-	}
+	gpio_export(GPIO_HUB_POWER, 0);
 	gpio_export(GPIO_HUB_NRESET, 0);
-	gpio_direction_output(GPIO_HUB_NRESET, 0);
-	gpio_set_value(GPIO_HUB_NRESET, 0);
 	gpio_set_value(GPIO_HUB_NRESET, 1);
 
 	usbhs_init(&usbhs_bdata);
 
 	/* enable power to hub */
 	gpio_set_value(GPIO_HUB_POWER, 1);
-	return;
-
-error2:
-	gpio_free(GPIO_HUB_POWER);
-error1:
-	pr_err("Unable to initialize EHCI power/reset\n");
-	return;
-
 }
 
 static struct omap_musb_board_data musb_board_data = {
@@ -651,27 +639,19 @@ static void omap4_panda_hdmi_mux_init(void)
 			OMAP_PIN_INPUT_PULLUP);
 }
 
+static struct gpio panda_hdmi_gpios[] = {
+	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_hpd"   },
+	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
+};
+
 static int omap4_panda_panel_enable_hdmi(struct omap_dss_device *dssdev)
 {
 	int status;
 
-	status = gpio_request_one(HDMI_GPIO_HPD, GPIOF_OUT_INIT_HIGH,
-							"hdmi_gpio_hpd");
-	if (status) {
-		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_HPD);
-		return status;
-	}
-	status = gpio_request_one(HDMI_GPIO_LS_OE, GPIOF_OUT_INIT_HIGH,
-							"hdmi_gpio_ls_oe");
-	if (status) {
-		pr_err("Cannot request GPIO %d\n", HDMI_GPIO_LS_OE);
-		goto error1;
-	}
-
-	return 0;
-
-error1:
-	gpio_free(HDMI_GPIO_HPD);
+	status = gpio_request_array(panda_hdmi_gpios,
+				    ARRAY_SIZE(panda_hdmi_gpios));
+	if (status)
+		pr_err("Cannot request HDMI GPIOs\n");
 
 	return status;
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 165e1fa..5f5be35 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -128,14 +128,14 @@ static struct platform_device vads7846_device = {
 
 static void __init overo_ads7846_init(void)
 {
-	if ((gpio_request(OVERO_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
-	    (gpio_direction_input(OVERO_GPIO_PENDOWN) == 0)) {
-		gpio_export(OVERO_GPIO_PENDOWN, 0);
-	} else {
+	int pendown = OVERO_GPIO_PENDOWN;
+
+	if (gpio_request_one(pendown, GPIOF_IN, "ADS7846_PENDOWN")) {
 		printk(KERN_ERR "could not obtain gpio for ADS7846_PENDOWN\n");
 		return;
 	}
 
+	gpio_export(pendown, 0);
 	platform_device_register(&vads7846_device);
 }
 
@@ -181,21 +181,20 @@ static int dvi_enabled;
 #define OVERO_GPIO_LCD_EN 144
 #define OVERO_GPIO_LCD_BL 145
 
+static struct gpio overo_dss_gpios[] __initdata = {
+	{ OVERO_GPIO_LCD_EN, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_EN" },
+	{ OVERO_GPIO_LCD_BL, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_BL" },
+};
+
 static void __init overo_display_init(void)
 {
-	if ((gpio_request(OVERO_GPIO_LCD_EN, "OVERO_GPIO_LCD_EN") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_LCD_EN, 1) == 0))
-		gpio_export(OVERO_GPIO_LCD_EN, 0);
-	else
-		printk(KERN_ERR "could not obtain gpio for "
-					"OVERO_GPIO_LCD_EN\n");
+	if (gpio_request_array(overo_dss_gpios, ARRAY_SIZE(overo_dss_gpios))) {
+		printk(KERN_ERR "could not obtain DSS control GPIOs\n");
+		return;
+	}
 
-	if ((gpio_request(OVERO_GPIO_LCD_BL, "OVERO_GPIO_LCD_BL") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_LCD_BL, 1) == 0))
-		gpio_export(OVERO_GPIO_LCD_BL, 0);
-	else
-		printk(KERN_ERR "could not obtain gpio for "
-					"OVERO_GPIO_LCD_BL\n");
+	gpio_export(OVERO_GPIO_LCD_EN, 0);
+	gpio_export(OVERO_GPIO_LCD_BL, 0);
 }
 
 static int overo_panel_enable_dvi(struct omap_dss_device *dssdev)
@@ -650,8 +649,15 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static struct gpio overo_bt_gpios[] __initdata = {
+	{ OVERO_GPIO_BT_XGATE,	GPIOF_OUT_INIT_LOW,	"lcd enable"    },
+	{ OVERO_GPIO_BT_NRESET, GPIOF_OUT_INIT_HIGH,	"lcd bl enable" },
+};
+
 static void __init overo_init(void)
 {
+	int ret;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	overo_i2c_init();
 	omap_display_init(&overo_dss_data);
@@ -670,9 +676,9 @@ static void __init overo_init(void)
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
-	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
-			  "OVERO_GPIO_W2W_NRESET") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) == 0)) {
+	ret = gpio_request_one(OVERO_GPIO_W2W_NRESET, GPIOF_OUT_INIT_HIGH,
+			       "OVERO_GPIO_W2W_NRESET");
+	if (ret == 0) {
 		gpio_export(OVERO_GPIO_W2W_NRESET, 0);
 		gpio_set_value(OVERO_GPIO_W2W_NRESET, 0);
 		udelay(10);
@@ -682,25 +688,20 @@ static void __init overo_init(void)
 					"OVERO_GPIO_W2W_NRESET\n");
 	}
 
-	if ((gpio_request(OVERO_GPIO_BT_XGATE, "OVERO_GPIO_BT_XGATE") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_BT_XGATE, 0) == 0))
+	ret = gpio_request_array(overo_bt_gpios, ARRAY_SIZE(overo_bt_gpios));
+	if (ret) {
+		pr_err("%s: could not obtain BT gpios\n", __func__);
+	} else {
 		gpio_export(OVERO_GPIO_BT_XGATE, 0);
-	else
-		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_BT_XGATE\n");
-
-	if ((gpio_request(OVERO_GPIO_BT_NRESET, "OVERO_GPIO_BT_NRESET") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_BT_NRESET, 1) == 0)) {
 		gpio_export(OVERO_GPIO_BT_NRESET, 0);
 		gpio_set_value(OVERO_GPIO_BT_NRESET, 0);
 		mdelay(6);
 		gpio_set_value(OVERO_GPIO_BT_NRESET, 1);
-	} else {
-		printk(KERN_ERR "could not obtain gpio for "
-					"OVERO_GPIO_BT_NRESET\n");
 	}
 
-	if ((gpio_request(OVERO_GPIO_USBH_CPEN, "OVERO_GPIO_USBH_CPEN") == 0) &&
-	    (gpio_direction_output(OVERO_GPIO_USBH_CPEN, 1) == 0))
+	ret = gpio_request_one(OVERO_GPIO_USBH_CPEN, GPIOF_OUT_INIT_HIGH,
+			       "OVERO_GPIO_USBH_CPEN");
+	if (ret == 0)
 		gpio_export(OVERO_GPIO_USBH_CPEN, 0);
 	else
 		printk(KERN_ERR "could not obtain gpio for "
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index bbcb677..d49c9ba 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -557,10 +557,8 @@ static __init void rx51_init_si4713(void)
 static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 {
 	/* FIXME this gpio setup is just a placeholder for now */
-	gpio_request(gpio + 6, "backlight_pwm");
-	gpio_direction_output(gpio + 6, 0);
-	gpio_request(gpio + 7, "speaker_en");
-	gpio_direction_output(gpio + 7, 1);
+	gpio_request_one(gpio + 6, GPIOF_OUT_INIT_LOW, "backlight_pwm");
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_HIGH, "speaker_en");
 
 	return 0;
 }
@@ -921,26 +919,20 @@ static void rx51_wl1251_set_power(bool enable)
 	gpio_set_value(RX51_WL1251_POWER_GPIO, enable);
 }
 
+static struct gpio rx51_wl1251_gpios[] __initdata = {
+	{ RX51_WL1251_POWER_GPIO, GPIOF_OUT_INIT_LOW,	"wl1251 power"	},
+	{ RX51_WL1251_IRQ_GPIO,	  GPIOF_IN,		"wl1251 irq"	},
+};
+
 static void __init rx51_init_wl1251(void)
 {
 	int irq, ret;
 
-	ret = gpio_request(RX51_WL1251_POWER_GPIO, "wl1251 power");
+	ret = gpio_request_array(rx51_wl1251_gpios,
+				 ARRAY_SIZE(rx51_wl1251_gpios));
 	if (ret < 0)
 		goto error;
 
-	ret = gpio_direction_output(RX51_WL1251_POWER_GPIO, 0);
-	if (ret < 0)
-		goto err_power;
-
-	ret = gpio_request(RX51_WL1251_IRQ_GPIO, "wl1251 irq");
-	if (ret < 0)
-		goto err_power;
-
-	ret = gpio_direction_input(RX51_WL1251_IRQ_GPIO);
-	if (ret < 0)
-		goto err_irq;
-
 	irq = gpio_to_irq(RX51_WL1251_IRQ_GPIO);
 	if (irq < 0)
 		goto err_irq;
@@ -952,10 +944,7 @@ static void __init rx51_init_wl1251(void)
 
 err_irq:
 	gpio_free(RX51_WL1251_IRQ_GPIO);
-
-err_power:
 	gpio_free(RX51_WL1251_POWER_GPIO);
-
 error:
 	printk(KERN_ERR "wl1251 board initialisation failed\n");
 	wl1251_pdata.set_power = NULL;
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 89a66db..1977733 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -76,13 +76,12 @@ static int __init rx51_video_init(void)
 		return 0;
 	}
 
-	if (gpio_request(RX51_LCD_RESET_GPIO, "LCD ACX565AKM reset")) {
+	if (gpio_request_one(RX51_LCD_RESET_GPIO, GPIOF_OUT_INIT_HIGH,
+			     "LCD ACX565AKM reset")) {
 		pr_err("%s failed to get LCD Reset GPIO\n", __func__);
 		return 0;
 	}
 
-	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
-
 	omap_display_init(&rx51_dss_board_info);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 2ee9ab9..6402e78 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -77,12 +77,9 @@ static inline void __init zoom_init_quaduart(void)
 
 	quart_gpio = ZOOM_QUADUART_GPIO;
 
-	if (gpio_request(quart_gpio, "TL16CP754C GPIO") < 0) {
+	if (gpio_request_one(quart_gpio, GPIOF_IN, "TL16CP754C GPIO") < 0)
 		printk(KERN_ERR "Failed to request GPIO%d for TL16CP754C\n",
 								quart_gpio);
-		return;
-	}
-	gpio_direction_input(quart_gpio);
 }
 
 static inline int omap_zoom_debugboard_detect(void)
@@ -92,12 +89,12 @@ static inline int omap_zoom_debugboard_detect(void)
 
 	debug_board_detect = ZOOM_SMSC911X_GPIO;
 
-	if (gpio_request(debug_board_detect, "Zoom debug board detect") < 0) {
+	if (gpio_request_one(debug_board_detect, GPIOF_IN,
+			     "Zoom debug board detect") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for Zoom debug"
 		"board detect\n", debug_board_detect);
 		return 0;
 	}
-	gpio_direction_input(debug_board_detect);
 
 	if (!gpio_get_value(debug_board_detect)) {
 		ret = 0;
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 37b84c2..ce53e82 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -21,34 +21,19 @@
 #define LCD_PANEL_RESET_GPIO_PILOT	55
 #define LCD_PANEL_QVGA_GPIO		56
 
+static struct gpio zoom_lcd_gpios[] __initdata = {
+	{ -EINVAL,		GPIOF_OUT_INIT_HIGH, "lcd reset" },
+	{ LCD_PANEL_QVGA_GPIO,	GPIOF_OUT_INIT_HIGH, "lcd qvga"	 },
+};
+
 static void zoom_lcd_panel_init(void)
 {
-	int ret;
-	unsigned char lcd_panel_reset_gpio;
-
-	lcd_panel_reset_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
+	zoom_lcd_gpios[0].gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
 			LCD_PANEL_RESET_GPIO_PROD :
 			LCD_PANEL_RESET_GPIO_PILOT;
 
-	ret = gpio_request(lcd_panel_reset_gpio, "lcd reset");
-	if (ret) {
-		pr_err("Failed to get LCD reset GPIO (gpio%d).\n",
-			lcd_panel_reset_gpio);
-		return;
-	}
-	gpio_direction_output(lcd_panel_reset_gpio, 1);
-
-	ret = gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
-	if (ret) {
-		pr_err("Failed to get LCD_PANEL_QVGA_GPIO (gpio%d).\n",
-			LCD_PANEL_QVGA_GPIO);
-		goto err0;
-	}
-	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
-
-	return;
-err0:
-	gpio_free(lcd_panel_reset_gpio);
+	if (gpio_request_array(zoom_lcd_gpios, ARRAY_SIZE(zoom_lcd_gpios)))
+		pr_err("%s: Failed to get LCD GPIOs.\n", __func__);
 }
 
 static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 8dee754..9fec1bf 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -276,13 +276,11 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	zoom_vsim_supply.dev = mmc[0].dev;
 	zoom_vmmc2_supply.dev = mmc[1].dev;
 
-	ret = gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd enable");
-	if (ret) {
+	ret = gpio_request_one(LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
+			       "lcd enable");
+	if (ret)
 		pr_err("Failed to get LCD_PANEL_ENABLE_GPIO (gpio%d).\n",
 				LCD_PANEL_ENABLE_GPIO);
-		return ret;
-	}
-	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
 
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 877c6f5..ba10c24 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -147,25 +147,24 @@ void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 			goto free1;
 	}
 
-	if (gpio_request(gpmc_cfg->gpio_irq, "SMC91X irq") < 0)
+	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "SMC91X irq") < 0)
 		goto free1;
 
-	gpio_direction_input(gpmc_cfg->gpio_irq);
 	gpmc_smc91x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
 
 	if (gpmc_cfg->gpio_pwrdwn) {
-		ret = gpio_request(gpmc_cfg->gpio_pwrdwn, "SMC91X powerdown");
+		ret = gpio_request_one(gpmc_cfg->gpio_pwrdwn,
+				       GPIOF_OUT_INIT_LOW, "SMC91X powerdown");
 		if (ret)
 			goto free2;
-		gpio_direction_output(gpmc_cfg->gpio_pwrdwn, 0);
 	}
 
 	if (gpmc_cfg->gpio_reset) {
-		ret = gpio_request(gpmc_cfg->gpio_reset, "SMC91X reset");
+		ret = gpio_request_one(gpmc_cfg->gpio_reset,
+				       GPIOF_OUT_INIT_LOW, "SMC91X reset");
 		if (ret)
 			goto free3;
 
-		gpio_direction_output(gpmc_cfg->gpio_reset, 0);
 		gpio_set_value(gpmc_cfg->gpio_reset, 1);
 		msleep(100);
 		gpio_set_value(gpmc_cfg->gpio_reset, 0);
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index e09374a..9970331 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -63,23 +63,22 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 	gpmc_smsc911x_resources[0].start = cs_mem_base + 0x0;
 	gpmc_smsc911x_resources[0].end = cs_mem_base + 0xff;
 
-	if (gpio_request(gpmc_cfg->gpio_irq, "smsc911x irq") < 0) {
+	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "smsc911x irq")) {
 		pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio_irq);
 		goto free1;
 	}
 
-	gpio_direction_input(gpmc_cfg->gpio_irq);
 	gpmc_smsc911x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
 
 	if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
-		ret = gpio_request(gpmc_cfg->gpio_reset, "smsc911x reset");
+		ret = gpio_request_one(gpmc_cfg->gpio_reset,
+				       GPIOF_OUT_INIT_HIGH, "smsc911x reset");
 		if (ret) {
 			pr_err("Failed to request reset GPIO%d\n",
 			       gpmc_cfg->gpio_reset);
 			goto free2;
 		}
 
-		gpio_direction_output(gpmc_cfg->gpio_reset, 1);
 		gpio_set_value(gpmc_cfg->gpio_reset, 0);
 		msleep(100);
 		gpio_set_value(gpmc_cfg->gpio_reset, 1);
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 8a3c05f..8dd26b7 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -293,12 +293,11 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 			);
 
 	/* IRQ */
-	status = gpio_request(irq, "TUSB6010 irq");
+	status = gpio_request_one(irq, GPIOF_IN, "TUSB6010 irq");
 	if (status < 0) {
 		printk(error, 3, status);
 		return status;
 	}
-	gpio_direction_input(irq);
 	tusb_resources[2].start = irq + IH_GPIO_BASE;
 
 	/* set up memory timings ... can speed them up later */
-- 
1.7.3.4

