From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] ARM: OMAP: Split sram.h to local headers and minimal
 shared header
Date: Tue, 30 Oct 2012 16:52:41 -0700
Message-ID: <20121030235241.25936.39137.stgit@muffinssi.local>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56209 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753291Ab2J3Xwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 19:52:42 -0400
In-Reply-To: <20121030234852.25936.12482.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Most of the defines are specific to omap1 and omap2+,
and should be in the local headers. Only minimal function
prototypes need to be shared.

As discussed on linux-arm-kernel, we want to avoid
relative includes for the arch/arm/*omap* shared code:

http://www.spinics.net/lists/linux-omap/msg80520.html

So this patch re-adds a minimal plat/sram.h.

The new plat/sram.h must not be included from drivers,
that will break build for omap2+ CONFIG_MULTIPLATFORM.

Note that this patch temporarily adds two more
relative includes; Those will be removed in the
following patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/clock.c                  |    3 +--
 arch/arm/mach-omap1/clock_data.c             |    3 +--
 arch/arm/mach-omap1/devices.c                |    3 +--
 arch/arm/mach-omap1/pm.c                     |    4 ++--
 arch/arm/mach-omap1/sram.h                   |    7 +++++++
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |    3 +--
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    3 +--
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    3 +--
 arch/arm/mach-omap2/io.c                     |    3 +--
 arch/arm/mach-omap2/omap4-common.c           |    2 --
 arch/arm/mach-omap2/pm24xx.c                 |    5 +++--
 arch/arm/mach-omap2/pm34xx.c                 |    4 ++--
 arch/arm/mach-omap2/sdrc.c                   |    2 --
 arch/arm/mach-omap2/sdrc2xxx.c               |    3 +--
 arch/arm/mach-omap2/sleep34xx.S              |    3 +--
 arch/arm/mach-omap2/sram.h                   |   26 +-------------------------
 arch/arm/plat-omap/include/plat/sram.h       |   12 ++++++++++++
 arch/arm/plat-omap/sram.c                    |    5 +++--
 18 files changed, 39 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-omap1/sram.h
 rename arch/arm/{plat-omap/sram.h => mach-omap2/sram.h} (79%)
 create mode 100644 arch/arm/plat-omap/include/plat/sram.h

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 931f3f6..4f5fd4a 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -24,12 +24,11 @@
 
 #include <mach/hardware.h>
 
-#include "../plat-omap/sram.h"
-
 #include "soc.h"
 #include "iomap.h"
 #include "clock.h"
 #include "opp.h"
+#include "sram.h"
 
 __u32 arm_idlect1_mask;
 struct clk *api_ck_p, *ck_dpll1_p, *ck_ref_p;
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 28aea55..cb7c6ae 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -27,10 +27,9 @@
 #include <mach/hardware.h>
 #include <mach/usb.h>   /* for OTG_BASE */
 
-#include "../plat-omap/sram.h"
-
 #include "iomap.h"
 #include "clock.h"
+#include "sram.h"
 
 /* Some ARM_IDLECT1 bit shifts - used in struct arm_idlect1_clk */
 #define IDL_CLKOUT_ARM_SHIFT			12
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 645668e..7155ed8 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -26,12 +26,11 @@
 #include <mach/camera.h>
 #include <mach/hardware.h>
 
-#include "../plat-omap/sram.h"
-
 #include "common.h"
 #include "clock.h"
 #include "dma.h"
 #include "mmc.h"
+#include "sram.h"
 
 #if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index b2c2328..66d663a 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -44,6 +44,7 @@
 #include <linux/io.h>
 #include <linux/atomic.h>
 
+#include <asm/fncpy.h>
 #include <asm/system_misc.h>
 #include <asm/irq.h>
 #include <asm/mach/time.h>
@@ -56,11 +57,10 @@
 
 #include <mach/irqs.h>
 
-#include "../plat-omap/sram.h"
-
 #include "iomap.h"
 #include "clock.h"
 #include "pm.h"
+#include "sram.h"
 
 static unsigned int arm_sleep_save[ARM_SLEEP_SAVE_SIZE];
 static unsigned short dsp_sleep_save[DSP_SLEEP_SAVE_SIZE];
diff --git a/arch/arm/mach-omap1/sram.h b/arch/arm/mach-omap1/sram.h
new file mode 100644
index 0000000..d5a6c83
--- /dev/null
+++ b/arch/arm/mach-omap1/sram.h
@@ -0,0 +1,7 @@
+#include <plat/sram.h>
+
+extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
+
+/* Do not use these */
+extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
+extern unsigned long omap1_sram_reprogram_clock_sz;
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 3432f91..0d2f14c 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -25,14 +25,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
-
 #include "clock.h"
 #include "clock2xxx.h"
 #include "opp2xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
+#include "sram.h"
 
 /* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index c66276b..a38ebb2 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -33,8 +33,6 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 
-#include "../plat-omap/sram.h"
-
 #include "soc.h"
 #include "clock.h"
 #include "clock2xxx.h"
@@ -42,6 +40,7 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
+#include "sram.h"
 
 const struct prcm_config *curr_prcm_set;
 const struct prcm_config *rate_table;
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 5510d92..6cf298e 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -21,12 +21,11 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
-
 #include "clock.h"
 #include "clock3xxx.h"
 #include "clock34xx.h"
 #include "sdrc.h"
+#include "sram.h"
 
 #define CYCLES_PER_MHZ			1000000
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4fadc78..814f699 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -27,8 +27,6 @@
 
 #include <plat-omap/dma-omap.h>
 
-#include "../plat-omap/sram.h"
-
 #include "omap_hwmod.h"
 #include "soc.h"
 #include "iomap.h"
@@ -43,6 +41,7 @@
 #include "omap-pm.h"
 #include "sdrc.h"
 #include "serial.h"
+#include "sram.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index d25845c..8a7fc04 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -25,8 +25,6 @@
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 
-#include "../plat-omap/sram.h"
-
 #include "omap-wakeupgen.h"
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6d17e044..9a2f559 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -31,6 +31,8 @@
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 
+#include <asm/fncpy.h>
+
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
@@ -38,8 +40,6 @@
 
 #include <plat-omap/dma-omap.h>
 
-#include "../plat-omap/sram.h"
-
 #include "soc.h"
 #include "common.h"
 #include "clock.h"
@@ -48,6 +48,7 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
+#include "sram.h"
 #include "pm.h"
 #include "control.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 160fa25..4c85762 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -32,6 +32,7 @@
 
 #include <trace/events/power.h>
 
+#include <asm/fncpy.h>
 #include <asm/suspend.h>
 #include <asm/system_misc.h>
 
@@ -40,8 +41,6 @@
 #include <plat/prcm.h>
 #include <plat-omap/dma-omap.h>
 
-#include "../plat-omap/sram.h"
-
 #include "soc.h"
 #include "common.h"
 #include "cm2xxx_3xxx.h"
@@ -52,6 +51,7 @@
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 #include "sdrc.h"
+#include "sram.h"
 #include "control.h"
 
 /* pm34xx errata defined in pm.h */
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 94d4082..c64ee19 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -23,8 +23,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
-
 #include "common.h"
 #include "clock.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 3b8bfdf..20cc950 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,14 +24,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "../plat-omap/sram.h"
-
 #include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "clock.h"
 #include "sdrc.h"
+#include "sram.h"
 
 /* Memory timing, DLL mode flags */
 #define M_DDR		1
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 75afe11..7046c3c 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -26,13 +26,12 @@
 
 #include <asm/assembler.h>
 
-#include "../plat-omap/sram.h"
-
 #include "omap34xx.h"
 #include "iomap.h"
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "sdrc.h"
+#include "sram.h"
 #include "control.h"
 
 /*
diff --git a/arch/arm/plat-omap/sram.h b/arch/arm/mach-omap2/sram.h
similarity index 79%
rename from arch/arm/plat-omap/sram.h
rename to arch/arm/mach-omap2/sram.h
index cefda2e..ca7277c 100644
--- a/arch/arm/plat-omap/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/plat-omap/include/mach/sram.h
- *
  * Interface for functions that need to be run in internal SRAM
  *
  * This program is free software; you can redistribute it and/or modify
@@ -8,26 +6,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __ARCH_ARM_OMAP_SRAM_H
-#define __ARCH_ARM_OMAP_SRAM_H
-
 #ifndef __ASSEMBLY__
-#include <asm/fncpy.h>
-
-int __init omap_sram_init(void);
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
+#include <plat/sram.h>
 
 extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 				u32 base_cs, u32 force_unlock);
@@ -44,9 +24,6 @@ extern u32 omap3_configure_core_dpll(
 extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
-extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
-extern unsigned long omap1_sram_reprogram_clock_sz;
-
 extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
 extern unsigned long omap24xx_sram_reprogram_clock_sz;
 
@@ -104,4 +81,3 @@ static inline void omap_push_sram_idle(void) {}
 #define OMAP4_SRAM_PA		0x40300000
 #endif
 #define AM33XX_SRAM_PA		0x40300000
-#endif
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
new file mode 100644
index 0000000..c60025a
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -0,0 +1,12 @@
+int omap_sram_init(void);
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
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 70dcc22..3372929 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -20,15 +20,16 @@
 #include <linux/init.h>
 #include <linux/io.h>
 
+#include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
 
 #include <asm/mach/map.h>
 
 #include "../mach-omap1/soc.h"
+#include "../mach-omap1/sram.h"
 #include "../mach-omap2/soc.h"
-
-#include "sram.h"
+#include "../mach-omap2/sram.h"
 
 /* XXX These "sideways" includes will disappear when sram.c becomes a driver */
 #include "../mach-omap2/iomap.h"

