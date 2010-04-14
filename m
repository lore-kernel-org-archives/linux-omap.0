From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Tue, 13 Apr 2010 20:10:48 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Keyboard controller for OMAP4 with built-in scanning algorithm.
The following implementations are used:

  - matrix_keypac.c logic
  - hwmod framework
  - threaded irq

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 drivers/input/keyboard/Kconfig        |    9 +
 drivers/input/keyboard/Makefile       |    1 +
 drivers/input/keyboard/omap4-keypad.c |  367 +++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/omap4-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 5049c3c..8a4103e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -390,6 +390,15 @@ config KEYBOARD_OMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-keypad.
 
+config KEYBOARD_OMAP4
+        tristate "TI OMAP4 keypad support"
+        depends on (ARCH_OMAP4)
+        help
+          Say Y here if you want to use the OMAP4 keypad.
+
+          To compile this driver as a module, choose M here: the
+          module will be called omap4-keypad.
+
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
 	depends on TWL4030_CORE
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 78654ef..1b3dfbe 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
+obj-$(CONFIG_KEYBOARD_OMAP4)		+= omap4-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
new file mode 100644
index 0000000..b656b4f
--- /dev/null
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -0,0 +1,367 @@
+/*
+ * linux/drivers/input/keyboard/omap4-keypad.c
+ *
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
+#include <linux/input/matrix_keypad.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
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
+struct omap_keypad {
+
+	struct platform_device *pdev;
+	struct omap_hwmod *oh;
+	const struct matrix_keypad_platform_data *pdata;
+
+	void __iomem    *base;
+
+	struct input_dev *input;
+
+	int irq;
+
+	unsigned short *keycodes;
+	unsigned int rows;
+	unsigned int cols;
+	unsigned int debounce;
+	unsigned int row_shift;
+	unsigned char key_state[8];
+};
+
+struct omap_device_pm_latency omap_keyboard_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static void __init omap_keypad_config(struct omap_keypad *keypad_data)
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
+/* Interrupt thread primary handler, called in hard interrupt context */
+
+static irqreturn_t omap_keypad_interrupt(int irq, void *dev_id)
+{
+	struct omap_keypad *keypad_data = dev_id;
+
+	/* disable interrupts */
+	__raw_writel(OMAP4_DEF_IRQDISABLE, keypad_data->base +
+				OMAP4_KBD_IRQENABLE);
+
+	/* wake up handler thread */
+	return IRQ_WAKE_THREAD;
+
+}
+
+/* Interrupt thread handler thread */
+
+static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
+{
+	struct omap_keypad *keypad_data = dev_id;
+	struct input_dev *input = keypad_data->input;
+	unsigned char key_state[8];
+	int col, row, code;
+	u32 *new_state = (u32 *) key_state;
+
+	*new_state	 = __raw_readl(keypad_data->base +
+			OMAP4_KBD_FULLCODE31_0);
+	*(new_state + 1) = __raw_readl(keypad_data->base +
+			OMAP4_KBD_FULLCODE63_32);
+
+	for (col = 0; col < keypad_data->cols; col++) {
+		for (row = 0; row < keypad_data->rows; row++) {
+			code = MATRIX_SCAN_CODE(row, col,
+					keypad_data->row_shift);
+			if (code < 0) {
+				printk(KERN_INFO "Spurious key %d-%d\n",
+						col, row);
+				continue;
+			}
+			input_report_key(input, keypad_data->keycodes[code],
+					key_state[col] & (1 << row));
+		}
+	}
+
+	memcpy(keypad_data->key_state, &key_state,
+			sizeof(keypad_data->key_state));
+
+	/* enable interrupts */
+	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
+			keypad_data->base + OMAP4_KBD_IRQENABLE);
+
+	/* clear pending interrupts */
+	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
+			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+
+	/* clear pending interrupts */
+	return IRQ_HANDLED;
+
+}
+
+
+static int __devinit omap_keypad_probe(struct platform_device *pdev)
+{
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	struct matrix_keypad_platform_data *pdata;
+	struct input_dev *input_dev;
+	const struct matrix_keymap_data *keymap_data;
+	struct omap_keypad *keypad_data;
+
+	unsigned int status = 0, row_shift = 0, error = 0, length = 0, id = 0;
+	unsigned short *keypad_codes;
+
+	int hw_mod_name_len = 16;
+	char oh_name[hw_mod_name_len];
+	char *name = "omap4-keypad";
+
+	length = snprintf(oh_name, hw_mod_name_len, "keyboard");
+	WARN(length >= hw_mod_name_len,
+		"String buffer overflow in keyboard device setup\n");
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh)
+		pr_err("Could not look up %s\n", oh_name);
+
+	pdata = kzalloc(sizeof(struct matrix_keypad_platform_data),
+				GFP_KERNEL);
+
+	od = omap_device_build(name, id, oh, pdata,
+				sizeof(struct matrix_keypad_platform_data),
+				omap_keyboard_latency,
+				ARRAY_SIZE(omap_keyboard_latency), 1);
+	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+		name, oh_name);
+
+	/* platform data */
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		kfree(pdata);
+		return -EINVAL;
+	}
+
+	/* keymap data */
+	keymap_data = pdata->keymap_data;
+	if (!keymap_data) {
+		dev_err(&pdev->dev, "no keymap data defined\n");
+		kfree(keymap_data);
+		return -EINVAL;
+	}
+
+	/* omap keypad data */
+	row_shift = get_count_order(pdata->num_col_gpios);
+	keypad_data = kzalloc(sizeof(struct omap_keypad), GFP_KERNEL);
+	if (!keypad_data) {
+		error = -ENOMEM;
+		goto failed_free_platform;
+	}
+
+	/* omap keypad codes */
+	keypad_codes = kzalloc((pdata->num_row_gpios << row_shift) *
+			sizeof(*keypad_codes), GFP_KERNEL);
+	if (!keypad_codes) {
+		error = -ENOMEM;
+		goto failed_free_data;
+	}
+
+	/* input device allocation */
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		error = -ENOMEM;
+		goto failed_free_codes;
+	}
+
+	/* base resource */
+	keypad_data->base = oh->_rt_va;
+	if (!keypad_data->base) {
+		error = -ENOMEM;
+		goto failed_free_input;
+	}
+
+	/* irq */
+	keypad_data->irq = oh->mpu_irqs[0].irq;
+	if (keypad_data->irq < 0) {
+		dev_err(&pdev->dev, "no keyboard irq assigned\n");
+		error = keypad_data->irq;
+		goto failed_free_base;
+	}
+
+	/* threaded irq init */
+	status = request_threaded_irq(keypad_data->irq, omap_keypad_interrupt,
+			omap_keypad_threaded,
+				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			"omap4-keypad", keypad_data);
+	if (status) {
+		dev_err(&pdev->dev, "failed to register interrupt\n");
+		error = -ENOMEM;
+		goto failed_free_irq;
+	}
+
+	keypad_data->input = input_dev;
+	keypad_data->row_shift = row_shift;
+	keypad_data->rows = pdata->num_row_gpios;
+	keypad_data->cols = pdata->num_col_gpios;
+	keypad_data->keycodes = keypad_codes;
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+
+	input_dev->keycode	= keypad_codes;
+	input_dev->keycodesize	= sizeof(*keypad_codes);
+
+	matrix_keypad_build_keymap(keymap_data, row_shift,
+				   input_dev->keycode, input_dev->keybit);
+
+	__set_bit(EV_REP, input_dev->evbit);
+	__set_bit(KEY_OK, input_dev->keybit);
+	__set_bit(EV_KEY, input_dev->evbit);
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	input_set_drvdata(input_dev, keypad_data);
+
+	status = input_register_device(keypad_data->input);
+	if (status < 0) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto failed_free_device;
+	}
+
+	omap_keypad_config(keypad_data);
+
+	platform_set_drvdata(pdev, keypad_data);
+
+	return 0;
+
+failed_free_device:
+	input_unregister_device(keypad_data->input);
+failed_free_irq:
+	free_irq(keypad_data->irq, pdev);
+failed_free_base:
+	keypad_data->base = NULL;
+failed_free_input:
+	input_free_device(input_dev);
+failed_free_codes:
+	kfree(keypad_codes);
+failed_free_data:
+	kfree(keypad_data);
+failed_free_platform:
+	kfree(keymap_data);
+	kfree(pdata);
+	return error;
+}
+
+static int __devexit omap_keypad_remove(struct platform_device *pdev)
+{
+	struct omap_keypad *keypad_data = platform_get_drvdata(pdev);
+
+	input_unregister_device(keypad_data->input);
+	free_irq(keypad_data->irq, keypad_data);
+	platform_set_drvdata(pdev, NULL);
+	kfree(keypad_data);
+
+	return 0;
+}
+
+static struct platform_driver omap_keypad_driver = {
+	.probe		= omap_keypad_probe,
+	.remove		= __devexit_p(omap_keypad_remove),
+	.driver		= {
+		.name	= "omap4-keypad",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init omap_keypad_init(void)
+{
+	return platform_driver_register(&omap_keypad_driver);
+}
+
+static void __exit omap_keypad_exit(void)
+{
+	platform_driver_unregister(&omap_keypad_driver);
+}
+
+module_init(omap_keypad_init);
+module_exit(omap_keypad_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("OMAP4 Keypad Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap4-keypad");
-- 
1.5.4.3

