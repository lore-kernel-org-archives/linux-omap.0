From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/6] OMAP: I2C: split device registration; convert OMAP2+ to omap_device
Date: Fri, 19 Feb 2010 17:57:15 +0530
Message-ID: <1266582437-22398-4-git-send-email-rnayak@ti.com>
References: <1266582437-22398-1-git-send-email-rnayak@ti.com>
 <1266582437-22398-2-git-send-email-rnayak@ti.com>
 <1266582437-22398-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37309 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0BSM11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 07:27:27 -0500
In-Reply-To: <1266582437-22398-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Split the OMAP1 and OMAP2+ platform_device build and register code.
Convert the OMAP2+ variant to use omap_device.

This patch was developed in collaboration with Rajendra Nayak
<rnayak@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/i2c.c             |  103 +++++++++++++++++++++++
 arch/arm/mach-omap2/i2c.c             |   67 +++++++++++++++
 arch/arm/plat-omap/i2c.c              |  144 +++++++++++----------------------
 arch/arm/plat-omap/include/plat/i2c.h |   24 ++++++
 4 files changed, 240 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 1bf4735..7cff846 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -19,9 +19,112 @@
  *
  */
 
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
 #include <plat/i2c.h>
 #include <plat/mux.h>
 #include <plat/cpu.h>
+#include <plat/irqs.h>
+
+#include "mux.h"
+
+#define OMAP1_I2C_SIZE         0x3f
+#define OMAP1_I2C_BASE         0xfffb3800
+
+static const char name[] = "i2c_omap";
+
+#define OMAP1_I2C_RESOURCE_BUILDER(base, irq)		\
+{
+	{						\
+		.start	= (base),			\
+		.end	= (base) + OMAP1_I2C_SIZE,	\
+		.flags	= IORESOURCE_MEM,		\
+	},						\
+	{						\
+		.start	= (irq),			\
+		.flags	= IORESOURCE_IRQ,		\
+	},						\
+}
+
+static struct resource i2c_resources[][2] = {
+	{ OMAP1_I2C_RESOURCE_BUILDER(OMAP1_I2C_BASE, INT_I2C) },
+};
+
+#define OMAP1_I2C_DEV_BUILDER(bus_id, res)		\
+	{						\
+		.id	= (bus_id),			\
+		.name	= name,				\
+		.num_resources	= ARRAY_SIZE(res),	\
+		.resource	= (res),		\
+	}
+
+static struct platform_device omap_i2c_devices[] = {
+	OMAP1_I2C_DEV_BUILDER(1, i2c_resources[0]),
+};
+
+#define I2C_ICLK	0
+#define I2C_FCLK	1
+static struct clk *omap_i2c_clks[ARRAY_SIZE(omap_i2c_devices)][2];
+
+static struct omap_i2c_dev_attr omap1_i2c_dev_attr;
+
+int __init omap1_i2c_nr_ports(void)
+{
+	return 1;
+}
+
+static int omap1_i2c_device_enable(struct platform_device *pdev)
+{
+	struct clk *c;
+	c = omap_i2c_clks[pdev->id - 1][I2C_ICLK];
+	if (c && !IS_ERR(c))
+		clk_enable(c);
+
+	c = omap_i2c_clks[pdev->id - 1][I2C_FCLK];
+	if (c && !IS_ERR(c))
+		clk_enable(c);
+
+	return 0;
+}
+
+static int omap1_i2c_device_idle(struct platform_device *pdev)
+{
+	struct clk *c;
+
+	c = omap_i2c_clks[pdev->id - 1][I2C_FCLK];
+	if (c && !IS_ERR(c))
+		clk_disable(c);
+
+	c = omap_i2c_clks[pdev->id - 1][I2C_ICLK];
+	if (c && !IS_ERR(c))
+		clk_disable(c);
+
+	return 0;
+}
+
+int __init omap1_i2c_add_bus(int bus_id)
+{
+	struct platform_device *pdev;
+	struct omap_i2c_platform_data *pdata;
+
+	pdev = &omap_i2c_devices[bus_id - 1];
+	pdata = omap_i2c_get_pdata(bus_id - 1);
+
+	/* idle and shutdown share the same code */
+	pdata->device_enable = omap1_i2c_device_enable;
+	pdata->device_idle = omap1_i2c_device_idle;
+	pdata->device_shutdown = omap1_i2c_device_idle;
+	pdata->dev_attr = &omap1_i2c_dev_attr;
+
+	omap_i2c_clks[bus_id - 1][I2C_ICLK] = clk_get(&pdev->dev, "ick");
+	omap_i2c_clks[bus_id - 1][I2C_FCLK] = clk_get(&pdev->dev, "fck");
+
+	return platform_device_register(pdev);
+}
 
 int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index 789ca8c..e773a25 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -19,12 +19,79 @@
  *
  */
 
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+
 #include <plat/cpu.h>
 #include <plat/i2c.h>
+#include <plat/irqs.h>
 #include <plat/mux.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 #include "mux.h"
 
+static const char name[] = "i2c_omap";
+
+#define MAX_OMAP_I2C_HWMOD_NAME_LEN		16
+
+int __init omap2_i2c_nr_ports(void)
+{
+	int ports = 0;
+
+	if (cpu_is_omap24xx())
+		ports = 2;
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
+		ports = 3;
+
+	return ports;
+}
+
+static struct omap_device_pm_latency omap_i2c_latency[] = {
+	[0] = {
+		.deactivate_func	= omap_device_idle_hwmods,
+		.activate_func		= omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int __init omap2_i2c_add_bus(int bus_id)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
+	int l, idx;
+	struct omap_i2c_platform_data *pdata;
+
+	idx = bus_id - 1;
+
+	l = snprintf(oh_name, MAX_OMAP_I2C_HWMOD_NAME_LEN,
+		     "i2c%d_hwmod", bus_id);
+	WARN(l >= MAX_OMAP_I2C_HWMOD_NAME_LEN,
+	     "String buffer overflow in I2C%d device setup\n", bus_id);
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -EEXIST;
+	}
+
+	pdata = omap_i2c_get_pdata(idx);
+	pdata->dev_attr = oh->dev_attr;
+	pdata->device_enable = omap_device_enable;
+	pdata->device_idle = omap_device_idle;
+	pdata->device_shutdown = omap_device_shutdown;
+
+	od = omap_device_build(name, bus_id, oh, pdata,
+			       sizeof(struct omap_i2c_platform_data),
+			       omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency));
+	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
+	     name, oh_name);
+
+	return PTR_ERR(od);
+}
+
 int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 96d2781..7c1bb32 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -28,96 +28,20 @@
 #include <linux/i2c.h>
 #include <mach/irqs.h>
 #include <plat/mux.h>
+#include <plat/i2c.h>
 
-#define OMAP_I2C_SIZE		0x3f
-#define OMAP1_I2C_BASE		0xfffb3800
-#define OMAP2_I2C_BASE1		0x48070000
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_BASE3		0x48060000
-
-static const char name[] = "i2c_omap";
-
-#define I2C_RESOURCE_BUILDER(base, irq)			\
-	{						\
-		.start	= (base),			\
-		.end	= (base) + OMAP_I2C_SIZE,	\
-		.flags	= IORESOURCE_MEM,		\
-	},						\
-	{						\
-		.start	= (irq),			\
-		.flags	= IORESOURCE_IRQ,		\
-	},
-
-static struct resource i2c_resources[][2] = {
-	{ I2C_RESOURCE_BUILDER(0, 0) },
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
-#endif
-#if	defined(CONFIG_ARCH_OMAP3)
-	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
-#endif
-};
-
-#define I2C_DEV_BUILDER(bus_id, res, data)		\
-	{						\
-		.id	= (bus_id),			\
-		.name	= name,				\
-		.num_resources	= ARRAY_SIZE(res),	\
-		.resource	= (res),		\
-		.dev		= {			\
-			.platform_data	= (data),	\
-		},					\
-	}
-
-static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
-static struct platform_device omap_i2c_devices[] = {
-	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
-#endif
-#if	defined(CONFIG_ARCH_OMAP3)
-	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
-#endif
-};
+/*
+ * Indicates to the OMAP platform I2C init code that the rate was set
+ * from the kernel command line
+ */
+#define OMAP_I2C_CMDLINE_SETUP		(BIT(31))
+#define OMAP_I2C_MAX_CONTROLLERS	3
 
-#define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
+static struct omap_i2c_platform_data omap_i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
 
-static int __init omap_i2c_nr_ports(void)
+struct omap_i2c_platform_data * __init omap_i2c_get_pdata(int bus_id)
 {
-	int ports = 0;
-
-	if (cpu_class_is_omap1())
-		ports = 1;
-	else if (cpu_is_omap24xx())
-		ports = 2;
-	else if (cpu_is_omap34xx())
-		ports = 3;
-
-	return ports;
-}
-
-static int __init omap_i2c_add_bus(int bus_id)
-{
-	struct platform_device *pdev;
-	struct resource *res;
-	resource_size_t base, irq;
-
-	pdev = &omap_i2c_devices[bus_id - 1];
-	if (bus_id == 1) {
-		res = pdev->resource;
-		if (cpu_class_is_omap1()) {
-			base = OMAP1_I2C_BASE;
-			irq = INT_I2C;
-		} else {
-			base = OMAP2_I2C_BASE1;
-			irq = INT_24XX_I2C1_IRQ;
-		}
-		res[0].start = base;
-		res[0].end = base + OMAP_I2C_SIZE;
-		res[1].start = irq;
-	}
-
-	return platform_device_register(pdev);
+	return &omap_i2c_pdata[bus_id];
 }
 
 /**
@@ -135,13 +59,23 @@ static int __init omap_i2c_bus_setup(char *str)
 {
 	int ports;
 	int ints[3];
+	int rate;
+
+	if (cpu_class_is_omap1())
+		ports = omap1_i2c_nr_ports();
+	else if (cpu_class_is_omap2())
+		ports = omap2_i2c_nr_ports();
+	else
+		ports = 0;
 
-	ports = omap_i2c_nr_ports();
 	get_options(str, 3, ints);
 	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
 		return 0;
-	i2c_rate[ints[1] - 1] = ints[2];
-	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
+
+	rate = ints[2];
+	rate |= OMAP_I2C_CMDLINE_SETUP;
+
+	omap_i2c_pdata[ints[1] - 1].rate = rate;
 
 	return 1;
 }
@@ -155,10 +89,14 @@ static int __init omap_register_i2c_bus_cmdline(void)
 {
 	int i, err = 0;
 
-	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
-		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
-			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
-			err = omap_i2c_add_bus(i + 1);
+	for (i = 0; i < ARRAY_SIZE(omap_i2c_pdata); i++)
+		if (omap_i2c_pdata[i].rate & OMAP_I2C_CMDLINE_SETUP) {
+			omap_i2c_pdata[i].rate &= ~OMAP_I2C_CMDLINE_SETUP;
+			err = -EINVAL;
+			if (cpu_class_is_omap1())
+				err = omap1_i2c_add_bus(i + 1);
+			else if (cpu_class_is_omap2())
+				err = omap2_i2c_add_bus(i + 1);
 			if (err)
 				goto out;
 		}
@@ -182,8 +120,14 @@ int __init omap_plat_register_i2c_bus(int bus_id, u32 clkrate,
 			  unsigned len)
 {
 	int err;
+	int nr_ports = 0;
+
+	if (cpu_class_is_omap1())
+		nr_ports = omap1_i2c_nr_ports();
+	else if (cpu_class_is_omap2())
+		nr_ports = omap2_i2c_nr_ports();
 
-	BUG_ON(bus_id < 1 || bus_id > omap_i2c_nr_ports());
+	BUG_ON(bus_id < 1 || bus_id > nr_ports);
 
 	if (info) {
 		err = i2c_register_board_info(bus_id, info, len);
@@ -191,9 +135,13 @@ int __init omap_plat_register_i2c_bus(int bus_id, u32 clkrate,
 			return err;
 	}
 
-	if (!i2c_rate[bus_id - 1])
-		i2c_rate[bus_id - 1] = clkrate;
-	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
+	if (!omap_i2c_pdata[bus_id - 1].rate)
+		omap_i2c_pdata[bus_id - 1].rate = clkrate;
+	omap_i2c_pdata[bus_id - 1].rate &= ~OMAP_I2C_CMDLINE_SETUP;
+
+	if (cpu_class_is_omap1())
+		return omap1_i2c_add_bus(bus_id);
+	else if (cpu_class_is_omap2())
+		return omap2_i2c_add_bus(bus_id);
 
-	return omap_i2c_add_bus(bus_id);
 }
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 6520980..aeb72f8 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -20,6 +20,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/platform_device.h>
 
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
@@ -50,3 +51,26 @@ struct omap_i2c_dev_attr {
 	u8      fifo_depth;
 	u8      flags;
 };
+
+/**
+ * struct omap_i2c_platform_data - OMAP I2C controller platform data
+ */
+struct omap_i2c_platform_data {
+	u32 rate;
+	struct omap_i2c_dev_attr *dev_attr;
+	void (*set_mpu_wkup_lat)(struct device *dev, int set);
+	int (*device_enable) (struct platform_device *pdev);
+	int (*device_shutdown) (struct platform_device *pdev);
+	int (*device_idle) (struct platform_device *pdev);
+};
+
+/* Prototypes for OMAP platform I2C core initialization code */
+
+struct omap_i2c_platform_data * __init omap_i2c_get_pdata(int bus_id);
+
+int __init omap1_i2c_nr_ports(void);
+int __init omap2_i2c_nr_ports(void);
+
+int __init omap1_i2c_add_bus(int bus_id);
+int __init omap2_i2c_add_bus(int bus_id);
+
-- 
1.5.4.7

