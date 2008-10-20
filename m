From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH 3/3] [OMAPZOOM] INPUT: Switch LDP to use both TWL4030 and GPIO keypad drivers
Date: Mon, 20 Oct 2008 14:46:19 -0500
Message-ID: <200810201446.19658.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbYJTTqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 15:46:25 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9KJkKQH008904
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 14:46:25 -0500
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m9KJkJsh003069
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 14:46:19 -0500 (CDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The LDP uses both TWL4030 and GPIO's for its keypad inputs.
This patch changes the LDP board file to make use of both the TWL4030
and GPIO keypad drivers. 

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c |  131 +++++++++++++++++++++++++--------------
 1 files changed, 84 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 47a0ba2..290d469 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -226,15 +227,10 @@ static int ldp_twl4030_keymap[] = {
 	KEY(0, 0, KEY_1),
 	KEY(1, 0, KEY_2),
 	KEY(2, 0, KEY_3),
-	KEY(3, 0, KEY_ENTER),
-	KEY(4, 0, KEY_F1),
-	KEY(5, 0, KEY_F2),
 	KEY(0, 1, KEY_4),
 	KEY(1, 1, KEY_5),
 	KEY(2, 1, KEY_6),
 	KEY(3, 1, KEY_F5),
-	KEY(4, 1, KEY_F3),
-	KEY(5, 1, KEY_F4),
 	KEY(0, 2, KEY_7),
 	KEY(1, 2, KEY_8),
 	KEY(2, 2, KEY_9),
@@ -242,62 +238,103 @@ static int ldp_twl4030_keymap[] = {
 	KEY(0, 3, KEY_F7),
 	KEY(1, 3, KEY_0),
 	KEY(2, 3, KEY_F8),
-	KEY(0, 4, KEY_RIGHT),
-	KEY(1, 4, KEY_UP),
-	KEY(2, 4, KEY_DOWN),
-	KEY(3, 4, KEY_LEFT),
 	KEY(5, 4, KEY_MUTE),
 	KEY(4, 4, KEY_VOLUMEUP),
 	KEY(5, 5, KEY_VOLUMEDOWN),
 	0
 };
 
-#define GPIO_KEY(gpio, key)  ((gpio<<16) | (key))
-
-static unsigned int ldp_omap_gpio_keymap[] = {
-	GPIO_KEY(101, KEY_ENTER), /*select*/
-	GPIO_KEY(102, KEY_F1),    /*S7*/
-	GPIO_KEY(103, KEY_F2),    /*S3*/
-	GPIO_KEY(104, KEY_F3),    /*S1*/
-	GPIO_KEY(105, KEY_F4),    /*S2*/
-	GPIO_KEY(106, KEY_LEFT),  /*left*/
-	GPIO_KEY(107, KEY_RIGHT), /*right*/
-	GPIO_KEY(108, KEY_UP),    /*up*/
-	GPIO_KEY(109, KEY_DOWN),  /*down*/
-	0
-};
-
-/* OMAP3430 LDP Keymaps:
- * OMAP LDP uses both TWL4030 GPIO's and OMAP GPIO's to get key presses.
- * This is why there are two keymaps:
- *  - ldp_twl4030_keymap (TWL4030)
- *  - ldp_omap_gpio_keymap (OMAP GPIO's)
- * Unfortunately the input subsystem requires all the keymaps to be
- * listed in one place (.keymap) in order for a key to be a valid input.
- * This is why some keys appear in both keymaps.
- * If a key does appear in both keymaps then its entry in
- * ldp_twl4030_keymap is purely to keep the input subsystem happy and
- * its row/col values have no meaning.
- */
-static struct omap_kp_platform_data ldp_kp_data = {
+static struct twl4030_keypad_data ldp_kp_twl4030_data = {
 	.rows		= 6,
 	.cols		= 6,
-	.keymap 	= ldp_twl4030_keymap,
-	.keymapsize 	= ARRAY_SIZE(ldp_twl4030_keymap),
+	.keymap		= ldp_twl4030_keymap,
+	.keymapsize	= ARRAY_SIZE(ldp_twl4030_keymap),
 	.rep		= 1,
 	.irq		= TWL4030_MODIRQ_KEYPAD,
-	/* Use row_gpios as a way to pass the OMAP GPIO keymap pointer */
-	.row_gpios	= ldp_omap_gpio_keymap,
 };
 
-static struct platform_device ldp_kp_device = {
-	.name		= "omap_twl4030keypad",
-	.id		= -1,
+
+static struct gpio_keys_button ldp_gpio_keys_buttons[] = {
+	[0] = {
+		.code		= KEY_ENTER,
+		.gpio		= 101,
+		.desc		= "enter sw",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[1] = {
+		.code		= KEY_F1,
+		.gpio		= 102,
+		.desc		= "func 1",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[2] = {
+		.code		= KEY_F2,
+		.gpio		= 103,
+		.desc		= "func 2",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[3] = {
+		.code		= KEY_F3,
+		.gpio		= 104,
+		.desc		= "func 3",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[4] = {
+		.code		= KEY_F4,
+		.gpio		= 105,
+		.desc		= "func 4",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[5] = {
+		.code		= KEY_LEFT,
+		.gpio		= 106,
+		.desc		= "left sw",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[6] = {
+		.code		= KEY_RIGHT,
+		.gpio		= 107,
+		.desc		= "right sw",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[7] = {
+		.code		= KEY_UP,
+		.gpio		= 108,
+		.desc		= "up sw",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+	[8] = {
+		.code		= KEY_DOWN,
+		.gpio		= 109,
+		.desc		= "down sw",
+		.active_low = 1,
+		.debounce_interval = 30,
+	},
+};
+
+static struct gpio_keys_platform_data ldp_gpio_keys = {
+	.buttons		= ldp_gpio_keys_buttons,
+	.nbuttons		= ARRAY_SIZE(ldp_gpio_keys_buttons),
+	.rep			= 1,
+};
+
+static struct platform_device ldp_gpio_keys_device = {
+	.name		= "gpio-keys",
+	.id			= -1,
 	.dev		= {
-		.platform_data = &ldp_kp_data,
+		.platform_data	= &ldp_gpio_keys,
 	},
 };
 
+
 static int ts_gpio;
 
 static int __init msecure_init(void)
@@ -444,7 +481,7 @@ static struct spi_board_info ldp_spi_board_info[] __initdata = {
 
 static struct platform_device *ldp_devices[] __initdata = {
        &ldp_smc911x_device,
-       &ldp_kp_device,
+       &ldp_gpio_keys_device,
 };
 
 static inline void __init ldp_init_smc911x(void)
@@ -536,7 +573,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	.madc		= &ldp_madc_data,
 	.usb		= &ldp_usb_data,
 	.gpio		= &ldp_gpio_data,
-	//.keypad         = &sdp3430_kp_data,
+	.keypad		= &ldp_kp_twl4030_data,
 };
 
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
-- 
1.5.4.1

