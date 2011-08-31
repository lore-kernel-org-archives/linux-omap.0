From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 1/4] regulator: omap smps regulator driver
Date: Wed, 31 Aug 2011 18:11:15 +0300
Message-ID: <1314803478-15634-2-git-send-email-t-kristo@ti.com>
References: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47514 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447Ab1HaPLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 11:11:55 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

OMAP SMPS regulator driver provides access to OMAP voltage processor
controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
layer for the actual voltage regulation operations.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Todd Poynor <toddpoynor@google.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>
---
 drivers/regulator/Kconfig               |    8 ++
 drivers/regulator/Makefile              |    1 +
 drivers/regulator/omap-smps-regulator.c |  178 +++++++++++++++++++++++++++++++
 include/linux/regulator/omap-smps.h     |   20 ++++
 4 files changed, 207 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/omap-smps-regulator.c
 create mode 100644 include/linux/regulator/omap-smps.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c7fd2c0..17c60bc 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -317,5 +317,13 @@ config REGULATOR_AAT2870
 	  If you have a AnalogicTech AAT2870 say Y to enable the
 	  regulator driver.
 
+config REGULATOR_OMAP_SMPS
+	tristate "TI OMAP SMPS Power Regulators"
+	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
+	help
+	  This driver supports the OMAP3 / OMAP4 SMPS regulators for VDD1,
+	  VDD2 and VDD3. These regulators are accessed using the voltage
+	  processor interface of OMAP.
+
 endif
 
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 040d5aa..42d3405 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -45,5 +45,6 @@ obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500.o
 obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
+obj-$(CONFIG_REGULATOR_OMAP_SMPS) += omap-smps-regulator.o
 
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/omap-smps-regulator.c b/drivers/regulator/omap-smps-regulator.c
new file mode 100644
index 0000000..f07c42d
--- /dev/null
+++ b/drivers/regulator/omap-smps-regulator.c
@@ -0,0 +1,178 @@
+/*
+ * OMAP SMPS regulator driver
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *
+ * Author: Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ctype.h>
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
+	const char		*vdd_name;
+	struct regulator_dev	*rdev;
+	struct voltagedomain	*voltdm;
+	struct regulator_desc	desc;
+};
+
+static int omap_smps_set_voltage(struct regulator_dev *rdev, int min_uV,
+				    int max_uV, unsigned *selector)
+{
+	struct omap_smps_reg_info	*info = rdev_get_drvdata(rdev);
+	return voltdm_scale(info->voltdm, min_uV);
+}
+
+static int omap_smps_get_voltage(struct regulator_dev *rdev)
+{
+	struct omap_smps_reg_info	*info = rdev_get_drvdata(rdev);
+	return voltdm_get_voltage(info->voltdm);
+}
+
+static struct regulator_ops omap_smps_ops = {
+	.set_voltage	= omap_smps_set_voltage,
+	.get_voltage	= omap_smps_get_voltage,
+};
+
+#define SMPS_REG(name) { \
+	.vdd_name = #name, \
+	.desc = { \
+		.ops = &omap_smps_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
+static struct omap_smps_reg_info omap_smps_regs[] = {
+	SMPS_REG(mpu),
+	SMPS_REG(mpu_iva),
+	SMPS_REG(iva),
+	SMPS_REG(core),
+};
+
+static void omap_smps_reg_cleanup(void)
+{
+	int				i;
+	struct omap_smps_reg_info	*info;
+
+	for (i = 0; i < ARRAY_SIZE(omap_smps_regs); i++) {
+		info = &omap_smps_regs[i];
+		if (info->rdev) {
+			regulator_unregister(info->rdev);
+			info->rdev = NULL;
+		}
+
+		kfree(info->desc.name);
+		info->desc.name = NULL;
+	}
+}
+
+static struct regulator_init_data dummy_initdata __devinitdata;
+
+static int __devinit omap_smps_reg_probe(struct platform_device *pdev)
+{
+	int				i, j, ret;
+	struct omap_smps_reg_info	*info;
+	struct omap_smps_platform_data	*pdata;
+	struct regulator_dev		*rdev;
+	struct regulator_init_data	*initdata;
+	struct voltagedomain		*voltdm;
+	char				*name;
+
+	pdata = pdev->dev.platform_data;
+
+	for (i = 0; i < ARRAY_SIZE(omap_smps_regs); i++) {
+		info = &omap_smps_regs[i];
+		voltdm = voltdm_lookup(info->vdd_name);
+		initdata = &dummy_initdata;
+
+		if (!voltdm)
+			continue;
+
+		for (j = 0; j < pdata->num_regulators; j++)
+			if (voltdm == pdata->regulators[j]->driver_data) {
+				initdata = pdata->regulators[j];
+				break;
+			}
+
+		info->voltdm = voltdm;
+
+		name = kmalloc(strlen(info->vdd_name) + 5, GFP_KERNEL);
+
+		if (!name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		sprintf(name, "VDD_%s", info->vdd_name);
+
+		for (j = 0; j < strlen(name); j++)
+			name[j] = toupper(name[j]);
+
+		info->desc.name = name;
+
+		rdev = regulator_register(&info->desc, &pdev->dev, initdata,
+			info);
+
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "can't register %s, %ld\n",
+				info->desc.name, PTR_ERR(rdev));
+			ret = PTR_ERR(rdev);
+			goto err;
+		}
+
+		info->rdev = rdev;
+	}
+
+	return 0;
+err:
+	omap_smps_reg_cleanup();
+	return ret;
+}
+
+static int omap_smps_reg_remove(struct platform_device *pdev)
+{
+	omap_smps_reg_cleanup();
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
 

