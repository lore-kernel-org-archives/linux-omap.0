From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 RFC] clk: add gpio controlled clock
Date: Tue, 5 Nov 2013 10:07:31 +0200
Message-ID: <1383638851-3850-1-git-send-email-jsarha@ti.com>
References: <20131104084227.3323f98e@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38236 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3KEIH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Nov 2013 03:07:56 -0500
In-Reply-To: <20131104084227.3323f98e@ipc1.ka-ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, mturquette@linaro.org

The added clk-gpio is a basic clock that can be enabled and disabled
trough a gpio output. The DT binding document for the clock is also
added.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/clock/gpio-clock.txt       |   21 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gpio.c                             |  155 ++++++++++++++++++++
 include/linux/clk-provider.h                       |   25 ++++
 4 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
 create mode 100644 drivers/clk/clk-gpio.c

diff --git a/Documentation/devicetree/bindings/clock/gpio-clock.txt b/Documentation/devicetree/bindings/clock/gpio-clock.txt
new file mode 100644
index 0000000..54fea39
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/gpio-clock.txt
@@ -0,0 +1,21 @@
+Binding for simple gpio controlled clock.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "gpio-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- enable-gpios : GPIO reference for enabling and disabling the clock.
+
+Optional properties:
+- clocks: Maximum of one parent clock is supported.
+
+Example:
+	clock {
+		compatible = "gpio-clock";
+		clocks = <&parentclk>;
+		#clock-cells = <0>;
+		enable-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+	};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7d74d06..81b65a3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
+obj-$(CONFIG_COMMON_CLK)	+= clk-gpio.o
 
 # SoCs specific
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
new file mode 100644
index 0000000..ff24567
--- /dev/null
+++ b/drivers/clk/clk-gpio.c
@@ -0,0 +1,155 @@
+/*
+ * Copyright (C) 2012 Texas Instruments
+ * Author: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Gpio controlled clock implementation
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/err.h>
+#include <linux/device.h>
+
+/**
+ * DOC: basic gpio controlled clock which can be enabled and disabled
+ *      with gpio output
+ * Traits of this clock:
+ * prepare - clk_(un)prepare only ensures parent is (un)prepared
+ * enable - clk_enable and clk_disable are functional & control gpio
+ * rate - inherits rate from parent.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
+
+static int clk_gpio_enable(struct clk_hw *hw)
+{
+	struct clk_gpio *gpio = to_clk_gpio(hw);
+	int value = gpio->active_low ? 0 : 1;
+
+	gpio_set_value(gpio->gpio, value);
+
+	return 0;
+}
+
+static void clk_gpio_disable(struct clk_hw *hw)
+{
+	struct clk_gpio *gpio = to_clk_gpio(hw);
+	int value = gpio->active_low ? 1 : 0;
+
+	gpio_set_value(gpio->gpio, value);
+}
+
+static int clk_gpio_is_enabled(struct clk_hw *hw)
+{
+	struct clk_gpio *gpio = to_clk_gpio(hw);
+	int value = gpio_get_value(gpio->gpio);
+
+	return gpio->active_low ? !value : value;
+}
+
+const struct clk_ops clk_gpio_ops = {
+	.enable = clk_gpio_enable,
+	.disable = clk_gpio_disable,
+	.is_enabled = clk_gpio_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_gpio_ops);
+
+/**
+ * clk_register_gpio - register a gpip clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_name: name of this clock's parent
+ * @flags: framework-specific flags for this clock
+ * @gpio: gpio to control this clock
+ * @active_low: gpio polarity
+ */
+struct clk *clk_register_gpio(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int gpio, bool active_low)
+{
+	struct clk_gpio *clk_gpio;
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+	unsigned long gpio_flags;
+	int err;
+
+	if (active_low)
+		gpio_flags = GPIOF_OUT_INIT_LOW;
+	else
+		gpio_flags = GPIOF_OUT_INIT_HIGH;
+
+	err = gpio_request_one(gpio, gpio_flags, name);
+	if (err) {
+		pr_err("%s: Error requesting clock control gpio %u\n",
+		       __func__, gpio);
+		return ERR_PTR(err);
+	}
+
+	clk_gpio = devm_kzalloc(dev, sizeof(struct clk_gpio), GFP_KERNEL);
+	if (!clk_gpio) {
+		pr_err("%s: could not allocate gpio clk\n", __func__);
+		gpio_free(gpio);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &clk_gpio_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	clk_gpio->gpio = gpio;
+	clk_gpio->active_low = active_low;
+	clk_gpio->hw.init = &init;
+
+	clk = clk_register(dev, &clk_gpio->hw);
+
+	if (IS_ERR(clk)) {
+		gpio_free(gpio);
+		kfree(clk_gpio);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(clk_register_gpio);
+
+#ifdef CONFIG_OF
+/**
+ * of_gpio_clk_setup() - Setup function for gpio controlled clock
+ */
+void __init of_gpio_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	enum of_gpio_flags gpio_flags;
+	int gpio;
+	bool active_low;
+
+	gpio = of_get_named_gpio_flags(node, "enable-gpios", 0, &gpio_flags);
+	if (gpio < 0) {
+		pr_err("%s: GPIO clock <%s> must have enable-gpios property\n",
+		       __func__, clk_name);
+		return;
+	}
+
+	active_low = gpio_flags & OF_GPIO_ACTIVE_LOW;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	clk = clk_register_gpio(NULL, clk_name, parent_name, 0,
+				gpio, active_low);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+EXPORT_SYMBOL_GPL(of_gpio_clk_setup);
+CLK_OF_DECLARE(gpio_clk, "gpio-clock", of_gpio_clk_setup);
+#endif
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3493c76..f861568 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -439,6 +439,31 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
 
+/***
+ * struct clk_gpio - gpio controlled clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @gpio:	gpio
+ * @active_low:	gpio polarity
+ *
+ * Clock with a gpio control for enabling and disabling the parent clock.
+ * Implements .enable, .disable and .is_enabled
+ */
+
+struct clk_gpio {
+	struct clk_hw	hw;
+	unsigned int	gpio;
+	bool		active_low;
+};
+
+extern const struct clk_ops clk_gpio_ops;
+
+struct clk *clk_register_gpio(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int gpio, bool active_low);
+
+void of_gpio_clk_setup(struct device_node *node);
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
-- 
1.7.9.5

