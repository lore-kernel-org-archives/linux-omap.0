From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v4 1/4] OMAP4: Keyboard controller support
Date: Wed, 16 Jun 2010 11:08:50 -0500
Message-ID: <1276704530-30560-1-git-send-email-x0066660@ti.com>
References: <x0066660@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51026 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab0FPQIb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 12:08:31 -0400
In-Reply-To: <x0066660@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

OMAP4 keyboard controller includes:
  - built-in scanning algorithm
  - debouncing feature

Driver implementation is based on matrix_keypac.c

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/plat-omap/include/plat/omap4-keypad.h |   19 ++
 drivers/input/keyboard/Kconfig                 |   10 +
 drivers/input/keyboard/Makefile                |    1 +
 drivers/input/keyboard/omap4-keypad.c          |  288 ++++++++++++++++++++++++
 4 files changed, 318 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap4-keypad.h
 create mode 100644 drivers/input/keyboard/omap4-keypad.c

diff --git a/arch/arm/plat-omap/include/plat/omap4-keypad.h b/arch/arm/plat-omap/include/plat/omap4-keypad.h
new file mode 100644
index 0000000..d11c3ab
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/omap4-keypad.h
@@ -0,0 +1,19 @@
+#ifndef ARCH_ARM_PLAT_OMAP4_KEYPAD_H
+#define ARCH_ARM_PLAT_OMAP4_KEYPAD_H
+
+#include <linux/input/matrix_keypad.h>
+
+struct omap4_keypad_platform_data {
+	const struct matrix_keymap_data *keymap_data;
+
+	u8 rows;
+	u8 cols;
+
+	u16 irq;
+	void __iomem *base;
+};
+
+extern int omap4_init_kp(struct omap4_keypad_platform_data *kpd);
+
+#endif
+
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d8fa5d7..af5ef6e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -393,6 +393,16 @@ config KEYBOARD_OMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-keypad.
 
+config KEYBOARD_OMAP4
+	tristate "TI OMAP4 keypad support"
+	depends on ARCH_OMAP4
+	default n
+	help
+	  Say Y here if you want to use the OMAP4 keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called omap4-keypad.
+
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
 	depends on TWL4030_CORE
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 4596d0c..fe48826 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
+obj-$(CONFIG_KEYBOARD_OMAP4)		+= omap4-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
new file mode 100644
index 0000000..5e224f2
--- /dev/null
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -0,0 +1,288 @@
+/*
+ * OMAP4 Keypad Driver
+ *
+ * Copyright (C) 2010 Texas Instruments
+ *
+ * Author: Abraham Arce <x0066660@ti.com>
+ * Initial Code: Syed Rafiuddin <rafiuddin.syed@ti.com>
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
+#include <linux/platform_device.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+
+#include <plat/omap4-keypad.h>
+
+/* OMAP4 registers */
+#define OMAP4_KBD_REVISION		0x00
+#define OMAP4_KBD_SYSCONFIG		0x10
+#define OMAP4_KBD_SYSSTATUS		0x14
+#define OMAP4_KBD_IRQSTATUS		0x18
+#define OMAP4_KBD_IRQENABLE		0x1C
+#define OMAP4_KBD_WAKEUPENABLE		0x20
+#define OMAP4_KBD_PENDING		0x24
+#define OMAP4_KBD_CTRL			0x28
+#define OMAP4_KBD_DEBOUNCINGTIME	0x2C
+#define OMAP4_KBD_LONGKEYTIME		0x30
+#define OMAP4_KBD_TIMEOUT		0x34
+#define OMAP4_KBD_STATEMACHINE		0x38
+#define OMAP4_KBD_ROWINPUTS		0x3C
+#define OMAP4_KBD_COLUMNOUTPUTS		0x40
+#define OMAP4_KBD_FULLCODE31_0		0x44
+#define OMAP4_KBD_FULLCODE63_32		0x48
+
+/* OMAP4 bit definitions */
+#define OMAP4_DEF_SYSCONFIG_SOFTRST	(1 << 1)
+#define OMAP4_DEF_SYSCONFIG_ENAWKUP	(1 << 2)
+#define OMAP4_DEF_IRQENABLE_EVENTEN	(1 << 0)
+#define OMAP4_DEF_IRQENABLE_LONGKEY	(1 << 1)
+#define OMAP4_DEF_IRQENABLE_TIMEOUTEN	(1 << 2)
+#define OMAP4_DEF_CTRL_NOSOFTMODE	(1 << 1)
+#define OMAP4_DEF_CTRLPTVVALUE		(1 << 2)
+#define OMAP4_DEF_CTRLPTV		(1 << 1)
+#define OMAP4_DEF_IRQDISABLE		0x00
+
+/* OMAP4 values */
+#define OMAP4_VAL_DEBOUNCINGTIME	0x07
+#define OMAP4_VAL_FUNCTIONALCFG		0x1E
+
+#define OMAP4_MASK_IRQSTATUSDISABLE	0xFFFF
+
+struct omap4_keypad {
+	struct input_dev *input;
+
+	void __iomem *base;
+	int irq;
+
+	unsigned int rows;
+	unsigned int cols;
+	unsigned int row_shift;
+	unsigned char key_state[8];
+	unsigned short keymap[];
+};
+
+static void __devinit omap4_keypad_config(struct omap4_keypad *keypad_data)
+{
+	__raw_writel(OMAP4_DEF_SYSCONFIG_SOFTRST | OMAP4_DEF_SYSCONFIG_ENAWKUP,
+			keypad_data->base + OMAP4_KBD_SYSCONFIG);
+	__raw_writel(OMAP4_VAL_FUNCTIONALCFG,
+			keypad_data->base + OMAP4_KBD_CTRL);
+	__raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
+			keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
+	__raw_writel(OMAP4_DEF_IRQDISABLE,
+			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
+			keypad_data->base + OMAP4_KBD_IRQENABLE);
+}
+
+/* Interrupt handler */
+static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
+{
+	struct omap4_keypad *keypad_data = dev_id;
+	struct input_dev *input_dev = keypad_data->input;
+	unsigned char key_state[ARRAY_SIZE(keypad_data->key_state)];
+	unsigned int col, row, code, changed;
+	u32 *new_state = (u32 *) key_state;
+
+	/* Disable interrupts */
+	__raw_writel(OMAP4_DEF_IRQDISABLE,
+		     keypad_data->base + OMAP4_KBD_IRQENABLE);
+
+	*new_state = __raw_readl(keypad_data->base + OMAP4_KBD_FULLCODE31_0);
+	*(new_state + 1) = __raw_readl(keypad_data->base +
+						OMAP4_KBD_FULLCODE63_32);
+
+	for (row = 0; row < keypad_data->rows; row++) {
+		changed = key_state[row] ^ keypad_data->key_state[row];
+		if (!changed)
+			continue;
+
+		for (col = 0; col < keypad_data->cols; col++) {
+			if (changed & (1 << col)) {
+				code = MATRIX_SCAN_CODE(row, col,
+						keypad_data->row_shift);
+				input_event(input_dev, EV_MSC, MSC_SCAN, code);
+				input_report_key(input_dev,
+						 keypad_data->keymap[code],
+						 key_state[row] & (1 << col));
+			}
+		}
+	}
+
+	input_sync(input_dev);
+
+	memcpy(keypad_data->key_state, key_state,
+		sizeof(keypad_data->key_state));
+
+	/* clear pending interrupts */
+	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
+			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+
+	/* enable interrupts */
+	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
+			keypad_data->base + OMAP4_KBD_IRQENABLE);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit omap4_keypad_probe(struct platform_device *pdev)
+{
+	const struct omap4_keypad_platform_data *pdata;
+	struct omap4_keypad *keypad_data;
+	struct input_dev *input_dev;
+	unsigned int row_shift, max_keys;
+	int error;
+
+	/* platform data */
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->base) {
+		dev_err(&pdev->dev, "no base address specified\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->irq) {
+		dev_err(&pdev->dev, "no keyboard irq assigned\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->keymap_data) {
+		dev_err(&pdev->dev, "no keymap data defined\n");
+		return -EINVAL;
+	}
+
+	row_shift = get_count_order(pdata->cols);
+	max_keys = pdata->rows << row_shift;
+
+	keypad_data = kzalloc(sizeof(struct omap4_keypad) +
+				max_keys * sizeof(keypad_data->keymap[0]),
+			      GFP_KERNEL);
+	if (!keypad_data) {
+		dev_err(&pdev->dev, "keypad_data memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	keypad_data->base = pdata->base;
+	keypad_data->irq = pdata->irq;
+
+	keypad_data->row_shift = row_shift;
+	keypad_data->rows = pdata->rows;
+	keypad_data->cols = pdata->cols;
+
+	/* input device allocation */
+	keypad_data->input = input_dev = input_allocate_device();
+	if (!input_dev) {
+		error = -ENOMEM;
+		goto err_free_keypad;
+	}
+
+	input_dev->name = pdev->name;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0001;
+
+	input_dev->keycode	= keypad_data->keymap;
+	input_dev->keycodesize	= sizeof(keypad_data->keymap[0]);
+	input_dev->keycodemax	= max_keys;
+
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(EV_REP, input_dev->evbit);
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+
+	input_set_drvdata(input_dev, keypad_data);
+
+	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
+			input_dev->keycode, input_dev->keybit);
+
+	omap4_keypad_config(keypad_data);
+
+	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
+			     IRQF_TRIGGER_FALLING,
+			     "omap4-keypad", keypad_data);
+	if (error) {
+		dev_err(&pdev->dev, "failed to register interrupt\n");
+		goto err_free_input;
+	}
+
+	error = input_register_device(keypad_data->input);
+	if (error < 0) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto err_free_irq;
+	}
+
+
+	platform_set_drvdata(pdev, keypad_data);
+	return 0;
+
+err_free_irq:
+	free_irq(keypad_data->irq, keypad_data);
+err_free_input:
+	input_free_device(input_dev);
+err_free_keypad:
+	kfree(keypad_data);
+	return error;
+}
+
+static int __devexit omap4_keypad_remove(struct platform_device *pdev)
+{
+	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
+
+	free_irq(keypad_data->irq, keypad_data);
+	input_unregister_device(keypad_data->input);
+	kfree(keypad_data);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver omap4_keypad_driver = {
+	.probe		= omap4_keypad_probe,
+	.remove		= __devexit_p(omap4_keypad_remove),
+	.driver		= {
+		.name	= "omap4-keypad",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap4_keypad_init(void)
+{
+	return platform_driver_register(&omap4_keypad_driver);
+}
+module_init(omap4_keypad_init);
+
+static void __exit omap4_keypad_exit(void)
+{
+	platform_driver_unregister(&omap4_keypad_driver);
+}
+module_exit(omap4_keypad_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("OMAP4 Keypad Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap4-keypad");
-- 
1.6.3.3

