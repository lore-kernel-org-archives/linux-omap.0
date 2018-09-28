From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Date: Fri, 28 Sep 2018 13:29:46 -0500
Message-ID: <20180928182954.25446-2-dmurphy@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928182954.25446-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

This adds backlight support for the following TI LMU
chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.

It controls LEDs on Droid 4
smartphone, including keyboard and screen backlights.

Signed-off-by: Milo Kim <milo.kim@ti.com>
[add LED subsystem support for keyboard backlight and rework DT
binding according to Rob Herrings feedback]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
[remove backlight subsystem support for now]
Signed-off-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/Kconfig             |   8 ++
 drivers/leds/Makefile            |   1 +
 drivers/leds/ti-lmu-led-common.c | 138 +++++++++++++++++++++++++++++++
 drivers/leds/ti-lmu-led-common.h |  54 ++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 drivers/leds/ti-lmu-led-common.h

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 44097a3e0fcc..dc717b30d9d3 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -756,6 +756,14 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
 
+config LEDS_TI_LMU_COMMON
+	tristate "LED driver for TI LMU"
+	depends on REGMAP
+	help
+          Say Y to enable the LED driver for TI LMU devices.
+          This supports common features between the TI LM3532, LM3631, LM3632,
+	  LM3633, LM3695 and LM3697.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 420b5d2cfa62..e09bb27bc7ea 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
+obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_CR0014114)		+= leds-cr0014114.o
diff --git a/drivers/leds/ti-lmu-led-common.c b/drivers/leds/ti-lmu-led-common.c
new file mode 100644
index 000000000000..2d4f22f480d1
--- /dev/null
+++ b/drivers/leds/ti-lmu-led-common.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2015 Texas Instruments
+ * Copyright 2018 Sebastian Reichel
+ * Copyright 2018 Pavel Machek <pavel@ucw.cz>
+ *
+ * TI LMU Led driver, based on previous work from
+ * Milo Kim <milo.kim@ti.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "ti-lmu-led-common.h"
+
+const static int ramp_table[16] = { 2, 262, 524, 1049, 2090, 4194, 8389,
+				16780, 33550, 41940, 50330, 58720,
+				67110, 83880, 100660, 117440};
+
+static int ti_lmu_common_update_brightness_register(struct ti_lmu_bank *lmu_bank,
+						       int brightness)
+{
+	struct regmap *regmap = lmu_bank->regmap;
+	u8 reg, val;
+	int ret;
+
+	/*
+	 * Brightness register update
+	 *
+	 * 11 bit dimming: update LSB bits and write MSB byte.
+	 *		   MSB brightness should be shifted.
+	 *  8 bit dimming: write MSB byte.
+	 */
+	if (lmu_bank->max_brightness == MAX_BRIGHTNESS_11BIT) {
+		reg = lmu_bank->lsb_brightness_reg;
+		ret = regmap_update_bits(regmap, reg,
+					 LMU_11BIT_LSB_MASK,
+					 brightness);
+		if (ret)
+			return ret;
+
+		val = brightness >> LMU_11BIT_MSB_SHIFT;
+	} else {
+		val = brightness;
+	}
+
+	reg = lmu_bank->msb_brightness_reg;
+
+	return regmap_write(regmap, reg, val);
+}
+
+int ti_lmu_common_set_brightness(struct ti_lmu_bank *lmu_bank,
+				    int brightness)
+{
+	lmu_bank->current_brightness = brightness;
+
+	return ti_lmu_common_update_brightness_register(lmu_bank, brightness);
+}
+EXPORT_SYMBOL(ti_lmu_common_set_brightness);
+
+static int ti_lmu_common_convert_ramp_to_index(unsigned int msec)
+{
+	int size = ARRAY_SIZE(ramp_table);
+	int i;
+
+	if (msec <= ramp_table[0])
+		return 0;
+
+	if (msec > ramp_table[size - 1])
+		return size - 1;
+
+	for (i = 1; i < size; i++) {
+		if (msec == ramp_table[i])
+			return i;
+
+		/* Find an approximate index by looking up the table */
+		if (msec > ramp_table[i - 1] && msec < ramp_table[i]) {
+			if (msec - ramp_table[i - 1] < ramp_table[i] - msec)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int ti_lmu_common_set_ramp(struct ti_lmu_bank *lmu_bank)
+{
+	struct regmap *regmap = lmu_bank->regmap;
+	u8 ramp, ramp_up, ramp_down;
+
+	if (lmu_bank->ramp_up_msec == 0 && lmu_bank->ramp_down_msec == 0) {
+		ramp_up = 0;
+		ramp_down = 0;
+	} else {
+		ramp_up = ti_lmu_common_convert_ramp_to_index(lmu_bank->ramp_up_msec);
+		ramp_down = ti_lmu_common_convert_ramp_to_index(lmu_bank->ramp_down_msec);
+	}
+
+	if (ramp_up < 0 || ramp_down < 0)
+		return -EINVAL;
+
+	ramp = (ramp_up << 4) | ramp_down;
+
+	return regmap_write(regmap, lmu_bank->runtime_ramp_reg, ramp);
+
+}
+EXPORT_SYMBOL(ti_lmu_common_set_ramp);
+
+int ti_lmu_common_get_ramp_params(struct device *dev,
+				  struct fwnode_handle *child,
+				  struct ti_lmu_bank *lmu_data)
+{
+	int ret;
+
+	ret = fwnode_property_read_u32(child, "ramp-up-ms",
+				 &lmu_data->ramp_up_msec);
+	if (ret)
+		dev_warn(dev, "ramp-up-ms property missing\n");
+
+
+	ret = fwnode_property_read_u32(child, "ramp-down-ms",
+				 &lmu_data->ramp_down_msec);
+	if (ret)
+		dev_warn(dev, "ramp-down-ms property missing\n");
+
+	return 0;
+}
+EXPORT_SYMBOL(ti_lmu_common_get_ramp_params);
+
+MODULE_DESCRIPTION("TI LMU LED Driver");
+MODULE_AUTHOR("Sebastian Reichel");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:ti-lmu-led");
diff --git a/drivers/leds/ti-lmu-led-common.h b/drivers/leds/ti-lmu-led-common.h
new file mode 100644
index 000000000000..511768dd54b6
--- /dev/null
+++ b/drivers/leds/ti-lmu-led-common.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+// TI LMU Common Core
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <uapi/linux/uleds.h>
+
+#define LMU_DUAL_CHANNEL_USED	(BIT(0) | BIT(1))
+#define LMU_11BIT_LSB_MASK	(BIT(0) | BIT(1) | BIT(2))
+#define LMU_11BIT_MSB_SHIFT	3
+
+#define MAX_BRIGHTNESS_8BIT	255
+#define MAX_BRIGHTNESS_11BIT	2047
+
+#define NUM_DUAL_CHANNEL	2
+
+struct ti_lmu_bank {
+	struct regmap *regmap;
+
+	int bank_id;
+	int fault_monitor_used;
+
+	u8 enable_reg;
+	unsigned long enable_usec;
+
+	int current_brightness;
+	u32 default_brightness;
+	int max_brightness;
+
+	u8 lsb_brightness_reg;
+	u8 msb_brightness_reg;
+
+	u8 runtime_ramp_reg;
+	u32 ramp_up_msec;
+	u32 ramp_down_msec;
+};
+
+
+int ti_lmu_common_set_brightness(struct ti_lmu_bank *lmu_bank,
+				    int brightness);
+
+int ti_lmu_common_set_ramp(struct ti_lmu_bank *lmu_bank);
+
+int ti_lmu_common_get_ramp_params(struct device *dev,
+				  struct fwnode_handle *child,
+				  struct ti_lmu_bank *lmu_data);
-- 
2.19.0
