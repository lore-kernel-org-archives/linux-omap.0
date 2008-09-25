From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/4] i2c: move twl4030_keypad to new style registration
Date: Thu, 25 Sep 2008 17:48:51 +0300
Message-ID: <1222354133-12919-3-git-send-email-felipe.balbi@nokia.com>
References: <1222354133-12919-1-git-send-email-felipe.balbi@nokia.com>
 <1222354133-12919-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22010 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbYIYOtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 10:49:12 -0400
In-Reply-To: <1222354133-12919-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

let twl4030-core.c take care of twl4030_keypad registration.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c         |   14 ++++----------
 arch/arm/mach-omap2/board-3430sdp.c         |   14 ++++----------
 arch/arm/mach-omap2/board-omap2evm.c        |   16 +++++-----------
 arch/arm/mach-omap2/board-omap3evm.c        |   16 +++++-----------
 drivers/i2c/chips/twl4030-core.c            |   21 +++++++++++++++++++++
 drivers/input/keyboard/omap-twl4030keypad.c |    6 +++---
 include/linux/i2c/twl4030.h                 |   16 ++++++++++++++++
 7 files changed, 58 insertions(+), 45 deletions(-)

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
index 6ce7740..350f147 100644
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
+	.keypad		= omap2evm_kp_data,
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
index 6aa7e28..a9346b1 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -93,6 +93,9 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.keypad		= omap3evm_kp_data,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
@@ -187,23 +190,15 @@ static int omap3evm_keymap[] = {
 	KEY(3, 3, KEY_P)
 };
 
-static struct omap_kp_platform_data omap3evm_kp_data = {
+static struct twl4030_keypad_data omap3evm_kp_data = {
 	.rows		= 4,
 	.cols		= 4,
-	.keymap 	= omap3evm_keymap,
+	.keymap		= omap3evm_keymap,
 	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
 	.rep		= 1,
 	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
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
@@ -219,7 +214,6 @@ static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
-	&omap3evm_kp_device,
 	&omap3evm_smc911x_device,
 };
 
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index bbffc40..241752f 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -669,6 +669,27 @@ static int add_children(struct twl4030_platform_data *pdata)
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
index 48f29d3..eefdb78 100644
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
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index ff1dff4..246eef3 100644
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
@@ -151,4 +161,10 @@ int twl4030_free_gpio(int gpio);
 #define twl_has_rtc()	(0)
 #endif
 
+#if defined(CONFIG_KEYBOARD_TWL4030) || defined(CONFIG_KEYBOARD_TWL4030_MODULE)
+#define twl_has_keypad()	(1)
+#else
+#define twl_has_keypad()	(0)
+#endif
+
 #endif /* End of __TWL4030_H */
-- 
1.6.0.2.307.gc427

