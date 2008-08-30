From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 10/33] Add twl4030 keypad driver
Date: Sat, 30 Aug 2008 20:16:10 +0300
Message-ID: <1220116593-862-11-git-send-email-me@felipebalbi.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
 <1220116593-862-2-git-send-email-me@felipebalbi.com>
 <1220116593-862-3-git-send-email-me@felipebalbi.com>
 <1220116593-862-4-git-send-email-me@felipebalbi.com>
 <1220116593-862-5-git-send-email-me@felipebalbi.com>
 <1220116593-862-6-git-send-email-me@felipebalbi.com>
 <1220116593-862-7-git-send-email-me@felipebalbi.com>
 <1220116593-862-8-git-send-email-me@felipebalbi.com>
 <1220116593-862-9-git-send-email-me@felipebalbi.com>
 <1220116593-862-10-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36417 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYH3RUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:20:38 -0400
In-Reply-To: <1220116593-862-10-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c         |   59 ++++
 arch/arm/plat-omap/include/mach/keypad.h    |    1 +
 drivers/input/keyboard/Kconfig              |   10 +
 drivers/input/keyboard/Makefile             |    1 +
 drivers/input/keyboard/omap-twl4030keypad.c |  415 +++++++++++++++++++++++++++
 drivers/input/keyboard/twl4030-keypad.h     |   82 ++++++
 6 files changed, 568 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/omap-twl4030keypad.c
 create mode 100644 drivers/input/keyboard/twl4030-keypad.h

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index b72ca13..975318d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -19,6 +19,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 
@@ -32,6 +34,7 @@
 #include <mach/mux.h>
 #include <mach/board.h>
 #include <mach/common.h>
+#include <mach/keypad.h>
 #include <mach/gpmc.h>
 
 #include <asm/io.h>
@@ -114,8 +117,64 @@ static struct platform_device sdp2430_smc91x_device = {
 	.resource	= sdp2430_smc91x_resources,
 };
 
+/*
+ * Key mapping for 2430 SDP board
+ */
+
+static int sdp2430_keymap[] = {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_A),
+	KEY(0, 3, KEY_B),
+	KEY(0, 4, KEY_C),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_E),
+	KEY(1, 3, KEY_F),
+	KEY(1, 4, KEY_G),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_I),
+	KEY(2, 2, KEY_J),
+	KEY(2, 3, KEY_K),
+	KEY(2, 4, KEY_3),
+	KEY(3, 0, KEY_M),
+	KEY(3, 1, KEY_N),
+	KEY(3, 2, KEY_O),
+	KEY(3, 3, KEY_P),
+	KEY(3, 4, KEY_Q),
+	KEY(4, 0, KEY_R),
+	KEY(4, 1, KEY_4),
+	KEY(4, 2, KEY_T),
+	KEY(4, 3, KEY_U),
+	KEY(4, 4, KEY_D),
+	KEY(5, 0, KEY_V),
+	KEY(5, 1, KEY_W),
+	KEY(5, 2, KEY_L),
+	KEY(5, 3, KEY_S),
+	KEY(5, 4, KEY_H),
+	0
+};
+
+static struct omap_kp_platform_data sdp2430_kp_data = {
+	.rows		= 5,
+	.cols		= 6,
+	.keymap		= sdp2430_keymap,
+	.keymapsize	= ARRAY_SIZE(sdp2430_keymap),
+	.rep		= 1,
+	.irq		= TWL4030_MODIRQ_KEYPAD,
+};
+
+static struct platform_device sdp2430_kp_device = {
+	.name		= "omap_twl4030keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &sdp2430_kp_data,
+	},
+};
+
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_smc91x_device,
+	&sdp2430_kp_device,
 	&sdp2430_flash_device,
 };
 
diff --git a/arch/arm/plat-omap/include/mach/keypad.h b/arch/arm/plat-omap/include/mach/keypad.h
index 232923a..ba1c95c 100644
--- a/arch/arm/plat-omap/include/mach/keypad.h
+++ b/arch/arm/plat-omap/include/mach/keypad.h
@@ -14,6 +14,7 @@ struct omap_kp_platform_data {
 	int rows;
 	int cols;
 	int *keymap;
+	int irq;
 	unsigned int keymapsize;
 	unsigned int rep:1;
 	unsigned long delay;
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 53239cb..04e6c77 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -259,6 +259,16 @@ config KEYBOARD_OMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-keypad.
 
+config KEYBOARD_TWL4030
+	tristate "TI TWL4030 keypad support"
+	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP2EVM || MACH_OMAP_3430SDP || MACH_OMAP3EVM)
+	help
+	  Say Y here if you want to use the OMAP TWL4030 keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called omap-twl4030keypad. This driver depends on
+	  TWL4030 Core and TWL4030 GPIO I2C client driver
+
 config OMAP_PS2
 	tristate "TI OMAP Innovator 1510 PS/2 keyboard & mouse support"
 	depends on ARCH_OMAP15XX && MACH_OMAP_INNOVATOR
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 52e9b70..a19e04b 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_OMAP_PS2)			+= innovator_ps2.o
 obj-$(CONFIG_KEYBOARD_LM8323)		+= lm8323.o
+obj-$(CONFIG_KEYBOARD_TWL4030)		+= omap-twl4030keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
new file mode 100644
index 0000000..3893d63
--- /dev/null
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -0,0 +1,415 @@
+/*
+ * drivers/input/keyboard/omap-twl4030keypad.c
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Code re-written for 2430SDP by:
+ * Syed Mohammed Khasim <x0khasim@ti.com>
+ *
+ * Initial Code:
+ * Manjunatha G K <manjugk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
+#include <linux/irq.h>
+#include <mach/keypad.h>
+#include "twl4030-keypad.h"
+
+#define PTV_PRESCALER		4
+
+#define MAX_ROWS		8 /* TWL4030 hardlimit */
+#define ROWCOL_MASK		0xFF000000
+#define KEYNUM_MASK		0x00FFFFFF
+
+/* Global variables */
+
+struct omap_keypad {
+	int		*keymap;
+	unsigned int	keymapsize;
+	u16		kp_state[MAX_ROWS];
+	int		n_rows;
+	int		n_cols;
+	int		irq;
+
+	struct device	*dbg_dev;
+	struct input_dev *omap_twl4030kp;
+
+	/* sync read/write */
+	struct mutex	mutex;
+};
+
+static int twl4030_kpread(struct omap_keypad *kp,
+		u32 module, u8 *data, u32 reg, u8 num_bytes)
+{
+	int ret;
+
+	ret = twl4030_i2c_read(module, data, reg, num_bytes);
+	if (ret < 0) {
+		dev_warn(kp->dbg_dev,
+			"Couldn't read TWL4030: %X - ret %d[%x]\n",
+			 reg, ret, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int twl4030_kpwrite_u8(struct omap_keypad *kp,
+		u32 module, u8 data, u32 reg)
+{
+	int ret;
+
+	ret = twl4030_i2c_write_u8(module, data, reg);
+	if (ret < 0) {
+		dev_warn(kp->dbg_dev,
+			"Could not write TWL4030: %X - ret %d[%x]\n",
+			 reg, ret, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int omap_kp_find_key(struct omap_keypad *kp, int col, int row)
+{
+	int i, rc;
+
+	rc = KEY(col, row, 0);
+	for (i = 0; i < kp->keymapsize; i++)
+		if ((kp->keymap[i] & ROWCOL_MASK) == rc)
+			return kp->keymap[i] & KEYNUM_MASK;
+
+	return -EINVAL;
+}
+
+static inline u16 omap_kp_col_xlate(struct omap_keypad *kp, u8 col)
+{
+	/* If all bits in a row are active for all coloumns then
+	 * we have that row line connected to gnd. Mark this
+	 * key on as if it was on matrix position n_cols (ie
+	 * one higher than the size of the matrix).
+	 */
+	if (col == 0xFF)
+		return 1 << kp->n_cols;
+	else
+		return col & ((1 << kp->n_cols) - 1);
+}
+
+static int omap_kp_read_kp_matrix_state(struct omap_keypad *kp, u16 *state)
+{
+	u8 new_state[MAX_ROWS];
+	int row;
+	int ret = twl4030_kpread(kp, TWL4030_MODULE_KEYPAD,
+				 new_state, KEYP_FULL_CODE_7_0, kp->n_rows);
+	if (ret >= 0) {
+		for (row = 0; row < kp->n_rows; row++)
+			state[row] = omap_kp_col_xlate(kp, new_state[row]);
+	}
+	return ret;
+}
+
+static int omap_kp_is_in_ghost_state(struct omap_keypad *kp, u16 *key_state)
+{
+	int i;
+	u16 check = 0;
+
+	for (i = 0; i < kp->n_rows; i++) {
+		u16 col = key_state[i];
+
+		if ((col & check) && hweight16(col) > 1)
+			return 1;
+		check |= col;
+	}
+
+	return 0;
+}
+
+static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
+{
+	u16 new_state[MAX_ROWS];
+	int col, row;
+
+	if (release_all)
+		memset(new_state, 0, sizeof(new_state));
+	else {
+		/* check for any changes */
+		int ret = omap_kp_read_kp_matrix_state(kp, new_state);
+		if (ret < 0)	/* panic ... */
+			return;
+
+		if (omap_kp_is_in_ghost_state(kp, new_state))
+			return;
+	}
+
+	mutex_lock(&kp->mutex);
+
+	/* check for changes and print those */
+	for (row = 0; row < kp->n_rows; row++) {
+		int changed = new_state[row] ^ kp->kp_state[row];
+
+		if (!changed)
+			continue;
+
+		for (col = 0; col < kp->n_cols + 1; col++) {
+			int key;
+
+			if (!(changed & (1 << col)))
+				continue;
+
+			dev_dbg(kp->dbg_dev, "key [%d:%d] %s\n", row, col,
+				(new_state[row] & (1 << col)) ?
+				"press" : "release");
+
+			key = omap_kp_find_key(kp, col, row);
+			if (key < 0)
+				dev_warn(kp->dbg_dev,
+					"Spurious key event %d-%d\n",
+					 col, row);
+			else
+				input_report_key(kp->omap_twl4030kp, key,
+						 new_state[row] & (1 << col));
+		}
+		kp->kp_state[row] = new_state[row];
+	}
+
+	mutex_unlock(&kp->mutex);
+}
+
+/*
+ * Keypad interrupt handler
+ */
+static irqreturn_t do_kp_irq(int irq, void *_kp)
+{
+	struct omap_keypad *kp = _kp;
+	u8 reg;
+	int ret;
+
+	/* Read & Clear TWL4030 pending interrupt */
+	ret = twl4030_kpread(kp, TWL4030_MODULE_KEYPAD, &reg, KEYP_ISR1, 1);
+
+	/* Release all keys if I2C has gone bad or
+	 * the KEYP has gone to idle state */
+	if ((ret >= 0) && (reg & KEYP_IMR1_KP))
+		twl4030_kp_scan(kp, 0);
+	else
+		twl4030_kp_scan(kp, 1);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Registers keypad device with input sub system
+ * and configures TWL4030 keypad registers
+ */
+static int __init omap_kp_probe(struct platform_device *pdev)
+{
+	u8 reg;
+	int i;
+	int ret = 0;
+	struct omap_keypad *kp;
+	struct omap_kp_platform_data *pdata = pdev->dev.platform_data;
+
+	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
+	if (!kp)
+		return -ENOMEM;
+
+	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
+		dev_err(kp->dbg_dev, "No rows, cols or keymap from pdata\n");
+		kfree(kp);
+		return -EINVAL;
+	}
+
+	dev_set_drvdata(&pdev->dev, kp);
+
+	/* Get the debug Device */
+	kp->dbg_dev = &pdev->dev;
+
+	kp->omap_twl4030kp = input_allocate_device();
+	if (!kp->omap_twl4030kp) {
+		kfree(kp);
+		return -ENOMEM;
+	}
+
+	mutex_init(&kp->mutex);
+
+	kp->keymap = pdata->keymap;
+	kp->keymapsize = pdata->keymapsize;
+	kp->n_rows = pdata->rows;
+	kp->n_cols = pdata->cols;
+	kp->irq = pdata->irq;
+
+	/* setup input device */
+	set_bit(EV_KEY, kp->omap_twl4030kp->evbit);
+
+	/* Enable auto repeat feature of Linux input subsystem */
+	if (pdata->rep)
+		set_bit(EV_REP, kp->omap_twl4030kp->evbit);
+
+	for (i = 0; i < kp->keymapsize; i++)
+		set_bit(kp->keymap[i] & KEYNUM_MASK,
+				kp->omap_twl4030kp->keybit);
+
+	kp->omap_twl4030kp->name	= "omap_twl4030keypad";
+	kp->omap_twl4030kp->phys	= "omap_twl4030keypad/input0";
+	kp->omap_twl4030kp->dev.parent	= &pdev->dev;
+
+	kp->omap_twl4030kp->id.bustype	= BUS_HOST;
+	kp->omap_twl4030kp->id.vendor	= 0x0001;
+	kp->omap_twl4030kp->id.product	= 0x0001;
+	kp->omap_twl4030kp->id.version	= 0x0003;
+
+	kp->omap_twl4030kp->keycode	= kp->keymap;
+	kp->omap_twl4030kp->keycodesize	= sizeof(unsigned int);
+	kp->omap_twl4030kp->keycodemax	= kp->keymapsize;
+
+	ret = input_register_device(kp->omap_twl4030kp);
+	if (ret < 0) {
+		dev_err(kp->dbg_dev,
+			"Unable to register twl4030 keypad device\n");
+		goto err2;
+	}
+
+	/* Disable auto-repeat */
+	reg = KEYP_CTRL_NOAUTORPT;
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_CTRL);
+	if (ret < 0)
+		goto err3;
+
+	/* Enable TO rising and KP rising and falling edge detection */
+	reg = KEYP_EDR_KP_BOTH | KEYP_EDR_TO_RISING;
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_EDR);
+	if (ret < 0)
+		goto err3;
+
+	/* Set PTV prescaler Field */
+	reg = (PTV_PRESCALER << KEYP_LK_PTV_PTV_SHIFT);
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_LK_PTV);
+	if (ret < 0)
+		goto err3;
+
+	/* Set key debounce time to 20 ms */
+	i = KEYP_PERIOD_US(20000, PTV_PRESCALER);
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, i, KEYP_DEB);
+	if (ret < 0)
+		goto err3;
+
+	/* Set timeout period to 100 ms */
+	i = KEYP_PERIOD_US(200000, PTV_PRESCALER);
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
+				 (i & 0xFF), KEYP_TIMEOUT_L);
+	if (ret < 0)
+		goto err3;
+
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
+				 (i >> 8), KEYP_TIMEOUT_H);
+	if (ret < 0)
+		goto err3;
+
+	/* Enable Clear-on-Read */
+	reg = KEYP_SIH_CTRL_COR | KEYP_SIH_CTRL_PEND_DIS;
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
+				 reg, KEYP_SIH_CTRL);
+	if (ret < 0)
+		goto err3;
+
+	/*
+	 * This ISR will always execute in kernel thread context because of
+	 * the need to access the TWL4030 over the I2C bus.
+	 */
+	ret = request_irq(kp->irq, do_kp_irq, IRQF_DISABLED,
+			"TWL4030 Keypad", kp);
+	if (ret < 0) {
+		dev_info(kp->dbg_dev, "request_irq failed for irq no=%d\n",
+			kp->irq);
+		goto err3;
+	} else {
+		/* Enable KP and TO interrupts now. */
+		reg = ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
+		ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
+					 reg, KEYP_IMR1);
+		if (ret < 0)
+			goto err5;
+	}
+
+	ret = omap_kp_read_kp_matrix_state(kp, kp->kp_state);
+	if (ret < 0)
+		goto err4;
+
+	return ret;
+err5:
+	/* mask all events - we don't care about the result */
+	(void) twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, 0xff, KEYP_IMR1);
+err4:
+	free_irq(kp->irq, NULL);
+err3:
+	input_unregister_device(kp->omap_twl4030kp);
+err2:
+	input_free_device(kp->omap_twl4030kp);
+
+	return -ENODEV;
+}
+
+static int omap_kp_remove(struct platform_device *pdev)
+{
+	struct omap_keypad *kp = dev_get_drvdata(&pdev->dev);
+
+	free_irq(kp->irq, kp);
+	input_unregister_device(kp->omap_twl4030kp);
+	kfree(kp);
+
+	return 0;
+}
+
+
+static struct platform_driver omap_kp_driver = {
+	.probe		= omap_kp_probe,
+	.remove		= __devexit_p(omap_kp_remove),
+	.driver		= {
+		.name	= "omap_twl4030keypad",
+		.owner	= THIS_MODULE,
+	},
+};
+
+/*
+ * OMAP TWL4030 Keypad init
+ */
+static int __devinit omap_kp_init(void)
+{
+	return platform_driver_register(&omap_kp_driver);
+}
+
+static void __exit omap_kp_exit(void)
+{
+	platform_driver_unregister(&omap_kp_driver);
+}
+
+module_init(omap_kp_init);
+module_exit(omap_kp_exit);
+MODULE_ALIAS("platform:omap_twl4030keypad");
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/keyboard/twl4030-keypad.h b/drivers/input/keyboard/twl4030-keypad.h
new file mode 100644
index 0000000..b903a77
--- /dev/null
+++ b/drivers/input/keyboard/twl4030-keypad.h
@@ -0,0 +1,82 @@
+/*
+ * drivers/input/keyboard/twl4030-keypad.h
+ *
+ * Copyright (C) 2006-2007 Texas Instruments, Inc.
+ *
+ * Intial Code:
+ *	Syed Mohammed Khasim <x0khasim@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __TWL4030_KEYPAD_H__
+#define __TWL4030_KEYPAD_H__
+
+/* Register Definitions */
+#define KEYP_CTRL				0x00
+#define KEYP_DEB				0x01
+#define KEYP_LONG_KEY				0x02
+#define KEYP_LK_PTV				0x03
+#define KEYP_TIMEOUT_L				0x04
+#define KEYP_TIMEOUT_H				0x05
+#define KEYP_FULL_CODE_7_0			0x09
+#define KEYP_ISR1				0x11
+#define KEYP_IMR1				0x12
+#define KEYP_EDR				0x16
+#define KEYP_SIH_CTRL				0x17
+
+/* KEYP_CTRL_REG Fields */
+#define KEYP_CTRL_SOFT_NRST			0x01
+#define KEYP_CTRL_SOFTMODEN			0x02
+#define KEYP_CTRL_LK_EN				0x04
+#define KEYP_CTRL_TOE_EN			0x08
+#define KEYP_CTRL_TOLE_EN			0x10
+#define KEYP_CTRL_RP_EN				0x20
+#define KEYP_CTRL_KBD_ON			0x40
+
+
+#define KEYP_CTRL_NOAUTORPT			(KEYP_CTRL_SOFT_NRST |	\
+						 KEYP_CTRL_SOFTMODEN |	\
+						 KEYP_CTRL_TOE_EN |	\
+						 KEYP_CTRL_KBD_ON)
+
+/* KEYP_DEB, KEYP_LONG_KEY, KEYP_TIMEOUT_x*/
+#define KEYP_PERIOD_US(T, prescale)		(T / (31 << (prescale + 1)) - 1)
+
+/* KEYP_LK_PTV_REG Fields */
+#define KEYP_LK_PTV_PTV_SHIFT			5
+
+/* KEYP_IMR1 Fields */
+#define KEYP_IMR1_MIS				0x08
+#define KEYP_IMR1_TO				0x04
+#define KEYP_IMR1_LK				0x02
+#define KEYP_IMR1_KP				0x01
+
+/* KEYP_EDR Fields */
+#define KEYP_EDR_KP_FALLING			0x01
+#define KEYP_EDR_KP_RISING			0x02
+#define KEYP_EDR_KP_BOTH			0x03
+#define KEYP_EDR_LK_FALLING			0x04
+#define KEYP_EDR_LK_RISING			0x08
+#define KEYP_EDR_TO_FALLING			0x10
+#define KEYP_EDR_TO_RISING			0x20
+#define KEYP_EDR_MIS_FALLING			0x40
+#define KEYP_EDR_MIS_RISING			0x80
+
+/* KEYP_SIH_CTRL Fields */
+#define KEYP_SIH_CTRL_COR			0x04
+#define KEYP_SIH_CTRL_PEND_DIS			0x02
+#define KEYP_SIH_CTRL_EXCL_EN			0x01
+
+#endif	/* End of __TWL4030-KEYPAD_H__ */
-- 
1.6.0.1.141.g445ca

