From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 17/24] ARM: omap: clk: Use plat clock.c & clock.h only for OMAP1
Date: Fri, 1 Jun 2012 17:37:58 +0530
Message-ID: <1338552485-31325-18-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54078 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759535Ab2FAMI4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:08:56 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Get rid of all OMAP2+ content from plat/clock.h and use it along with
plat/clock.c only for OMAP1.
Get rid of all '#include <plat/clock.h>' from OMAP2+ files.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c          |    1 -
 arch/arm/mach-omap2/clkt2xxx_dpll.c          |    2 -
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |    1 -
 arch/arm/mach-omap2/clkt2xxx_osc.c           |    2 -
 arch/arm/mach-omap2/clkt2xxx_sys.c           |    2 -
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    1 -
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    1 -
 arch/arm/mach-omap2/clkt_clksel.c            |    2 -
 arch/arm/mach-omap2/clkt_dpll.c              |    1 -
 arch/arm/mach-omap2/clkt_iclk.c              |    1 -
 arch/arm/mach-omap2/clock.c                  |    1 -
 arch/arm/mach-omap2/clock.h                  |    6 -
 arch/arm/mach-omap2/clock2430.c              |    1 -
 arch/arm/mach-omap2/clock2xxx.c              |    1 -
 arch/arm/mach-omap2/clock34xx.c              |    2 -
 arch/arm/mach-omap2/clock3517.c              |    2 -
 arch/arm/mach-omap2/clock36xx.c              |    2 -
 arch/arm/mach-omap2/clock3xxx.c              |    1 -
 arch/arm/mach-omap2/clockdomain.c            |    1 -
 arch/arm/mach-omap2/clockdomain.h            |    1 -
 arch/arm/mach-omap2/common.c                 |    1 -
 arch/arm/mach-omap2/dpll3xxx.c               |    1 -
 arch/arm/mach-omap2/dpll44xx.c               |    1 -
 arch/arm/mach-omap2/omap_hwmod.c             |    1 -
 arch/arm/mach-omap2/pm-debug.c               |    1 -
 arch/arm/mach-omap2/pm24xx.c                 |    1 -
 arch/arm/mach-omap2/sdram-nokia.c            |    1 -
 arch/arm/mach-omap2/sdrc.c                   |    1 -
 arch/arm/mach-omap2/sdrc2xxx.c               |    1 -
 arch/arm/plat-omap/Makefile                  |    3 +-
 arch/arm/plat-omap/clock.c                   |    2 -
 arch/arm/plat-omap/counter_32k.c             |    2 -
 arch/arm/plat-omap/include/plat/clock.h      |  140 --------------------------
 drivers/spi/spi-omap2-mcspi.c                |    1 -
 34 files changed, 2 insertions(+), 187 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index a147188..882eab9 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
 #include <plat/prcm.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpll.c b/arch/arm/mach-omap2/clkt2xxx_dpll.c
index a1f9915..4bc699c 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpll.c
@@ -14,8 +14,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
-
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index d5e9c94..fd7b9ab 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -25,7 +25,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
index 3b1d13f..52a4508 100644
--- a/arch/arm/mach-omap2/clkt2xxx_osc.c
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -23,8 +23,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
-
 #include "clock.h"
 #include "clock2xxx.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_sys.c b/arch/arm/mach-omap2/clkt2xxx_sys.c
index 12164a6..d68b3bc 100644
--- a/arch/arm/mach-omap2/clkt2xxx_sys.c
+++ b/arch/arm/mach-omap2/clkt2xxx_sys.c
@@ -22,8 +22,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
-
 #include "clock.h"
 #include "clock2xxx.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index a0b2b28..eb7f553 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -34,7 +34,6 @@
 #include <linux/slab.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 7e550b1..74cc4ed 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index c99222a..396f7fb 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -49,8 +49,6 @@
 #include <linux/io.h>
 #include <linux/bug.h>
 
-#include <plat/clock.h>
-
 #include "clock.h"
 
 /* Private functions */
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index e84512f..23c677e 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -25,7 +25,6 @@
 
 #include <asm/div64.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index b3aa8d3..16f84fb 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -18,7 +18,6 @@
 #endif
 #include <linux/io.h>
 
-#include <plat/clock.h>
 #include <plat/prcm.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index cdfa9c5..d19af9b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -29,7 +29,6 @@
 #include <trace/events/power.h>
 
 #include <asm/cpu.h>
-#include <plat/clock.h>
 #include "clockdomain.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index bfeb18e..fd022b3 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -17,11 +17,6 @@
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_H
 
 #include <linux/kernel.h>
-
-#include <plat/clock.h>
-
-#ifdef CONFIG_COMMON_CLK
-
 #include <linux/clk-provider.h>
 #include <linux/list.h>
 
@@ -261,7 +256,6 @@ struct clk_hw_omap_ops {
 
 unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
 		unsigned long parent_rate);
-#endif /* CONFIG_COMMON_CLK */
 
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
 #define CORE_CLK_SRC_32K		0x0
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index a629bc3..b3f07c3 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 
 #include <plat/hardware.h>
-#include <plat/clock.h>
 
 #include "iomap.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 39a183b..3377221 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index a4b0d38..16da66e 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -21,8 +21,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
-
 #include "clock.h"
 #include "clock34xx.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/clock3517.c
index f338697..07cb9e2 100644
--- a/arch/arm/mach-omap2/clock3517.c
+++ b/arch/arm/mach-omap2/clock3517.c
@@ -21,8 +21,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
-
 #include "clock.h"
 #include "clock3517.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36xx.c
index 502c960..9f50e97 100644
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -22,8 +22,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clock.h>
-
 #include "clock.h"
 #include "clock36xx.h"
 
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index af05eeb..ecb6029 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 
 #include <plat/hardware.h>
-#include <plat/clock.h>
 
 #include "clock.h"
 #include "clock3xxx.h"
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ad07689..b765228 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -27,7 +27,6 @@
 
 #include <linux/bitops.h>
 
-#include <plat/clock.h>
 #include "clockdomain.h"
 
 /* clkdm_list contains all registered struct clockdomains */
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index f7b5860..c77d7b7 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -20,7 +20,6 @@
 #include <linux/spinlock.h>
 
 #include "powerdomain.h"
-#include <plat/clock.h>
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 1549c11..cf91170 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -20,7 +20,6 @@
 #include <plat/hardware.h>
 #include <plat/board.h>
 #include <plat/mux.h>
-#include <plat/clock.h>
 
 #include "iomap.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 13535b1..aadc8c1 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -29,7 +29,6 @@
 #include <linux/clkdev.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index fbf94d2..529c79d 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -16,7 +16,6 @@
 #include <linux/bitops.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 
 #include "clock.h"
 #include "clock44xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 91d0f19..e153298 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -146,7 +146,6 @@
 #include <plat/cpu.h>
 #include "clockdomain.h"
 #include "powerdomain.h"
-#include <plat/clock.h>
 #include <plat/omap_hwmod.h>
 #include <plat/prcm.h>
 
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 6fa332c..eff10e4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#include <plat/clock.h>
 #include <plat/board.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 7656ff8..d719959 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -39,7 +39,6 @@
 #include <asm/mach-types.h>
 #include <asm/system_misc.h>
 
-#include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/dma.h>
 #include <plat/board.h>
diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 845c4fd..810ad8c 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 
 #include "common.h"
-#include <plat/clock.h>
 #include <plat/sdrc.h>
 
 #include "sdram-nokia.h"
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index e3d345f..93e0fd4 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -24,7 +24,6 @@
 #include <linux/io.h>
 
 #include "common.h"
-#include <plat/clock.h>
 #include <plat/sram.h>
 
 #include <plat/sdrc.h>
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 1133bb2..59608ff 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -25,7 +25,6 @@
 #include <linux/io.h>
 
 #include <plat/hardware.h>
-#include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index c0fe275..69b3888 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,12 +3,13 @@
 #
 
 # Common support
-obj-y := common.o sram.o clock.o devices.o dma.o mux.o \
+obj-y := common.o sram.o devices.o dma.o mux.o \
 	 usb.o fb.o counter_32k.o
 obj-m :=
 obj-n :=
 obj-  :=
 
+obj-$(CONFIG_ARCH_OMAP1) += clock.o
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index d311b7c..62ec5c4 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -10,7 +10,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef CONFIG_COMMON_CLK
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -568,4 +567,3 @@ err_out:
 late_initcall(clk_debugfs_init);
 
 #endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
-#endif /* CONFIG_COMMON_CLK */
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index f96b803..c88d6b2 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -25,8 +25,6 @@
 #include <plat/common.h>
 #include <plat/board.h>
 
-#include <plat/clock.h>
-
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
  * OMAP 730 and 1510.  Other timers could be used as clocksources, with
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d937cfb..6cba482 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -13,17 +13,12 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
-#ifndef CONFIG_COMMON_CLK
 #include <linux/list.h>
 
 struct module;
 struct clk;
 struct clockdomain;
 
-#define __clk_get_name(clk) clk->name
-#define __clk_get_parent(clk) clk->parent
-#define __clk_get_rate(clk) clk->rate
-
 /**
  * struct clkops - some clock function pointers
  * @enable: fn ptr that enables the current clock in hardware
@@ -53,131 +48,6 @@ struct clkops {
 	void			(*deny_idle)(struct clk *);
 };
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
-/* struct clksel_rate.flags possibilities */
-#define RATE_IN_242X		(1 << 0)
-#define RATE_IN_243X		(1 << 1)
-#define RATE_IN_3430ES1		(1 << 2)	/* 3430ES1 rates only */
-#define RATE_IN_3430ES2PLUS	(1 << 3)	/* 3430 ES >= 2 rates only */
-#define RATE_IN_36XX		(1 << 4)
-#define RATE_IN_4430		(1 << 5)
-#define RATE_IN_TI816X		(1 << 6)
-#define RATE_IN_4460		(1 << 7)
-#define RATE_IN_AM33XX		(1 << 8)
-#define RATE_IN_TI814X		(1 << 9)
-
-#define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
-#define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
-#define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
-#define RATE_IN_44XX		(RATE_IN_4430 | RATE_IN_4460)
-
-/* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
-#define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
-
-
-/**
- * struct clksel_rate - register bitfield values corresponding to clk divisors
- * @val: register bitfield value (shifted to bit 0)
- * @div: clock divisor corresponding to @val
- * @flags: (see "struct clksel_rate.flags possibilities" above)
- *
- * @val should match the value of a read from struct clk.clksel_reg
- * AND'ed with struct clk.clksel_mask, shifted right to bit 0.
- *
- * @div is the divisor that should be applied to the parent clock's rate
- * to produce the current clock's rate.
- */
-struct clksel_rate {
-	u32			val;
-	u8			div;
-	u16			flags;
-};
-
-/**
- * struct clksel - available parent clocks, and a pointer to their divisors
- * @parent: struct clk * to a possible parent clock
- * @rates: available divisors for this parent clock
- *
- * A struct clksel is always associated with one or more struct clks
- * and one or more struct clksel_rates.
- */
-struct clksel {
-	struct clk		 *parent;
-	const struct clksel_rate *rates;
-};
-
-/**
- * struct dpll_data - DPLL registers and integration data
- * @mult_div1_reg: register containing the DPLL M and N bitfields
- * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
- * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
- * @clk_bypass: struct clk pointer to the clock's bypass clock input
- * @clk_ref: struct clk pointer to the clock's reference clock input
- * @control_reg: register containing the DPLL mode bitfield
- * @enable_mask: mask of the DPLL mode bitfield in @control_reg
- * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
- * @last_rounded_m: cache of the last M result of omap2_dpll_round_rate()
- * @max_multiplier: maximum valid non-bypass multiplier value (actual)
- * @last_rounded_n: cache of the last N result of omap2_dpll_round_rate()
- * @min_divider: minimum valid non-bypass divider value (actual)
- * @max_divider: maximum valid non-bypass divider value (actual)
- * @modes: possible values of @enable_mask
- * @autoidle_reg: register containing the DPLL autoidle mode bitfield
- * @idlest_reg: register containing the DPLL idle status bitfield
- * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidle_reg
- * @freqsel_mask: mask of the DPLL jitter correction bitfield in @control_reg
- * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
- * @auto_recal_bit: bitshift of the driftguard enable bit in @control_reg
- * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for recalibration IRQs
- * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for recalibration IRQs
- * @flags: DPLL type/features (see below)
- *
- * Possible values for @flags:
- * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
- *
- * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
- *
- * XXX Some DPLLs have multiple bypass inputs, so it's not technically
- * correct to only have one @clk_bypass pointer.
- *
- * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_m,
- * @last_rounded_n) should be separated from the runtime-fixed fields
- * and placed into a different structure, so that the runtime-fixed data
- * can be placed into read-only space.
- */
-struct dpll_data {
-	void __iomem		*mult_div1_reg;
-	u32			mult_mask;
-	u32			div1_mask;
-	struct clk		*clk_bypass;
-	struct clk		*clk_ref;
-	void __iomem		*control_reg;
-	u32			enable_mask;
-	unsigned long		last_rounded_rate;
-	u16			last_rounded_m;
-	u16			max_multiplier;
-	u8			last_rounded_n;
-	u8			min_divider;
-	u16			max_divider;
-	u8			modes;
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	void __iomem		*autoidle_reg;
-	void __iomem		*idlest_reg;
-	u32			autoidle_mask;
-	u32			freqsel_mask;
-	u32			idlest_mask;
-	u32			dco_mask;
-	u32			sddiv_mask;
-	u8			auto_recal_bit;
-	u8			recal_en_bit;
-	u8			recal_st_bit;
-#  endif
-	u8			flags;
-};
-
-#endif
-
 /*
  * struct clk.flags possibilities
  *
@@ -261,17 +131,8 @@ struct clk {
 	s8			usecount;
 	u8			fixed_div;
 	u8			flags;
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	void __iomem		*clksel_reg;
-	u32			clksel_mask;
-	const struct clksel	*clksel;
-	struct dpll_data	*dpll_data;
-	const char		*clkdm_name;
-	struct clockdomain	*clkdm;
-#else
 	u8			rate_offset;
 	u8			src_offset;
-#endif
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 	struct dentry		*dent;	/* For visible tree hierarchy */
 #endif
@@ -308,5 +169,4 @@ extern const struct clkops clkops_null;
 
 extern struct clk dummy_ck;
 
-#endif /* CONFIG_COMMON_CLK */
 #endif
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index bb9274c..bb37511 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -40,7 +40,6 @@
 #include <linux/spi/spi.h>
 
 #include <plat/dma.h>
-#include <plat/clock.h>
 #include <plat/mcspi.h>
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
-- 
1.7.1

