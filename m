From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP1: osk5912: Mistral eeprom support
Date: Thu, 04 Dec 2008 18:31:36 -0800
Message-ID: <20081205023136.2992.29479.stgit@localhost>
References: <20081205022951.2992.97190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63746 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbYLECbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:31:38 -0500
In-Reply-To: <20081205022951.2992.97190.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

List the 4 Kbit I2C EEPROM included on the Mistral board.

Also add a comment about the hardware workaround needed to
properly support the WAKE button.  More info at

  http://elinux.org/OSK_Mistral_wakeup_button_mod

Still no support for the (optional) camera sensor.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 2f88095..4b7c1bc 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -260,7 +260,6 @@ static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 	},
 	/* TODO when driver support is ready:
 	 *  - aic23 audio chip at 0x1a
-	 *  - on Mistral, 24c04 eeprom at 0x50
 	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
 	 */
 };
@@ -337,11 +336,28 @@ static struct omap_board_config_kernel osk_config[] __initdata = {
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
@@ -488,7 +504,13 @@ static void __init osk_mistral_init(void)
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
@@ -521,6 +543,9 @@ static void __init osk_mistral_init(void)
 	if (gpio_request(2, "lcd_pwr") == 0)
 		gpio_direction_output(2, 1);
 
+	i2c_register_board_info(1, mistral_i2c_board_info,
+			ARRAY_SIZE(mistral_i2c_board_info));
+
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else

