From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP: zoom: Use pwm stack for lcd and keyboard backlight
Date: Mon, 11 Mar 2013 12:57:56 +0100
Message-ID: <1363003076-17360-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54939 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab3CKL6G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 07:58:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use pwm_leds driver for the keyboard light and pwm-backlight for the lcd
backlight control (instead of implementing the PWM driver part in the board
file).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-zoom-display.c     | 56 ----------------------------
 arch/arm/mach-omap2/board-zoom-peripherals.c | 53 +++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 8cef477..9a7174f 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/i2c/twl.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <video/omapdss.h>
@@ -49,59 +48,6 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 }
 
-/* Register offsets in TWL4030_MODULE_INTBR */
-#define TWL_INTBR_PMBR1	0xD
-#define TWL_INTBR_GPBR1	0xC
-
-/* Register offsets in TWL_MODULE_PWM */
-#define TWL_LED_PWMON	0x3
-#define TWL_LED_PWMOFF	0x4
-
-static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
-{
-#ifdef CONFIG_TWL4030_CORE
-	unsigned char c;
-	u8 mux_pwm, enb_pwm;
-
-	if (level > 100)
-		return -1;
-
-	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &mux_pwm, TWL_INTBR_PMBR1);
-	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &enb_pwm, TWL_INTBR_GPBR1);
-
-	if (level == 0) {
-		/* disable pwm1 output and clock */
-		enb_pwm = enb_pwm & 0xF5;
-		/* change pwm1 pin to gpio pin */
-		mux_pwm = mux_pwm & 0xCF;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR,
-					enb_pwm, TWL_INTBR_GPBR1);
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR,
-					mux_pwm, TWL_INTBR_PMBR1);
-		return 0;
-	}
-
-	if (!((enb_pwm & 0xA) && (mux_pwm & 0x30))) {
-		/* change gpio pin to pwm1 pin */
-		mux_pwm = mux_pwm | 0x30;
-		/* enable pwm1 output and clock*/
-		enb_pwm = enb_pwm | 0x0A;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR,
-					mux_pwm, TWL_INTBR_PMBR1);
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR,
-					enb_pwm, TWL_INTBR_GPBR1);
-	}
-
-	c = ((50 * (100 - level)) / 100) + 1;
-	twl_i2c_write_u8(TWL_MODULE_PWM, 0x7F, TWL_LED_PWMOFF);
-	twl_i2c_write_u8(TWL_MODULE_PWM, c, TWL_LED_PWMON);
-#else
-	pr_warn("Backlight not enabled\n");
-#endif
-
-	return 0;
-}
-
 static struct omap_dss_device zoom_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "NEC_8048_panel",
@@ -109,8 +55,6 @@ static struct omap_dss_device zoom_lcd_device = {
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= zoom_panel_enable_lcd,
 	.platform_disable	= zoom_panel_disable_lcd,
-	.max_backlight_level	= 100,
-	.set_backlight		= zoom_set_bl_intensity,
 };
 
 static struct omap_dss_device *zoom_dss_devices[] = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index cdc0c10..a90375d 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -22,6 +22,9 @@
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/omap-twl4030.h>
 #include <linux/usb/phy.h>
+#include <linux/pwm.h>
+#include <linux/leds_pwm.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -193,6 +196,53 @@ static struct platform_device omap_vwlan_device = {
 	},
 };
 
+static struct pwm_lookup zoom_pwm_lookup[] = {
+	PWM_LOOKUP("twl-pwm", 0, "leds_pwm", "zoom::keypad"),
+	PWM_LOOKUP("twl-pwm", 1, "pwm-backlight", "backlight"),
+};
+
+static struct led_pwm zoom_pwm_leds[] = {
+	{
+		.name		= "zoom::keypad",
+		.max_brightness	= 127,
+		.pwm_period_ns	= 7812500,
+	},
+};
+
+static struct led_pwm_platform_data zoom_pwm_data = {
+	.num_leds	= ARRAY_SIZE(zoom_pwm_leds),
+	.leds		= zoom_pwm_leds,
+};
+
+static struct platform_device zoom_leds_pwm = {
+	.name	= "leds_pwm",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &zoom_pwm_data,
+	},
+};
+
+static struct platform_pwm_backlight_data zoom_backlight_data = {
+	.pwm_id = 1,
+	.max_brightness = 127,
+	.dft_brightness = 127,
+	.pwm_period_ns = 7812500,
+};
+
+static struct platform_device zoom_backlight_pwm = {
+	.name   = "pwm-backlight",
+	.id     = -1,
+	.dev    = {
+		.platform_data = &zoom_backlight_data,
+	},
+};
+
+static struct platform_device *zoom_devices[] __initdata = {
+	&omap_vwlan_device,
+	&zoom_leds_pwm,
+	&zoom_backlight_pwm,
+};
+
 static struct wl12xx_platform_data omap_zoom_wlan_data __initdata = {
 	.board_ref_clock = WL12XX_REFCLOCK_26, /* 26 MHz */
 };
@@ -301,7 +351,8 @@ void __init zoom_peripherals_init(void)
 
 	omap_hsmmc_init(mmc);
 	omap_i2c_init();
-	platform_device_register(&omap_vwlan_device);
+	pwm_add_table(zoom_pwm_lookup, ARRAY_SIZE(zoom_pwm_lookup));
+	platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
 	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
 	usb_musb_init(NULL);
 	enable_board_wakeup_source();
-- 
1.8.1.5

