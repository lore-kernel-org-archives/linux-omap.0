From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 10/11] omap4: thermal: add basic CPU thermal zone
Date: Fri, 25 May 2012 11:26:00 +0300
Message-ID: <1337934361-1606-11-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48387 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756121Ab2EYI12 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 May 2012 04:27:28 -0400
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
 drivers/thermal/Makefile        |    1 +
 drivers/thermal/omap-bandgap.c  |    1 +
 drivers/thermal/omap-bandgap.h  |   12 ++++++
 drivers/thermal/omap4-thermal.c |   72 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/omap4-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index ffdd240..2e82797 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -39,3 +39,15 @@ config OMAP_BANDGAP
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
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 5ff1af1..6397678 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
 obj-$(CONFIG_OMAP_BANDGAP)	+= omap-thermal.o
 omap-thermal-y			:= omap-bandgap.o
+omap-thermal-$(CONFIG_OMAP4_THERMAL)	+= omap4-thermal.o
diff --git a/drivers/thermal/omap-bandgap.c b/drivers/thermal/omap-bandgap.c
index 3d5a12b..d53ffcf 100644
--- a/drivers/thermal/omap-bandgap.c
+++ b/drivers/thermal/omap-bandgap.c
@@ -1192,6 +1192,7 @@ static const struct omap_bandgap_data omap4460_data = {
 	.fclock_name = "bandgap_ts_fclk",
 	.div_ck_name = "div_ts_ck",
 	.conv_table = omap4460_adc_to_temp,
+	.expose_sensor = omap4_thermal_expose_sensor,
 	.sensors = {
 		{
 			.registers = &omap4460_mpu_temp_sensor_registers,
diff --git a/drivers/thermal/omap-bandgap.h b/drivers/thermal/omap-bandgap.h
index 12e0d6b..0f5b3e6 100644
--- a/drivers/thermal/omap-bandgap.h
+++ b/drivers/thermal/omap-bandgap.h
@@ -60,4 +60,16 @@ int omap_bandgap_write_update_interval(struct omap_bandgap *bg_ptr, int id,
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
diff --git a/drivers/thermal/omap4-thermal.c b/drivers/thermal/omap4-thermal.c
new file mode 100644
index 0000000..f83cf96
--- /dev/null
+++ b/drivers/thermal/omap4-thermal.c
@@ -0,0 +1,72 @@
+/*
+ * OMAP4 thermal driver.
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
-- 
1.7.7.1.488.ge8e1c

