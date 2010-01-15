From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 18/18] OMAP2/3/4 clock: rename and clean the omap2_clk_init()
	functions
Date: Fri, 15 Jan 2010 02:07:16 -0700
Message-ID: <20100115090710.30690.63693.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48756 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849Ab0AOJIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:16 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rename the omap2_clk_init() in the OMAP2, 3, and 4 clock code to be
omap2xxx_clk_init(), omap3xxx_clk_init(), etc.  Remove all traces of
the (commented) old virt_prcm_set code from omap3xxx_clk_init() and
omap4xxx_clk_init(), since this will be handled with the OPP code that
is cooking in the PM branch.

After this patch, there should be very little else in the clock code
that blocks a multi-OMAP 2+3 kernel.  (OMAP2420+OMAP2430 still has some
outstanding issues that need to be resolved; this is pending on some
additions to the hwmod data.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.h          |    1 -
 arch/arm/mach-omap2/clock2xxx.h      |    1 +
 arch/arm/mach-omap2/clock2xxx_data.c |    2 +-
 arch/arm/mach-omap2/clock34xx.c      |    2 +-
 arch/arm/mach-omap2/clock34xx.h      |    1 +
 arch/arm/mach-omap2/clock34xx_data.c |   19 +------------------
 arch/arm/mach-omap2/clock44xx.h      |    2 ++
 arch/arm/mach-omap2/clock44xx_data.c |    4 +---
 arch/arm/mach-omap2/io.c             |   15 +++++++++++++--
 9 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index be5a55f..7bc344b 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -47,7 +47,6 @@
 #define DPLL_LOW_POWER_BYPASS	0x5
 #define DPLL_LOCKED		0x7
 
-int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index bed294a..32f3d0a 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -19,6 +19,7 @@ unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
 u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
+int omap2xxx_clk_init(void);
 
 /* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
 #ifdef CONFIG_ARCH_OMAP2420
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index 3a435bb..52c7a6c 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -2238,7 +2238,7 @@ static struct omap_clk omap24xx_clks[] = {
  * init code
  */
 
-int __init omap2_clk_init(void)
+int __init omap2xxx_clk_init(void)
 {
 	const struct prcm_config *prcm;
 	struct omap_clk *c;
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 34d3950..1f1b5a6 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -150,7 +150,7 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 	return omap3_noncore_dpll_set_rate(clk, rate);
 }
 
-void omap3_clk_lock_dpll5(void)
+void __init omap3_clk_lock_dpll5(void)
 {
 	struct clk *dpll5_clk;
 	struct clk *dpll5_m2_clk;
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 9a2c07e..73f2109 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -8,6 +8,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
 
+int omap3xxx_clk_init(void);
 int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
 int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
 void omap3_clk_lock_dpll5(void);
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 9e7f68a..0d04f92 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -3212,11 +3212,9 @@ static struct omap_clk omap3xxx_clks[] = {
 };
 
 
-int __init omap2_clk_init(void)
+int __init omap3xxx_clk_init(void)
 {
-	/* struct prcm_config *prcm; */
 	struct omap_clk *c;
-	/* u32 clkrate; */
 	u32 cpu_clkflg = CK_3XXX;
 
 	if (cpu_is_omap3517()) {
@@ -3254,21 +3252,6 @@ int __init omap2_clk_init(void)
 			omap2_init_clk_clkdm(c->lk.clk);
 		}
 
-	/* REVISIT: Not yet ready for OMAP3 */
-#if 0
-	/* Check the MPU rate set by bootloader */
-	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-		if (prcm->dpll_speed <= clkrate)
-			break;
-	}
-	curr_prcm_set = prcm;
-#endif
-
 	recalculate_root_clocks();
 
 	printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 59b9ced..1f55b6b 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -10,6 +10,8 @@
 #define OMAP4430_MAX_DPLL_MULT	2048
 #define OMAP4430_MAX_DPLL_DIV	128
 
+int omap4xxx_clk_init(void);
+
 extern const struct clkops clkops_noncore_dpll_ops;
 
 #endif
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index ae9649f..35ffe63 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2726,11 +2726,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"utmi_p2_gfclk_ck",		&utmi_p2_gfclk_ck,	CK_443X),
 };
 
-int __init omap2_clk_init(void)
+int __init omap4xxx_clk_init(void)
 {
-	/* struct prcm_config *prcm; */
 	struct omap_clk *c;
-	/* u32 clkrate; */
 	u32 cpu_clkflg;
 
 	if (cpu_is_omap44xx()) {
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 8c58699..01ef2ae 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -35,7 +35,9 @@
 #include <plat/serial.h>
 #include <plat/vram.h>
 
-#include "clock.h"
+#include "clock2xxx.h"
+#include "clock34xx.h"
+#include "clock44xx.h"
 
 #include <plat/omap-pm.h>
 #include <plat/powerdomain.h>
@@ -320,7 +322,16 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	omap2_mux_init();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 #endif
-	omap2_clk_init();
+
+	if (cpu_is_omap24xx())
+		omap2xxx_clk_init();
+	else if (cpu_is_omap34xx())
+		omap3xxx_clk_init();
+	else if (cpu_is_omap44xx())
+		omap4xxx_clk_init();
+	else
+		pr_err("Could not init clock framework - unknown CPU\n");
+
 	omap_serial_early_init();
 #ifndef CONFIG_ARCH_OMAP4
 	omap_hwmod_late_init();


