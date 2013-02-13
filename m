From: Archit Taneja <archit@ti.com>
Subject: [PATCH 07/33] arm: omap: board-am3517: use generic dpi panel's gpio handling
Date: Wed, 13 Feb 2013 19:51:59 +0530
Message-ID: <1360765345-19312-8-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56522 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934024Ab3BMOXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:23:35 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>

The am3517 board file currently requests gpios required to configure the sharp
lq DPI panel, and provides platform_enable/disable callbacks to configure them.

These tasks have been moved to the generic dpi panel driver itself and shouldn't
be done in the board files.

Remove the gpio requests and the platform callbacks from the board file.
Add the gpio information to generic dpi panel's platform data so that it's
passed to the panel driver.

Note: It's not clear why the GPIOs were muxed as input signals in PULL down mode
in am3517_evm_display_init(). Also, only the LCD_PANEL_PWR was toggled in the
platform_enable/disable calls, the generic DPI panel driver will now toggle all
the three gpios on panel's disable/enable. We need to test if these changes to
see if they have any impact or not.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   63 ++++-----------------------------
 1 file changed, 6 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 2988049..eb245a6 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -120,63 +120,14 @@ static int __init am3517_evm_i2c_init(void)
 	return 0;
 }
 
-static int lcd_enabled;
-static int dvi_enabled;
-
-#if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
-		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
-static struct gpio am3517_evm_dss_gpios[] __initdata = {
-	/* GPIO 182 = LCD Backlight Power */
-	{ LCD_PANEL_BKLIGHT_PWR, GPIOF_OUT_INIT_HIGH, "lcd_backlight_pwr" },
-	/* GPIO 181 = LCD Panel PWM */
-	{ LCD_PANEL_PWM,	 GPIOF_OUT_INIT_HIGH, "lcd bl enable"	  },
-	/* GPIO 176 = LCD Panel Power enable pin */
-	{ LCD_PANEL_PWR,	 GPIOF_OUT_INIT_HIGH, "dvi enable"	  },
-};
-
-static void __init am3517_evm_display_init(void)
-{
-	int r;
-
-	omap_mux_init_gpio(LCD_PANEL_PWR, OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_gpio(LCD_PANEL_BKLIGHT_PWR, OMAP_PIN_INPUT_PULLDOWN);
-	omap_mux_init_gpio(LCD_PANEL_PWM, OMAP_PIN_INPUT_PULLDOWN);
-
-	r = gpio_request_array(am3517_evm_dss_gpios,
-			       ARRAY_SIZE(am3517_evm_dss_gpios));
-	if (r) {
-		printk(KERN_ERR "failed to get DSS panel control GPIOs\n");
-		return;
-	}
-
-	printk(KERN_INFO "Display initialized successfully\n");
-}
-#else
-static void __init am3517_evm_display_init(void) {}
-#endif
-
-static int am3517_evm_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-	gpio_set_value(LCD_PANEL_PWR, 1);
-	lcd_enabled = 1;
-
-	return 0;
-}
-
-static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(LCD_PANEL_PWR, 0);
-	lcd_enabled = 0;
-}
-
 static struct panel_generic_dpi_data lcd_panel = {
 	.name			= "sharp_lq",
-	.platform_enable	= am3517_evm_panel_enable_lcd,
-	.platform_disable	= am3517_evm_panel_disable_lcd,
+	.num_gpios		= 3,
+	.gpios			= {
+		LCD_PANEL_PWR,
+		LCD_PANEL_BKLIGHT_PWR,
+		LCD_PANEL_PWM,
+	},
 };
 
 static struct omap_dss_device am3517_evm_lcd_device = {
@@ -362,8 +313,6 @@ static void __init am3517_evm_init(void)
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
 	usbhs_init(&usbhs_bdata);
 	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
-	/* DSS */
-	am3517_evm_display_init();
 
 	/* RTC - S35390A */
 	am3517_evm_rtc_init();
-- 
1.7.9.5

