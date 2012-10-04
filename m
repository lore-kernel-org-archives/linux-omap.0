From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/16] ARM: OMAP: Split plat-omap/i2c.c into mach-omap1 and
 mach-omap2
Date: Thu, 04 Oct 2012 15:04:36 -0700
Message-ID: <20121004220436.26676.33938.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11055 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751234Ab2JDWEk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:04:40 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

There's no need to keep the device related things in the
common i2c.c as omap2+ is using hwmod. Split the code to
mach-omap1 and mach-omap2 parts and only leave common
code to plat-omap/i2c.c.

Note that as omap1 only has one i2c controller, we can
now remove the old device related macros.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/common.h               |    3 +
 arch/arm/mach-omap1/i2c.c                  |   59 +++++++++++
 arch/arm/mach-omap2/board-rm680.c          |    1 
 arch/arm/mach-omap2/common.h               |    4 +
 arch/arm/mach-omap2/i2c.c                  |   72 +++++++++++++
 arch/arm/mach-omap2/i2c.h                  |   25 +----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    4 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    4 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 -
 arch/arm/mach-omap2/twl-common.c           |    1 
 arch/arm/plat-omap/i2c.c                   |  152 +---------------------------
 arch/arm/plat-omap/i2c.h                   |   46 ++++++++
 arch/arm/plat-omap/include/plat/common.h   |    1 
 15 files changed, 202 insertions(+), 181 deletions(-)
 rename arch/arm/{plat-omap/include/plat/i2c.h => mach-omap2/i2c.h} (66%)
 create mode 100644 arch/arm/plat-omap/i2c.h

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index c2552b2..306b7ac 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -28,6 +28,9 @@
 
 #include <plat/common.h>
 #include <linux/mtd/mtd.h>
+#include <linux/i2c-omap.h>
+
+#include "../plat-omap/i2c.h"
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 void omap7xx_map_io(void);
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index a0551a6..a6f465a 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -19,11 +19,25 @@
  *
  */
 
-#include <plat/i2c.h>
+#include <linux/i2c-omap.h>
 #include <mach/mux.h>
 #include <plat/cpu.h>
 
-void __init omap1_i2c_mux_pins(int bus_id)
+#include "../plat-omap/i2c.h"
+
+#define OMAP_I2C_SIZE		0x3f
+#define OMAP1_I2C_BASE		0xfffb3800
+#define OMAP1_INT_I2C		(32 + 4)
+
+static const char name[] = "omap_i2c";
+
+static struct resource i2c_resources[2] = {
+};
+
+static struct platform_device omap_i2c_devices[1] = {
+};
+
+static void __init omap1_i2c_mux_pins(int bus_id)
 {
 	if (cpu_is_omap7xx()) {
 		omap_cfg_reg(I2C_7XX_SDA);
@@ -33,3 +47,44 @@ void __init omap1_i2c_mux_pins(int bus_id)
 		omap_cfg_reg(I2C_SCL);
 	}
 }
+
+int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
+				int bus_id)
+{
+	struct platform_device *pdev;
+	struct resource *res;
+
+	omap1_i2c_mux_pins(bus_id);
+
+	pdev = &omap_i2c_devices[bus_id - 1];
+	pdev->id = bus_id;
+	pdev->name = name;
+	pdev->num_resources = ARRAY_SIZE(i2c_resources);
+	res = i2c_resources;
+	res[0].start = OMAP1_I2C_BASE;
+	res[0].end = res[0].start + OMAP_I2C_SIZE;
+	res[0].flags = IORESOURCE_MEM;
+	res[1].start = OMAP1_INT_I2C;
+	res[1].flags = IORESOURCE_IRQ;
+	pdev->resource = res;
+
+	/* all OMAP1 have IP version 1 register set */
+	pdata->rev = OMAP_I2C_IP_VERSION_1;
+
+	/* all OMAP1 I2C are implemented like this */
+	pdata->flags = OMAP_I2C_FLAG_NO_FIFO |
+		       OMAP_I2C_FLAG_SIMPLE_CLOCK |
+		       OMAP_I2C_FLAG_16BIT_DATA_REG |
+		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
+
+	/* how the cpu bus is wired up differs for 7xx only */
+
+	if (cpu_is_omap7xx())
+		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_1;
+	else
+		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
+
+	pdev->dev.platform_data = pdata;
+
+	return platform_device_register(pdev);
+}
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 45997bf..a57ed21 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -22,7 +22,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
-#include <plat/i2c.h>
 #include <plat/mmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 7045e4d..a68b421 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -28,7 +28,9 @@
 
 #include <linux/irq.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/i2c/twl.h>
+#include <linux/i2c-omap.h>
 
 #include <asm/proc-fns.h>
 
@@ -36,6 +38,8 @@
 #include <plat/serial.h>
 #include <plat/common.h>
 
+#include "i2c.h"
+
 #define OMAP_INTC_START		NR_IRQS
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index fc57e67..b15416c 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -19,11 +19,15 @@
  *
  */
 
-#include <plat/i2c.h>
+#include <linux/i2c-omap.h>
+
 #include "common.h"
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+#include <plat/omap-pm.h>
 
 #include "mux.h"
+#include "i2c.h"
 
 /* In register I2C_CON, Bit 15 is the I2C enable bit */
 #define I2C_EN					BIT(15)
@@ -33,7 +37,9 @@
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
 
-void __init omap2_i2c_mux_pins(int bus_id)
+#define MAX_OMAP_I2C_HWMOD_NAME_LEN	16
+
+static void __init omap2_i2c_mux_pins(int bus_id)
 {
 	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
 
@@ -104,3 +110,65 @@ int omap_i2c_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+/*
+ * XXX This function is a temporary compatibility wrapper - only
+ * needed until the I2C driver can be converted to call
+ * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
+ */
+static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
+{
+	omap_pm_set_max_mpu_wakeup_lat(dev, t);
+}
+
+static const char name[] = "omap_i2c";
+
+int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
+				int bus_id)
+{
+	int l;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
+	struct omap_i2c_bus_platform_data *pdata;
+	struct omap_i2c_dev_attr *dev_attr;
+
+	omap2_i2c_mux_pins(bus_id);
+
+	l = snprintf(oh_name, MAX_OMAP_I2C_HWMOD_NAME_LEN, "i2c%d", bus_id);
+	WARN(l >= MAX_OMAP_I2C_HWMOD_NAME_LEN,
+		"String buffer overflow in I2C%d device setup\n", bus_id);
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+			pr_err("Could not look up %s\n", oh_name);
+			return -EEXIST;
+	}
+
+	pdata = i2c_pdata;
+	/*
+	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
+	 * use, and functionality implementation flags, up to the OMAP I2C
+	 * driver via platform data
+	 */
+	pdata->rev = oh->class->rev;
+
+	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
+	pdata->flags = dev_attr->flags;
+
+	/*
+	 * When waiting for completion of a i2c transfer, we need to
+	 * set a wake up latency constraint for the MPU. This is to
+	 * ensure quick enough wakeup from idle, when transfer
+	 * completes.
+	 * Only omap3 has support for constraints
+	 */
+	if (cpu_is_omap34xx())
+		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
+	pdev = omap_device_build(name, bus_id, oh, pdata,
+			sizeof(struct omap_i2c_bus_platform_data),
+			NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
+
+	return PTR_RET(pdev);
+}
+
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/mach-omap2/i2c.h
similarity index 66%
rename from arch/arm/plat-omap/include/plat/i2c.h
rename to arch/arm/mach-omap2/i2c.h
index 7c22b9e..81dbb99 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/mach-omap2/i2c.h
@@ -18,24 +18,11 @@
  * 02110-1301 USA
  *
  */
-#ifndef __ASM__ARCH_OMAP_I2C_H
-#define __ASM__ARCH_OMAP_I2C_H
 
-#include <linux/i2c.h>
-#include <linux/i2c-omap.h>
+#include "../plat-omap/i2c.h"
 
-#if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
-extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
-				 struct i2c_board_info const *info,
-				 unsigned len);
-#else
-static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
-				 struct i2c_board_info const *info,
-				 unsigned len)
-{
-	return 0;
-}
-#endif
+#ifndef __MACH_OMAP2_I2C_H
+#define __MACH_OMAP2_I2C_H
 
 /**
  * i2c_dev_attr - OMAP I2C controller device attributes for omap_hwmod
@@ -50,10 +37,6 @@ struct omap_i2c_dev_attr {
 	u32	flags;
 };
 
-void __init omap1_i2c_mux_pins(int bus_id);
-void __init omap2_i2c_mux_pins(int bus_id);
-
-struct omap_hwmod;
 int omap_i2c_reset(struct omap_hwmod *oh);
 
-#endif /* __ASM__ARCH_OMAP_I2C_H */
+#endif	/* __MACH_OMAP2_I2C_H */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b5db600..1821109 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -12,12 +12,13 @@
  * XXX handle crossbar/shared link difference for L3?
  * XXX these should be marked initdata for multi-OMAP kernels
  */
+
+#include <linux/i2c-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
-#include <plat/i2c.h>
 #include <plat/dmtimer.h>
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
@@ -27,6 +28,7 @@
 
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
+#include "i2c.h"
 #include "wd_timer.h"
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c455e41..f902a18 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -12,13 +12,14 @@
  * XXX handle crossbar/shared link difference for L3?
  * XXX these should be marked initdata for multi-OMAP kernels
  */
+
+#include <linux/i2c-omap.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
-#include <plat/i2c.h>
 #include <plat/dmtimer.h>
 #include <plat/mmc.h>
 #include "l3_2xxx.h"
@@ -27,6 +28,7 @@
 #include "omap_hwmod_common_data.h"
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
+#include "i2c.h"
 #include "wd_timer.h"
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 59d5c1c..67f1ac4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -14,13 +14,14 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/i2c-omap.h>
+
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
-#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -28,6 +29,7 @@
 #include "cm33xx.h"
 #include "prm33xx.h"
 #include "prm-regbits-33xx.h"
+#include "i2c.h"
 
 /*
  * IP blocks
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 2857772..e72ccdc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -14,6 +14,8 @@
  *
  * XXX these should be marked initdata for multi-OMAP kernels
  */
+
+#include <linux/i2c-omap.h>
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/gpio-omap.h>
 
@@ -22,7 +24,6 @@
 #include <plat/serial.h>
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
-#include <plat/i2c.h>
 #include <plat/mmc.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
@@ -35,6 +36,7 @@
 #include "omap_hwmod_common_data.h"
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
+#include "i2c.h"
 #include "wd_timer.h"
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..964d61d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -21,9 +21,9 @@
 #include <linux/io.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/power/smartreflex.h>
+#include <linux/i2c-omap.h>
 
 #include <plat/omap_hwmod.h>
-#include <plat/i2c.h>
 #include <plat/dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
@@ -37,6 +37,7 @@
 #include "cm2_44xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
+#include "i2c.h"
 #include "wd_timer.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 974974c..0468814 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -26,7 +26,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 
-#include <plat/i2c.h>
 #include <plat/usb.h>
 
 #include "soc.h"
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 6013831..37597a6 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -32,48 +32,12 @@
 #include <linux/clk.h>
 
 #include <mach/irqs.h>
-#include <plat/i2c.h>
-#include <plat/omap-pm.h>
-#include <plat/omap_device.h>
+#include <plat/cpu.h>
 
-#define OMAP_I2C_SIZE		0x3f
-#define OMAP1_I2C_BASE		0xfffb3800
-#define OMAP1_INT_I2C		(32 + 4)
+#include "i2c.h"
 
-static const char name[] = "omap_i2c";
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
-#define MAX_OMAP_I2C_HWMOD_NAME_LEN	16
 #define OMAP_I2C_MAX_CONTROLLERS 4
 static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
-static struct platform_device omap_i2c_devices[] = {
-	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
-};
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
 
@@ -93,114 +57,6 @@ static int __init omap_i2c_nr_ports(void)
 	return ports;
 }
 
-static inline int omap1_i2c_add_bus(int bus_id)
-{
-	struct platform_device *pdev;
-	struct omap_i2c_bus_platform_data *pdata;
-	struct resource *res;
-
-	omap1_i2c_mux_pins(bus_id);
-
-	pdev = &omap_i2c_devices[bus_id - 1];
-	res = pdev->resource;
-	res[0].start = OMAP1_I2C_BASE;
-	res[0].end = res[0].start + OMAP_I2C_SIZE;
-	res[1].start = OMAP1_INT_I2C;
-	pdata = &i2c_pdata[bus_id - 1];
-
-	/* all OMAP1 have IP version 1 register set */
-	pdata->rev = OMAP_I2C_IP_VERSION_1;
-
-	/* all OMAP1 I2C are implemented like this */
-	pdata->flags = OMAP_I2C_FLAG_NO_FIFO |
-		       OMAP_I2C_FLAG_SIMPLE_CLOCK |
-		       OMAP_I2C_FLAG_16BIT_DATA_REG |
-		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
-
-	/* how the cpu bus is wired up differs for 7xx only */
-
-	if (cpu_is_omap7xx())
-		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_1;
-	else
-		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
-
-	return platform_device_register(pdev);
-}
-
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-/*
- * XXX This function is a temporary compatibility wrapper - only
- * needed until the I2C driver can be converted to call
- * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
- */
-static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
-{
-	omap_pm_set_max_mpu_wakeup_lat(dev, t);
-}
-
-static inline int omap2_i2c_add_bus(int bus_id)
-{
-	int l;
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
-	struct omap_i2c_bus_platform_data *pdata;
-	struct omap_i2c_dev_attr *dev_attr;
-
-	omap2_i2c_mux_pins(bus_id);
-
-	l = snprintf(oh_name, MAX_OMAP_I2C_HWMOD_NAME_LEN, "i2c%d", bus_id);
-	WARN(l >= MAX_OMAP_I2C_HWMOD_NAME_LEN,
-		"String buffer overflow in I2C%d device setup\n", bus_id);
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-			pr_err("Could not look up %s\n", oh_name);
-			return -EEXIST;
-	}
-
-	pdata = &i2c_pdata[bus_id - 1];
-	/*
-	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
-	 * use, and functionality implementation flags, up to the OMAP I2C
-	 * driver via platform data
-	 */
-	pdata->rev = oh->class->rev;
-
-	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
-	pdata->flags = dev_attr->flags;
-
-	/*
-	 * When waiting for completion of a i2c transfer, we need to
-	 * set a wake up latency constraint for the MPU. This is to
-	 * ensure quick enough wakeup from idle, when transfer
-	 * completes.
-	 * Only omap3 has support for constraints
-	 */
-	if (cpu_is_omap34xx())
-		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
-	pdev = omap_device_build(name, bus_id, oh, pdata,
-			sizeof(struct omap_i2c_bus_platform_data),
-			NULL, 0, 0);
-	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
-
-	return PTR_RET(pdev);
-}
-#else
-static inline int omap2_i2c_add_bus(int bus_id)
-{
-	return 0;
-}
-#endif
-
-static int __init omap_i2c_add_bus(int bus_id)
-{
-	if (cpu_class_is_omap1())
-		return omap1_i2c_add_bus(bus_id);
-	else
-		return omap2_i2c_add_bus(bus_id);
-}
-
 /**
  * omap_i2c_bus_setup - Process command line options for the I2C bus speed
  * @str: String of options
@@ -239,7 +95,7 @@ static int __init omap_register_i2c_bus_cmdline(void)
 	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
 		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
 			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
-			err = omap_i2c_add_bus(i + 1);
+			err = omap_i2c_add_bus(&i2c_pdata[i], i + 1);
 			if (err)
 				goto out;
 		}
@@ -277,5 +133,5 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 
 	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
 
-	return omap_i2c_add_bus(bus_id);
+	return omap_i2c_add_bus(&i2c_pdata[bus_id - 1], bus_id);
 }
diff --git a/arch/arm/plat-omap/i2c.h b/arch/arm/plat-omap/i2c.h
new file mode 100644
index 0000000..9ae01a0
--- /dev/null
+++ b/arch/arm/plat-omap/i2c.h
@@ -0,0 +1,46 @@
+/*
+ * Helper module for board specific I2C bus registration
+ *
+ * Copyright (C) 2009 Nokia Corporation.
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
+#ifndef __PLAT_OMAP_I2C_H
+#define __PLAT_OMAP_I2C_H
+
+struct i2c_board_info;
+
+int omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
+			int bus_id);
+
+#if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
+				 struct i2c_board_info const *info,
+				 unsigned len);
+#else
+static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
+				 struct i2c_board_info const *info,
+				 unsigned len)
+{
+	return 0;
+}
+#endif
+
+struct omap_hwmod;
+int omap_i2c_reset(struct omap_hwmod *oh);
+
+#endif /* __PLAT_OMAP_I2C_H */
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index d1cb6f5..55c0f8b 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -27,7 +27,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
 #define __ARCH_ARM_MACH_OMAP_COMMON_H
 
-#include <plat/i2c.h>
 #include <plat/omap_hwmod.h>
 
 extern int __init omap_init_clocksource_32k(void __iomem *vbase);

