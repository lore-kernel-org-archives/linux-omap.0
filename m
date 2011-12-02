From: <hvaibhav@ti.com>
Subject: [PATCH-V5 1/3] arm:omap:am33xx: Update common OMAP machine specific sources
Date: Fri, 2 Dec 2011 12:13:22 +0530
Message-ID: <1322808204-12878-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1LBGnm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 01:43:42 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch updates the common machine specific source files for
support for AM33XX/AM335x with cpu type, macros for identification of
AM33XX/AM335X device.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |    3 +++
 arch/arm/mach-omap2/common.c               |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/id.c                   |    6 ++++++
 arch/arm/mach-omap2/io.c                   |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/serial.c               |    4 ++--
 arch/arm/plat-omap/include/plat/am33xx.h   |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h   |    2 ++
 arch/arm/plat-omap/include/plat/hardware.h |    1 +
 arch/arm/plat-omap/include/plat/io.h       |   20 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |    2 ++
 arch/arm/plat-omap/io.c                    |    5 +++++
 11 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/am33xx.h

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 5d0064a..c1ab6bc 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3517,6 +3517,9 @@ int __init omap3xxx_clk_init(void)
 	} else if (cpu_is_ti816x()) {
 		cpu_mask = RATE_IN_TI816X;
 		cpu_clkflg = CK_TI816X;
+	} else if (cpu_is_am33xx()) {
+		cpu_mask = RATE_IN_AM33XX;
+		cpu_clkflg = CK_AM33XX;
 	} else if (cpu_is_omap34xx()) {
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			cpu_mask = RATE_IN_3430ES1;
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 110e5b9..16bac26 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -128,6 +128,27 @@ void __init omap2_set_globals_ti816x(void)
 {
 	__omap2_set_globals(&ti816x_globals);
 }
+
+#define AM33XX_TAP_BASE		(AM33XX_CTRL_BASE + \
+				TI816X_CONTROL_DEVICE_ID - 0x204)
+
+static struct omap_globals am33xx_globals = {
+	.class  = AM335X_CLASS,
+	.tap    = AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE),
+	.ctrl   = AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
+	.prm    = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
+	.cm     = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
+};
+
+void __init omap2_set_globals_am33xx(void)
+{
+	__omap2_set_globals(&am33xx_globals);
+}
+
+void __init am33xx_map_io(void)
+{
+	omapam33xx_map_common_io();
+}
 #endif

 #if defined(CONFIG_ARCH_OMAP4)
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index f1784ee..37fe42f 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -340,6 +340,10 @@ static void __init omap3_check_revision(const char **cpu_rev)
 			break;
 		}
 		break;
+	case 0xb944:
+		omap_revision = AM335X_REV_ES1_0;
+		*cpu_rev = "1.0";
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP3630_REV_ES1_2;
@@ -432,6 +436,8 @@ static void __init omap3_cpuinfo(const char *cpu_rev)
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
 		cpu_name = "TI816X";
+	} else if (cpu_is_am335x()) {
+		cpu_name =  "AM335X";
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		cpu_name = "OMAP3430/3530";
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index da9bc4a..74e84c6 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -183,7 +183,24 @@ static struct map_desc omapti816x_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
 		.length		= L4_34XX_SIZE,
 		.type		= MT_DEVICE
+	}
+};
+#endif
+
+#ifdef CONFIG_SOC_OMAPAM33XX
+static struct map_desc omapam33xx_io_desc[] __initdata = {
+	{
+		.virtual	= L4_34XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
+		.length		= L4_34XX_SIZE,
+		.type		= MT_DEVICE
 	},
+	{
+		.virtual	= L4_WK_AM33XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_WK_AM33XX_PHYS),
+		.length		= L4_WK_AM33XX_SIZE,
+		.type		= MT_DEVICE
+	}
 };
 #endif

@@ -270,6 +287,13 @@ void __init omapti816x_map_common_io(void)
 }
 #endif

+#ifdef CONFIG_SOC_OMAPAM33XX
+void __init omapam33xx_map_common_io(void)
+{
+	iotable_init(omapam33xx_io_desc, ARRAY_SIZE(omapam33xx_io_desc));
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 void __init omap44xx_map_common_io(void)
 {
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0dbd5a2..03fc153 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -464,7 +464,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		mod_timer(&uart->timer, jiffies + uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);

-	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
+	if (cpu_is_omap34xx() && !(cpu_is_ti816x() || cpu_is_am33xx())) {
 		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
 		u32 padconf = 0;
@@ -828,7 +828,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	}

 	/* Enable the MDR1 errata for OMAP3 */
-	if (cpu_is_omap34xx() && !cpu_is_ti816x())
+	if (cpu_is_omap34xx() && !(cpu_is_ti816x() || cpu_is_am33xx()))
 		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
 }

diff --git a/arch/arm/plat-omap/include/plat/am33xx.h b/arch/arm/plat-omap/include/plat/am33xx.h
new file mode 100644
index 0000000..06c19bb
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/am33xx.h
@@ -0,0 +1,25 @@
+/*
+ * This file contains the address info for various AM33XX modules.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc. - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_ARCH_AM33XX_H
+#define __ASM_ARCH_AM33XX_H
+
+#define L4_SLOW_AM33XX_BASE	0x48000000
+
+#define AM33XX_SCM_BASE		0x44E10000
+#define AM33XX_CTRL_BASE	AM33XX_SCM_BASE
+#define AM33XX_PRCM_BASE	0x44E00000
+
+#endif /* __ASM_ARCH_AM33XX_H */
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 3ff3e36..bb8a6c1 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -82,6 +82,7 @@ void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
 void omap2_set_globals_ti816x(void);
+void omap2_set_globals_am33xx(void);

 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
@@ -92,6 +93,7 @@ void omap2_set_globals_prcm(struct omap_globals *);
 void omap242x_map_io(void);
 void omap243x_map_io(void);
 void omap3_map_io(void);
+void am33xx_map_io(void);
 void omap4_map_io(void);


diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index e87efe1..e6521e1 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -287,5 +287,6 @@
 #include <plat/omap34xx.h>
 #include <plat/omap44xx.h>
 #include <plat/ti816x.h>
+#include <plat/am33xx.h>

 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 7f2969e..ffed821 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -73,6 +73,9 @@
 #define OMAP4_L3_IO_OFFSET	0xb4000000
 #define OMAP4_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_IO_OFFSET) /* L3 */

+#define AM33XX_L4_WK_IO_OFFSET	0xb5000000
+#define AM33XX_L4_WK_IO_ADDRESS(pa)	IOMEM((pa) + AM33XX_L4_WK_IO_OFFSET)
+
 #define OMAP4_L3_PER_IO_OFFSET	0xb1100000
 #define OMAP4_L3_PER_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_PER_IO_OFFSET)

@@ -154,6 +157,15 @@
 #define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */

 /*
+ * ----------------------------------------------------------------------------
+ * AM33XX specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+#define L4_WK_AM33XX_PHYS	L4_WK_AM33XX_BASE
+#define L4_WK_AM33XX_VIRT	(L4_WK_AM33XX_PHYS + AM33XX_L4_WK_IO_OFFSET)
+#define L4_WK_AM33XX_SIZE	SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
  * Need to look at the Size 4M for L4.
  * VPOM3430 was not working for Int controller
  */
@@ -316,6 +328,14 @@ static inline void omapti816x_map_common_io(void)
 }
 #endif

+#ifdef CONFIG_SOC_OMAPAM33XX
+extern void omapam33xx_map_common_io(void);
+#else
+static inline void omapam33xx_map_common_io(void)
+{
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 extern void omap44xx_map_common_io(void);
 #else
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index b9e8588..0d818ac 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -35,6 +35,8 @@
 #define L4_EMU_34XX_BASE	0x54000000
 #define L3_34XX_BASE		0x68000000

+#define L4_WK_AM33XX_BASE	0x44C00000
+
 #define OMAP3430_32KSYNCT_BASE	0x48320000
 #define OMAP3430_CM_BASE	0x48004800
 #define OMAP3430_PRM_BASE	0x48306800
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 333871f..14c421a 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -94,6 +94,11 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 	if (cpu_is_ti816x()) {
 		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
 			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
+	} else if (cpu_is_am33xx()) {
+		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
+			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
+		if (BETWEEN(p, L4_WK_AM33XX_PHYS, L4_WK_AM33XX_SIZE))
+			return XLATE(p, L4_WK_AM33XX_PHYS, L4_WK_AM33XX_VIRT);
 	} else if (cpu_is_omap34xx()) {
 		if (BETWEEN(p, L3_34XX_PHYS, L3_34XX_SIZE))
 			return XLATE(p, L3_34XX_PHYS, L3_34XX_VIRT);
--
1.7.0.4

