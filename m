From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains achievable functional states
Date: Wed, 15 Aug 2012 12:02:42 +0200
Message-ID: <1345024968-28951-3-git-send-email-j-pihet@ti.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59062 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2HOKDN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 06:03:13 -0400
Received: by wgbdr13 with SMTP id dr13so1239154wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 03:03:12 -0700 (PDT)
In-Reply-To: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>, Tero Kristo <t-kristo@ti.com>

Note: the patch is in RFC state because the state machine for setting
the next power domain states needs more discussion. Validated on OMAP3&4
with cpuidle and suspend/resume, though.

Power domains have varied capabilities. When attempting a low power
state such as OFF/RET, a specific min requested state may not be
supported on the power domain. This is because a combination
of system power states where the parent PD's state is not in line
with expectation can result in system instabilities.

This patch provides a function that returns the achievable functional
power state for a power domain and its use by pwrdm_set_next_fpwrst.
The achievable power state is first looked for in the lower power
states in order to maximize the power savings, then if not found
in the higher power states.

Inspired from Tero's work on OMAP4 device OFF support, generalized
to the functional power states and reworked as per Nishant's
suggestions.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |  152 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/powerdomain.h |    1 +
 2 files changed, 130 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6fc3c84..3a1f56c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -199,6 +199,53 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
+/**
+ * Search down then up for a valid state from a list of allowed states.
+ * Used by pwrdm_get_achievable_fpwrst to look for allowed power and
+ * logic states for a powerdomain.
+ *
+ * @pwrsts: list of allowed states, defined as a bitmask
+ * @pwrst: initial state to be used as a starting point
+ * @min: minimum allowed state
+ * @max: maximum allowed state
+ *
+ * Returns the matching allowed state.
+ */
+static inline int _match_pwrst(u32 pwrsts, int pwrst, int min, int max)
+{
+	int found = 1, new_pwrst = pwrst;
+
+	/*
+	 * Search lower: if the requested state is not supported
+	 * try the lower states, stopping at the minimum allowed
+	 * state
+	 */
+	while (!(pwrsts & (1 << new_pwrst))) {
+		if (new_pwrst <= min) {
+			found = 0;
+			break;
+		}
+		new_pwrst--;
+	}
+
+	/*
+	 * Search higher: if no lower state found fallback to the higher
+	 * states, stopping at the maximum allowed state
+	 */
+	if (!found) {
+		new_pwrst = pwrst;
+		while (!(pwrsts & (1 << new_pwrst))) {
+			if (new_pwrst >= max) {
+				new_pwrst = max;
+				break;
+			}
+			new_pwrst++;
+		}
+	}
+
+	return new_pwrst;
+}
+
 /* Public functions */
 
 /**
@@ -553,6 +600,57 @@ int pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
 	return ret;
 }
 
+/**
+ * pwrdm_get_achievable_fpwrst() - Provide achievable functional state
+ * @pwrdm: struct powerdomain * to set
+ * @fpwrst: minimum functional state we would like to hit
+ * (one of the PWRDM_FUNC_* macros)
+ *
+ * Power domains have varied capabilities. When attempting a low power
+ * state such as OFF/RET, a specific min requested state may not be
+ * supported on the power domain. This is because a combination
+ * of system power states where the parent PD's state is not in line
+ * with expectation can result in system instabilities.
+ *
+ * The achievable power state is first looked for in the lower power
+ * states in order to maximize the power savings, then if not found
+ * in the higher power states.
+ *
+ * Returns the achievable functional power state, or -EINVAL in case of
+ * invalid parameters.
+ */
+int pwrdm_get_achievable_fpwrst(struct powerdomain *pwrdm, u8 fpwrst)
+{
+	int pwrst = pwrdm_fpwrst_to_pwrst(pwrdm, fpwrst);
+	int logic = pwrdm_fpwrst_to_logic_pwrst(pwrdm, fpwrst);
+	int new_fpwrst, new_pwrst, new_logic;
+
+	if (!pwrdm || IS_ERR(pwrdm)) {
+		pr_debug("%s: invalid params: pwrdm=%p, fpwrst=%0x\n",
+			 __func__, pwrdm, fpwrst);
+		return -EINVAL;
+	}
+
+	if ((pwrst < 0) || (logic < 0)) {
+		pr_debug("%s: invalid params for pwrdm %s, fpwrst=%0x\n",
+			 __func__, pwrdm->name, fpwrst);
+		return PWRDM_FUNC_PWRST_ON;
+	}
+
+	new_pwrst = _match_pwrst(pwrdm->pwrsts, pwrst, PWRDM_POWER_OFF,
+				 PWRDM_POWER_ON);
+	new_logic = _match_pwrst(pwrdm->pwrsts_logic_ret, logic,
+				 PWRDM_LOGIC_MEM_PWRST_OFF,
+				 PWRDM_LOGIC_MEM_PWRST_RET);
+
+	new_fpwrst = pwrdm_pwrst_to_fpwrst(pwrdm, new_pwrst, new_logic);
+
+	pr_debug("%s(%s, fpwrst=%0x) returns %0x\n", __func__,
+		 pwrdm->name, fpwrst, new_fpwrst);
+
+	return new_fpwrst;
+}
+
 /* Types of sleep_switch used in pwrdm_set_next_fpwrst */
 #define FORCEWAKEUP_SWITCH	0
 #define LOWPOWERSTATE_SWITCH	1
@@ -562,34 +660,30 @@ int pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
  * @pwrdm: struct powerdomain * to set
  * @fpwrst: power domain functional state, one of the PWRDM_FUNC_* macros
  *
- * This programs the pwrdm next functional state, sets the dependencies
- * and waits for the state to be applied.
+ * This looks for the more suited (or achievable) next functional power
+ * state, programs it, sets the dependencies and waits for the state to
+ * be applied to the power domain.
  */
 int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
 			  enum pwrdm_func_state fpwrst)
 {
-	u8 curr_pwrst, next_pwrst;
-	int pwrst = pwrdm_fpwrst_to_pwrst(pwrdm, fpwrst);
-	int logic = pwrdm_fpwrst_to_logic_pwrst(pwrdm, fpwrst);
 	int sleep_switch = -1, ret = 0, hwsup = 0;
+	int new_fpwrst, next_fpwrst, pwrst, logic;
+	u8 curr_pwrst;
 
-	if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0) || (logic < 0)) {
-		pr_debug("%s: invalid params: pwrdm=%p, fpwrst=%0x\n",
-			 __func__, pwrdm, fpwrst);
+	if (!pwrdm || IS_ERR(pwrdm)) {
+		pr_debug("%s: invalid params: pwrdm=%p\n", __func__, pwrdm);
 		return -EINVAL;
 	}
 
-	pr_debug("%s: set fpwrst %0x to pwrdm %s\n",
-		 __func__, fpwrst, pwrdm->name);
+	pr_debug("%s(%s, fpwrst=%0x)\n", __func__, pwrdm->name, fpwrst);
 
-	while (!(pwrdm->pwrsts & (1 << pwrst))) {
-		if (pwrst == PWRDM_POWER_OFF)
-			return ret;
-		pwrst--;
-	}
+	new_fpwrst = pwrdm_get_achievable_fpwrst(pwrdm, fpwrst);
+	pwrst = pwrdm_fpwrst_to_pwrst(pwrdm, new_fpwrst);
+	logic = pwrdm_fpwrst_to_logic_pwrst(pwrdm, new_fpwrst);
 
-	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	if (next_pwrst == pwrst)
+	next_fpwrst = pwrdm_read_next_fpwrst(pwrdm);
+	if (new_fpwrst == next_fpwrst)
 		return ret;
 
 	curr_pwrst = pwrdm_read_pwrst(pwrdm);
@@ -604,13 +698,25 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
 		}
 	}
 
-	if (logic != pwrdm_read_logic_retst(pwrdm))
-		pwrdm_set_logic_retst(pwrdm, logic);
+	pr_debug("%s: set fpwrst %0x (%0x,%0x) to pwrdm %s\n",
+		 __func__, new_fpwrst, pwrst, logic, pwrdm->name);
+
+	/* Trace the pwrdm desired target state */
+	trace_power_domain_target(pwrdm->name, new_fpwrst,
+				  smp_processor_id());
+
+	/* Program next power state */
+	if (pwrst != pwrdm_fpwrst_to_pwrst(pwrdm, next_fpwrst)) {
+		ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+		if (ret)
+			pr_err("%s: unable to set power state of powerdomain: %s\n",
+			       __func__, pwrdm->name);
+	}
 
-	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
-	if (ret)
-		pr_err("%s: unable to set power state of powerdomain: %s\n",
-		       __func__, pwrdm->name);
+	/* Program RET logic state */
+	if ((pwrst == PWRDM_POWER_RET) &&
+	    (logic != pwrdm_fpwrst_to_logic_pwrst(pwrdm, next_fpwrst)))
+		pwrdm_set_logic_retst(pwrdm, logic);
 
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index aa9f9b9..45c449d 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -239,6 +239,7 @@ int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
 int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm);
 int pwrdm_read_fpwrst(struct powerdomain *pwrdm);
 int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm);
+int pwrdm_get_achievable_fpwrst(struct powerdomain *pwrdm, u8 fpwrst);
 int omap2_pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
 int omap2_pwrdm_fpwrst_to_logic_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
 int omap2_pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
-- 
1.7.7.6

