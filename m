From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 3/5] OMAP: clockdomain: Arch specific funcs for sleep/wakeup of clkdm
Date: Tue, 18 Jan 2011 19:57:38 +0530
Message-ID: <1295360860-26490-4-git-send-email-rnayak@ti.com>
References: <1295360860-26490-1-git-send-email-rnayak@ti.com>
 <1295360860-26490-2-git-send-email-rnayak@ti.com>
 <1295360860-26490-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49104 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab1ARO1u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 09:27:50 -0500
In-Reply-To: <1295360860-26490-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3/4
.clkdm_sleep
.clkdm_wakeup

Convert the platform-independent framework to call these functions.
Also rename the api's by removing the omap2_ preamble.
Hence call omap2_clkdm_wakeup as clkdm_wakeup and
omap2_clkdm_sleep as clkdm_sleep.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                |    1 +
 arch/arm/mach-omap2/clockdomain.c           |   64 ++++++--------------------
 arch/arm/mach-omap2/clockdomain.h           |    5 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c  |   35 +++++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c       |   35 +++++++++++++++
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 arch/arm/mach-omap2/pm.c                    |    4 +-
 arch/arm/mach-omap2/pm24xx.c                |    6 +-
 arch/arm/mach-omap2/pm34xx.c                |    2 +-
 9 files changed, 96 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6b2824d..72f2891 100644
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
index 1c461ed..9beccc7 100644
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
 
@@ -724,7 +724,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 }
 
 /**
- * omap2_clkdm_sleep - force clockdomain sleep transition
+ * clkdm_sleep - force clockdomain sleep transition
  * @clkdm: struct clockdomain *
  *
  * Instruct the CM to force a sleep transition on the specified
@@ -732,7 +732,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
  * clockdomain does not support software-initiated sleep; 0 upon
  * success.
  */
-int omap2_clkdm_sleep(struct clockdomain *clkdm)
+int clkdm_sleep(struct clockdomain *clkdm)
 {
 	if (!clkdm)
 		return -EINVAL;
@@ -743,33 +743,16 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 		return -EINVAL;
 	}
 
-	pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
-
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
+	if (!arch_clkdm || !arch_clkdm->clkdm_sleep)
+		return -EINVAL;
 
-	} else {
-		BUG();
-	};
+	pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
 
-	return 0;
+	return arch_clkdm->clkdm_sleep(clkdm);
 }
 
 /**
- * omap2_clkdm_wakeup - force clockdomain wakeup transition
+ * clkdm_wakeup - force clockdomain wakeup transition
  * @clkdm: struct clockdomain *
  *
  * Instruct the CM to force a wakeup transition on the specified
@@ -777,7 +760,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
  * clockdomain does not support software-controlled wakeup; 0 upon
  * success.
  */
-int omap2_clkdm_wakeup(struct clockdomain *clkdm)
+int clkdm_wakeup(struct clockdomain *clkdm)
 {
 	if (!clkdm)
 		return -EINVAL;
@@ -788,29 +771,12 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 		return -EINVAL;
 	}
 
-	pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
-
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
+	if (!arch_clkdm || !arch_clkdm->clkdm_wakeup)
+		return -EINVAL;
 
-	} else {
-		BUG();
-	};
+	pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
 
-	return 0;
+	return arch_clkdm->clkdm_wakeup(clkdm);
 }
 
 /**
@@ -951,7 +917,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 		_clkdm_add_autodeps(clkdm);
 		_enable_hwsup(clkdm);
 	} else {
-		omap2_clkdm_wakeup(clkdm);
+		clkdm_wakeup(clkdm);
 	}
 
 	pwrdm_wait_transition(clkdm->pwrdm.ptr);
@@ -1023,7 +989,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 		_clkdm_del_autodeps(clkdm);
 		_enable_hwsup(clkdm);
 	} else {
-		omap2_clkdm_sleep(clkdm);
+		clkdm_sleep(clkdm);
 	}
 
 	pwrdm_clkdm_state_switch(clkdm);
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 90b6d6a..7a5cb5c 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -170,8 +170,8 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
 void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
 
-int omap2_clkdm_wakeup(struct clockdomain *clkdm);
-int omap2_clkdm_sleep(struct clockdomain *clkdm);
+int clkdm_wakeup(struct clockdomain *clkdm);
+int clkdm_sleep(struct clockdomain *clkdm);
 
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
@@ -182,5 +182,6 @@ extern void __init omap44xx_clockdomains_init(void);
 
 extern struct clkdm_ops omap2_clkdm_operations;
 extern struct clkdm_ops omap3_clkdm_operations;
+extern struct clkdm_ops omap4_clkdm_operations;
 
 #endif
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 58b0626..2b90e91 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -20,6 +20,7 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
 #include "cm-regbits-34xx.h"
+#include "prm-regbits-24xx.h"
 #include "clockdomain.h"
 
 static int omap2_clkdm_add_wkdep(struct clockdomain *clkdm1,
@@ -107,11 +108,43 @@ static int omap3_clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 	return 0;
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
 	.clkdm_read_wkdep	= omap2_clkdm_read_wkdep,
 	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
+	.clkdm_sleep		= omap2_clkdm_sleep,
+	.clkdm_wakeup		= omap2_clkdm_wakeup,
 };
 
 struct clkdm_ops omap3_clkdm_operations = {
@@ -123,4 +156,6 @@ struct clkdm_ops omap3_clkdm_operations = {
 	.clkdm_del_sleepdep	= omap3_clkdm_del_sleepdep,
 	.clkdm_read_sleepdep	= omap3_clkdm_read_sleepdep,
 	.clkdm_clear_all_sleepdeps	= omap3_clkdm_clear_all_sleepdeps,
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
index 9e5dc8e..5c32f5f 100644
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
index 8cbbead..b954b6f 100644
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

