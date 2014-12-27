From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 3/5] input: misc: add tps65218 power button driver
Date: Fri, 26 Dec 2014 21:36:48 -0600
Message-ID: <1419651408-529-1-git-send-email-balbi@ti.com>
References: <20141226234117.GA1071@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20141226234117.GA1071@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

With this driver, we can report KEY_POWER on
AM437x SK. This patch has been tested with said
board.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes since v1:
	- Add device tree documentation
	- s/ret/error
	- removed 'pressed' as input core will filter events
	- use a saner name when requesting IRQ. dev_name(dev) will return
		$i2c_bus_address.i2c-omap:0-0024:tps65218-pwrbutton
	- remove blank line before MODULE_DEVICE_TABLE()

 .../bindings/input/tps65218-pwrbutton.txt          |  17 +++
 drivers/input/misc/Kconfig                         |  10 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/tps65218-pwrbutton.c            | 124 +++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 drivers/input/misc/tps65218-pwrbutton.c

diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
new file mode 100644
index 0000000..e30e0b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
@@ -0,0 +1,17 @@
+Texas Instruments TPS65218 power button
+
+This driver provides a simple power button event via an Interrupt.
+
+Required properties:
+- compatible: should be "ti,tps65218-pwrbutton"
+- interrupts: should be one of the following
+   - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
+
+Example:
+
+&tps {
+	power-button {
+		compatible = "ti,tps65218-pwrbutton";
+		interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+	};
+};
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 23297ab..364cfb8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -404,6 +404,16 @@ config INPUT_RETU_PWRBUTTON
 	  To compile this driver as a module, choose M here. The module will
 	  be called retu-pwrbutton.
 
+config INPUT_TPS65218_PWRBUTTON
+	tristate "TPS65218 Power button driver"
+	depends on MFD_TPS65218
+	help
+	  Say Y here if you want to enable power buttong reporting for
+	  the TPS65218 Power Management IC device.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called tps65218-pwrbutton.
+
 config INPUT_TWL4030_PWRBUTTON
 	tristate "TWL4030 Power button Driver"
 	depends on TWL4030_CORE
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 19c7603..a923753 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
+obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
 obj-$(CONFIG_INPUT_TWL6040_VIBRA)	+= twl6040-vibra.o
diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
new file mode 100644
index 0000000..2f85e2e
--- /dev/null
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -0,0 +1,124 @@
+/*
+ * Texas Instruments' TPS65218 Power Button Input Driver
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Felipe Balbi <balbi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/tps65218.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct tps65218_pwrbutton {
+	struct device *dev;
+	struct tps65218 *tps;
+	struct input_dev *idev;
+};
+
+static irqreturn_t tps65218_pwr_irq(int irq, void *_pwr)
+{
+	struct tps65218_pwrbutton *pwr = _pwr;
+	unsigned int reg;
+	int error;
+
+	error = tps65218_reg_read(pwr->tps, TPS65218_REG_STATUS, &reg);
+	if (error) {
+		dev_err(pwr->dev, "can't read register --> %d\n", error);
+		goto out;
+	}
+
+	if (reg & TPS65218_STATUS_PB_STATE) {
+		input_report_key(pwr->idev, KEY_POWER, 1);
+		pm_wakeup_event(pwr->dev, 0);
+	} else {
+		input_report_key(pwr->idev, KEY_POWER, 0);
+	}
+
+	input_sync(pwr->idev);
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int tps65218_pwron_probe(struct platform_device *pdev)
+{
+	struct tps65218 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct tps65218_pwrbutton *pwr;
+	struct input_dev *idev;
+	int error;
+	int irq;
+
+	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
+	if (!pwr)
+		return -ENOMEM;
+
+	idev = devm_input_allocate_device(dev);
+	if (!idev)
+		return -ENOMEM;
+
+	idev->name = "tps65218_pwrbutton";
+	idev->phys = "tps65218_pwrbutton/input0";
+	idev->dev.parent = dev;
+	idev->id.bustype = BUS_I2C;
+
+	input_set_capability(idev, EV_KEY, KEY_POWER);
+
+	pwr->tps = tps;
+	pwr->dev = dev;
+	pwr->idev = idev;
+	platform_set_drvdata(pdev, pwr);
+	device_init_wakeup(dev, true);
+
+	irq = platform_get_irq(pdev, 0);
+	error = devm_request_threaded_irq(dev, irq, NULL, tps65218_pwr_irq,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			"tps65218-pwrbutton", pwr);
+	if (error) {
+		dev_err(dev, "failed to request IRQ #%d --> %d\n",
+				irq, error);
+		return error;
+	}
+
+	error= input_register_device(idev);
+	if (error) {
+		dev_err(dev, "Can't register power button --> %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static struct of_device_id of_tps65218_pwr_match[] = {
+	{ .compatible = "ti,tps65218-pwrbutton" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
+
+static struct platform_driver tps65218_pwron_driver = {
+	.probe	= tps65218_pwron_probe,
+	.driver	= {
+		.name	= "tps65218_pwrbutton",
+		.of_match_table = of_tps65218_pwr_match,
+	},
+};
+module_platform_driver(tps65218_pwron_driver);
+
+MODULE_DESCRIPTION("TPS65218 Power Button");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
-- 
2.2.0

