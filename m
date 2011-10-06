From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2: Fix H4 matrix keyboard warning
Date: Thu, 6 Oct 2011 15:44:35 -0700
Message-ID: <20111006224435.GV6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751998Ab1JFWoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 18:44:38 -0400
Received: from c-98-234-237-12.hsd1.ca.comcast.net ([98.234.237.12] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)
	(envelope-from <tony@atomide.com>)
	id 1RBwg9-000E2t-9p
	for linux-omap@vger.kernel.org; Thu, 06 Oct 2011 22:44:37 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Convert to use matrix keyboard to remove the warning
"Please update the board to use matrix-keypad driver".

Based on similar setup in palmtc.c. Note that this
patch is compile tested only because of lack of working
hardware.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -35,7 +36,6 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/keypad.h>
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
@@ -48,10 +48,8 @@
 
 #define H4_ETHR_GPIO_IRQ		92
 
-static unsigned int row_gpios[6] = { 88, 89, 124, 11, 6, 96 };
-static unsigned int col_gpios[7] = { 90, 91, 100, 36, 12, 97, 98 };
-
-static const unsigned int h4_keymap[] = {
+#if defined(CONFIG_KEYBOARD_MATRIX) || defined(CONFIG_KEYBOARD_MATRIX_MODULE)
+static const uint32_t board_matrix_keys[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(1, 0, KEY_RIGHT),
 	KEY(2, 0, KEY_A),
@@ -84,6 +82,71 @@ static const unsigned int h4_keymap[] = {
 	KEY(4, 5, KEY_ENTER),
 };
 
+static const struct matrix_keymap_data board_keymap_data = {
+	.keymap			= board_matrix_keys,
+	.keymap_size		= ARRAY_SIZE(board_matrix_keys),
+};
+
+static unsigned int board_keypad_row_gpios[] = {
+	88, 89, 124, 11, 6, 96
+};
+
+static unsigned int board_keypad_col_gpios[] = {
+	90, 91, 100, 36, 12, 97, 98
+};
+
+static struct matrix_keypad_platform_data board_keypad_platform_data = {
+	.keymap_data	= &board_keymap_data,
+	.row_gpios	= board_keypad_row_gpios,
+	.num_row_gpios	= ARRAY_SIZE(board_keypad_row_gpios),
+	.col_gpios	= board_keypad_col_gpios,
+	.num_col_gpios	= ARRAY_SIZE(board_keypad_col_gpios),
+	.active_low	= 1,
+
+	.debounce_ms		= 20,
+	.col_scan_delay_us	= 5,
+};
+
+static struct platform_device board_keyboard = {
+	.name	= "matrix-keypad",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &board_keypad_platform_data,
+	},
+};
+static void __init board_mkp_init(void)
+{
+	omap_mux_init_gpio(88, OMAP_PULL_ENA | OMAP_PULL_UP);
+	omap_mux_init_gpio(89, OMAP_PULL_ENA | OMAP_PULL_UP);
+	omap_mux_init_gpio(124, OMAP_PULL_ENA | OMAP_PULL_UP);
+	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);
+	if (omap_has_menelaus()) {
+		omap_mux_init_signal("sdrc_a14.gpio0",
+			OMAP_PULL_ENA | OMAP_PULL_UP);
+		omap_mux_init_signal("vlynq_rx0.gpio_15", 0);
+		omap_mux_init_signal("gpio_98", 0);
+		board_keypad_row_gpios[5] = 0;
+		board_keypad_col_gpios[2] = 15;
+		board_keypad_col_gpios[6] = 18;
+	} else {
+		omap_mux_init_signal("gpio_96", OMAP_PULL_ENA | OMAP_PULL_UP);
+		omap_mux_init_signal("gpio_100", 0);
+		omap_mux_init_signal("gpio_98", 0);
+	}
+	omap_mux_init_signal("gpio_90", 0);
+	omap_mux_init_signal("gpio_91", 0);
+	omap_mux_init_signal("gpio_36", 0);
+	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
+	omap_mux_init_signal("gpio_97", 0);
+
+	platform_device_register(&board_keyboard);
+}
+#else
+static inline void board_mkp_init(void)
+{
+}
+#endif
+
 static struct mtd_partition h4_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -135,28 +198,6 @@ static struct platform_device h4_flash_device = {
 	.resource	= &h4_flash_resource,
 };
 
-static const struct matrix_keymap_data h4_keymap_data = {
-	.keymap		= h4_keymap,
-	.keymap_size	= ARRAY_SIZE(h4_keymap),
-};
-
-static struct omap_kp_platform_data h4_kp_data = {
-	.rows		= 6,
-	.cols		= 7,
-	.keymap_data	= &h4_keymap_data,
-	.rep		= true,
-	.row_gpios 	= row_gpios,
-	.col_gpios 	= col_gpios,
-};
-
-static struct platform_device h4_kp_device = {
-	.name		= "omap-keypad",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &h4_kp_data,
-	},
-};
-
 static struct platform_device h4_lcd_device = {
 	.name		= "lcd_h4",
 	.id		= -1,
@@ -164,7 +205,6 @@ static struct platform_device h4_lcd_device = {
 
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_flash_device,
-	&h4_kp_device,
 	&h4_lcd_device,
 };
 
@@ -329,31 +369,7 @@ static void __init omap_h4_init(void)
 	 * if not needed.
 	 */
 
-#if defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
-	omap_mux_init_gpio(88, OMAP_PULL_ENA | OMAP_PULL_UP);
-	omap_mux_init_gpio(89, OMAP_PULL_ENA | OMAP_PULL_UP);
-	omap_mux_init_gpio(124, OMAP_PULL_ENA | OMAP_PULL_UP);
-	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);
-	if (omap_has_menelaus()) {
-		omap_mux_init_signal("sdrc_a14.gpio0",
-			OMAP_PULL_ENA | OMAP_PULL_UP);
-		omap_mux_init_signal("vlynq_rx0.gpio_15", 0);
-		omap_mux_init_signal("gpio_98", 0);
-		row_gpios[5] = 0;
-		col_gpios[2] = 15;
-		col_gpios[6] = 18;
-	} else {
-		omap_mux_init_signal("gpio_96", OMAP_PULL_ENA | OMAP_PULL_UP);
-		omap_mux_init_signal("gpio_100", 0);
-		omap_mux_init_signal("gpio_98", 0);
-	}
-	omap_mux_init_signal("gpio_90", 0);
-	omap_mux_init_signal("gpio_91", 0);
-	omap_mux_init_signal("gpio_36", 0);
-	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
-	omap_mux_init_signal("gpio_97", 0);
-#endif
-
+	board_mkp_init();
 	i2c_register_board_info(1, h4_i2c_board_info,
 			ARRAY_SIZE(h4_i2c_board_info));
 
