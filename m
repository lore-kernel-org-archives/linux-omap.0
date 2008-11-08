From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap git] osk5912:  Mistral eeprom support
Date: Fri, 7 Nov 2008 19:14:59 -0800
Message-ID: <200811071914.59884.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:33385 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751832AbYKHDPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 22:15:03 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

List the 4 Kbit I2C EEPROM included on the Mistral board.

Also add a comment about the hardware workaround needed to
properly support the WAKE button.  More info at

  http://elinux.org/OSK_Mistral_wakeup_button_mod

Still no support for the (optional) camera sensor.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap1/board-osk.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -262,10 +262,6 @@ static struct i2c_board_info __initdata 
 	{
 		I2C_BOARD_INFO("tlv320aic23", 0x1B),
 	},
-	/* TODO when driver support is ready:
-	 *  - on Mistral, 24c04 eeprom at 0x50
-	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
-	 */
 };
 
 static void __init osk_init_smc91x(void)
@@ -340,11 +336,28 @@ static struct omap_board_config_kernel o
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 
 #include <linux/input.h>
+#include <linux/i2c/at24.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
 #include <mach/keypad.h>
 
+static struct at24_platform_data at24c04 = {
+	.byte_len	= SZ_4K / 8,
+	.page_size	= 16,
+};
+
+static struct i2c_board_info __initdata mistral_i2c_board_info[] = {
+	{
+		/* NOTE:  powered from LCD supply */
+		I2C_BOARD_INFO("24c04", 0x50),
+		.platform_data	= &at24c04,
+	},
+	/* TODO when driver support is ready:
+	 *  - optionally ov9640 camera sensor at 0x30
+	 */
+};
+
 static const int osk_keymap[] = {
 	/* KEY(col, row, code) */
 	KEY(0, 0, KEY_F1),		/* SW4 */
@@ -491,7 +504,13 @@ static void __init osk_mistral_init(void
 	spi_register_board_info(mistral_boardinfo,
 			ARRAY_SIZE(mistral_boardinfo));
 
-	/* the sideways button (SW1) is for use as a "wakeup" button */
+	/* the sideways button (SW1) is for use as a "wakeup" button
+	 *
+	 * NOTE:  The Mistral board has the wakeup button (SW1) wired
+	 * to the LCD 3.3V rail, which is powered down during suspend.
+	 * To allow this button to wake up the omap, work around this
+	 * HW bug by rewiring SW1 to use the main 3.3V rail.
+	 */
 	omap_cfg_reg(N15_1610_MPUIO2);
 	if (gpio_request(OMAP_MPUIO(2), "wakeup") == 0) {
 		int ret = 0;
@@ -523,6 +542,9 @@ static void __init osk_mistral_init(void
 	if (gpio_request(2, "lcd_pwr") == 0)
 		gpio_direction_output(2, 1);
 
+	i2c_register_board_info(1, mistral_i2c_board_info,
+			ARRAY_SIZE(mistral_i2c_board_info));
+
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else
