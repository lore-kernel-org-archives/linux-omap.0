From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 6/7] [omap1] Bluetooth device code common to HTC smartphones
Date: Mon, 19 Jul 2010 21:07:45 -0700
Message-ID: <1279598866-18716-5-git-send-email-darkstar6262@gmail.com>
References: <1279598866-18716-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab0GTEI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 00:08:26 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so5354123iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Jul 2010 21:08:26 -0700 (PDT)
In-Reply-To: <1279598866-18716-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds in a bluetooth controld driver/rfkill
interface to the serial bluetooth controller found on many
HTC smartphones such as the HTC Herald and HTC Wizard.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/htc-bt.c              |  183 +++++++++++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/htc-bt.h |   22 ++++
 2 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/htc-bt.c
 create mode 100644 arch/arm/mach-omap1/include/mach/htc-bt.h

diff --git a/arch/arm/mach-omap1/htc-bt.c b/arch/arm/mach-omap1/htc-bt.c
new file mode 100644
index 0000000..aca7b97
--- /dev/null
+++ b/arch/arm/mach-omap1/htc-bt.c
@@ -0,0 +1,183 @@
+/*
+ * Bluetooth built-in chip control
+ *
+ * Copyright (c) 2010 Cory Maccarrone
+ * Based on tosa-bt.c copyright (c) 2008 Dmitry Baryshkov
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/rfkill.h>
+#include <linux/clk.h>
+
+#include <plat/mux.h>
+
+#include <mach/htc-bt.h>
+
+static struct clk *uart_ck;
+
+static void htc_bt_on(struct htc_bt_data *data)
+{
+	gpio_set_value(data->gpio_pwr, 1);
+
+	if (uart_ck)
+		clk_enable(uart_ck);
+
+	msleep(1000);
+
+	if (data->gpio_enable)
+		gpio_set_value(data->gpio_enable, 1);
+}
+
+static void htc_bt_off(struct htc_bt_data *data)
+{
+	gpio_set_value(data->gpio_pwr, 0);
+
+	if (uart_ck)
+		clk_disable(uart_ck);
+
+	msleep(1000);
+
+	if (data->gpio_enable)
+		gpio_set_value(data->gpio_enable, 0);
+}
+
+static int htc_bt_set_block(void *data, bool blocked)
+{
+	if (!blocked)
+		htc_bt_on(data);
+	else
+		htc_bt_off(data);
+
+	return 0;
+}
+
+static const struct rfkill_ops htc_bt_rfkill_ops = {
+	.set_block = htc_bt_set_block,
+};
+
+static int htc_bt_probe(struct platform_device *dev)
+{
+	int rc;
+	struct rfkill *rfk;
+
+	struct htc_bt_data *data = dev->dev.platform_data;
+
+	/* Configure the GPIOs */
+	if (data->gpio_enable) {
+		rc = gpio_request(data->gpio_enable, "Bluetooth enable");
+		if (rc)
+			goto err_enable;
+		rc = gpio_direction_output(data->gpio_enable, 0);
+		if (rc)
+			goto err_enable_dir;
+	}
+
+	rc = gpio_request(data->gpio_pwr, "Bluetooth power");
+	if (rc)
+		goto err_pwr;
+	rc = gpio_direction_output(data->gpio_pwr, 0);
+	if (rc)
+		goto err_pwr_dir;
+
+	/* Get the clocks */
+	if (data->uart_clock != NULL) {
+		uart_ck = clk_get(NULL, data->uart_clock);
+		if (IS_ERR(uart_ck)) {
+			pr_warn("htc-bt: Could not get uart clock\n");
+			uart_ck = NULL;
+		} else
+			clk_disable(uart_ck);
+	} else
+		uart_ck = NULL;
+
+	/* MUX pins for UART */
+	omap_cfg_reg(UART_7XX_1);
+	omap_cfg_reg(UART_7XX_2);
+
+	/* Configure RFKill */
+	rfk = rfkill_alloc("htc-bt", &dev->dev, RFKILL_TYPE_BLUETOOTH,
+			   &htc_bt_rfkill_ops, data);
+	if (!rfk) {
+		rc = -ENOMEM;
+		goto err_rfk_alloc;
+	}
+
+	rfkill_set_led_trigger_name(rfk, "htc-bt");
+
+	rc = rfkill_register(rfk);
+	if (rc)
+		goto err_rfkill;
+
+	platform_set_drvdata(dev, rfk);
+
+	return 0;
+
+err_rfkill:
+	rfkill_destroy(rfk);
+err_rfk_alloc:
+	htc_bt_off(data);
+err_pwr_dir:
+	gpio_free(data->gpio_pwr);
+err_pwr:
+err_enable_dir:
+	if (data->gpio_enable)
+		gpio_free(data->gpio_enable);
+err_enable:
+	return rc;
+}
+
+static int __devexit htc_bt_remove(struct platform_device *dev)
+{
+	struct htc_bt_data *data = dev->dev.platform_data;
+	struct rfkill *rfk = platform_get_drvdata(dev);
+
+	platform_set_drvdata(dev, NULL);
+
+	if (rfk) {
+		rfkill_unregister(rfk);
+		rfkill_destroy(rfk);
+	}
+	rfk = NULL;
+
+	htc_bt_off(data);
+
+	gpio_free(data->gpio_pwr);
+	if (data->gpio_enable)
+		gpio_free(data->gpio_enable);
+
+	return 0;
+}
+
+static struct platform_driver htc_bt_driver = {
+	.probe = htc_bt_probe,
+	.remove = __devexit_p(htc_bt_remove),
+
+	.driver = {
+		.name = "htc-bt",
+		.owner = THIS_MODULE,
+	},
+};
+
+
+static int __init htc_bt_init(void)
+{
+	return platform_driver_register(&htc_bt_driver);
+}
+
+static void __exit htc_bt_exit(void)
+{
+	platform_driver_unregister(&htc_bt_driver);
+}
+
+late_initcall(htc_bt_init);
+module_exit(htc_bt_exit);
+
diff --git a/arch/arm/mach-omap1/include/mach/htc-bt.h b/arch/arm/mach-omap1/include/mach/htc-bt.h
new file mode 100644
index 0000000..843ec45
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/htc-bt.h
@@ -0,0 +1,22 @@
+/*
+ * HTC bluetooth built-in chip control.
+ *
+ * Copyright (C) 2010 Cory Maccarrone
+ * Based on tosa_bt.h copyright (c) 2008 Dmitry Baryshkov
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef HTC_BT_H
+#define HTC_BT_H
+
+struct htc_bt_data {
+	const char	*uart_clock;
+	int		gpio_pwr;
+	int		gpio_enable;
+};
+
+#endif
+
-- 
1.7.0.4

