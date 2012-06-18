From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [RFC PATCH v2 08/11] omap4: thermal: add basic CPU thermal zone
Date: Mon, 18 Jun 2012 15:32:36 +0400
Message-ID: <4FDF11D4.80206@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48674 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750828Ab2FRLch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 07:32:37 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch exposes OMAP4 thermal sensor as a thermal zone
named "cpu". Only thermal creation is done here.

TODO:

 - Add cooling bindings
 - Add extrapolation rules

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/Kconfig         |   12 ++++++
 drivers/thermal/Makefile        |    1 
 drivers/thermal/omap-bandgap.c  |    1 
 drivers/thermal/omap-bandgap.h  |   12 ++++++
 drivers/thermal/omap4-thermal.c |   72 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+)

Index: linux-2.6/drivers/thermal/Kconfig
===================================================================
--- linux-2.6.orig/drivers/thermal/Kconfig
+++ linux-2.6/drivers/thermal/Kconfig
@@ -38,3 +38,15 @@ config OMAP_BANDGAP
 	  This includes alert interrupts generation and also the TSHUT
 	  support.
 
+config OMAP4_THERMAL
+	bool "Texas Instruments OMAP4 thermal support"
+	depends on OMAP_BANDGAP
+	depends on ARCH_OMAP4
+	help
+	  If you say yes here you get thermal support for the Texas Instruments
+	  OMAP4 SoC family. The current chip supported are:
+	   - OMAP4460
+
+	  This includes alert interrupts generation and also the TSHUT
+	  support.
+
Index: linux-2.6/drivers/thermal/Makefile
===================================================================
--- linux-2.6.orig/drivers/thermal/Makefile
+++ linux-2.6/drivers/thermal/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
 obj-$(CONFIG_OMAP_BANDGAP)	+= omap-thermal.o
 omap-thermal-y			:= omap-bandgap.o
+omap-thermal-$(CONFIG_OMAP4_THERMAL)	+= omap4-thermal.o
Index: linux-2.6/drivers/thermal/omap-bandgap.c
===================================================================
--- linux-2.6.orig/drivers/thermal/omap-bandgap.c
+++ linux-2.6/drivers/thermal/omap-bandgap.c
@@ -1213,6 +1213,7 @@ static const struct omap_bandgap_data om
 	.fclock_name = "bandgap_ts_fclk",
 	.div_ck_name = "div_ts_ck",
 	.conv_table = omap4460_adc_to_temp,
+	.expose_sensor = omap4_thermal_expose_sensor,
 	.irq = 126,
 	.sensors = {
 		{
Index: linux-2.6/drivers/thermal/omap-bandgap.h
===================================================================
--- linux-2.6.orig/drivers/thermal/omap-bandgap.h
+++ linux-2.6/drivers/thermal/omap-bandgap.h
@@ -61,4 +61,16 @@ int omap_bandgap_write_update_interval(s
 int omap_bandgap_read_temperature(struct omap_bandgap *bg_ptr, int id,
 				  int *temperature);
 
+#ifdef CONFIG_OMAP4_THERMAL
+int omap4_thermal_expose_sensor(struct omap_bandgap *bg_ptr, int id,
+				char *domain);
+#else
+static inline int omap4_thermal_expose_sensor(struct omap_bandgap *bg_ptr,
+					      int id, char *domain)
+{
+	return 0;
+}
+
+#endif
+
 #endif
Index: linux-2.6/drivers/thermal/omap4-thermal.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/thermal/omap4-thermal.c
@@ -0,0 +1,72 @@
+/*
+ * SPEAr thermal driver.
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Inc.
+ * Contact:
+ *	Eduardo Valentin <eduardo.valentin@ti.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/thermal.h>
+
+#include "omap-bandgap.h"
+
+struct omap4_thermal_data {
+	struct thermal_zone_device *omap4_thermal;
+	struct omap_bandgap *bg_ptr;
+	int sensor_id;
+};
+
+static inline int omap4_thermal_get_temp(struct thermal_zone_device *thermal,
+					 unsigned long *temp)
+{
+	struct omap4_thermal_data *data = thermal->devdata;
+	int ret, tmp;
+
+	ret = omap_bandgap_read_temperature(data->bg_ptr, data->sensor_id,
+					    &tmp);
+	if (!ret)
+		*temp = tmp;
+
+	return ret;
+}
+
+static struct thermal_zone_device_ops omap4_thermal_ops = {
+	.get_temp = omap4_thermal_get_temp,
+};
+
+int omap4_thermal_expose_sensor(struct omap_bandgap *bg_ptr, int id,
+				char *domain)
+{
+	struct omap4_thermal_data *data;
+
+	data = devm_kzalloc(bg_ptr->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(bg_ptr->dev, "kzalloc fail\n");
+		return -ENOMEM;
+	}
+	data->sensor_id = id;
+	data->bg_ptr = bg_ptr;
+	data->omap4_thermal = thermal_zone_device_register(domain, 0,
+				data, &omap4_thermal_ops, 0, 0, 0, 0);
+	if (IS_ERR(data->omap4_thermal)) {
+		dev_err(bg_ptr->dev, "thermal zone device is NULL\n");
+		return PTR_ERR(data->omap4_thermal);
+	}
+
+	return 0;
+}
