From: <hvaibhav@ti.com>
Subject: [RFC PATCH-V2 2/4] AM335X: Update common OMAP machine specific sources
Date: Mon, 29 Aug 2011 18:16:14 +0530
Message-ID: <1314621976-25750-3-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60523 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab1H2Mqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 08:46:34 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch updates the common machine specific source files for
support for AM335x with cpu type, macros for identification of
AM335X device.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |    3 +++
 arch/arm/mach-omap2/common.c               |   16 ++++++++++++++++
 arch/arm/mach-omap2/id.c                   |    6 ++++++
 arch/arm/mach-omap2/io.c                   |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/am33xx.h   |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h   |    1 +
 arch/arm/plat-omap/include/plat/hardware.h |    1 +
 arch/arm/plat-omap/include/plat/io.h       |   20 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |    2 ++
 arch/arm/plat-omap/io.c                    |    3 +++
 10 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/am33xx.h

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index af58741..0ad8841 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3485,6 +3485,9 @@ int __init omap3xxx_clk_init(void)
 	} else if (cpu_is_ti814x()) {
 		cpu_mask = RATE_IN_TI814X;
 		cpu_clkflg = CK_TI814X;
+	} else if (cpu_is_am335x()) {
+		cpu_mask = RATE_IN_AM335X;
+		cpu_clkflg = CK_AM335X;
 	} else if (cpu_is_omap34xx()) {
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			cpu_mask = RATE_IN_3430ES1;
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 7ce80f2..9aea780 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -119,6 +119,22 @@ void __init omap2_set_globals_ti81xx(void)
 {
 	__omap2_set_globals(&ti81xx_globals);
 }
+
+#define AM33XX_TAP_BASE		(AM33XX_CTRL_BASE + \
+				TI81XX_CONTROL_DEVICE_ID - 0x204)
+
+static struct omap_globals am33xx_globals = {
+	.class  = OMAP343X_CLASS,
+	.tap    = OMAP2_L4_IO_ADDRESS(AM33XX_TAP_BASE),
+	.ctrl   = AM33XX_CTRL_BASE,
+	.prm    = AM33XX_PRCM_BASE,
+	.cm     = AM33XX_PRCM_BASE,
+};
+
+void __init omap2_set_globals_am33xx(void)
+{
+	__omap2_set_globals(&am33xx_globals);
+}
 #endif

 #if defined(CONFIG_ARCH_OMAP4)
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 98f1922..bb8603f 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -362,6 +362,10 @@ static void __init omap3_check_revision(void)
 			omap_revision = TI8148_REV_ES2_1;
 		}
 		break;
+	case 0xb944:
+		omap_revision = AM335X_REV_ES1_0;
+		omap_chip.oc |= CHIP_IS_AM335X;
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		omap_revision =  OMAP3630_REV_ES1_2;
@@ -469,6 +473,8 @@ static void __init omap3_cpuinfo(void)
 		strcpy(cpu_name, "TI816X");
 	} else if (cpu_is_ti814x()) {
 		strcpy(cpu_name, "TI814X");
+	} else if (cpu_is_am335x()) {
+		strcpy(cpu_name, "AM335X");
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1bba2db..2edf9c7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -182,7 +182,24 @@ static struct map_desc omapti81xx_io_desc[] __initdata = {
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

@@ -286,6 +303,14 @@ void __init omapti81xx_map_common_io(void)
 }
 #endif

+#ifdef CONFIG_SOC_OMAPAM33XX
+void __init omapam33xx_map_common_io(void)
+{
+	iotable_init(omapam33xx_io_desc, ARRAY_SIZE(omapam33xx_io_desc));
+	_omap2_map_common_io();
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 void __init omap44xx_map_common_io(void)
 {
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
index 3f16dc1..fc14d1e 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -76,6 +76,7 @@ void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
 void omap2_set_globals_ti81xx(void);
+void omap2_set_globals_am33xx(void);

 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index 1a2f830..e897978 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -287,5 +287,6 @@
 #include <plat/omap34xx.h>
 #include <plat/omap44xx.h>
 #include <plat/ti81xx.h>
+#include <plat/am33xx.h>

 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index ca36735..2e507e0 100644
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
+#define L4_WK_AM33XX_PHYS		L4_WK_AM33XX_BASE
+#define L4_WK_AM33XX_VIRT		(L4_WK_AM33XX_PHYS + AM33XX_L4_WK_IO_OFFSET)
+#define L4_WK_AM33XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
  * Need to look at the Size 4M for L4.
  * VPOM3430 was not working for Int controller
  */
@@ -291,6 +303,14 @@ static inline void omapti81xx_map_common_io(void)
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
index 1443992..5f2dfc7 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -88,6 +88,9 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 	if (cpu_is_ti81xx()) {
 		if (BETWEEN(p, L4_34XX_PHYS, L4_34XX_SIZE))
 			return XLATE(p, L4_34XX_PHYS, L4_34XX_VIRT);
+	} else if (cpu_is_am33xx()) {
+		if (BETWEEN(p, L4_WK_AM33XX_PHYS, L4_WK_AM33XX_SIZE))
+			return XLATE(p, L4_WK_AM33XX_PHYS, L4_WK_AM33XX_VIRT);
 	} else if (cpu_is_omap34xx()) {
 		if (BETWEEN(p, L3_34XX_PHYS, L3_34XX_SIZE))
 			return XLATE(p, L3_34XX_PHYS, L3_34XX_VIRT);
--
1.6.2.4

