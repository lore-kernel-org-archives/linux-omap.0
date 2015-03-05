From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 3/3] remoteproc: wkup_m3: Add wkup_m3 remoteproc driver
Date: Wed, 4 Mar 2015 21:54:00 -0600
Message-ID: <1425527640-2690-4-git-send-email-d-gerlach@ti.com>
References: <1425527640-2690-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425527640-2690-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add a remoteproc driver to load the firmware for and boot the wkup_m3
present on am33xx and am43xx. The wkup_m3 is an integrated Cortex M3
that allows the SoC to enter the lowest possible power state by taking
control from the MPU after it has gone into its own low power state and
shutting off any additional peripherals.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/remoteproc/Kconfig            |  13 ++
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/wkup_m3_rproc.c    | 229 ++++++++++++++++++++++++++++++++++
 include/linux/platform_data/wkup_m3.h |  25 ++++
 4 files changed, 268 insertions(+)
 create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
 create mode 100644 include/linux/platform_data/wkup_m3.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 5e343ba..f73ba65 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -41,6 +41,19 @@ config STE_MODEM_RPROC
 	  This can be either built-in or a loadable module.
 	  If unsure say N.
 
+config WKUP_M3_RPROC
+	tristate "AMx3xx wkup-m3 remoteproc support"
+	depends on SOC_AM33XX || SOC_AM43XX
+	select REMOTEPROC
+	help
+	  Say y here to support AMx3xx wkup-m3.
+
+	  Required for Suspend-to-ram on AM33xx and AM43XX. Also needed
+	  for deep CPUIdle states on AM33xx. Allows for loading of
+	  firmware of CM3 PM coprocessor that is present on AMx3xx
+	  family of SoCs.
+	  If unsure say N.
+
 config DA8XX_REMOTEPROC
 	tristate "DA8xx/OMAP-L13x remoteproc support"
 	depends on ARCH_DAVINCI_DA8XX
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index ac2ff75..81b04d1 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -9,4 +9,5 @@ remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_STE_MODEM_RPROC)	 	+= ste_modem_rproc.o
+obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
new file mode 100644
index 0000000..252f6f7
--- /dev/null
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -0,0 +1,229 @@
+/*
+ * TI AMx3 Wkup M3 Remote Processor driver
+ *
+ * Copyright (C) 2014-2015 Texas Instruments, Inc.
+ *
+ * Dave Gerlach <d-gerlach@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/remoteproc.h>
+
+#include <linux/platform_data/wkup_m3.h>
+
+#include "remoteproc_internal.h"
+
+#define WKUPM3_MEM_MAX	2
+
+struct wkup_m3_mem {
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	u32 dev_addr;
+	size_t size;
+};
+
+struct wkup_m3_rproc {
+	struct rproc *rproc;
+	struct platform_device *pdev;
+	struct wkup_m3_mem mem[WKUPM3_MEM_MAX];
+};
+
+static int wkup_m3_rproc_start(struct rproc *rproc)
+{
+	struct wkup_m3_rproc *wkupm3 = rproc->priv;
+	struct platform_device *pdev = wkupm3->pdev;
+	struct device *dev = &pdev->dev;
+	struct wkup_m3_platform_data *pdata = dev->platform_data;
+
+	if (pdata->deassert_reset(pdev, pdata->reset_name)) {
+		dev_err(dev, "Unable to reset wkup_m3!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int wkup_m3_rproc_stop(struct rproc *rproc)
+{
+	struct wkup_m3_rproc *wkupm3 = rproc->priv;
+	struct platform_device *pdev = wkupm3->pdev;
+	struct device *dev = &pdev->dev;
+	struct wkup_m3_platform_data *pdata = dev->platform_data;
+
+	if (pdata->assert_reset(pdev, pdata->reset_name)) {
+		dev_err(dev, "Unable to assert reset of wkup_m3!\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void *wkup_m3_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct wkup_m3_rproc *wkupm3 = rproc->priv;
+	void *va = NULL;
+	int i;
+	u32 offset;
+
+	if (len <= 0)
+		return NULL;
+
+	for (i = 0; i < WKUPM3_MEM_MAX; i++) {
+		if (da >= wkupm3->mem[i].dev_addr &&
+		    da + len <= wkupm3->mem[i].dev_addr +
+		    wkupm3->mem[i].size) {
+			offset = da - wkupm3->mem[i].dev_addr;
+			va = (__force void *)(wkupm3->mem[i].cpu_addr + offset);
+			break;
+		}
+	}
+
+	return va;
+}
+
+static struct rproc_ops wkup_m3_rproc_ops = {
+	.start		= wkup_m3_rproc_start,
+	.stop		= wkup_m3_rproc_stop,
+	.da_to_va	= wkup_m3_rproc_da_to_va,
+};
+
+static const struct of_device_id wkup_m3_rproc_of_match[] = {
+	{ .compatible = "ti,am3353-wkup-m3", },
+	{ .compatible = "ti,am4372-wkup-m3", },
+	{},
+};
+
+static int wkup_m3_rproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const char *fw_name;
+	struct wkup_m3_platform_data *pdata = dev->platform_data;
+	struct wkup_m3_rproc *wkupm3;
+	struct rproc *rproc;
+	struct resource *res;
+	const __be32 *addrp;
+	u64 size;
+	int ret;
+	int i;
+
+	if (!(pdata && pdata->deassert_reset && pdata->assert_reset &&
+	      pdata->reset_name)) {
+		dev_err(dev, "Platform data missing!\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_string(dev->of_node, "ti,pm-firmware",
+				      &fw_name);
+	if (ret) {
+		dev_err(dev, "No firmware filename given\n");
+		return -ENODEV;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
+		goto err;
+	}
+
+	rproc = rproc_alloc(dev, "wkup_m3", &wkup_m3_rproc_ops,
+			    fw_name, sizeof(*wkupm3));
+	if (!rproc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	wkupm3 = rproc->priv;
+	wkupm3->rproc = rproc;
+	wkupm3->pdev = pdev;
+
+	for (i = 0; i < WKUPM3_MEM_MAX; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		wkupm3->mem[i].cpu_addr = devm_ioremap_resource(dev, res);
+		if (IS_ERR(wkupm3->mem[i].cpu_addr)) {
+			dev_err(&pdev->dev, "devm_ioremap_resource failed for resource %d\n",
+				i);
+			ret = PTR_ERR(wkupm3->mem[i].cpu_addr);
+			goto err;
+		}
+		wkupm3->mem[i].bus_addr = res->start;
+		wkupm3->mem[i].size = resource_size(res);
+		addrp = of_get_address(dev->of_node, i, &size, NULL);
+		wkupm3->mem[i].dev_addr = be32_to_cpu(*addrp);
+	}
+
+	dev_set_drvdata(dev, rproc);
+
+	/* Register as a remoteproc device */
+	ret = rproc_add(rproc);
+	if (ret) {
+		dev_err(dev, "rproc_add failed\n");
+		goto err_put_rproc;
+	}
+
+	return 0;
+
+err_put_rproc:
+	rproc_put(rproc);
+err:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static int wkup_m3_rproc_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+
+	rproc_del(rproc);
+	rproc_put(rproc);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int wkup_m3_rpm_suspend(struct device *dev)
+{
+	return -EBUSY;
+}
+
+static int wkup_m3_rpm_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops wkup_m3_rproc_pm_ops = {
+	SET_RUNTIME_PM_OPS(wkup_m3_rpm_suspend, wkup_m3_rpm_resume, NULL)
+};
+
+static struct platform_driver wkup_m3_rproc_driver = {
+	.probe = wkup_m3_rproc_probe,
+	.remove = wkup_m3_rproc_remove,
+	.driver = {
+		.name = "wkup_m3_rproc",
+		.of_match_table = wkup_m3_rproc_of_match,
+		.pm = &wkup_m3_rproc_pm_ops,
+	},
+};
+
+module_platform_driver(wkup_m3_rproc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("wkup m3 remote processor control driver");
+MODULE_AUTHOR("Dave Gerlach <d-gerlach@ti.com>");
diff --git a/include/linux/platform_data/wkup_m3.h b/include/linux/platform_data/wkup_m3.h
new file mode 100644
index 0000000..39247c5
--- /dev/null
+++ b/include/linux/platform_data/wkup_m3.h
@@ -0,0 +1,25 @@
+/*
+ * omap wkup_m3: platform data
+ *
+ * Copyright (C) 2015 Texas Instruments, Inc.
+ *
+ * Dave Gerlach <d-gerlach@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_WKUP_M3_H
+#define _LINUX_PLATFORM_DATA_WKUP_M3_H
+
+struct platform_device;
+
+struct wkup_m3_platform_data {
+	const char *reset_name;
+
+	int (*assert_reset)(struct platform_device *pdev, const char *name);
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+};
+
+#endif /* _LINUX_PLATFORM_DATA_WKUP_M3_H */
-- 
2.3.0
