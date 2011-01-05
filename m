From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/5] OMAP: clockdomain: Arch specific funcs for sleep/wakeup of clkdm
Date: Wed,  5 Jan 2011 19:52:43 +0530
Message-ID: <1294237365-10893-4-git-send-email-rnayak@ti.com>
References: <1294237365-10893-1-git-send-email-rnayak@ti.com>
 <1294237365-10893-2-git-send-email-rnayak@ti.com>
 <1294237365-10893-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51951 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab1AEOW5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 09:22:57 -0500
In-Reply-To: <1294237365-10893-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3/4
.clkdm_sleep
.clkdm_wakeup

Convert the platform-independent framework to call these functions.
Also rename the api's by removing the omap2_ preamble.
Hence call omap2_clkdm_wakeup as clkdm_wakeup and
omap2_clkdm_sleep as clkdm_sleep.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                     |    1 +
 arch/arm/mach-omap2/clockdomain.c                |   56 ++++-----------------
 arch/arm/mach-omap2/clockdomain.h                |    9 ++-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |   46 ++++++++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c            |   35 +++++++++++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    7 ++-
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/io.c                         |    6 +-
 arch/arm/mach-omap2/pm.c                         |    4 +-
 arch/arm/mach-omap2/pm24xx.c                     |    6 +-
 arch/arm/mach-omap2/pm34xx.c                     |    2 +-
 11 files changed, 115 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d28db0a..9990d88 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
 					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
+					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index c32480c..ce55279 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -330,7 +330,7 @@ void clkdm_init(struct clockdomain **clkdms,
 	 */
 	list_for_each_entry(clkdm, &clkdm_list, node) {
 		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
-			omap2_clkdm_wakeup(clkdm);
+			clkdm_wakeup(clkdm);
 		else if (clkdm->flags & CLKDM_CAN_DISABLE_AUTO)
 			omap2_clkdm_deny_idle(clkdm);
 
@@ -704,7 +704,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 }
 
 /**
- * omap2_clkdm_sleep - force clockdomain sleep transition
+ * clkdm_sleep - force clockdomain sleep transition
  * @clkdm: struct clockdomain *
  *
  * Instruct the CM to force a sleep transition on the specified
@@ -712,7 +712,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
  * clockdomain does not support software-initiated sleep; 0 upon
  * success.
  */
-int omap2_clkdm_sleep(struct clockdomain *clkdm)
+int clkdm_sleep(struct clockdomain *clkdm)
 {
 	if (!clkdm)
 		return -EINVAL;
@@ -725,31 +725,14 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 
 	pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
 
-	if (cpu_is_omap24xx()) {
-
-		omap2_cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
-			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
-
-	} else if (cpu_is_omap34xx()) {
-
-		omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
-					      clkdm->clktrctrl_mask);
-
-	} else if (cpu_is_omap44xx()) {
-
-		omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
-					       clkdm->cm_inst,
-					       clkdm->clkdm_offs);
-
-	} else {
-		BUG();
-	};
+	if (arch_clkdm && arch_clkdm->clkdm_sleep)
+		return arch_clkdm->clkdm_sleep(clkdm);
 
 	return 0;
 }
 
 /**
- * omap2_clkdm_wakeup - force clockdomain wakeup transition
+ * clkdm_wakeup - force clockdomain wakeup transition
  * @clkdm: struct clockdomain *
  *
  * Instruct the CM to force a wakeup transition on the specified
@@ -757,7 +740,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
  * clockdomain does not support software-controlled wakeup; 0 upon
  * success.
  */
-int omap2_clkdm_wakeup(struct clockdomain *clkdm)
+int clkdm_wakeup(struct clockdomain *clkdm)
 {
 	if (!clkdm)
 		return -EINVAL;
@@ -770,25 +753,8 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 
 	pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
 
-	if (cpu_is_omap24xx()) {
-
-		omap2_cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
-			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
-
-	} else if (cpu_is_omap34xx()) {
-
-		omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
-					       clkdm->clktrctrl_mask);
-
-	} else if (cpu_is_omap44xx()) {
-
-		omap4_cminst_clkdm_force_wakeup(clkdm->prcm_partition,
-						clkdm->cm_inst,
-						clkdm->clkdm_offs);
-
-	} else {
-		BUG();
-	};
+	if (arch_clkdm && arch_clkdm->clkdm_wakeup)
+		return arch_clkdm->clkdm_wakeup(clkdm);
 
 	return 0;
 }
@@ -931,7 +897,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 		_clkdm_add_autodeps(clkdm);
 		_enable_hwsup(clkdm);
 	} else {
-		omap2_clkdm_wakeup(clkdm);
+		clkdm_wakeup(clkdm);
 	}
 
 	pwrdm_wait_transition(clkdm->pwrdm.ptr);
@@ -1003,7 +969,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 		_clkdm_del_autodeps(clkdm);
 		_enable_hwsup(clkdm);
 	} else {
-		omap2_clkdm_sleep(clkdm);
+		clkdm_sleep(clkdm);
 	}
 
 	pwrdm_clkdm_state_switch(clkdm);
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index a9cda27..9f28aa9 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -172,15 +172,18 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
 
-int omap2_clkdm_wakeup(struct clockdomain *clkdm);
-int omap2_clkdm_sleep(struct clockdomain *clkdm);
+int clkdm_wakeup(struct clockdomain *clkdm);
+int clkdm_sleep(struct clockdomain *clkdm);
 
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 
-extern void __init omap2_clockdomains_init(void);
+extern void __init omap2xxx_clockdomains_init(void);
+extern void __init omap3xxx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 
 extern struct clkdm_ops omap2_clkdm_operations;
+extern struct clkdm_ops omap3_clkdm_operations;
+extern struct clkdm_ops omap4_clkdm_operations;
 
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index a7303bd..555e394 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -20,6 +20,7 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
+#include "prm-regbits-24xx.h"
 #include "clockdomain.h"
 
 static void omap2_clkdm_add_wkdep(struct clockdomain *clkdm1,
@@ -101,6 +102,36 @@ static void omap2_clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 				OMAP3430_CM_SLEEPDEP);
 }
 
+static int omap2_clkdm_sleep(struct clockdomain *clkdm)
+{
+	omap2_cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
+				clkdm->pwrdm.ptr->prcm_offs,
+				OMAP2_PM_PWSTCTRL);
+	return 0;
+}
+
+static int omap2_clkdm_wakeup(struct clockdomain *clkdm)
+{
+	omap2_cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
+				clkdm->pwrdm.ptr->prcm_offs,
+				OMAP2_PM_PWSTCTRL);
+	return 0;
+}
+
+static int omap3_clkdm_sleep(struct clockdomain *clkdm)
+{
+	omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+	return 0;
+}
+
+static int omap3_clkdm_wakeup(struct clockdomain *clkdm)
+{
+	omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+	return 0;
+}
+
 struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
 	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
@@ -110,4 +141,19 @@ struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_del_sleepdep	= omap2_clkdm_del_sleepdep,
 	.clkdm_read_sleepdep	= omap2_clkdm_read_sleepdep,
 	.clkdm_clear_all_sleepdeps	= omap2_clkdm_clear_all_sleepdeps,
+	.clkdm_sleep		= omap2_clkdm_sleep,
+	.clkdm_wakeup		= omap2_clkdm_wakeup,
+};
+
+struct clkdm_ops omap3_clkdm_operations = {
+	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
+	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
+	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
+	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
+	.clkdm_add_sleepdep	= omap2_clkdm_add_sleepdep,
+	.clkdm_del_sleepdep	= omap2_clkdm_del_sleepdep,
+	.clkdm_read_sleepdep	= omap2_clkdm_read_sleepdep,
+	.clkdm_clear_all_sleepdeps	= omap2_clkdm_clear_all_sleepdeps,
+	.clkdm_sleep		= omap3_clkdm_sleep,
+	.clkdm_wakeup		= omap3_clkdm_wakeup,
 };
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
new file mode 100644
index 0000000..9ccb406
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -0,0 +1,35 @@
+/*
+ * OMAP4 clockdomain control
+ *
+ * Copyright (C) 2008-2010 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Derived from mach-omap2/clockdomain.c written by Paul Walmsley
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "clockdomain.h"
+#include "cminst44xx.h"
+
+static int omap4_clkdm_sleep(struct clockdomain *clkdm)
+{
+	omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
+					clkdm->cm_inst, clkdm->clkdm_offs);
+	return 0;
+}
+
+static int omap4_clkdm_wakeup(struct clockdomain *clkdm)
+{
+	omap4_cminst_clkdm_force_wakeup(clkdm->prcm_partition,
+					clkdm->cm_inst, clkdm->clkdm_offs);
+	return 0;
+}
+
+struct clkdm_ops omap4_clkdm_operations = {
+	.clkdm_sleep		= omap4_clkdm_sleep,
+	.clkdm_wakeup		= omap4_clkdm_wakeup,
+};
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index ba0bbbd..f85de72 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -854,7 +854,12 @@ static struct clockdomain *clockdomains_omap2[] __initdata = {
 	NULL,
 };
 
-void __init omap2_clockdomains_init(void)
+void __init omap2xxx_clockdomains_init(void)
 {
 	clkdm_init(clockdomains_omap2, clkdm_autodeps, &omap2_clkdm_operations);
 }
+
+void __init omap3xxx_clockdomains_init(void)
+{
+	clkdm_init(clockdomains_omap2, clkdm_autodeps, &omap3_clkdm_operations);
+}
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index f04abc5..2fe1570 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -307,5 +307,5 @@ static struct clockdomain *clockdomains_omap44xx[] __initdata = {
 
 void __init omap44xx_clockdomains_init(void)
 {
-	clkdm_init(clockdomains_omap44xx, NULL, NULL);
+	clkdm_init(clockdomains_omap44xx, NULL, &omap4_clkdm_operations);
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..e1c5e76 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -339,15 +339,15 @@ void __init omap2_init_common_infrastructure(void)
 
 	if (cpu_is_omap242x()) {
 		omap2xxx_powerdomains_init();
-		omap2_clockdomains_init();
+		omap2xxx_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
 		omap2xxx_powerdomains_init();
-		omap2_clockdomains_init();
+		omap2xxx_clockdomains_init();
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
 		omap3xxx_powerdomains_init();
-		omap2_clockdomains_init();
+		omap3xxx_clockdomains_init();
 		omap3xxx_hwmod_init();
 	} else if (cpu_is_omap44xx()) {
 		omap44xx_powerdomains_init();
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d5a102c..74c3100 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -124,7 +124,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
 			sleep_switch = LOWPOWERSTATE_SWITCH;
 		} else {
-			omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
 			pwrdm_wait_transition(pwrdm);
 			sleep_switch = FORCEWAKEUP_SWITCH;
 		}
@@ -142,7 +142,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		if (pwrdm->pwrdm_clkdms[0]->flags & CLKDM_CAN_ENABLE_AUTO)
 			omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		else
-			omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
+			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
 		break;
 	case LOWPOWERSTATE_SWITCH:
 		pwrdm_set_lowpwrstchange(pwrdm);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index dac2d1d..c14113b 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -370,7 +370,7 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 		omap2_clkdm_allow_idle(clkdm);
 	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
 		 atomic_read(&clkdm->usecount) == 0)
-		omap2_clkdm_sleep(clkdm);
+		clkdm_sleep(clkdm);
 	return 0;
 }
 
@@ -405,11 +405,11 @@ static void __init prcm_setup_regs(void)
 
 	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
 	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
-	omap2_clkdm_sleep(dsp_clkdm);
+	clkdm_sleep(dsp_clkdm);
 
 	pwrdm = clkdm_get_pwrdm(gfx_clkdm);
 	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
-	omap2_clkdm_sleep(gfx_clkdm);
+	clkdm_sleep(gfx_clkdm);
 
 	/*
 	 * Clear clockdomain wakeup dependencies and enable
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5b323f2..c7712c7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -992,7 +992,7 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 		omap2_clkdm_allow_idle(clkdm);
 	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
 		 atomic_read(&clkdm->usecount) == 0)
-		omap2_clkdm_sleep(clkdm);
+		clkdm_sleep(clkdm);
 	return 0;
 }
 
-- 
1.7.0.4

