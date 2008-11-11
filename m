From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH v2 5/6] OMAP_LDP: Add keypad support on ZOOM SDK
Date: Tue, 11 Nov 2008 19:50:57 +0800
Message-ID: <1226404258-13027-6-git-send-email-stanley.miao@windriver.com>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-2-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-3-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-4-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-5-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63307 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357AbYKKLpd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 06:45:33 -0500
In-Reply-To: <1226404258-13027-5-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: johnpol@2ka.mipt.ru

Support twl4030 keypad and gpio keys on ZOOM SDK.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-ldp.c             |  114 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/keypad.h    |    5 +
 drivers/input/keyboard/Kconfig              |    2 +-
 drivers/input/keyboard/gpio_keys.c          |    4 +
 drivers/input/keyboard/omap-twl4030keypad.c |    9 +-
 include/linux/gpio_keys.h                   |    1 +
 6 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e89f271..a8e63d7 100644
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
@@ -33,6 +34,7 @@
 #include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/common.h>
+#include <mach/keypad.h>
 #include <mach/gpmc.h>
 #include <mach/mmc.h>
 #include <mach/usb-musb.h>
@@ -72,6 +74,116 @@ static struct platform_device ldp_smc911x_device = {
 	.resource	= ldp_smc911x_resources,
 };
 
+static int ldp_twl4030_keymap[] = {
+	KEY(0, 0, KEY_1),
+	KEY(1, 0, KEY_2),
+	KEY(2, 0, KEY_3),
+	KEY(0, 1, KEY_4),
+	KEY(1, 1, KEY_5),
+	KEY(2, 1, KEY_6),
+	KEY(3, 1, KEY_F5),
+	KEY(0, 2, KEY_7),
+	KEY(1, 2, KEY_8),
+	KEY(2, 2, KEY_9),
+	KEY(3, 2, KEY_F6),
+	KEY(0, 3, KEY_F7),
+	KEY(1, 3, KEY_0),
+	KEY(2, 3, KEY_F8),
+	PERSISTENT_KEY(4, 5),
+	KEY(4, 4, KEY_VOLUMEUP),
+	KEY(5, 5, KEY_VOLUMEDOWN),
+	0
+};
+
+static struct twl4030_keypad_data ldp_kp_twl4030_data = {
+	.rows		= 6,
+	.cols		= 6,
+	.keymap		= ldp_twl4030_keymap,
+	.keymapsize	= ARRAY_SIZE(ldp_twl4030_keymap),
+	.rep		= 1,
+	.irq		= TWL4030_MODIRQ_KEYPAD,
+};
+
+static struct gpio_keys_button ldp_gpio_keys_buttons[] = {
+	[0] = {
+		.code			= KEY_ENTER,
+		.gpio			= 101,
+		.desc			= "enter sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[1] = {
+		.code			= KEY_F1,
+		.gpio			= 102,
+		.desc			= "func 1",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[2] = {
+		.code			= KEY_F2,
+		.gpio			= 103,
+		.desc			= "func 2",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[3] = {
+		.code			= KEY_F3,
+		.gpio			= 104,
+		.desc			= "func 3",
+		.active_low		= 1,
+		.debounce_interval 	= 30,
+	},
+	[4] = {
+		.code			= KEY_F4,
+		.gpio			= 105,
+		.desc			= "func 4",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[5] = {
+		.code			= KEY_LEFT,
+		.gpio			= 106,
+		.desc			= "left sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[6] = {
+		.code			= KEY_RIGHT,
+		.gpio			= 107,
+		.desc			= "right sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[7] = {
+		.code			= KEY_UP,
+		.gpio			= 108,
+		.desc			= "up sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[8] = {
+		.code			= KEY_DOWN,
+		.gpio			= 109,
+		.desc			= "down sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
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
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &ldp_gpio_keys,
+	},
+};
+
 static int ts_gpio;
 
 static int __init msecure_init(void)
@@ -200,6 +312,7 @@ static struct platform_device ldp_lcd_device = {
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_smc911x_device,
 	&ldp_lcd_device,
+	&ldp_gpio_keys_device,
 };
 
 static inline void __init ldp_init_smc911x(void)
@@ -374,6 +487,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	.usb		= &ldp_usb_data,
 	.power		= &sdp3430_t2scripts_data,
 	.gpio		= &ldp_gpio_data,
+	.keypad		= &ldp_kp_twl4030_data,
 };
 
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
diff --git a/arch/arm/plat-omap/include/mach/keypad.h b/arch/arm/plat-omap/include/mach/keypad.h
index ba1c95c..b7f270a 100644
--- a/arch/arm/plat-omap/include/mach/keypad.h
+++ b/arch/arm/plat-omap/include/mach/keypad.h
@@ -34,7 +34,12 @@ struct omap_kp_platform_data {
 #define GROUP_3		(3 << 16)
 #define GROUP_MASK	GROUP_3
 
+#define ROWCOL_MASK		0xFF000000
+#define KEY_PERSISTENT		0x00800000
+#define KEYNUM_MASK		0x00EFFFFF
 #define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
+#define PERSISTENT_KEY(col, row) (((col) << 28) | ((row) << 24) | \
+						KEY_PERSISTENT)
 
 #endif
 
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index e4d0436..c8abf13 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -261,7 +261,7 @@ config KEYBOARD_OMAP
 
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030 keypad support"
-	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP2EVM || MACH_OMAP_3430SDP || MACH_OMAP3EVM)
+	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP2EVM || MACH_OMAP_3430SDP || MACH_OMAP3EVM || MACH_OMAP_LDP)
 	help
 	  Say Y here if you want to use the OMAP TWL4030 keypad.
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 05f3f43..722529c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -98,6 +98,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
+	/* Enable auto repeat feature of Linux input subsystem */
+	if (pdata->rep)
+		set_bit(EV_REP, input->evbit);
+
 	ddata->input = input;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index d3e1d20..13c9c0a 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -38,14 +38,13 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/irq.h>
+#include <mach/keypad.h>
+
 #include "twl4030-keypad.h"
 
 #define PTV_PRESCALER		4
 
 #define MAX_ROWS		8 /* TWL4030 hardlimit */
-#define ROWCOL_MASK		0xFF000000
-#define KEYNUM_MASK		0x00FFFFFF
-#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
 
 /* Global variables */
 
@@ -101,7 +100,7 @@ static int omap_kp_find_key(struct omap_keypad *kp, int col, int row)
 	rc = KEY(col, row, 0);
 	for (i = 0; i < kp->keymapsize; i++)
 		if ((kp->keymap[i] & ROWCOL_MASK) == rc)
-			return kp->keymap[i] & KEYNUM_MASK;
+			return kp->keymap[i] & (KEYNUM_MASK | KEY_PERSISTENT);
 
 	return -EINVAL;
 }
@@ -189,6 +188,8 @@ static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
 				dev_warn(kp->dbg_dev,
 					"Spurious key event %d-%d\n",
 					 col, row);
+			else if (key & KEY_PERSISTENT)
+				continue;
 			else
 				input_report_key(kp->omap_twl4030kp, key,
 						 new_state[row] & (1 << col));
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ec6ecd7..1289fa7 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -15,6 +15,7 @@ struct gpio_keys_button {
 struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
+	unsigned int rep:1;		/* enable input subsystem auto repeat */
 };
 
 #endif
-- 
1.5.6.3

