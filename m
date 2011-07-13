From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 2/5] regulator: omap smps regulator driver
Date: Wed, 13 Jul 2011 17:00:35 +0300
Message-ID: <1310565638-13140-3-git-send-email-t-kristo@ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43923 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab1GMOBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 10:01:46 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com

OMAP SMPS regulator driver provides access to OMAP voltage processor
controlled regulators. These include VDD1 and VDD2 for OMAP3 and additionally
VDD3 for OMAP4. SMPS regulators use the OMAP voltage layer for the actual
voltage regulation operations.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/regulator/Kconfig               |    9 ++
 drivers/regulator/Makefile              |    1 +
 drivers/regulator/omap-smps-regulator.c |  126 +++++++++++++++++++++++++++++++
 include/linux/regulator/omap-smps.h     |   20 +++++
 4 files changed, 156 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/omap-smps-regulator.c
 create mode 100644 include/linux/regulator/omap-smps.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d7ed20f..bb18ff2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -303,5 +303,14 @@ config REGULATOR_TPS65910
 	help
 	  This driver supports TPS65910 voltage regulator chips.
 
+config REGULATOR_OMAP_SMPS
+	tristate "TI OMAP SMPS Power Regulators"
+	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM && TWL4030_CORE
+	help
+	  This driver supports the OMAP3 / OMAP4 SMPS regulators for VDD1,
+	  VDD2 and VDD3. These regulators reside inside the TWL4030 /
+	  TWL6030 chip but are accessed using the voltage processor
+	  interface of OMAP.
+
 endif
 
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3932d2e..191e3d5 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -43,5 +43,6 @@ obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500.o
 obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
+obj-$(CONFIG_REGULATOR_OMAP_SMPS) += omap-smps-regulator.o
 
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/omap-smps-regulator.c b/drivers/regulator/omap-smps-regulator.c
new file mode 100644
index 0000000..88009b1
--- /dev/null
+++ b/drivers/regulator/omap-smps-regulator.c
@@ -0,0 +1,126 @@
+/*
+ * omap-vp-regulator.c -- support SMPS regulators for OMAP chips
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/omap-smps.h>
+#include <plat/voltage.h>
+
+#define DRIVER_NAME		"omap-smps"
+
+struct omap_smps_reg_info {
+	struct voltagedomain	*voltdm;
+	struct regulator_desc	desc;
+};
+
+static int omap_smps_set_voltage(struct regulator_dev *rdev, int min_uV,
+				    int max_uV, unsigned *selector)
+{
+	struct omap_smps_reg_info	*info = rdev_get_drvdata(rdev);
+	return omap_voltage_scale_vdd(info->voltdm, min_uV);
+}
+
+static int omap_smps_get_voltage(struct regulator_dev *rdev)
+{
+	struct omap_smps_reg_info	*info = rdev_get_drvdata(rdev);
+	return omap_vp_get_curr_volt(info->voltdm);
+}
+
+static struct regulator_ops omap_smps_ops = {
+	.set_voltage	= omap_smps_set_voltage,
+	.get_voltage	= omap_smps_get_voltage,
+};
+
+static int __devinit omap_smps_reg_probe(struct platform_device *pdev)
+{
+	int				i;
+	struct omap_smps_reg_info	*info;
+	struct omap_smps_platform_data	*pdata;
+	struct regulation_constraints	*c;
+	struct regulator_dev		*rdev;
+	struct regulator_init_data	*initdata;
+	struct voltagedomain		*voltdm;
+
+	pdata = pdev->dev.platform_data;
+
+	for (i = 0; i < pdata->num_regulators; i++) {
+		initdata = pdata->regulators[i];
+
+		c = &initdata->constraints;
+		c->valid_modes_mask &= REGULATOR_MODE_NORMAL;
+		c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE;
+		c->always_on = true;
+
+		voltdm = omap_voltage_domain_lookup(
+			initdata->consumer_supplies[0].dev_name);
+
+		if (IS_ERR(voltdm)) {
+			dev_err(&pdev->dev, "can't find voltdm %s, %ld\n",
+				initdata->consumer_supplies[0].dev_name,
+				PTR_ERR(voltdm));
+			return PTR_ERR(voltdm);
+		}
+		info = kzalloc(sizeof(struct omap_smps_reg_info), GFP_KERNEL);
+
+		info->voltdm = voltdm;
+		info->desc.ops = &omap_smps_ops;
+		info->desc.name = c->name;
+		info->desc.type = REGULATOR_VOLTAGE;
+		info->desc.n_voltages = 0;
+		rdev = regulator_register(&info->desc, &pdev->dev, initdata,
+			info);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "can't register %s, %ld\n",
+				info->desc.name, PTR_ERR(rdev));
+			return PTR_ERR(rdev);
+		}
+		platform_set_drvdata(pdev, rdev);
+	}
+
+	return 0;
+}
+
+static int omap_smps_reg_remove(struct platform_device *pdev)
+{
+	regulator_unregister(platform_get_drvdata(pdev));
+	return 0;
+}
+
+static struct platform_driver omap_smps_reg_driver = {
+	.probe		= omap_smps_reg_probe,
+	.remove		= __devexit_p(omap_smps_reg_remove),
+	.driver.name	= DRIVER_NAME,
+	.driver.owner	= THIS_MODULE,
+};
+
+static int __init omap_smps_reg_init(void)
+{
+	return platform_driver_register(&omap_smps_reg_driver);
+}
+subsys_initcall(omap_smps_reg_init);
+
+static void __exit omap_smps_reg_exit(void)
+{
+	platform_driver_unregister(&omap_smps_reg_driver);
+}
+module_exit(omap_smps_reg_exit);
+
+MODULE_ALIAS("platform:"DRIVER_NAME);
+MODULE_AUTHOR("Tero Kristo <t-kristo@ti.com>");
+MODULE_DESCRIPTION("OMAP SMPS regulator driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/omap-smps.h b/include/linux/regulator/omap-smps.h
new file mode 100644
index 0000000..1d5f940
--- /dev/null
+++ b/include/linux/regulator/omap-smps.h
@@ -0,0 +1,20 @@
+/*
+ * omap-smps.h - header for OMAP SMPS regulator support
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP_SMPS_H__
+#define __OMAP_SMPS_H__
+
+struct omap_smps_platform_data {
+	struct regulator_init_data	**regulators;
+	int				num_regulators;
+};
+
+#endif /* End of __OMAP_SMPS_H__ */
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

