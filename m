From: Sriramakrishnan <srk@ti.com>
Subject: [PATCHv2 1/3] TCA6416 keypad : Implement keypad driver for keys interfaced to TCA6416
Date: Fri, 12 Mar 2010 14:48:17 +0530
Message-ID: <1268385499-7075-2-git-send-email-srk@ti.com>
References: <1268385499-7075-1-git-send-email-srk@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1268385499-7075-1-git-send-email-srk@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch implements a simple Keypad driver that functions
as an I2C client. It handles key press events for keys
connected to TCA6416 I2C based IO expander.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 drivers/input/keyboard/Kconfig          |   16 ++
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/tca6416-keypad.c |  354 +++++++++++++++++++++++++++++++
 include/linux/tca6416_keypad.h          |   34 +++
 4 files changed, 405 insertions(+), 0 deletions(-)
 create mode 100755 drivers/input/keyboard/tca6416-keypad.c
 create mode 100755 include/linux/tca6416_keypad.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 64c1023..cf7fca9 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -192,6 +192,22 @@ config KEYBOARD_GPIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called gpio_keys.
 
+config KEYBOARD_TCA6416
+	tristate "TCA6416 Keypad Support"
+	depends on I2C
+	help
+	  This driver implements basic keypad functionality
+	  for keys connected through TCA6416 IO expander
+
+	  Say Y here if your device has keys connected to
+	  TCA6416 IO expander. Your board-specific setup logic
+	  must also provide pin-mask details(of which TCA6416 pins
+	  are used for keypad).
+
+	  If enabled the complete TCA6416 device will be managed through
+	  this driver.
+
+
 config KEYBOARD_MATRIX
 	tristate "GPIO driven matrix keypad support"
 	depends on GENERIC_GPIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 706c6b5..47e267c 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_KEYBOARD_CORGI)		+= corgikbd.o
 obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keyscan.o
 obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
+obj-$(CONFIG_KEYBOARD_TCA6416)		+= tca6416-keypad.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
 obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
new file mode 100755
index 0000000..17df832
--- /dev/null
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -0,0 +1,354 @@
+/*
+ * Driver for keys on TCA6416 I2C IO expander
+ *
+ * Copyright (C) 2010 Texas Instruments
+ *
+ * Author : Sriramakrishnan.A.G. <srk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/tca6416_keypad.h>
+#include <linux/workqueue.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#define TCA6416_INPUT          0
+#define TCA6416_OUTPUT         1
+#define TCA6416_INVERT         2
+#define TCA6416_DIRECTION      3
+
+static const struct i2c_device_id tca6416_id[] = {
+	{ "tca6416-keys", 16, },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tca6416_id);
+
+struct tca6416_drv_data {
+	struct input_dev *input;
+	struct tca6416_button data[0];
+};
+
+struct tca6416_keypad_chip {
+	uint16_t reg_output;
+	uint16_t reg_direction;
+	uint16_t reg_input;
+
+	struct i2c_client *client;
+	struct tca6416_drv_data  *drv_data;
+	struct delayed_work dwork;
+	uint16_t pinmask;
+	int irqnum;
+	int use_polling;
+};
+
+static int tca6416_write_reg(struct tca6416_keypad_chip *chip, int reg,
+				uint16_t val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_word_data(chip->client, reg << 1, val);
+
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "failed writing register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tca6416_read_reg(struct tca6416_keypad_chip *chip, int reg,
+				uint16_t *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(chip->client, reg << 1);
+
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "failed reading register\n");
+		return ret;
+	}
+
+	*val = (uint16_t)ret;
+	return 0;
+}
+
+static irqreturn_t tca6416_keys_isr(int irq, void *dev_id)
+{
+	struct tca6416_keypad_chip *chip =
+		(struct tca6416_keypad_chip *) dev_id;
+
+	disable_irq(irq);
+	schedule_delayed_work(&chip->dwork, 0);
+	return IRQ_HANDLED;
+
+}
+
+static void tca6416_keys_work_func(struct work_struct *workstruct)
+{
+	struct delayed_work *delay_work =
+		container_of(workstruct, struct delayed_work, work);
+	struct tca6416_keypad_chip *chip =
+		container_of(delay_work, struct tca6416_keypad_chip, dwork);
+	struct tca6416_drv_data *ddata = chip->drv_data;
+	uint16_t reg_val, val;
+	int ret, i, pin_index;
+
+	ret = tca6416_read_reg(chip, TCA6416_INPUT, &reg_val);
+	if (ret)
+		return;
+
+	reg_val &= chip->pinmask;
+
+	/* Figure out which lines have changed */
+	val = reg_val ^ (chip->reg_input);
+	chip->reg_input = reg_val;
+
+	for (i = 0, pin_index = 0; i < 16; i++) {
+		if (val & (1 << i)) {
+			struct tca6416_button *button = &ddata->data[pin_index];
+			struct input_dev *input = ddata->input;
+			unsigned int type = button->type ?: EV_KEY;
+			int state = ((reg_val & (1 << i)) ? 1 : 0)
+						^ button->active_low;
+
+			input_event(input, type, button->code, !!state);
+			input_sync(input);
+		}
+
+		if (chip->pinmask & (1 << i))
+			pin_index++;
+	}
+
+	if (chip->use_polling)
+		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
+	else
+		enable_irq(chip->irqnum);
+
+}
+
+
+static int __devinit tca6416_keypad_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct tca6416_keys_platform_data *pdata;
+	struct tca6416_keypad_chip *chip;
+	struct tca6416_drv_data *ddata;
+	struct input_dev *input;
+	int i, ret, pin_index, err;
+	uint16_t reg_val;
+
+	/* Check functionality */
+	err = i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE);
+	if (!err) {
+		dev_err(&client->dev, "%s adapter not supported\n",
+			dev_driver_string(&client->adapter->dev));
+		return -ENODEV;
+	}
+
+
+	chip = kzalloc(sizeof(struct tca6416_keypad_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	pdata = client->dev.platform_data;
+	if (pdata == NULL) {
+		dev_dbg(&client->dev, "no platform data\n");
+		ret = -EINVAL;
+		goto fail1;
+	}
+
+	chip->client = client;
+	chip->pinmask = pdata->pinmask;
+
+	/* initialize cached registers from their original values.
+	 * we can't share this chip with another i2c master.
+	 */
+	ret = tca6416_read_reg(chip, TCA6416_OUTPUT, &chip->reg_output);
+	if (ret)
+		goto fail1;
+
+	ret = tca6416_read_reg(chip, TCA6416_DIRECTION, &chip->reg_direction);
+	if (ret)
+		goto fail1;
+
+	/* ensure that keypad pins are set to input */
+	reg_val = chip->reg_direction | chip->pinmask;
+	ret = tca6416_write_reg(chip, TCA6416_DIRECTION, reg_val);
+	if (ret)
+		goto fail1;
+
+	ret = tca6416_read_reg(chip, TCA6416_DIRECTION, &chip->reg_direction);
+	if (ret)
+		goto fail1;
+
+	ret = tca6416_read_reg(chip, TCA6416_INPUT, &chip->reg_input);
+	if (ret)
+		goto fail1;
+
+	i2c_set_clientdata(client, chip);
+
+
+	ddata = kzalloc(sizeof(struct tca6416_drv_data) +
+			pdata->nbuttons * sizeof(struct tca6416_button),
+			GFP_KERNEL);
+	if (!ddata) {
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_dbg(&client->dev, "failed to allocate state\n");
+		ret = -ENOMEM;
+		kfree(ddata);
+		goto fail2;
+	}
+
+	input->phys = "tca6416-keys/input0";
+	input->name = client->name;
+	input->dev.parent = &client->dev;
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	/* Enable auto repeat feature of Linux input subsystem */
+	if (pdata->rep)
+		__set_bit(EV_REP, input->evbit);
+
+	ddata->input = input;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		unsigned int type;
+
+		ddata->data[i] = pdata->buttons[i];
+		type = (pdata->buttons[i].type) ?: EV_KEY;
+		input_set_capability(input, type, (pdata->buttons[i].code));
+	}
+
+	chip->drv_data = ddata;
+	chip->use_polling = pdata->use_polling;
+
+	INIT_DELAYED_WORK(&chip->dwork, tca6416_keys_work_func);
+
+	if (!chip->use_polling) {
+		if (pdata->irq_is_gpio)
+			chip->irqnum = gpio_to_irq(client->irq);
+		else
+			chip->irqnum = client->irq;
+
+		ret = request_irq(chip->irqnum, tca6416_keys_isr,
+				IRQF_SHARED | IRQF_TRIGGER_FALLING ,
+				"tca6416-keypad", chip);
+		if (ret) {
+			dev_dbg(&client->dev,
+				"Unable to claim irq %d; error %d\n",
+				chip->irqnum, ret);
+			goto fail3;
+		}
+		disable_irq(chip->irqnum);
+	}
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_dbg(&client->dev, "Unable to register input device, "
+			"error: %d\n", ret);
+		goto fail4;
+	}
+
+	/* get current state of buttons */
+
+	ret = tca6416_read_reg(chip, TCA6416_INPUT, &reg_val);
+	if (ret)
+		goto fail5;
+
+	chip->reg_input = reg_val & chip->pinmask;
+
+	for (i = 0, pin_index = 0; i < 16; i++) {
+		if (chip->pinmask & (1 << i)) {
+			struct tca6416_button *button = &ddata->data[pin_index];
+			unsigned int type = button->type ?: EV_KEY;
+			int state = ((reg_val & (1 << i)) ? 1 : 0)
+						^ button->active_low;
+
+			input_event(input, type, button->code, !!state);
+			input_sync(input);
+			pin_index++;
+		}
+	}
+	input_sync(input);
+
+	if (chip->use_polling)
+		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
+	else
+		enable_irq(chip->irqnum);
+
+	return 0;
+
+fail5:
+	input_unregister_device(input);
+fail4:
+	if (!chip->use_polling)
+		free_irq(chip->irqnum, chip);
+fail3:
+	input_free_device(input);
+fail2:
+	kfree(ddata);
+fail1:
+	kfree(chip);
+	return ret;
+}
+
+static int tca6416_keypad_remove(struct i2c_client *client)
+{
+	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
+	struct tca6416_drv_data *ddata = chip->drv_data;
+	struct input_dev *input = ddata->input;
+
+	if (!chip->use_polling)
+		free_irq(chip->irqnum, chip);
+	cancel_delayed_work_sync(&chip->dwork);
+	input_unregister_device(input);
+	input_free_device(input);
+	kfree(ddata);
+	kfree(chip);
+	return 0;
+}
+
+
+static struct i2c_driver tca6416_keypad_driver = {
+	.driver = {
+		.name	= "tca6416-keypad",
+	},
+	.probe		= tca6416_keypad_probe,
+	.remove		= tca6416_keypad_remove,
+	.id_table	= tca6416_id,
+};
+
+static int __init tca6416_keypad_init(void)
+{
+	return i2c_add_driver(&tca6416_keypad_driver);
+}
+
+subsys_initcall(tca6416_keypad_init);
+
+static void __exit tca6416_keypad_exit(void)
+{
+	i2c_del_driver(&tca6416_keypad_driver);
+}
+module_exit(tca6416_keypad_exit);
+
+MODULE_AUTHOR("Sriramakrishnan <srk@ti.com>");
+MODULE_DESCRIPTION("Keypad driver over tca6146 IO expander");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/tca6416_keypad.h b/include/linux/tca6416_keypad.h
new file mode 100755
index 0000000..7bd266f
--- /dev/null
+++ b/include/linux/tca6416_keypad.h
@@ -0,0 +1,34 @@
+/*
+ * tca6416 keypad platform support
+ *
+ * Copyright (C) 2010 Texas Instruments
+ *
+ * Author: Sriramakrishnan <srk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _TCA6416_KEYS_H
+#define _TCA6416_KEYS_H
+
+#include <linux/types.h>
+
+struct tca6416_button {
+	/* Configuration parameters */
+	int code;		/* input event code (KEY_*, SW_*) */
+	int active_low;
+	int type;		/* input event type (EV_KEY, EV_SW) */
+};
+
+struct tca6416_keys_platform_data {
+	struct tca6416_button *buttons;
+	int nbuttons;
+	unsigned int rep:1;	/* enable input subsystem auto repeat */
+	uint16_t pinmask;
+	uint16_t invert;
+	int irq_is_gpio;
+	int use_polling;	/* use polling if Interrupt is not connected*/
+};
+#endif
-- 
1.6.2.4

