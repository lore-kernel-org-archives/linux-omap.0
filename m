From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 04/23] i2c: move twl4030_keypad to new style registration
Date: Tue, 30 Sep 2008 13:05:41 +0300
Message-ID: <1222769160-31615-5-git-send-email-felipe.balbi@nokia.com>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-2-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-3-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-4-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34941 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYI3KGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:06:44 -0400
In-Reply-To: <1222769160-31615-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

let twl4030-core.c take care of twl4030_keypad registration.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c         |   14 ++----
 arch/arm/mach-omap2/board-3430sdp.c         |   14 ++----
 arch/arm/mach-omap2/board-omap2evm.c        |   16 ++----
 arch/arm/mach-omap2/board-omap3evm.c        |   69 ++++++++++++--------------
 drivers/i2c/chips/twl4030-core.c            |   27 ++++++++++
 drivers/input/keyboard/omap-twl4030keypad.c |    8 ++--
 include/linux/i2c/twl4030.h                 |   10 ++++
 7 files changed, 86 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 3649a94..8c4c9dd 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -173,7 +173,7 @@ static int sdp2430_keymap[] = {
 	0
 };
 
-static struct omap_kp_platform_data sdp2430_kp_data = {
+static struct twl4030_keypad_data sdp2430_kp_data = {
 	.rows		= 5,
 	.cols		= 6,
 	.keymap		= sdp2430_keymap,
@@ -182,14 +182,6 @@ static struct omap_kp_platform_data sdp2430_kp_data = {
 	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
-static struct platform_device sdp2430_kp_device = {
-	.name		= "omap_twl4030keypad",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &sdp2430_kp_data,
-	},
-};
-
 static int __init msecure_init(void)
 {
 	int ret = 0;
@@ -216,7 +208,6 @@ out:
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_smc91x_device,
 	&sdp2430_flash_device,
-	&sdp2430_kp_device,
 	&sdp2430_lcd_device,
 };
 
@@ -356,6 +347,9 @@ static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 static struct twl4030_platform_data sdp2430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.keypad		= &sdp2430_kp_data,
 };
 
 static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4c60d7b..fe1ba4e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -110,7 +110,7 @@ static int sdp3430_keymap[] = {
 	0
 };
 
-static struct omap_kp_platform_data sdp3430_kp_data = {
+static struct twl4030_keypad_data sdp3430_kp_data = {
 	.rows		= 5,
 	.cols		= 6,
 	.keymap		= sdp3430_keymap,
@@ -119,14 +119,6 @@ static struct omap_kp_platform_data sdp3430_kp_data = {
 	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
-static struct platform_device sdp3430_kp_device = {
-	.name		= "omap_twl4030keypad",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &sdp3430_kp_data,
-	},
-};
-
 static int ts_gpio;
 
 static int __init msecure_init(void)
@@ -252,7 +244,6 @@ static struct platform_device sdp3430_lcd_device = {
 
 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_smc91x_device,
-	&sdp3430_kp_device,
 	&sdp3430_lcd_device,
 };
 
@@ -312,6 +303,9 @@ static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.keypad		= &sdp3430_kp_data,
 };
 
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap2evm.c b/arch/arm/mach-omap2/board-omap2evm.c
index 6ce7740..d2a3743 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -200,23 +200,15 @@ static int omap2evm_keymap[] = {
 	KEY(3, 3, KEY_P)
 };
 
-static struct omap_kp_platform_data omap2evm_kp_data = {
+static struct twl4030_keypad_data omap2evm_kp_data = {
 	.rows		= 4,
 	.cols		= 4,
-	.keymap 	= omap2evm_keymap,
+	.keymap		= omap2evm_keymap,
 	.keymapsize	= ARRAY_SIZE(omap2evm_keymap),
 	.rep		= 1,
 	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
-static struct platform_device omap2evm_kp_device = {
-	.name		= "omap_twl4030keypad",
-	.id		= -1,
-	.dev		= {
-				.platform_data = &omap2evm_kp_data,
-			},
-};
-
 static void __init omap2_evm_init_irq(void)
 {
 	omap2_init_common_hw(NULL);
@@ -237,6 +229,9 @@ static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
 static struct twl4030_platform_data omap2evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.keypad		= &omap2evm_kp_data,
 };
 
 static struct i2c_board_info __initdata omap2evm_i2c_boardinfo[] = {
@@ -259,7 +254,6 @@ static int __init omap2_evm_i2c_init(void)
 static struct platform_device *omap2_evm_devices[] __initdata = {
 	&omap2_evm_lcd_device,
 	&omap2evm_smc911x_device,
-	&omap2evm_kp_device,
 };
 
 static void __init omap2_evm_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6aa7e28..c4a969d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -90,9 +90,41 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static int omap3evm_keymap[] = {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_A),
+	KEY(0, 3, KEY_B),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_E),
+	KEY(1, 3, KEY_F),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_I),
+	KEY(2, 2, KEY_J),
+	KEY(2, 3, KEY_K),
+	KEY(3, 0, KEY_M),
+	KEY(3, 1, KEY_N),
+	KEY(3, 2, KEY_O),
+	KEY(3, 3, KEY_P)
+};
+
+static struct twl4030_keypad_data omap3evm_kp_data = {
+	.rows		= 4,
+	.cols		= 4,
+	.keymap		= omap3evm_keymap,
+	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
+	.rep		= 1,
+	.irq		= TWL4030_MODIRQ_KEYPAD,
+};
+
+
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.keypad		= &omap3evm_kp_data,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
@@ -168,42 +200,6 @@ struct spi_board_info omap3evm_spi_board_info[] = {
 	},
 };
 
-static int omap3evm_keymap[] = {
-	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_A),
-	KEY(0, 3, KEY_B),
-	KEY(1, 0, KEY_DOWN),
-	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_E),
-	KEY(1, 3, KEY_F),
-	KEY(2, 0, KEY_ENTER),
-	KEY(2, 1, KEY_I),
-	KEY(2, 2, KEY_J),
-	KEY(2, 3, KEY_K),
-	KEY(3, 0, KEY_M),
-	KEY(3, 1, KEY_N),
-	KEY(3, 2, KEY_O),
-	KEY(3, 3, KEY_P)
-};
-
-static struct omap_kp_platform_data omap3evm_kp_data = {
-	.rows		= 4,
-	.cols		= 4,
-	.keymap 	= omap3evm_keymap,
-	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
-	.rep		= 1,
-	.irq		= TWL4030_MODIRQ_KEYPAD,
-};
-
-static struct platform_device omap3evm_kp_device = {
-	.name		= "omap_twl4030keypad",
-	.id		= -1,
-	.dev		= {
-				.platform_data = &omap3evm_kp_data,
-			},
-};
-
 static void __init omap3_evm_init_irq(void)
 {
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
@@ -219,7 +215,6 @@ static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
-	&omap3evm_kp_device,
 	&omap3evm_smc911x_device,
 };
 
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index e55f49e..0a2d8fe 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -51,6 +51,12 @@
 #define twl_has_rtc()	false
 #endif
 
+#if defined(CONFIG_KEYBOARD_TWL4030) || defined(CONFIG_KEYBOARD_TWL4030_MODULE)
+#define twl_has_keypad()	true
+#else
+#define twl_has_keypad()	false
+#endif
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -674,6 +680,27 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
+	if (twl_has_keypad() && pdata->keypad) {
+		pdev = platform_device_alloc("twl4030_keypad", -1);
+		if (pdev) {
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
+			pdev->dev.parent = &twl->client->dev;
+			device_init_wakeup(&pdev->dev, 1);
+			status = platform_device_add_data(pdev, pdata->keypad,
+					sizeof(*pdata->keypad));
+			if (status < 0) {
+				platform_device_put(pdev);
+				goto err;
+			}
+			status = platform_device_add(pdev);
+			if (status < 0)
+				platform_device_put(pdev);
+		} else {
+			status = -ENOMEM;
+			goto err;
+		}
+	}
+
 err:
 	pr_err("failed to add twl4030's children\n");
 	return status;
diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 48f29d3..e6b34be 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -38,7 +38,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/irq.h>
-#include <mach/keypad.h>
 #include "twl4030-keypad.h"
 
 #define PTV_PRESCALER		4
@@ -46,6 +45,7 @@
 #define MAX_ROWS		8 /* TWL4030 hardlimit */
 #define ROWCOL_MASK		0xFF000000
 #define KEYNUM_MASK		0x00FFFFFF
+#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
 
 /* Global variables */
 
@@ -231,7 +231,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 	int i;
 	int ret = 0;
 	struct omap_keypad *kp;
-	struct omap_kp_platform_data *pdata = pdev->dev.platform_data;
+	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
 
 	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
 	if (!kp)
@@ -389,7 +389,7 @@ static struct platform_driver omap_kp_driver = {
 	.probe		= omap_kp_probe,
 	.remove		= __devexit_p(omap_kp_remove),
 	.driver		= {
-		.name	= "omap_twl4030keypad",
+		.name	= "twl4030_keypad",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -409,7 +409,7 @@ static void __exit omap_kp_exit(void)
 
 module_init(omap_kp_init);
 module_exit(omap_kp_exit);
-MODULE_ALIAS("platform:omap_twl4030keypad");
+MODULE_ALIAS("platform:twl4030_keypad");
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 2434ad0..0ac417c 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -52,8 +52,18 @@
 #define TWL4030_MODULE_RTC		0x14
 #define TWL4030_MODULE_SECURED_REG	0x15
 
+struct twl4030_keypad_data {
+	int rows;
+	int cols;
+	int *keymap;
+	int irq;
+	unsigned int keymapsize;
+	unsigned int rep:1;
+};
+
 struct twl4030_platform_data {
 	unsigned	irq_base, irq_end;
+	struct twl4030_keypad_data *keypad;
 
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
-- 
1.6.0.2.307.gc427

