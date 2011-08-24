From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 5/6 V3] OMAP4: Temperature sensor device support
Date: Wed, 24 Aug 2011 20:07:11 +0530
Message-ID: <1314196632-8207-6-git-send-email-j-keerthy@ti.com>
References: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57396 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667Ab1HXOhb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 10:37:31 -0400
In-Reply-To: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, tony@atomide.com

The device file adds the device support for OMAP4
on die temperature sensor.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com
---
 arch/arm/mach-omap2/Makefile             |    1 +
 arch/arm/mach-omap2/temp_sensor_device.c |  188 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig               |   12 ++
 3 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/temp_sensor_device.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2d5d981..5812fb4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
+obj-$(CONFIG_OMAP_TEMP_SENSOR)          += temp_sensor_device.o
 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
 # SMP support ONLY available for OMAP4
diff --git a/arch/arm/mach-omap2/temp_sensor_device.c b/arch/arm/mach-omap2/temp_sensor_device.c
new file mode 100644
index 0000000..12d6789
--- /dev/null
+++ b/arch/arm/mach-omap2/temp_sensor_device.c
@@ -0,0 +1,188 @@
+/*
+ * OMAP on die Temperature sensor device file
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: J Keerthy <j-keerthy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/idr.h>
+#include <plat/omap_device.h>
+#include "pm.h"
+#include <plat/temperature_sensor.h>
+
+
+int omap_temp_sensor_device_idle(struct omap_device *od)
+{
+	struct	omap_temp_sensor_registers	*registers;
+	struct	resource			*mem;
+	void	__iomem				*phy_base;
+	unsigned long				timeout;
+	u32					ret = 0, temp;
+
+	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&od->pdev.dev, "no mem resource\n");
+		ret = -EINVAL;
+		goto plat_res_err;
+	}
+
+	phy_base = ioremap(mem->start, resource_size(mem));
+
+	if (!phy_base) {
+		dev_err(&od->pdev.dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto plat_res_err;
+	}
+
+	if (!strcmp(od->hwmods[0]->dev_attr, "mpu"))
+		registers = &omap_mpu_temp_sensor_registers;
+
+	temp = __raw_readl(phy_base + registers->temp_sensor_ctrl);
+	temp |= registers->bgap_tempsoff_mask;
+
+	/* BGAP_TEMPSOFF should be set to 1 before gating clock */
+	__raw_writel(temp, phy_base + registers->temp_sensor_ctrl);
+	temp = __raw_readl(phy_base + registers->bgap_status);
+	timeout = jiffies + msecs_to_jiffies(5);
+
+	/* wait till the clean stop bit is set or till the timeout expires */
+	while (!(temp | registers->status_clean_stop_mask) &&
+			!(time_after(jiffies, timeout))) {
+		temp = __raw_readl(phy_base + registers->bgap_status);
+		usleep_range(500, 2000);
+	}
+
+	if (time_after(jiffies, timeout))
+		dev_err(&od->pdev.dev, "Clean stop bit not set\n");
+
+	ret = omap_device_idle_hwmods(od);
+	iounmap(phy_base);
+plat_res_err:
+	return ret;
+}
+
+int omap_temp_sensor_device_activate(struct omap_device *od)
+{
+	struct	omap_temp_sensor_registers	*registers;
+	struct	resource			*mem;
+	void	__iomem				*phy_base;
+	u32					ret = 0, temp;
+
+	ret = omap_device_enable_hwmods(od);
+	if (ret < 0)
+		return ret;
+	mem = platform_get_resource(&od->pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&od->pdev.dev, "no mem resource\n");
+		return -EINVAL;
+	}
+
+	phy_base = ioremap(mem->start, resource_size(mem));
+	if (!phy_base) {
+		dev_err(&od->pdev.dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto plat_res_err;
+	}
+
+	if (!strcmp(od->hwmods[0]->dev_attr, "mpu"))
+		registers = &omap_mpu_temp_sensor_registers;
+
+	temp = __raw_readl(phy_base + registers->temp_sensor_ctrl);
+	temp &= ~(registers->bgap_tempsoff_mask);
+	/* BGAP_TEMPSOFF should be reset to 0 */
+	__raw_writel(temp,
+			phy_base + registers->temp_sensor_ctrl);
+	iounmap(phy_base);
+
+plat_res_err:
+	return ret;
+}
+
+static struct omap_device_pm_latency omap_temp_sensor_latency[] = {
+	{
+		.deactivate_func = omap_temp_sensor_device_idle,
+		.activate_func =  omap_temp_sensor_device_activate,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	}
+};
+
+static DEFINE_IDR(temp_sensor_device_idr);
+
+static int temp_sensor_dev_init(struct omap_hwmod *oh, void *user)
+{
+	struct	omap_temp_sensor_pdata		*temp_sensor_pdata;
+	struct	omap_device			*od;
+	struct	omap_temp_sensor_dev_attr	*temp_sensor_dev_attr;
+	int					ret = 0;
+	int					num;
+
+	temp_sensor_pdata =
+	    kzalloc(sizeof(*temp_sensor_pdata), GFP_KERNEL);
+	if (!temp_sensor_pdata) {
+		dev_err(&oh->od->pdev.dev,
+			"Unable to allocate memory for temp sensor pdata\n");
+		return -ENOMEM;
+	}
+
+	ret = idr_pre_get(&temp_sensor_device_idr, GFP_KERNEL);
+	if (ret < 0)
+		goto fail_id;
+	ret = idr_get_new(&temp_sensor_device_idr, temp_sensor_pdata, &num);
+	if (ret < 0)
+		goto fail_id;
+
+	temp_sensor_dev_attr = oh->dev_attr;
+	if (!strcmp(temp_sensor_dev_attr->name, "mpu")) {
+		temp_sensor_pdata->registers = &omap_mpu_temp_sensor_registers;
+	} else {
+		dev_warn(&oh->od->pdev.dev, "Invalid device attribute\n");
+		ret = -EINVAL;
+		goto fail_id;
+	}
+
+	od = omap_device_build("omap_temp_sensor", num,
+		oh, temp_sensor_pdata, sizeof(*temp_sensor_pdata),
+		omap_temp_sensor_latency,
+		ARRAY_SIZE(omap_temp_sensor_latency), 0);
+
+	if (IS_ERR(od)) {
+		dev_warn(&oh->od->pdev.dev,
+			"Could not build omap_device for %s\n", oh->name);
+		ret = PTR_ERR(od);
+	}
+
+fail_id:
+	kfree(temp_sensor_pdata);
+
+	return ret;
+}
+
+int __init omap_devinit_temp_sensor(void)
+{
+	if (!cpu_is_omap446x())
+		return 0;
+
+	return omap_hwmod_for_each_by_class("temperature_sensor",
+			temp_sensor_dev_init, NULL);
+}
+
+arch_initcall(omap_devinit_temp_sensor);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6e6735f..8fd8e80 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -115,6 +115,18 @@ config OMAP_MCBSP
 	  Say Y here if you want support for the OMAP Multichannel
 	  Buffered Serial Port.
 
+config OMAP_TEMP_SENSOR
+	bool "OMAP Temp Sensor Support"
+	depends on ARCH_OMAP
+	default n
+	help
+	  Say Y here if you want support for the temp sensor
+	  on OMAP4460.
+
+	  This provides the temperature of the MPU
+	  subsystem. Only one instance of on die temperature
+	  sensor is present.
+
 config OMAP_MBOX_FWK
 	tristate "Mailbox framework support"
 	depends on ARCH_OMAP
-- 
1.7.0.4

