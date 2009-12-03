From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] omap: Split i2c platform init for mach-omap1 and
	mach-omap2
Date: Wed, 02 Dec 2009 16:22:23 -0800
Message-ID: <20091203002223.2769.36853.stgit@localhost>
References: <20091203001601.2769.20621.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55212 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbZLCAWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 19:22:18 -0500
In-Reply-To: <20091203001601.2769.20621.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

Otherwise we cannot limit new mux code to mach-omap2.
The same signal names should eventually work for other
omaps under mach-omap2.

Note that these pins don't need to be OMAP_PIN_INPUT_PULLUP,
just OMAP_PIN_INPUT is enough.

Cc: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Makefile             |    3 ++
 arch/arm/mach-omap1/i2c.c                |   33 ++++++++++++++++++
 arch/arm/mach-omap2/Makefile             |    3 ++
 arch/arm/mach-omap2/i2c.c                |   56 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/i2c.c                 |   44 +-----------------------
 arch/arm/plat-omap/include/plat/common.h |   14 +-------
 arch/arm/plat-omap/include/plat/i2c.h    |   39 +++++++++++++++++++++
 7 files changed, 137 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-omap1/i2c.c
 create mode 100644 arch/arm/mach-omap2/i2c.c
 create mode 100644 arch/arm/plat-omap/include/plat/i2c.h

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 87e539a..51bc195 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -17,6 +17,9 @@ obj-$(CONFIG_PM) += pm.o sleep.o
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
 mailbox_mach-objs		:= mailbox.o
 
+i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
+obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
+
 led-y := leds.o
 
 # Specific board support
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
new file mode 100644
index 0000000..bc9d12b
--- /dev/null
+++ b/arch/arm/mach-omap1/i2c.c
@@ -0,0 +1,33 @@
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
+#include <plat/i2c.h>
+#include <plat/mux.h>
+
+int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
+			  struct i2c_board_info const *info,
+			  unsigned len)
+{
+	omap_cfg_reg(I2C_SDA);
+	omap_cfg_reg(I2C_SCL);
+
+	return omap_plat_register_i2c_bus(bus_id, clkrate, info, len);
+}
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3d0c35f..52ceeef 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -55,6 +55,9 @@ iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
 
 obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 
+i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
+obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
new file mode 100644
index 0000000..789ca8c
--- /dev/null
+++ b/arch/arm/mach-omap2/i2c.c
@@ -0,0 +1,56 @@
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
+#include <plat/cpu.h>
+#include <plat/i2c.h>
+#include <plat/mux.h>
+
+#include "mux.h"
+
+int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
+			  struct i2c_board_info const *info,
+			  unsigned len)
+{
+	if (cpu_is_omap24xx()) {
+		const int omap24xx_pins[][2] = {
+			{ M19_24XX_I2C1_SCL, L15_24XX_I2C1_SDA },
+			{ J15_24XX_I2C2_SCL, H19_24XX_I2C2_SDA },
+		};
+		int scl, sda;
+
+		scl = omap24xx_pins[bus_id - 1][0];
+		sda = omap24xx_pins[bus_id - 1][1];
+		omap_cfg_reg(sda);
+		omap_cfg_reg(scl);
+	}
+
+	/* First I2C bus is not muxable */
+	if (cpu_is_omap34xx() && bus_id > 1) {
+		char mux_name[sizeof("i2c2_scl.i2c2_scl")];
+
+		sprintf(mux_name, "i2c%i_scl.i2c%i_scl", bus_id, bus_id);
+		omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
+		sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
+		omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
+	}
+
+	return omap_plat_register_i2c_bus(bus_id, clkrate, info, len);
+}
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index c08362d..33fff4e 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -80,47 +80,8 @@ static struct platform_device omap_i2c_devices[] = {
 #endif
 };
 
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
-
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
 
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
 static int __init omap_i2c_nr_ports(void)
 {
 	int ports = 0;
@@ -156,7 +117,6 @@ static int __init omap_i2c_add_bus(int bus_id)
 		res[1].start = irq;
 	}
 
-	omap_i2c_mux_pins(bus_id - 1);
 	return platform_device_register(pdev);
 }
 
@@ -209,7 +169,7 @@ out:
 subsys_initcall(omap_register_i2c_bus_cmdline);
 
 /**
- * omap_register_i2c_bus - register I2C bus with device descriptors
+ * omap_plat_register_i2c_bus - register I2C bus with device descriptors
  * @bus_id: bus id counting from number 1
  * @clkrate: clock rate of the bus in kHz
  * @info: pointer into I2C device descriptor table or NULL
@@ -217,7 +177,7 @@ subsys_initcall(omap_register_i2c_bus_cmdline);
  *
  * Returns 0 on success or an error code.
  */
-int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
+int __init omap_plat_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
 {
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 064f173..754fbc8 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -27,7 +27,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
 #define __ARCH_ARM_MACH_OMAP_COMMON_H
 
-#include <linux/i2c.h>
+#include <plat/i2c.h>
 
 struct sys_timer;
 
@@ -36,18 +36,6 @@ extern void __iomem *gic_cpu_base_addr;
 
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
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
 
 /* IO bases for various OMAP processors */
 struct omap_globals {
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
new file mode 100644
index 0000000..585d9ca
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -0,0 +1,39 @@
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
+#include <linux/i2c.h>
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
+int omap_plat_register_i2c_bus(int bus_id, u32 clkrate,
+				 struct i2c_board_info const *info,
+				 unsigned len);

