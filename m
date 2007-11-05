From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/3] ARM: OMAP: Add helper module for board specific I2C bus
	registration
Date: Mon,  5 Nov 2007 15:15:57 +0200
Message-ID: <1194268559-16539-2-git-send-email-jarkko.nikula@nokia.com>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This helper module simplifies I2C bus registration for different OMAP
platforms by doing registration in one place only and to allow board
specific bus configuration like clock rate and number of busses configured.

Helper should cover OMAP processors from first to third generation.

This patch just adds the feature and current implementation cleanup and
board file modifications will be done in following patches.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/Makefile        |    1 +
 arch/arm/plat-omap/i2c.c           |  150 ++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/common.h |    7 ++
 3 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/i2c.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 282ea00..9d97ae5 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
+obj-$(CONFIG_I2C_OMAP) += i2c.o
 
 # OMAP MMU framework
 obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
new file mode 100644
index 0000000..ff247b7
--- /dev/null
+++ b/arch/arm/plat-omap/i2c.c
@@ -0,0 +1,150 @@
+/*
+ * linux/arch/arm/plat-omap/i2c.c
+ *
+ * Helper module for board specific I2C bus registration
+ *
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
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
+#include <asm/mach-types.h>
+#include <asm/arch/mux.h>
+
+#define OMAP_I2C_SIZE		0x3f
+#define OMAP1_I2C_BASE		0xfffb3800
+#define OMAP2_I2C_BASE1		0x48070000
+#define OMAP2_I2C_BASE2		0x48072000
+#define OMAP2_I2C_BASE3		0x48060000
+
+static const char name[] = "i2c_omap";
+
+#define I2C_RESOURCE_BUILDER(base, irq)			\
+	{						\
+		.start	= (base),			\
+		.end	= (base) + OMAP_I2C_SIZE,	\
+		.flags	= IORESOURCE_MEM,		\
+	},						\
+	{						\
+		.start	= (irq),			\
+		.flags	= IORESOURCE_IRQ,		\
+	},
+
+static struct resource i2c_resources[][2] = {
+	{ I2C_RESOURCE_BUILDER(0, 0) },
+#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
+#endif
+#if	defined(CONFIG_ARCH_OMAP34XX)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
+#endif
+};
+
+#define I2C_DEV_BUILDER(bus_id, res, data)		\
+	{						\
+		.id	= (bus_id),			\
+		.name	= name,				\
+		.num_resources	= ARRAY_SIZE(res),	\
+		.resource	= (res),		\
+		.dev		= {			\
+			.platform_data	= (data),	\
+		},					\
+	}
+
+static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
+static struct platform_device omap_i2c_devices[] = {
+	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
+#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
+#endif
+#if	defined(CONFIG_ARCH_OMAP34XX)
+	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
+#endif
+};
+
+/*
+ * REVISIT: How many boards really require muxing here? It should be done
+ * by the bootloader and if not, then the muxing should go into those
+ * board files. Since this is not known yet, do it here like how previous
+ * implementation was doing. However, eventually this function shall disappear
+ */
+static void omap_i2c_mux_pins(int bus_id)
+{
+	switch (bus_id) {
+	case 1:
+		if (cpu_class_is_omap1()) {
+			omap_cfg_reg(I2C_SCL);
+			omap_cfg_reg(I2C_SDA);
+		}
+		break;
+	case 2:
+		if (cpu_is_omap24xx()) {
+			omap_cfg_reg(J15_24XX_I2C2_SCL);
+			omap_cfg_reg(H19_24XX_I2C2_SDA);
+		}
+		break;
+	}
+}
+
+int omap_register_i2c_bus(int bus_id, u32 clkrate,
+			  struct i2c_board_info const *info,
+			  unsigned len)
+{
+	int ports, err;
+	struct platform_device *pdev;
+	struct resource *res;
+	resource_size_t base, irq;
+
+	if (cpu_class_is_omap1())
+		ports = 1;
+	else if (cpu_is_omap24xx())
+		ports = 2;
+	else if (cpu_is_omap34xx())
+		ports = 3;
+
+	BUG_ON(bus_id < 1 || bus_id > ports);
+
+	if (info) {
+		err = i2c_register_board_info(bus_id, info, len);
+		if (err)
+			return err;
+	}
+
+	pdev = &omap_i2c_devices[bus_id - 1];
+	*(u32 *)pdev->dev.platform_data = clkrate;
+
+	if (bus_id == 1) {
+		res = pdev->resource;
+		if (cpu_class_is_omap1()) {
+			base = OMAP1_I2C_BASE;
+			irq = INT_I2C;
+		} else {
+			base = OMAP2_I2C_BASE1;
+			irq = INT_24XX_I2C1_IRQ;
+		}
+		res[0].start = base;
+		res[0].end = base + OMAP_I2C_SIZE;
+		res[1].start = irq;
+	}
+
+	omap_i2c_mux_pins(bus_id);
+	return platform_device_register(pdev);
+}
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 08d58ab..089ddc7 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -27,10 +27,17 @@
 #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
 #define __ARCH_ARM_MACH_OMAP_COMMON_H
 
+#ifdef CONFIG_I2C_OMAP
+#include <linux/i2c.h>
+#endif
+
 struct sys_timer;
 
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
+extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
+				 struct i2c_board_info const *info,
+				 unsigned len);
 
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
-- 
1.5.3.4
