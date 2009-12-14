From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/4] OMAP: I2C: split device registration; convert OMAP2+ to omap_device
Date: Mon, 14 Dec 2009 14:42:38 +0530
Message-ID: <1260781959-28050-3-git-send-email-rnayak@ti.com>
References: <1260781959-28050-1-git-send-email-rnayak@ti.com>
 <1260781959-28050-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52689 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885AbZLNJMq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 04:12:46 -0500
In-Reply-To: <1260781959-28050-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Split the OMAP1 and OMAP2+ platform_device build and register code.
Convert the OMAP2+ variant to use omap_device.

This patch was developed in collaboration with Rajendra Nayak
<rnayak@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/Makefile          |    2 +
 arch/arm/mach-omap1/i2c.c             |  137 ++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/i2c.c             |  132 ++++++++++++++++++++++
 arch/arm/plat-omap/i2c.c              |  200 +++++++++------------------------
 arch/arm/plat-omap/include/plat/i2c.h |   22 ++++
 6 files changed, 349 insertions(+), 146 deletions(-)
 create mode 100644 arch/arm/mach-omap1/i2c.c
 create mode 100644 arch/arm/mach-omap2/i2c.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 87e539a..660eac6 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_PM) += pm.o sleep.o
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
 mailbox_mach-objs		:= mailbox.o
 
+obj-$(CONFIG_I2C_OMAP)		+= i2c.o
+
 led-y := leds.o
 
 # Specific board support
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
new file mode 100644
index 0000000..4642b36
--- /dev/null
+++ b/arch/arm/mach-omap1/i2c.c
@@ -0,0 +1,137 @@
+/*
+ * linux/arch/arm/mach-omap1/i2c.c
+ *
+ * Helper module for board specific I2C bus registration
+ *
+ * Copyright (C) 2007, 2009 Nokia Corporation.
+ *
+ * Contact: Jarkko Nikula <jhnikula@gmail.com>
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
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
+#include <mach/i2c.h>
+#include <mach/irqs.h>
+#include <mach/mux.h>
+
+#define OMAP1_I2C_SIZE		0x3f
+#define OMAP1_I2C_BASE		0xfffb3800
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
+static void __init omap1_i2c_mux_pins(int bus)
+{
+	omap_cfg_reg(I2C_SCL);
+	omap_cfg_reg(I2C_SDA);
+}
+
+int __init omap1_i2c_nr_ports(void)
+{
+	return 1;
+}
+
+static int omap1_i2c_device_enable(struct platform_device *pdev)
+{
+	struct clk *c;
+
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
+	omap1_i2c_mux_pins(bus_id - 1);
+
+	return platform_device_register(pdev);
+}
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1ff10eb..1a4843e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -57,6 +57,8 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 # Debobs
 obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
 
+obj-$(CONFIG_I2C_OMAP)			+= i2c.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
new file mode 100644
index 0000000..09f28ca
--- /dev/null
+++ b/arch/arm/mach-omap2/i2c.c
@@ -0,0 +1,132 @@
+/*
+ * linux/arch/arm/plat-omap/i2c.c
+ *
+ * Helper module for board specific I2C bus registration
+ *
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Jarkko Nikula <jhnikula@gmail.com>
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
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+
+#include <plat/irqs.h>
+#include <plat/mux.h>
+#include <plat/i2c.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
+static const char name[] = "i2c_omap";
+
+#define MAX_OMAP_I2C_HWMOD_NAME_LEN			16
+
+#if defined(CONFIG_ARCH_OMAP24XX)
+static const int omap24xx_pins[][2] = {
+	{ M19_24XX_I2C1_SCL, L15_24XX_I2C1_SDA },
+	{ J15_24XX_I2C2_SCL, H19_24XX_I2C2_SDA },
+};
+#else
+static const int omap24xx_pins[][2] = {};
+#endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+static const int omap34xx_pins[][2] = {
+	{ K21_34XX_I2C1_SCL, J21_34XX_I2C1_SDA},
+	{ AF15_34XX_I2C2_SCL, AE15_34XX_I2C2_SDA},
+	{ AF14_34XX_I2C3_SCL, AG14_34XX_I2C3_SDA},
+};
+#else
+static const int omap34xx_pins[][2] = {};
+#endif
+
+static void __init omap2_i2c_mux_pins(int bus)
+{
+	int scl, sda;
+
+	if (cpu_is_omap24xx()) {
+		scl = omap24xx_pins[bus][0];
+		sda = omap24xx_pins[bus][1];
+	} else if (cpu_is_omap34xx()) {
+		scl = omap34xx_pins[bus][0];
+		sda = omap34xx_pins[bus][1];
+	} else {
+		return;
+	}
+
+	omap_cfg_reg(sda);
+	omap_cfg_reg(scl);
+}
+
+int __init omap2_i2c_nr_ports(void)
+{
+	int ports = 0;
+
+	if (cpu_is_omap24xx())
+		ports = 2;
+	else if (cpu_is_omap34xx())
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
+	omap2_i2c_mux_pins(idx);
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
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index f8eb3a0..1a3facb 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -3,7 +3,7 @@
  *
  * Helper module for board specific I2C bus registration
  *
- * Copyright (C) 2007 Nokia Corporation.
+ * Copyright (C) 2007, 2009 Nokia Corporation.
  *
  * Contact: Jarkko Nikula <jhnikula@gmail.com>
  *
@@ -24,84 +24,28 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/platform_device.h>
 #include <linux/i2c-omap.h>
+#include <plat/i2c.h>
+#include <plat/cpu.h>
 
-#include <mach/irqs.h>
-#include <plat/mux.h>
 #include <plat/omap-pm.h>
 
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
-#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
-#endif
-#if	defined(CONFIG_ARCH_OMAP34XX)
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
+/*
+ * Indicates to the OMAP platform I2C init code that the rate was set
+ * from the kernel command line
+ */
+#define OMAP_I2C_CMDLINE_SETUP		(BIT(31))
 
-static struct omap_i2c_bus_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
-static struct platform_device omap_i2c_devices[] = {
-	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
-#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
-#endif
-#if	defined(CONFIG_ARCH_OMAP34XX)
-	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
-#endif
-};
+#define OMAP_I2C_MAX_CONTROLLERS	3
 
-#if defined(CONFIG_ARCH_OMAP24XX)
-static const int omap24xx_pins[][2] = {
-	{ M19_24XX_I2C1_SCL, L15_24XX_I2C1_SDA },
-	{ J15_24XX_I2C2_SCL, H19_24XX_I2C2_SDA },
-};
-#else
-static const int omap24xx_pins[][2] = {};
-#endif
-#if defined(CONFIG_ARCH_OMAP34XX)
-static const int omap34xx_pins[][2] = {
-	{ K21_34XX_I2C1_SCL, J21_34XX_I2C1_SDA},
-	{ AF15_34XX_I2C2_SCL, AE15_34XX_I2C2_SDA},
-	{ AF14_34XX_I2C3_SCL, AG14_34XX_I2C3_SDA},
-};
-#else
-static const int omap34xx_pins[][2] = {};
-#endif
+static struct omap_i2c_platform_data omap_i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
 
-#define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
+struct omap_i2c_platform_data * __init omap_i2c_get_pdata(int bus_id)
+{
+	return &omap_i2c_pdata[bus_id];
+}
 
 #ifdef CONFIG_ARCH_OMAP34XX
 /*
@@ -122,7 +66,7 @@ static inline void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val){}
 #endif
 
 static void __init omap_set_i2c_constraint_func(
-				struct omap_i2c_bus_platform_data *pd)
+				struct omap_i2c_platform_data *pd)
 {
 	if (cpu_is_omap34xx())
 		pd->set_mpu_wkup_lat = omap_i2c_set_wfc_mpu_wkup_lat;
@@ -130,66 +74,6 @@ static void __init omap_set_i2c_constraint_func(
 		pd->set_mpu_wkup_lat = NULL;
 }
 
-static void __init omap_i2c_mux_pins(int bus)
-{
-	int scl, sda;
-
-	if (cpu_class_is_omap1()) {
-		scl = I2C_SCL;
-		sda = I2C_SDA;
-	} else if (cpu_is_omap24xx()) {
-		scl = omap24xx_pins[bus][0];
-		sda = omap24xx_pins[bus][1];
-	} else if (cpu_is_omap34xx()) {
-		scl = omap34xx_pins[bus][0];
-		sda = omap34xx_pins[bus][1];
-	} else {
-		return;
-	}
-
-	omap_cfg_reg(sda);
-	omap_cfg_reg(scl);
-}
-
-static int __init omap_i2c_nr_ports(void)
-{
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
-	omap_i2c_mux_pins(bus_id - 1);
-	return platform_device_register(pdev);
-}
-
 /**
  * omap_i2c_bus_setup - Process command line options for the I2C bus speed
  * @str: String of options
@@ -205,13 +89,23 @@ static int __init omap_i2c_bus_setup(char *str)
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
-	i2c_pdata[ints[1] - 1].clkrate = ints[2];
-	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
+
+	rate = ints[2];
+	rate |= OMAP_I2C_CMDLINE_SETUP;
+
+	omap_i2c_pdata[ints[1] - 1].rate = rate;
 
 	return 1;
 }
@@ -225,11 +119,15 @@ static int __init omap_register_i2c_bus_cmdline(void)
 {
 	int i, err = 0;
 
-	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
-		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
-			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
-			omap_set_i2c_constraint_func(&i2c_pdata[i]);
-			err = omap_i2c_add_bus(i + 1);
+	for (i = 0; i < OMAP_I2C_MAX_CONTROLLERS; i++)
+		if (omap_i2c_pdata[i].rate & OMAP_I2C_CMDLINE_SETUP) {
+			omap_i2c_pdata[i].rate &= ~OMAP_I2C_CMDLINE_SETUP;
+			err = -EINVAL;
+			if (cpu_class_is_omap1())
+				err = omap1_i2c_add_bus(i + 1);
+			else if (cpu_class_is_omap2())
+				err = omap2_i2c_add_bus(i + 1);
+			omap_set_i2c_constraint_func(&omap_i2c_pdata[i]);
 			if (err)
 				goto out;
 		}
@@ -253,8 +151,14 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
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
@@ -262,11 +166,15 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			return err;
 	}
 
-	if (!i2c_pdata[bus_id - 1].clkrate)
-		i2c_pdata[bus_id - 1].clkrate = clkrate;
+	if (!omap_i2c_pdata[bus_id - 1].rate)
+		omap_i2c_pdata[bus_id - 1].rate = clkrate;
 
-	omap_set_i2c_constraint_func(&i2c_pdata[bus_id - 1]);
-	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
+	omap_set_i2c_constraint_func(&omap_i2c_pdata[bus_id - 1]);
+	omap_i2c_pdata[bus_id - 1].rate &= ~OMAP_I2C_CMDLINE_SETUP;
+
+	if (cpu_class_is_omap1())
+		return omap1_i2c_add_bus(bus_id);
+	else if (cpu_class_is_omap2())
+		return omap2_i2c_add_bus(bus_id);
 
-	return omap_i2c_add_bus(bus_id);
 }
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 886ee5d..1fe96ea 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -40,4 +40,26 @@ struct omap_i2c_dev_attr {
 	u8	flags;
 };
 
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
 #endif
-- 
1.5.4.7

