From: <hvaibhav@ti.com>
Subject: [RFC: PATCH 2/4] AM335X: Update common OMAP machine specific sources
Date: Thu, 11 Aug 2011 16:00:28 +0530
Message-ID: <1313058630-32447-3-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41598 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289Ab1HKKat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 06:30:49 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

This patch updates the common machine specific source files for
support for AM335x with cpu type, macros for identification of
AM335X device.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |    3 +++
 arch/arm/mach-omap2/common.c               |   16 ++++++++++++++++
 arch/arm/mach-omap2/id.c                   |    6 ++++++
 arch/arm/plat-omap/include/plat/io.h       |   12 ++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |    2 ++
 arch/arm/plat-omap/include/plat/ti81xx.h   |    4 ++++
 6 files changed, 43 insertions(+), 0 deletions(-)

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
index 7ce80f2..8551fa2 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -119,6 +119,22 @@ void __init omap2_set_globals_ti81xx(void)
 {
 	__omap2_set_globals(&ti81xx_globals);
 }
+
+#define AM335X_TAP_BASE		(AM335X_CTRL_BASE + \
+				TI81XX_CONTROL_DEVICE_ID - 0x204)
+
+static struct omap_globals am335x_globals = {
+	.class  = OMAP343X_CLASS,
+	.tap    = OMAP2_L4_IO_ADDRESS(AM335X_TAP_BASE),
+	.ctrl   = AM335X_CTRL_BASE,
+	.prm    = AM335X_PRCM_BASE,
+	.cm     = AM335X_PRCM_BASE,
+};
+
+void __init omap2_set_globals_am335x(void)
+{
+	__omap2_set_globals(&am335x_globals);
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
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 98c4280..17eec63 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -73,6 +73,9 @@
 #define OMAP4_L3_IO_OFFSET	0xb4000000
 #define OMAP4_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_IO_OFFSET) /* L3 */

+#define AM335X_L4_WK_IO_OFFSET	0xb5000000
+#define AM335X_L4_WK_IO_ADDRESS(pa)	IOMEM((pa) + AM335X_L4_WK_IO_OFFSET)
+
 #define OMAP4_L3_PER_IO_OFFSET	0xb1100000
 #define OMAP4_L3_PER_IO_ADDRESS(pa)	IOMEM((pa) + OMAP4_L3_PER_IO_OFFSET)

@@ -154,6 +157,15 @@
 #define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */

 /*
+ * ----------------------------------------------------------------------------
+ * AM335x specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+#define L4_WK_AM335X_PHYS		L4_WK_AM335X_BASE
+#define L4_WK_AM335X_VIRT		(L4_WK_AM335X_PHYS + AM335X_L4_WK_IO_OFFSET)
+#define L4_WK_AM335X_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
  * Need to look at the Size 4M for L4.
  * VPOM3430 was not working for Int controller
  */
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index b9e8588..0376a97 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -35,6 +35,8 @@
 #define L4_EMU_34XX_BASE	0x54000000
 #define L3_34XX_BASE		0x68000000

+#define L4_WK_AM335X_BASE	0x44C00000
+
 #define OMAP3430_32KSYNCT_BASE	0x48320000
 #define OMAP3430_CM_BASE	0x48004800
 #define OMAP3430_PRM_BASE	0x48306800
diff --git a/arch/arm/plat-omap/include/plat/ti81xx.h b/arch/arm/plat-omap/include/plat/ti81xx.h
index 8f9843f..f52f7dc 100644
--- a/arch/arm/plat-omap/include/plat/ti81xx.h
+++ b/arch/arm/plat-omap/include/plat/ti81xx.h
@@ -24,4 +24,8 @@

 #define TI81XX_ARM_INTC_BASE	0x48200000

+#define AM335X_SCM_BASE		0x44E10000
+#define AM335X_CTRL_BASE	AM335X_SCM_BASE
+#define AM335X_PRCM_BASE	0x44E00000
+
 #endif /* __ASM_ARCH_TI81XX_H */
--
1.6.2.4

