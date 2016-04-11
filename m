From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 20/30] ARM: OMAP2+: clockdomain: add usecounting support to autoidle APIs
Date: Mon, 11 Apr 2016 11:19:11 +0300
Message-ID: <1460362761-4842-21-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The previous implementation was racy in many locations, where the current
status of the clockdomain was read out, some operations were executed,
and the previous status info was used afterwards to decide next state
for the clockdomain. Instead, fix the implementation of the allow_idle /
deny_idle APIs to properly have usecounting support. This allows clean
handling internally within the clockdomain core, and simplifies the
usage also within hwmod.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |   36 ++++++++++++++++++++++++------------
 arch/arm/mach-omap2/clockdomain.h |    2 ++
 arch/arm/mach-omap2/cpuidle44xx.c |    2 +-
 arch/arm/mach-omap2/omap-smp.c    |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c  |   27 ++++++++++++---------------
 arch/arm/mach-omap2/pm.c          |    8 +-------
 arch/arm/mach-omap2/powerdomain.c |   20 ++++++--------------
 7 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 2da3b5e..b79b1ca 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -465,10 +465,7 @@ int clkdm_complete_init(void)
 		return -EACCES;
 
 	list_for_each_entry(clkdm, &clkdm_list, node) {
-		if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
-			clkdm_wakeup(clkdm);
-		else if (clkdm->flags & CLKDM_CAN_DISABLE_AUTO)
-			clkdm_deny_idle(clkdm);
+		clkdm_deny_idle(clkdm);
 
 		_resolve_clkdm_deps(clkdm, clkdm->wkdep_srcs);
 		clkdm_clear_all_wkdeps(clkdm);
@@ -925,11 +922,20 @@ void clkdm_allow_idle_nolock(struct clockdomain *clkdm)
 	if (!clkdm)
 		return;
 
-	if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO)) {
-		pr_debug("clock: %s: automatic idle transitions cannot be enabled\n",
-			 clkdm->name);
+	if (!WARN_ON(!clkdm->forcewake_count))
+		clkdm->forcewake_count--;
+
+	if (clkdm->forcewake_count)
+		return;
+
+	if (!clkdm->usecount && (clkdm->flags & CLKDM_CAN_FORCE_SLEEP))
+		clkdm_sleep_nolock(clkdm);
+
+	if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO))
+		return;
+
+	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING)
 		return;
-	}
 
 	if (!arch_clkdm || !arch_clkdm->clkdm_allow_idle)
 		return;
@@ -974,11 +980,17 @@ void clkdm_deny_idle_nolock(struct clockdomain *clkdm)
 	if (!clkdm)
 		return;
 
-	if (!(clkdm->flags & CLKDM_CAN_DISABLE_AUTO)) {
-		pr_debug("clockdomain: %s: automatic idle transitions cannot be disabled\n",
-			 clkdm->name);
+	if (clkdm->forcewake_count++)
+		return;
+
+	if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
+		clkdm_wakeup_nolock(clkdm);
+
+	if (!(clkdm->flags & CLKDM_CAN_DISABLE_AUTO))
+		return;
+
+	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING)
 		return;
-	}
 
 	if (!arch_clkdm || !arch_clkdm->clkdm_deny_idle)
 		return;
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 2c398ce..24667a5 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -114,6 +114,7 @@ struct omap_hwmod;
  * @wkdep_srcs: Clockdomains that can be told to wake this powerdomain up
  * @sleepdep_srcs: Clockdomains that can be told to keep this clkdm from inact
  * @usecount: Usecount tracking
+ * @forcewake_count: Usecount for forcing the domain active
  * @node: list_head to link all clockdomains together
  *
  * @prcm_partition should be a macro from mach-omap2/prcm44xx.h (OMAP4 only)
@@ -138,6 +139,7 @@ struct clockdomain {
 	struct clkdm_dep *wkdep_srcs;
 	struct clkdm_dep *sleepdep_srcs;
 	int usecount;
+	int forcewake_count;
 	struct list_head node;
 };
 
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 4b8e9f4..fa138d4 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -140,7 +140,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 		    mpuss_can_lose_context)
 			gic_dist_disable();
 
-		clkdm_wakeup(cpu_clkdm[1]);
+		clkdm_deny_idle(cpu_clkdm[1]);
 		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
 		clkdm_allow_idle(cpu_clkdm[1]);
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index c625cc1..690bfa5 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -143,7 +143,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		 * Ensure that CPU power state is set to ON to avoid CPU
 		 * powerdomain transition on wfi
 		 */
-		clkdm_wakeup_nolock(cpu1_clkdm);
+		clkdm_deny_idle_nolock(cpu1_clkdm);
 		pwrdm_set_next_pwrst(cpu1_pwrdm, PWRDM_POWER_ON);
 		clkdm_allow_idle_nolock(cpu1_clkdm);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c2f6811..345786f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1678,7 +1678,6 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
 	int ret = -EINVAL;
-	int hwsup = 0;
 
 	if (!oh)
 		return -EINVAL;
@@ -1696,7 +1695,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 		 * might not be completed. The clockdomain can be set
 		 * in HW_AUTO only when the module become ready.
 		 */
-		hwsup = clkdm_in_hwsup(oh->clkdm);
+		clkdm_deny_idle(oh->clkdm);
 		ret = clkdm_hwmod_enable(oh->clkdm, oh);
 		if (ret) {
 			WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
@@ -1723,8 +1722,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 		 * Set the clockdomain to HW_AUTO, assuming that the
 		 * previous state was HW_AUTO.
 		 */
-		if (hwsup)
-			clkdm_allow_idle(oh->clkdm);
+		clkdm_allow_idle(oh->clkdm);
 
 		clkdm_hwmod_disable(oh->clkdm, oh);
 	}
@@ -2078,7 +2076,6 @@ static int _enable_preprogram(struct omap_hwmod *oh)
 static int _enable(struct omap_hwmod *oh)
 {
 	int r;
-	int hwsup = 0;
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
@@ -2138,8 +2135,7 @@ static int _enable(struct omap_hwmod *oh)
 		 * completely the module. The clockdomain can be set
 		 * in HW_AUTO only when the module become ready.
 		 */
-		hwsup = clkdm_in_hwsup(oh->clkdm) &&
-			!clkdm_missing_idle_reporting(oh->clkdm);
+		clkdm_deny_idle(oh->clkdm);
 		r = clkdm_hwmod_enable(oh->clkdm, oh);
 		if (r) {
 			WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
@@ -2159,14 +2155,10 @@ static int _enable(struct omap_hwmod *oh)
 
 	r = (soc_ops.wait_target_ready) ? soc_ops.wait_target_ready(oh) :
 		-EINVAL;
-	if (!r) {
-		/*
-		 * Set the clockdomain to HW_AUTO only if the target is ready,
-		 * assuming that the previous state was HW_AUTO
-		 */
-		if (oh->clkdm && hwsup)
-			clkdm_allow_idle(oh->clkdm);
+	if (oh->clkdm)
+		clkdm_allow_idle(oh->clkdm);
 
+	if (!r) {
 		oh->_state = _HWMOD_STATE_ENABLED;
 
 		/* Access the sysconfig only if the target is ready */
@@ -2220,6 +2212,9 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 
+	if (oh->clkdm)
+		clkdm_deny_idle(oh->clkdm);
+
 	if (oh->flags & HWMOD_BLOCK_WFI)
 		cpu_idle_poll_ctrl(false);
 	if (soc_ops.disable_module)
@@ -2232,8 +2227,10 @@ static int _idle(struct omap_hwmod *oh)
 	 * transition to complete properly.
 	 */
 	_disable_clocks(oh);
-	if (oh->clkdm)
+	if (oh->clkdm) {
+		clkdm_allow_idle(oh->clkdm);
 		clkdm_hwmod_disable(oh->clkdm, oh);
+	}
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux && oh->mux->pads_dynamic) {
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 83143fe..630b305 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -110,13 +110,7 @@ static void __init omap2_init_processor_devices(void)
 
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
-	/* XXX The usecount test is racy */
-	if ((clkdm->flags & CLKDM_CAN_ENABLE_AUTO) &&
-	    !(clkdm->flags & CLKDM_MISSING_IDLE_REPORTING))
-		clkdm_allow_idle(clkdm);
-	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
-		 clkdm->usecount == 0)
-		clkdm_sleep(clkdm);
+	clkdm_allow_idle(clkdm);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 78af6d8..be7a976 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -222,7 +222,6 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
  * @pwrdm: struct powerdomain * to operate on
  * @curr_pwrst: current power state of @pwrdm
  * @pwrst: power state to switch to
- * @hwsup: ptr to a bool to return whether the clkdm is hardware-supervised
  *
  * Determine whether the powerdomain needs to be turned on before
  * attempting to switch power states.  Called by
@@ -233,8 +232,7 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
  * "Types of sleep_switch" comment above).
  */
 static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
-					       u8 curr_pwrst, u8 pwrst,
-					       bool *hwsup)
+					       u8 curr_pwrst, u8 pwrst)
 {
 	u8 sleep_switch;
 
@@ -244,8 +242,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
 		    arch_pwrdm->pwrdm_set_lowpwrstchange) {
 			sleep_switch = LOWPOWERSTATE_SWITCH;
 		} else {
-			*hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
-			clkdm_wakeup_nolock(pwrdm->pwrdm_clkdms[0]);
+			clkdm_deny_idle_nolock(pwrdm->pwrdm_clkdms[0]);
 			sleep_switch = FORCEWAKEUP_SWITCH;
 		}
 	} else {
@@ -259,7 +256,6 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
  * _pwrdm_restore_clkdm_state - restore the clkdm hwsup state after pwrst change
  * @pwrdm: struct powerdomain * to operate on
  * @sleep_switch: return value from _pwrdm_save_clkdm_state_and_activate()
- * @hwsup: should @pwrdm's first clockdomain be set to hardware-supervised mode?
  *
  * Restore the clockdomain state perturbed by
  * _pwrdm_save_clkdm_state_and_activate(), and call the power state
@@ -270,14 +266,11 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
  * software-supervised sleep.  No return value.
  */
 static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
-				       u8 sleep_switch, bool hwsup)
+				       u8 sleep_switch)
 {
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
-		if (hwsup)
-			clkdm_allow_idle_nolock(pwrdm->pwrdm_clkdms[0]);
-		else
-			clkdm_sleep_nolock(pwrdm->pwrdm_clkdms[0]);
+		clkdm_allow_idle_nolock(pwrdm->pwrdm_clkdms[0]);
 		break;
 	case LOWPOWERSTATE_SWITCH:
 		if (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
@@ -1092,7 +1085,6 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 	u8 next_pwrst, sleep_switch;
 	int curr_pwrst;
 	int ret = 0;
-	bool hwsup = false;
 
 	if (!pwrdm || IS_ERR(pwrdm))
 		return -EINVAL;
@@ -1116,14 +1108,14 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 		goto osps_out;
 
 	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, curr_pwrst,
-							    pwrst, &hwsup);
+							    pwrst);
 
 	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
 	if (ret)
 		pr_err("%s: unable to set power state of powerdomain: %s\n",
 		       __func__, pwrdm->name);
 
-	_pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
+	_pwrdm_restore_clkdm_state(pwrdm, sleep_switch);
 
 osps_out:
 	pwrdm_unlock(pwrdm);
-- 
1.7.9.5

