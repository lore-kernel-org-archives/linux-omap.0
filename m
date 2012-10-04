From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/16] ARM: OMAP: Make plat/sram.h local to plat-omap
Date: Thu, 04 Oct 2012 15:04:49 -0700
Message-ID: <20121004220449.26676.54281.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11182 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751971Ab2JDWEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:04:51 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We can move this from plat to be local to plat-omap
for common ARM zImage support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/clock.c                  |    3 -
 arch/arm/mach-omap1/clock_data.c             |    3 -
 arch/arm/mach-omap1/devices.c                |    2 
 arch/arm/mach-omap1/pm.c                     |    3 -
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |    3 -
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    3 -
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    3 -
 arch/arm/mach-omap2/io.c                     |    3 -
 arch/arm/mach-omap2/omap4-common.c           |    4 -
 arch/arm/mach-omap2/pm24xx.c                 |    3 -
 arch/arm/mach-omap2/pm34xx.c                 |    3 -
 arch/arm/mach-omap2/sdrc.c                   |    2 
 arch/arm/mach-omap2/sdrc2xxx.c               |    2 
 arch/arm/mach-omap2/sleep34xx.S              |    2 
 arch/arm/plat-omap/common.h                  |    2 
 arch/arm/plat-omap/include/plat/sram.h       |  105 -------------------------
 arch/arm/plat-omap/sram.c                    |    1 
 arch/arm/plat-omap/sram.h                    |  109 +++++++++++++++++++++++++-
 18 files changed, 130 insertions(+), 126 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/sram.h

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 638f407..b15d4ee 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -24,11 +24,12 @@
 #include <plat/cpu.h>
 #include <plat/usb.h>
 #include <plat/clock.h>
-#include <plat/sram.h>
 #include <plat/clkdev_omap.h>
 
 #include <mach/hardware.h>
 
+#include "../plat-omap/sram.h"
+
 #include "iomap.h"
 #include "clock.h"
 #include "opp.h"
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 9b45f4b..4337586 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -25,11 +25,12 @@
 #include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/clkdev_omap.h>
-#include <plat/sram.h>	/* for omap_sram_reprogram_clock() */
 
 #include <mach/hardware.h>
 #include <mach/usb.h>   /* for OTG_BASE */
 
+#include "../plat-omap/sram.h"
+
 #include "iomap.h"
 #include "clock.h"
 
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 6faae7f..552bda0 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -28,6 +28,8 @@
 #include <mach/camera.h>
 #include <mach/hardware.h>
 
+#include "../plat-omap/sram.h"
+
 #include "common.h"
 #include "clock.h"
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index a60b7c3..aa12444 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -51,7 +51,6 @@
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
-#include <plat/sram.h>
 #include <mach/tc.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
@@ -59,6 +58,8 @@
 
 #include <mach/irqs.h>
 
+#include "../plat-omap/sram.h"
+
 #include "iomap.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 4ae4392..9a08840 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -26,9 +26,10 @@
 #include <linux/io.h>
 
 #include <plat/clock.h>
-#include <plat/sram.h>
 #include <plat/sdrc.h>
 
+#include "../plat-omap/sram.h"
+
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 3524f0e..0bd09c1 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -34,9 +34,10 @@
 #include <linux/slab.h>
 
 #include <plat/clock.h>
-#include <plat/sram.h>
 #include <plat/sdrc.h>
 
+#include "../plat-omap/sram.h"
+
 #include "soc.h"
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 7c6da2f..adeaf29 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -22,9 +22,10 @@
 #include <linux/io.h>
 
 #include <plat/clock.h>
-#include <plat/sram.h>
 #include <plat/sdrc.h>
 
+#include "../plat-omap/sram.h"
+
 #include "clock.h"
 #include "clock3xxx.h"
 #include "clock34xx.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4234d28..e389919 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -25,7 +25,6 @@
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
 
-#include <plat/sram.h>
 #include <plat/sdrc.h>
 #include <plat/serial.h>
 #include <plat/omap-pm.h>
@@ -33,6 +32,8 @@
 #include <plat/multi.h>
 #include <plat/dma.h>
 
+#include "../plat-omap/sram.h"
+
 #include "soc.h"
 #include "iomap.h"
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index e1f2897..21992d8 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -25,12 +25,12 @@
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 
-#include <plat/sram.h>
 #include <plat/omap-secure.h>
 #include <plat/mmc.h>
 
-#include "omap-wakeupgen.h"
+#include "../plat-omap/sram.h"
 
+#include "omap-wakeupgen.h"
 #include "soc.h"
 #include "common.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 8af6cd6..4abce49 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -37,9 +37,10 @@
 #include <asm/system_misc.h>
 
 #include <plat/clock.h>
-#include <plat/sram.h>
 #include <plat/dma.h>
 
+#include "../plat-omap/sram.h"
+
 #include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ba670db..8828b5b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -35,7 +35,6 @@
 #include <asm/suspend.h>
 #include <asm/system_misc.h>
 
-#include <plat/sram.h>
 #include "clockdomain.h"
 #include "powerdomain.h"
 #include <plat/sdrc.h>
@@ -43,6 +42,8 @@
 #include <plat/gpmc.h>
 #include <plat/dma.h>
 
+#include "../plat-omap/sram.h"
+
 #include "common.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index e3d345f..2f0588b 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -25,7 +25,7 @@
 
 #include "common.h"
 #include <plat/clock.h>
-#include <plat/sram.h>
+#include "../plat-omap/sram.h"
 
 #include <plat/sdrc.h>
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 73e55e4..45ef23f 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -25,7 +25,7 @@
 #include <linux/io.h>
 
 #include <plat/clock.h>
-#include <plat/sram.h>
+#include "../plat-omap/sram.h"
 #include <plat/sdrc.h>
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 5069879..75afe11 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -26,7 +26,7 @@
 
 #include <asm/assembler.h>
 
-#include <plat/sram.h>
+#include "../plat-omap/sram.h"
 
 #include "omap34xx.h"
 #include "iomap.h"
diff --git a/arch/arm/plat-omap/common.h b/arch/arm/plat-omap/common.h
index e196d13..8ae0542 100644
--- a/arch/arm/plat-omap/common.h
+++ b/arch/arm/plat-omap/common.h
@@ -33,6 +33,4 @@ extern void omap_reserve(void);
 struct omap_hwmod;
 extern int omap_dss_reset(struct omap_hwmod *);
 
-void omap_sram_init(void);
-
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
deleted file mode 100644
index 227ae26..0000000
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/sram.h
- *
- * Interface for functions that need to be run in internal SRAM
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_OMAP_SRAM_H
-#define __ARCH_ARM_OMAP_SRAM_H
-
-#ifndef __ASSEMBLY__
-#include <asm/fncpy.h>
-
-extern void *omap_sram_push_address(unsigned long size);
-
-/* Macro to push a function to the internal SRAM, using the fncpy API */
-#define omap_sram_push(funcp, size) ({				\
-	typeof(&(funcp)) _res = NULL;				\
-	void *_sram_address = omap_sram_push_address(size);	\
-	if (_sram_address)					\
-		_res = fncpy(_sram_address, &(funcp), size);	\
-	_res;							\
-})
-
-extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
-
-extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
-				u32 base_cs, u32 force_unlock);
-extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
-				      u32 mem_type);
-extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
-
-extern u32 omap3_configure_core_dpll(
-			u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
-extern void omap3_sram_restore_context(void);
-
-/* Do not use these */
-extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
-extern unsigned long omap1_sram_reprogram_clock_sz;
-
-extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
-extern unsigned long omap24xx_sram_reprogram_clock_sz;
-
-extern void omap242x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
-						u32 base_cs, u32 force_unlock);
-extern unsigned long omap242x_sram_ddr_init_sz;
-
-extern u32 omap242x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
-						int bypass);
-extern unsigned long omap242x_sram_set_prcm_sz;
-
-extern void omap242x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
-						u32 mem_type);
-extern unsigned long omap242x_sram_reprogram_sdrc_sz;
-
-
-extern void omap243x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
-						u32 base_cs, u32 force_unlock);
-extern unsigned long omap243x_sram_ddr_init_sz;
-
-extern u32 omap243x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
-						int bypass);
-extern unsigned long omap243x_sram_set_prcm_sz;
-
-extern void omap243x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
-						u32 mem_type);
-extern unsigned long omap243x_sram_reprogram_sdrc_sz;
-
-extern u32 omap3_sram_configure_core_dpll(
-			u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
-extern unsigned long omap3_sram_configure_core_dpll_sz;
-
-#ifdef CONFIG_PM
-extern void omap_push_sram_idle(void);
-#else
-static inline void omap_push_sram_idle(void) {}
-#endif /* CONFIG_PM */
-
-#endif /* __ASSEMBLY__ */
-
-/*
- * OMAP2+: define the SRAM PA addresses.
- * Used by the SRAM management code and the idle sleep code.
- */
-#define OMAP2_SRAM_PA		0x40200000
-#define OMAP3_SRAM_PA           0x40200000
-#ifdef CONFIG_OMAP4_ERRATA_I688
-#define OMAP4_SRAM_PA		0x40304000
-#define OMAP4_SRAM_VA		0xfe404000
-#else
-#define OMAP4_SRAM_PA		0x40300000
-#endif
-#define AM33XX_SRAM_PA		0x40300000
-#endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 28acb38..dc2d800 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -25,7 +25,6 @@
 
 #include <asm/mach/map.h>
 
-#include <plat/sram.h>
 #include <plat/cpu.h>
 
 #include "sram.h"
diff --git a/arch/arm/plat-omap/sram.h b/arch/arm/plat-omap/sram.h
index 29b43ef..cefda2e 100644
--- a/arch/arm/plat-omap/sram.h
+++ b/arch/arm/plat-omap/sram.h
@@ -1,6 +1,107 @@
-#ifndef __PLAT_OMAP_SRAM_H__
-#define __PLAT_OMAP_SRAM_H__
+/*
+ * arch/arm/plat-omap/include/mach/sram.h
+ *
+ * Interface for functions that need to be run in internal SRAM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 
-extern int __init omap_sram_init(void);
+#ifndef __ARCH_ARM_OMAP_SRAM_H
+#define __ARCH_ARM_OMAP_SRAM_H
 
-#endif /* __PLAT_OMAP_SRAM_H__ */
+#ifndef __ASSEMBLY__
+#include <asm/fncpy.h>
+
+int __init omap_sram_init(void);
+
+extern void *omap_sram_push_address(unsigned long size);
+
+/* Macro to push a function to the internal SRAM, using the fncpy API */
+#define omap_sram_push(funcp, size) ({				\
+	typeof(&(funcp)) _res = NULL;				\
+	void *_sram_address = omap_sram_push_address(size);	\
+	if (_sram_address)					\
+		_res = fncpy(_sram_address, &(funcp), size);	\
+	_res;							\
+})
+
+extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
+
+extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+				u32 base_cs, u32 force_unlock);
+extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+				      u32 mem_type);
+extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
+
+extern u32 omap3_configure_core_dpll(
+			u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+extern void omap3_sram_restore_context(void);
+
+/* Do not use these */
+extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
+extern unsigned long omap1_sram_reprogram_clock_sz;
+
+extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
+extern unsigned long omap24xx_sram_reprogram_clock_sz;
+
+extern void omap242x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+						u32 base_cs, u32 force_unlock);
+extern unsigned long omap242x_sram_ddr_init_sz;
+
+extern u32 omap242x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+						int bypass);
+extern unsigned long omap242x_sram_set_prcm_sz;
+
+extern void omap242x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+						u32 mem_type);
+extern unsigned long omap242x_sram_reprogram_sdrc_sz;
+
+
+extern void omap243x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+						u32 base_cs, u32 force_unlock);
+extern unsigned long omap243x_sram_ddr_init_sz;
+
+extern u32 omap243x_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+						int bypass);
+extern unsigned long omap243x_sram_set_prcm_sz;
+
+extern void omap243x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+						u32 mem_type);
+extern unsigned long omap243x_sram_reprogram_sdrc_sz;
+
+extern u32 omap3_sram_configure_core_dpll(
+			u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+extern unsigned long omap3_sram_configure_core_dpll_sz;
+
+#ifdef CONFIG_PM
+extern void omap_push_sram_idle(void);
+#else
+static inline void omap_push_sram_idle(void) {}
+#endif /* CONFIG_PM */
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * OMAP2+: define the SRAM PA addresses.
+ * Used by the SRAM management code and the idle sleep code.
+ */
+#define OMAP2_SRAM_PA		0x40200000
+#define OMAP3_SRAM_PA           0x40200000
+#ifdef CONFIG_OMAP4_ERRATA_I688
+#define OMAP4_SRAM_PA		0x40304000
+#define OMAP4_SRAM_VA		0xfe404000
+#else
+#define OMAP4_SRAM_PA		0x40300000
+#endif
+#define AM33XX_SRAM_PA		0x40300000
+#endif

