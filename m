From: Abhijit.Pagare@india.ti.com
Subject: [PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support OMAP4 features.
Date: Fri, 11 Dec 2009 16:15:56 +0530
Message-ID: <33451.9486911178$1260528544@news.gmane.org>
References: <1260528356-11621-1-git-send-email-a0393848@linfarm476.(none)>
	<1260528356-11621-2-git-send-email-a0393848@linfarm476.(none)>
	<1260528356-11621-3-git-send-email-a0393848@linfarm476.(none)>
	<1260528356-11621-4-git-send-email-a0393848@linfarm476.(none)>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1260528356-11621-4-git-send-email-a0393848@linfarm476.(none)>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Abhijit Pagare <abhijitpagare@ti.com>

The proper Macros have to be used for platform specific calls and
some of the compiling requirements and init calls are taken care of.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    1 +
 arch/arm/mach-omap2/io.c          |    2 +-
 arch/arm/mach-omap2/powerdomain.c |  112 ++++++++++++++++++++++++++++---------
 3 files changed, 87 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b6e011a..8b351e3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,6 +11,7 @@ clock-common				= clock.o clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 7d344d0..aff5387 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -313,12 +313,12 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	else if (cpu_is_omap34xx())
 		hwmods = omap34xx_hwmods;
 
+	pwrdm_init(powerdomains_omap);
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
 	omap2_mux_init();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
-	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
 #endif
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index fb36c5d..3d529c1 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -6,6 +6,8 @@
  *
  * Written by Paul Walmsley
  *
+ * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -28,8 +30,10 @@
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
+#include "prm-regbits-44xx.h"
 
 #include <plat/cpu.h>
 #include <plat/powerdomain.h>
@@ -42,6 +46,38 @@ enum {
 	PWRDM_STATE_PREV,
 };
 
+/* Variable holding value of the CPU dependent PWRSTCTRL Register Offset */
+static u16 pwrstctrl_reg_offs;
+
+/* Variable holding value of the CPU dependent PWRSTST Register Offset */
+static u16 pwrstst_reg_offs;
+
+/* OMAP3 and OMAP4 specific register bit initialisations
+ * Notice that the names here are not according to each power
+ * domain but the bit mapping used applies to all of them
+ */
+
+/* OMAP3 and OMAP4 Memory Onstate Masks (common across all power domains) */
+#define OMAP_MEM0_ONSTATE_MASK OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK
+#define OMAP_MEM1_ONSTATE_MASK OMAP3430_L1FLATMEMONSTATE_MASK
+#define OMAP_MEM2_ONSTATE_MASK OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK
+#define OMAP_MEM3_ONSTATE_MASK OMAP3430_L2FLATMEMONSTATE_MASK
+#define OMAP_MEM4_ONSTATE_MASK OMAP4430_OCP_NRET_BANK_ONSTATE_MASK
+
+/* OMAP3 and OMAP4 Memory Retstate Masks (common across all power domains) */
+#define OMAP_MEM0_RETSTATE_MASK OMAP3430_SHAREDL1CACHEFLATRETSTATE
+#define OMAP_MEM1_RETSTATE_MASK OMAP3430_L1FLATMEMRETSTATE
+#define OMAP_MEM2_RETSTATE_MASK OMAP3430_SHAREDL2CACHEFLATRETSTATE
+#define OMAP_MEM3_RETSTATE_MASK OMAP3430_L2FLATMEMRETSTATE
+#define OMAP_MEM4_RETSTATE_MASK OMAP4430_OCP_NRET_BANK_RETSTATE_MASK
+
+/* OMAP3 and OMAP4 Memory Status bits */
+#define OMAP_MEM0_STATEST_MASK OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK
+#define OMAP_MEM1_STATEST_MASK OMAP3430_L1FLATMEMSTATEST_MASK
+#define OMAP_MEM2_STATEST_MASK OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK
+#define OMAP_MEM3_STATEST_MASK OMAP3430_L2FLATMEMSTATEST_MASK
+#define OMAP_MEM4_STATEST_MASK OMAP4430_OCP_NRET_BANK_STATEST_MASK
+
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
 
@@ -183,6 +219,18 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
 {
 	struct powerdomain **p = NULL;
 
+	if (cpu_is_omap24xx() | cpu_is_omap34xx()) {
+		pwrstctrl_reg_offs = OMAP2_PM_PWSTCTRL;
+		pwrstst_reg_offs = OMAP2_PM_PWSTST;
+	} else if (cpu_is_omap44xx()) {
+		pwrstctrl_reg_offs = OMAP4_PM_PWSTCTRL;
+		pwrstst_reg_offs = OMAP4_PM_PWSTST;
+	} else {
+		printk(KERN_ERR "Power Domain struct not supported for " \
+							"this CPU\n");
+		return;
+	}
+
 	if (pwrdm_list) {
 		for (p = pwrdm_list; *p; p++) {
 			pwrdm_register(*p);
@@ -712,7 +760,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 			     (pwrst << OMAP_POWERSTATE_SHIFT),
-			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
 
 	return 0;
 }
@@ -730,8 +778,8 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
-					OMAP_POWERSTATE_MASK);
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				 pwrstctrl_reg_offs, OMAP_POWERSTATE_MASK);
 }
 
 /**
@@ -747,8 +795,8 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
-					OMAP_POWERSTATEST_MASK);
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				 pwrstst_reg_offs, OMAP_POWERSTATEST_MASK);
 }
 
 /**
@@ -798,7 +846,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	 */
 	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE,
 			     (pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE)),
-			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+				 pwrdm->prcm_offs, pwrstctrl_reg_offs);
 
 	return 0;
 }
@@ -841,16 +889,19 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	 */
 	switch (bank) {
 	case 0:
-		m = OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK;
+		m = OMAP_MEM0_ONSTATE_MASK;
 		break;
 	case 1:
-		m = OMAP3430_L1FLATMEMONSTATE_MASK;
+		m = OMAP_MEM1_ONSTATE_MASK;
 		break;
 	case 2:
-		m = OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK;
+		m = OMAP_MEM2_ONSTATE_MASK;
 		break;
 	case 3:
-		m = OMAP3430_L2FLATMEMONSTATE_MASK;
+		m = OMAP_MEM3_ONSTATE_MASK;
+		break;
+	case 4:
+		m = OMAP_MEM4_ONSTATE_MASK;
 		break;
 	default:
 		WARN_ON(1); /* should never happen */
@@ -858,7 +909,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	}
 
 	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
-			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
 
 	return 0;
 }
@@ -902,16 +953,19 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	 */
 	switch (bank) {
 	case 0:
-		m = OMAP3430_SHAREDL1CACHEFLATRETSTATE;
+		m = OMAP_MEM0_RETSTATE_MASK;
 		break;
 	case 1:
-		m = OMAP3430_L1FLATMEMRETSTATE;
+		m = OMAP_MEM1_RETSTATE_MASK;
 		break;
 	case 2:
-		m = OMAP3430_SHAREDL2CACHEFLATRETSTATE;
+		m = OMAP_MEM2_RETSTATE_MASK;
 		break;
 	case 3:
-		m = OMAP3430_L2FLATMEMRETSTATE;
+		m = OMAP_MEM3_RETSTATE_MASK;
+		break;
+	case 4:
+		m = OMAP_MEM4_RETSTATE_MASK;
 		break;
 	default:
 		WARN_ON(1); /* should never happen */
@@ -919,7 +973,7 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	}
 
 	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
-			     OMAP2_PM_PWSTCTRL);
+			     pwrstctrl_reg_offs);
 
 	return 0;
 }
@@ -938,8 +992,8 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
-					OMAP3430_LOGICSTATEST);
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+				 pwrstst_reg_offs, OMAP3430_LOGICSTATEST);
 }
 
 /**
@@ -993,23 +1047,27 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	 */
 	switch (bank) {
 	case 0:
-		m = OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK;
+		m = OMAP_MEM0_STATEST_MASK;
 		break;
 	case 1:
-		m = OMAP3430_L1FLATMEMSTATEST_MASK;
+		m = OMAP_MEM1_STATEST_MASK;
 		break;
 	case 2:
-		m = OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK;
+		m = OMAP_MEM2_STATEST_MASK;
 		break;
 	case 3:
-		m = OMAP3430_L2FLATMEMSTATEST_MASK;
+		m = OMAP_MEM3_STATEST_MASK;
+		break;
+	case 4:
+		m = OMAP_MEM4_STATEST_MASK;
 		break;
 	default:
 		WARN_ON(1); /* should never happen */
 		return -EEXIST;
 	}
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST, m);
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					 pwrstst_reg_offs, m);
 }
 
 /**
@@ -1110,7 +1168,7 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 		 pwrdm->name);
 
 	prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
 
 	return 0;
 }
@@ -1138,7 +1196,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 		 pwrdm->name);
 
 	prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
-			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
 
 	return 0;
 }
@@ -1179,10 +1237,10 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	 */
 
 	/* XXX Is this udelay() value meaningful? */
-	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
+	while ((prm_read_mod_reg(pwrdm->prcm_offs, pwrstst_reg_offs) &
 		OMAP_INTRANSITION) &&
 	       (c++ < PWRDM_TRANSITION_BAILOUT))
-		udelay(1);
+			udelay(1);
 
 	if (c > PWRDM_TRANSITION_BAILOUT) {
 		printk(KERN_ERR "powerdomain: waited too long for "
-- 
1.5.4.7
