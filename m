From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/14] ARM: OMAP2+: Remove legacy i2c.c platform init code
Date: Fri, 11 Nov 2016 11:16:59 -0800
Message-ID: <20161111191711.5079-3-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can now initialize I2C for mach-omap2 using device tree. And we
can move the remaining code in plat-omap/i2c.c into mach-omap1/i2c.c.

Note that we cannot remove some of the I2C bus reset functions
as they are being used by hwmod code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/i2c.c   |  83 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/i2c.c   |  97 ------------------------------------
 arch/arm/plat-omap/Makefile |   3 --
 arch/arm/plat-omap/i2c.c    | 116 --------------------------------------------
 4 files changed, 83 insertions(+), 216 deletions(-)
 delete mode 100644 arch/arm/plat-omap/i2c.c

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <linux/i2c.h>
 #include <linux/i2c-omap.h>
 #include <mach/mux.h>
 #include "soc.h"
@@ -91,6 +92,88 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
 	return platform_device_register(pdev);
 }
 
+#define OMAP_I2C_MAX_CONTROLLERS 4
+static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
+
+#define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
+
+/**
+ * omap_i2c_bus_setup - Process command line options for the I2C bus speed
+ * @str: String of options
+ *
+ * This function allow to override the default I2C bus speed for given I2C
+ * bus with a command line option.
+ *
+ * Format: i2c_bus=bus_id,clkrate (in kHz)
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+static int __init omap_i2c_bus_setup(char *str)
+{
+	int ints[3];
+
+	get_options(str, 3, ints);
+	if (ints[0] < 2 || ints[1] < 1 ||
+			ints[1] > OMAP_I2C_MAX_CONTROLLERS)
+		return 0;
+	i2c_pdata[ints[1] - 1].clkrate = ints[2];
+	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
+
+	return 1;
+}
+__setup("i2c_bus=", omap_i2c_bus_setup);
+
+/*
+ * Register busses defined in command line but that are not registered with
+ * omap_register_i2c_bus from board initialization code.
+ */
+int __init omap_register_i2c_bus_cmdline(void)
+{
+	int i, err = 0;
+
+	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
+		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
+			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
+			err = omap_i2c_add_bus(&i2c_pdata[i], i + 1);
+			if (err)
+				goto out;
+		}
+
+out:
+	return err;
+}
+
+/**
+ * omap_register_i2c_bus - register I2C bus with device descriptors
+ * @bus_id: bus id counting from number 1
+ * @clkrate: clock rate of the bus in kHz
+ * @info: pointer into I2C device descriptor table or NULL
+ * @len: number of descriptors in the table
+ *
+ * Returns 0 on success or an error code.
+ */
+int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
+			  struct i2c_board_info const *info,
+			  unsigned len)
+{
+	int err;
+
+	BUG_ON(bus_id < 1 || bus_id > OMAP_I2C_MAX_CONTROLLERS);
+
+	if (info) {
+		err = i2c_register_board_info(bus_id, info, len);
+		if (err)
+			return err;
+	}
+
+	if (!i2c_pdata[bus_id - 1].clkrate)
+		i2c_pdata[bus_id - 1].clkrate = clkrate;
+
+	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
+
+	return omap_i2c_add_bus(&i2c_pdata[bus_id - 1], bus_id);
+}
+
 static  int __init omap_i2c_cmdline(void)
 {
 	return omap_register_i2c_bus_cmdline();
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -26,7 +26,6 @@
 
 #include "prm.h"
 #include "common.h"
-#include "mux.h"
 #include "i2c.h"
 
 /* In register I2C_CON, Bit 15 is the I2C enable bit */
@@ -36,20 +35,6 @@
 
 #define MAX_OMAP_I2C_HWMOD_NAME_LEN	16
 
-static void __init omap2_i2c_mux_pins(int bus_id)
-{
-	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
-
-	/* First I2C bus is not muxable */
-	if (bus_id == 1)
-		return;
-
-	sprintf(mux_name, "i2c%i_scl.i2c%i_scl", bus_id, bus_id);
-	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
-	sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
-	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
-}
-
 /**
  * omap_i2c_reset - reset the omap i2c module.
  * @oh: struct omap_hwmod *
@@ -107,85 +92,3 @@ int omap_i2c_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
-
-static int __init omap_i2c_nr_ports(void)
-{
-	int ports = 0;
-
-	if (cpu_is_omap24xx())
-		ports = 2;
-	else if (cpu_is_omap34xx())
-		ports = 3;
-	else if (cpu_is_omap44xx())
-		ports = 4;
-	return ports;
-}
-
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
-static const char name[] = "omap_i2c";
-
-int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
-				int bus_id)
-{
-	int l;
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
-	struct omap_i2c_bus_platform_data *pdata;
-	struct omap_i2c_dev_attr *dev_attr;
-
-	if (bus_id > omap_i2c_nr_ports())
-		return -EINVAL;
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
-	pdata = i2c_pdata;
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
-				 sizeof(struct omap_i2c_bus_platform_data));
-	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-
-static  int __init omap_i2c_cmdline(void)
-{
-	return omap_register_i2c_bus_cmdline();
-}
-omap_subsys_initcall(omap_i2c_cmdline);
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -11,6 +11,3 @@ obj-y := sram.o dma.o counter_32k.o
 
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
-obj-y += $(i2c-omap-m) $(i2c-omap-y)
-
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
deleted file mode 100644
--- a/arch/arm/plat-omap/i2c.c
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/i2c.c
- *
- * Helper module for board specific I2C bus registration
- *
- * Copyright (C) 2007 Nokia Corporation.
- *
- * Contact: Jarkko Nikula <jhnikula@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/i2c-omap.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-
-#include <plat/i2c.h>
-
-#define OMAP_I2C_MAX_CONTROLLERS 4
-static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
-
-#define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
-
-/**
- * omap_i2c_bus_setup - Process command line options for the I2C bus speed
- * @str: String of options
- *
- * This function allow to override the default I2C bus speed for given I2C
- * bus with a command line option.
- *
- * Format: i2c_bus=bus_id,clkrate (in kHz)
- *
- * Returns 1 on success, 0 otherwise.
- */
-static int __init omap_i2c_bus_setup(char *str)
-{
-	int ints[3];
-
-	get_options(str, 3, ints);
-	if (ints[0] < 2 || ints[1] < 1 ||
-			ints[1] > OMAP_I2C_MAX_CONTROLLERS)
-		return 0;
-	i2c_pdata[ints[1] - 1].clkrate = ints[2];
-	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
-
-	return 1;
-}
-__setup("i2c_bus=", omap_i2c_bus_setup);
-
-/*
- * Register busses defined in command line but that are not registered with
- * omap_register_i2c_bus from board initialization code.
- */
-int __init omap_register_i2c_bus_cmdline(void)
-{
-	int i, err = 0;
-
-	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
-		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
-			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
-			err = omap_i2c_add_bus(&i2c_pdata[i], i + 1);
-			if (err)
-				goto out;
-		}
-
-out:
-	return err;
-}
-
-/**
- * omap_register_i2c_bus - register I2C bus with device descriptors
- * @bus_id: bus id counting from number 1
- * @clkrate: clock rate of the bus in kHz
- * @info: pointer into I2C device descriptor table or NULL
- * @len: number of descriptors in the table
- *
- * Returns 0 on success or an error code.
- */
-int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
-			  struct i2c_board_info const *info,
-			  unsigned len)
-{
-	int err;
-
-	BUG_ON(bus_id < 1 || bus_id > OMAP_I2C_MAX_CONTROLLERS);
-
-	if (info) {
-		err = i2c_register_board_info(bus_id, info, len);
-		if (err)
-			return err;
-	}
-
-	if (!i2c_pdata[bus_id - 1].clkrate)
-		i2c_pdata[bus_id - 1].clkrate = clkrate;
-
-	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
-
-	return omap_i2c_add_bus(&i2c_pdata[bus_id - 1], bus_id);
-}
-- 
2.10.2
