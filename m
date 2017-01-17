From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 3/4] cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
Date: Tue, 17 Jan 2017 07:18:07 -0600
Message-ID: <20170117131808.29798-4-d-gerlach@ti.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117131808.29798-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some TI SoCs, like those in the AM335x, AM437x, DRA7x, and AM57x families,
have different OPPs available for the MPU depending on which specific
variant of the SoC is in use. This can be determined through use of the
revision and an eFuse register present in the silicon. Introduce a
ti-cpufreq driver that can read the aformentioned values and provide
them as version matching data to the opp framework. Through this the
opp-supported-hw dt binding that is part of the operating-points-v2
table can be used to indicate availability of OPPs for each device.

This driver also creates the "cpufreq-dt" platform_device after passing
the version matching data to the OPP framework so that the cpufreq-dt
handles the actual cpufreq implementation. Even without the necessary
data to pass the version matching data the driver will still create this
device to maintain backwards compatibility with operating-points v1
tables.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
v3->v4:
	Update to use simplified binding, only use "syscon" now to pass control
	module register space and add offsets to relevant data for each SoC.

 drivers/cpufreq/Kconfig.arm  |  11 ++
 drivers/cpufreq/Makefile     |   1 +
 drivers/cpufreq/ti-cpufreq.c | 272 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 920c469f3953..6d87742fc5aa 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -247,6 +247,17 @@ config ARM_TEGRA124_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
 
+config ARM_TI_CPUFREQ
+	bool "Texas Instruments CPUFreq support"
+	depends on ARCH_OMAP2PLUS
+	help
+	  This driver enables valid OPPs on the running platform based on
+	  values contained within the SoC in use. Enable this in order to
+	  use the cpufreq-dt driver on all Texas Instruments platforms that
+	  provide dt based operating-points-v2 tables with opp-supported-hw
+	  data provided. Required for cpufreq support on AM335x, AM437x,
+	  DRA7x, and AM57x platforms.
+
 config ARM_PXA2xx_CPUFREQ
 	tristate "Intel PXA2xx CPUfreq driver"
 	depends on PXA27x || PXA25x
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 1e46c3918e7a..2078a0f212d8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
+obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
new file mode 100644
index 000000000000..a2a4e84c6166
--- /dev/null
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -0,0 +1,272 @@
+/*
+ * TI CPUFreq/OPP hw-supported driver
+ *
+ * Copyright (C) 2016-2017 Texas Instruments, Inc.
+ *	 Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
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
+#include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_opp.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define REVISION_MASK				0xF
+#define REVISION_SHIFT				28
+
+#define AM33XX_800M_ARM_MPU_MAX_FREQ		0x1E2F
+#define AM43XX_600M_ARM_MPU_MAX_FREQ		0xFFA
+
+#define DRA7_EFUSE_HAS_OD_MPU_OPP		11
+#define DRA7_EFUSE_HAS_HIGH_MPU_OPP		15
+#define DRA7_EFUSE_HAS_ALL_MPU_OPP		23
+
+#define DRA7_EFUSE_NOM_MPU_OPP			BIT(0)
+#define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
+#define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
+
+#define VERSION_COUNT				2
+
+struct ti_cpufreq_data;
+
+struct ti_cpufreq_soc_data {
+	unsigned long (*efuse_xlate)(struct ti_cpufreq_data *opp_data,
+				     unsigned long efuse);
+	unsigned long efuse_fallback;
+	unsigned long efuse_offset;
+	unsigned long efuse_mask;
+	unsigned long efuse_shift;
+	unsigned long rev_offset;
+};
+
+struct ti_cpufreq_data {
+	struct device *cpu_dev;
+	struct device_node *opp_node;
+	struct regmap *syscon;
+	const struct ti_cpufreq_soc_data *soc_data;
+};
+
+static unsigned long amx3_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				      unsigned long efuse)
+{
+	if (!efuse)
+		efuse = opp_data->soc_data->efuse_fallback;
+	/* AM335x and AM437x use "OPP disable" bits, so invert */
+	return ~efuse;
+}
+
+static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				      unsigned long efuse)
+{
+	unsigned long calculated_efuse = DRA7_EFUSE_NOM_MPU_OPP;
+
+	/*
+	 * The efuse on dra7 and am57 parts contains a specific
+	 * value indicating the highest available OPP.
+	 */
+
+	switch (efuse) {
+	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
+	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
+		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
+	case DRA7_EFUSE_HAS_OD_MPU_OPP:
+		calculated_efuse |= DRA7_EFUSE_OD_MPU_OPP;
+	}
+
+	return calculated_efuse;
+}
+
+static struct ti_cpufreq_soc_data am3x_soc_data = {
+	.efuse_xlate = amx3_efuse_xlate,
+	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
+	.efuse_offset = 0x07fc,
+	.efuse_mask = 0x1fff,
+	.rev_offset = 0x600,
+};
+
+static struct ti_cpufreq_soc_data am4x_soc_data = {
+	.efuse_xlate = amx3_efuse_xlate,
+	.efuse_fallback = AM43XX_600M_ARM_MPU_MAX_FREQ,
+	.efuse_offset = 0x0610,
+	.efuse_mask = 0x3f,
+	.rev_offset = 0x600,
+};
+
+static struct ti_cpufreq_soc_data dra7_soc_data = {
+	.efuse_xlate = dra7_efuse_xlate,
+	.efuse_offset = 0x020c,
+	.efuse_mask = 0xf80000,
+	.efuse_shift = 19,
+	.rev_offset = 0x204,
+};
+
+/**
+ * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
+ * @opp_data: pointer to ti_cpufreq_data context
+ * @efuse_value: Set to the value parsed from efuse
+ *
+ * Returns error code if efuse not read properly.
+ */
+static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
+				u32 *efuse_value)
+{
+	struct device *dev = opp_data->cpu_dev;
+	u32 efuse;
+	int ret;
+
+	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
+			  &efuse);
+	if (ret) {
+		dev_err(dev,
+			"Failed to read the efuse value from syscon: %d\n",
+			ret);
+		return ret;
+	}
+
+	efuse = (efuse & opp_data->soc_data->efuse_mask);
+	efuse >>= opp_data->soc_data->efuse_shift;
+
+	*efuse_value = opp_data->soc_data->efuse_xlate(opp_data, efuse);
+
+	return 0;
+}
+
+/**
+ * ti_cpufreq_get_rev() - Parse and return rev value present on SoC
+ * @opp_data: pointer to ti_cpufreq_data context
+ * @revision_value: Set to the value parsed from revision register
+ *
+ * Returns error code if revision not read properly.
+ */
+static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
+			      u32 *revision_value)
+{
+	struct device *dev = opp_data->cpu_dev;
+	u32 revision;
+	int ret;
+
+	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
+			  &revision);
+	if (ret) {
+		dev_err(dev,
+			"Failed to read the revision number from syscon: %d\n",
+			ret);
+		return ret;
+	}
+
+	*revision_value = BIT((revision >> REVISION_SHIFT) & REVISION_MASK);
+
+	return 0;
+}
+
+static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
+{
+	struct device *dev = opp_data->cpu_dev;
+	struct device_node *np = opp_data->opp_node;
+
+	opp_data->syscon = syscon_regmap_lookup_by_phandle(np,
+							"syscon");
+	if (IS_ERR(opp_data->syscon)) {
+		dev_err(dev,
+			"\"syscon\" is missing, cannot use OPPv2 table.\n");
+		return PTR_ERR(opp_data->syscon);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ti_cpufreq_of_match[] = {
+	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
+	{ .compatible = "ti,am4372", .data = &am4x_soc_data, },
+	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
+	{},
+};
+
+static int ti_cpufreq_init(void)
+{
+	u32 version[VERSION_COUNT];
+	struct device_node *np;
+	const struct of_device_id *match;
+	struct ti_cpufreq_data *opp_data;
+	int ret;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(ti_cpufreq_of_match, np);
+	if (!match)
+		return -ENODEV;
+
+	opp_data = kzalloc(sizeof(*opp_data), GFP_KERNEL);
+	if (!opp_data)
+		return -ENOMEM;
+
+	opp_data->soc_data = match->data;
+
+	opp_data->cpu_dev = get_cpu_device(0);
+	if (!opp_data->cpu_dev) {
+		pr_err("%s: Failed to get device for CPU0\n", __func__);
+		return -ENODEV;
+	}
+
+	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
+	if (!opp_data->opp_node) {
+		dev_info(opp_data->cpu_dev,
+			 "OPP-v2 not supported, cpufreq-dt will attempt to use legacy tables.\n");
+		goto register_cpufreq_dt;
+	}
+
+	ret = ti_cpufreq_setup_syscon_register(opp_data);
+	if (ret)
+		goto fail_put_node;
+
+	/*
+	 * OPPs determine whether or not they are supported based on
+	 * two metrics:
+	 *	0 - SoC Revision
+	 *	1 - eFuse value
+	 */
+	ret = ti_cpufreq_get_rev(opp_data, &version[0]);
+	if (ret)
+		goto fail_put_node;
+
+	ret = ti_cpufreq_get_efuse(opp_data, &version[1]);
+	if (ret)
+		goto fail_put_node;
+
+	of_node_put(opp_data->opp_node);
+
+	ret = dev_pm_opp_set_supported_hw(opp_data->cpu_dev, version,
+					  VERSION_COUNT);
+	if (ret) {
+		dev_err(opp_data->cpu_dev,
+			"Failed to set supported hardware\n");
+		goto fail_put_node;
+	}
+
+register_cpufreq_dt:
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+
+	return 0;
+
+fail_put_node:
+	of_node_put(opp_data->opp_node);
+
+	return ret;
+}
+module_init(ti_cpufreq_init);
+
+MODULE_DESCRIPTION("TI CPUFreq/OPP hw-supported driver");
+MODULE_AUTHOR("Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
