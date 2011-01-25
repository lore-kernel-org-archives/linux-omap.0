From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 4/5] OMAP: clockdomain: Arch specific funcs for hwsup control of clkdm
Date: Tue, 25 Jan 2011 17:21:47 +0530
Message-ID: <1295956308-23860-5-git-send-email-rnayak@ti.com>
References: <1295956308-23860-1-git-send-email-rnayak@ti.com>
 <1295956308-23860-2-git-send-email-rnayak@ti.com>
 <1295956308-23860-3-git-send-email-rnayak@ti.com>
 <1295956308-23860-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53431 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab1AYLwG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 06:52:06 -0500
In-Reply-To: <1295956308-23860-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Define the following architecture specific funtions for omap2/3/4
.clkdm_allow_idle
.clkdm_deny_idle

Convert the platform-independent framework to call these functions.
Also rename the api's by removing the omap2_ preamble.
Hence call omap2_clkdm_allow_idle as clkdm_allow_idle and
omap2_clkdm_deny_idle as clkdm_deny_idle.

Make the _clkdm_add_autodeps and _clkdm_del_autodeps as non-static
so they can be accessed from OMAP2/3 platform specific code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c          |   49 ++++++++-------------------
 arch/arm/mach-omap2/clockdomain.h          |    6 ++-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   40 ++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c      |   14 ++++++++
 arch/arm/mach-omap2/cpuidle34xx.c          |    4 +-
 arch/arm/mach-omap2/pm.c                   |    2 +-
 arch/arm/mach-omap2/pm24xx.c               |    2 +-
 arch/arm/mach-omap2/pm34xx.c               |    4 +-
 8 files changed, 79 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 9beccc7..9f1f37b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -178,7 +178,7 @@ static void _autodep_lookup(struct clkdm_autodep *autodep)
  * XXX autodeps are deprecated and should be removed at the earliest
  * opportunity
  */
-static void _clkdm_add_autodeps(struct clockdomain *clkdm)
+void _clkdm_add_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
@@ -212,7 +212,7 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
  * XXX autodeps are deprecated and should be removed at the earliest
  * opportunity
  */
-static void _clkdm_del_autodeps(struct clockdomain *clkdm)
+void _clkdm_del_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
@@ -332,7 +332,7 @@ void clkdm_init(struct clockdomain **clkdms,
 		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
 			clkdm_wakeup(clkdm);
 		else if (clkdm->flags & CLKDM_CAN_DISABLE_AUTO)
-			omap2_clkdm_deny_idle(clkdm);
+			clkdm_deny_idle(clkdm);
 
 		for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
 			if (!omap_chip_is(cd->omap_chip))
@@ -780,7 +780,7 @@ int clkdm_wakeup(struct clockdomain *clkdm)
 }
 
 /**
- * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
+ * clkdm_allow_idle - enable hwsup idle transitions for clkdm
  * @clkdm: struct clockdomain *
  *
  * Allow the hardware to automatically switch the clockdomain @clkdm into
@@ -789,7 +789,7 @@ int clkdm_wakeup(struct clockdomain *clkdm)
  * framework, wkdep/sleepdep autodependencies are added; this is so
  * device drivers can read and write to the device.  No return value.
  */
-void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
+void clkdm_allow_idle(struct clockdomain *clkdm)
 {
 	if (!clkdm)
 		return;
@@ -800,28 +800,18 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 		return;
 	}
 
+	if (!arch_clkdm || !arch_clkdm->clkdm_allow_idle)
+		return;
+
 	pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
-	/*
-	 * XXX This should be removed once TI adds wakeup/sleep
-	 * dependency code and data for OMAP4.
-	 */
-	if (cpu_is_omap44xx()) {
-		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
-			  "support is not yet implemented\n");
-	} else {
-		if (atomic_read(&clkdm->usecount) > 0)
-			_clkdm_add_autodeps(clkdm);
-	}
-
-	_enable_hwsup(clkdm);
-
+	arch_clkdm->clkdm_allow_idle(clkdm);
 	pwrdm_clkdm_state_switch(clkdm);
 }
 
 /**
- * omap2_clkdm_deny_idle - disable hwsup idle transitions for clkdm
+ * clkdm_deny_idle - disable hwsup idle transitions for clkdm
  * @clkdm: struct clockdomain *
  *
  * Prevent the hardware from automatically switching the clockdomain
@@ -829,7 +819,7 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
  * downstream clocks enabled in the clock framework, wkdep/sleepdep
  * autodependencies are removed.  No return value.
  */
-void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
+void clkdm_deny_idle(struct clockdomain *clkdm)
 {
 	if (!clkdm)
 		return;
@@ -840,22 +830,13 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 		return;
 	}
 
+	if (!arch_clkdm || !arch_clkdm->clkdm_deny_idle)
+		return;
+
 	pr_debug("clockdomain: disabling automatic idle transitions for %s\n",
 		 clkdm->name);
 
-	_disable_hwsup(clkdm);
-
-	/*
-	 * XXX This should be removed once TI adds wakeup/sleep
-	 * dependency code and data for OMAP4.
-	 */
-	if (cpu_is_omap44xx()) {
-		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
-			  "support is not yet implemented\n");
-	} else {
-		if (atomic_read(&clkdm->usecount) > 0)
-			_clkdm_del_autodeps(clkdm);
-	}
+	arch_clkdm->clkdm_deny_idle(clkdm);
 }
 
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 7a5cb5c..7126658 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -167,8 +167,8 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2);
 int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
 
-void omap2_clkdm_allow_idle(struct clockdomain *clkdm);
-void omap2_clkdm_deny_idle(struct clockdomain *clkdm);
+void clkdm_allow_idle(struct clockdomain *clkdm);
+void clkdm_deny_idle(struct clockdomain *clkdm);
 
 int clkdm_wakeup(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
@@ -179,6 +179,8 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 extern void __init omap2xxx_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
+extern void _clkdm_add_autodeps(struct clockdomain *clkdm);
+extern void _clkdm_del_autodeps(struct clockdomain *clkdm);
 
 extern struct clkdm_ops omap2_clkdm_operations;
 extern struct clkdm_ops omap3_clkdm_operations;
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 2b90e91..54b0ca9 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -124,6 +124,24 @@ static int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 	return 0;
 }
 
+static void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
+{
+	if (atomic_read(&clkdm->usecount) > 0)
+		_clkdm_add_autodeps(clkdm);
+
+	omap2xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+}
+
+static void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
+{
+	omap2xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+
+	if (atomic_read(&clkdm->usecount) > 0)
+		_clkdm_del_autodeps(clkdm);
+}
+
 static int omap3_clkdm_sleep(struct clockdomain *clkdm)
 {
 	omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
@@ -138,6 +156,24 @@ static int omap3_clkdm_wakeup(struct clockdomain *clkdm)
 	return 0;
 }
 
+static void omap3_clkdm_allow_idle(struct clockdomain *clkdm)
+{
+	if (atomic_read(&clkdm->usecount) > 0)
+		_clkdm_add_autodeps(clkdm);
+
+	omap3xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+}
+
+static void omap3_clkdm_deny_idle(struct clockdomain *clkdm)
+{
+	omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+				clkdm->clktrctrl_mask);
+
+	if (atomic_read(&clkdm->usecount) > 0)
+		_clkdm_del_autodeps(clkdm);
+}
+
 struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_add_wkdep	= omap2_clkdm_add_wkdep,
 	.clkdm_del_wkdep	= omap2_clkdm_del_wkdep,
@@ -145,6 +181,8 @@ struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_clear_all_wkdeps	= omap2_clkdm_clear_all_wkdeps,
 	.clkdm_sleep		= omap2_clkdm_sleep,
 	.clkdm_wakeup		= omap2_clkdm_wakeup,
+	.clkdm_allow_idle	= omap2_clkdm_allow_idle,
+	.clkdm_deny_idle	= omap2_clkdm_deny_idle,
 };
 
 struct clkdm_ops omap3_clkdm_operations = {
@@ -158,4 +196,6 @@ struct clkdm_ops omap3_clkdm_operations = {
 	.clkdm_clear_all_sleepdeps	= omap3_clkdm_clear_all_sleepdeps,
 	.clkdm_sleep		= omap3_clkdm_sleep,
 	.clkdm_wakeup		= omap3_clkdm_wakeup,
+	.clkdm_allow_idle	= omap3_clkdm_allow_idle,
+	.clkdm_deny_idle	= omap3_clkdm_deny_idle,
 };
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index 9ccb406..a46125f 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -29,7 +29,21 @@ static int omap4_clkdm_wakeup(struct clockdomain *clkdm)
 	return 0;
 }
 
+static void omap4_clkdm_allow_idle(struct clockdomain *clkdm)
+{
+	omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
+					clkdm->cm_inst, clkdm->clkdm_offs);
+}
+
+static void omap4_clkdm_deny_idle(struct clockdomain *clkdm)
+{
+	omap4_cminst_clkdm_disable_hwsup(clkdm->prcm_partition,
+					clkdm->cm_inst, clkdm->clkdm_offs);
+}
+
 struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_sleep		= omap4_clkdm_sleep,
 	.clkdm_wakeup		= omap4_clkdm_wakeup,
+	.clkdm_allow_idle	= omap4_clkdm_allow_idle,
+	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
 };
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f7b22a1..7cc8071 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -99,14 +99,14 @@ static int omap3_idle_bm_check(void)
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
 {
-	omap2_clkdm_allow_idle(clkdm);
+	clkdm_allow_idle(clkdm);
 	return 0;
 }
 
 static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
 {
-	omap2_clkdm_deny_idle(clkdm);
+	clkdm_deny_idle(clkdm);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 74c3100..7bb64d8 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -140,7 +140,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
 		if (pwrdm->pwrdm_clkdms[0]->flags & CLKDM_CAN_ENABLE_AUTO)
-			omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		else
 			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
 		break;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 5c32f5f..ebda2ea 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -367,7 +367,7 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 	clkdm_clear_all_sleepdeps(clkdm);
 
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
-		omap2_clkdm_allow_idle(clkdm);
+		clkdm_allow_idle(clkdm);
 	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
 		 atomic_read(&clkdm->usecount) == 0)
 		clkdm_sleep(clkdm);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b954b6f..78e1aa5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -495,7 +495,7 @@ console_still_active:
 
 	pwrdm_post_transition();
 
-	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
+	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
 int omap3_can_sleep(void)
@@ -989,7 +989,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
-		omap2_clkdm_allow_idle(clkdm);
+		clkdm_allow_idle(clkdm);
 	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
 		 atomic_read(&clkdm->usecount) == 0)
 		clkdm_sleep(clkdm);
-- 
1.7.0.4

