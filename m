From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 4/5] OMAP: I2C: split device registration and convert OMAP2+ to omap_device
Date: Fri, 17 Sep 2010 20:07:08 +0530
Message-ID: <1284734229-16281-5-git-send-email-rnayak@ti.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com>
 <1284734229-16281-2-git-send-email-rnayak@ti.com>
 <1284734229-16281-3-git-send-email-rnayak@ti.com>
 <1284734229-16281-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab0IQOhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 10:37:18 -0400
In-Reply-To: <1284734229-16281-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Paul Walmsley <paul@pwsan.com>

Split the OMAP1 and OMAP2+ platform_device build and register code.
Convert the OMAP2+ variant to use omap_device.

This patch was developed in collaboration with Rajendra Nayak
<rnayak@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/i2c.c |  124 ++++++++++++++++++----------------------------
 include/linux/i2c-omap.h |    5 ++
 2 files changed, 54 insertions(+), 75 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a5ce4f0..a5bff9c 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -27,18 +27,18 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-omap.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/clk.h>
 
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/i2c.h>
 #include <plat/omap-pm.h>
+#include <plat/omap_device.h>
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
-#define OMAP2_I2C_BASE1		0x48070000
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_BASE3		0x48060000
-#define OMAP4_I2C_BASE4		0x48350000
 
 static const char name[] = "i2c_omap";
 
@@ -55,15 +55,6 @@ static const char name[] = "i2c_omap";
 
 static struct resource i2c_resources[][2] = {
 	{ I2C_RESOURCE_BUILDER(0, 0) },
-#if	defined(CONFIG_ARCH_OMAP2PLUS)
-	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, 0) },
-#endif
-#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, 0) },
-#endif
-#if	defined(CONFIG_ARCH_OMAP4)
-	{ I2C_RESOURCE_BUILDER(OMAP4_I2C_BASE4, 0) },
-#endif
 };
 
 #define I2C_DEV_BUILDER(bus_id, res, data)		\
@@ -77,18 +68,11 @@ static struct resource i2c_resources[][2] = {
 		},					\
 	}
 
-static struct omap_i2c_bus_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
+#define MAX_OMAP_I2C_HWMOD_NAME_LEN	16
+#define OMAP_I2C_MAX_CONTROLLERS 4
+static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
-#if	defined(CONFIG_ARCH_OMAP2PLUS)
-	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
-#endif
-#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
-#endif
-#if	defined(CONFIG_ARCH_OMAP4)
-	I2C_DEV_BUILDER(4, i2c_resources[3], &i2c_pdata[3]),
-#endif
 };
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
@@ -109,35 +93,20 @@ static int __init omap_i2c_nr_ports(void)
 	return ports;
 }
 
-/* Shared between omap2 and 3 */
-static resource_size_t omap2_i2c_irq[3] __initdata = {
-	INT_24XX_I2C1_IRQ,
-	INT_24XX_I2C2_IRQ,
-	INT_34XX_I2C3_IRQ,
-};
-
-static resource_size_t omap4_i2c_irq[4] __initdata = {
-	OMAP44XX_IRQ_I2C1,
-	OMAP44XX_IRQ_I2C2,
-	OMAP44XX_IRQ_I2C3,
-	OMAP44XX_IRQ_I2C4,
-};
-
-static inline int omap1_i2c_add_bus(struct platform_device *pdev, int bus_id)
+static inline int omap1_i2c_add_bus(int bus_id)
 {
-	struct omap_i2c_bus_platform_data *pd;
-	struct resource *res;
-
-	pd = pdev->dev.platform_data;
-	res = pdev->resource;
-	res[0].start = OMAP1_I2C_BASE;
-	res[0].end = res[0].start + OMAP_I2C_SIZE;
-	res[1].start = INT_I2C;
+	struct platform_device *pdev;
+	struct omap_i2c_bus_platform_data *pdata;
+
 	omap1_i2c_mux_pins(bus_id);
 
+	pdev = &omap_i2c_devices[bus_id - 1];
+	pdata = &i2c_pdata[bus_id - 1];
+
 	return platform_device_register(pdev);
 }
 
+
 /*
  * XXX This function is a temporary compatibility wrapper - only
  * needed until the I2C driver can be converted to call
@@ -148,52 +117,57 @@ static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
 	omap_pm_set_max_mpu_wakeup_lat(dev, t);
 }
 
-static inline int omap2_i2c_add_bus(struct platform_device *pdev, int bus_id)
-{
-	struct resource *res;
-	resource_size_t *irq;
+static struct omap_device_pm_latency omap_i2c_latency[] = {
+	[0] = {
+		.deactivate_func	= omap_device_idle_hwmods,
+		.activate_func		= omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
 
-	res = pdev->resource;
+static inline int omap2_i2c_add_bus(int bus_id)
+{
+	int l;
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
+	struct omap_i2c_bus_platform_data *pdata;
 
-	if (!cpu_is_omap44xx())
-		irq = omap2_i2c_irq;
-	else
-		irq = omap4_i2c_irq;
+	omap2_i2c_mux_pins(bus_id);
 
-	if (bus_id == 1) {
-		res[0].start = OMAP2_I2C_BASE1;
-		res[0].end = res[0].start + OMAP_I2C_SIZE;
+	l = snprintf(oh_name, MAX_OMAP_I2C_HWMOD_NAME_LEN, "i2c%d", bus_id);
+	WARN(l >= MAX_OMAP_I2C_HWMOD_NAME_LEN,
+		"String buffer overflow in I2C%d device setup\n", bus_id);
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+			pr_err("Could not look up %s\n", oh_name);
+			return -EEXIST;
 	}
 
-	res[1].start = irq[bus_id - 1];
-	omap2_i2c_mux_pins(bus_id);
-
+	pdata = &i2c_pdata[bus_id - 1];
 	/*
 	 * When waiting for completion of a i2c transfer, we need to
 	 * set a wake up latency constraint for the MPU. This is to
 	 * ensure quick enough wakeup from idle, when transfer
 	 * completes.
+	 * Only omap3 has support for constraints
 	 */
-	if (cpu_is_omap34xx()) {
-		struct omap_i2c_bus_platform_data *pd;
-
-		pd = pdev->dev.platform_data;
-		pd->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
-	}
-
-	return platform_device_register(pdev);
+	if (cpu_is_omap34xx())
+		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
+	od = omap_device_build(name, bus_id, oh, pdata,
+			sizeof(struct omap_i2c_bus_platform_data),
+			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
+	WARN(IS_ERR(od), "Could not build omap_device for %s\n", name);
+
+	return PTR_ERR(od);
 }
 
 static int __init omap_i2c_add_bus(int bus_id)
 {
-	struct platform_device *pdev;
-
-	pdev = &omap_i2c_devices[bus_id - 1];
-
 	if (cpu_class_is_omap1())
-		return omap1_i2c_add_bus(pdev, bus_id);
+		return omap1_i2c_add_bus(bus_id);
 	else
-		return omap2_i2c_add_bus(pdev, bus_id);
+		return omap2_i2c_add_bus(bus_id);
 }
 
 /**
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 78ebf50..7472449 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -1,9 +1,14 @@
 #ifndef __I2C_OMAP_H__
 #define __I2C_OMAP_H__
 
+#include <linux/platform_device.h>
+
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
+	int		(*device_enable) (struct platform_device *pdev);
+	int		(*device_shutdown) (struct platform_device *pdev);
+	int		(*device_idle) (struct platform_device *pdev);
 };
 
 #endif
-- 
1.7.0.4

