From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 5/8] ARM: OMAP2+: PM: introduce power domains achievable functional states
Date: Thu, 14 Jun 2012 16:53:08 +0200
Message-ID: <1339685591-11177-6-git-send-email-j-pihet@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49034 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115Ab2FNOxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 10:53:39 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn6so2037554wib.1
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 07:53:38 -0700 (PDT)
In-Reply-To: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
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
power state for a power domain and its use by omap_set_pwrdm_state.
The achievable power state is first looked for in the lower power
states in order to maximize the power savings, then if not found
in the higher power states.

Inspired from Tero's work on OMAP4 device OFF support and generalized
to the functional power states.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |  156 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/powerdomain.h |    1 +
 2 files changed, 134 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index ce2685a..f94174b 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -554,6 +554,108 @@ int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
 	return ret;
 }
 
+/**
+ * pwrdm_get_achievable_func_pwrst() - Provide achievable functional state
+ * @pwrdm: struct powerdomain * to set
+ * @func_pwrst: minimum functional state we would like to hit
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
+int pwrdm_get_achievable_func_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
+{
+	int pwrst = pwrdm_func_to_pwrst(pwrdm, func_pwrst);
+	int logic = pwrdm_func_to_logic_pwrst(pwrdm, func_pwrst);
+	int new_func_pwrst, new_pwrst, new_logic;
+	int found;
+
+	if (!pwrdm || IS_ERR(pwrdm)) {
+		pr_debug("%s: invalid params: pwrdm=%p, func_pwrst=%0x\n",
+			 __func__, pwrdm, func_pwrst);
+		return -EINVAL;
+	}
+
+	if ((pwrst < 0) || (logic < 0)) {
+		pr_debug("%s: invalid params for pwrdm %s, func_pwrst=%0x\n",
+			 __func__, pwrdm->name, func_pwrst);
+		return PWRDM_FUNC_PWRST_ON;
+	}
+
+	/*
+	 * Power state: if the requested state is not supported,
+	 * try the lower power states.
+	 */
+	found = 1;
+	new_pwrst = pwrst;
+	while (!(pwrdm->pwrsts & (1 << new_pwrst))) {
+		if (new_pwrst == PWRDM_POWER_OFF) {
+			found = 0;
+			break;
+		}
+		new_pwrst--;
+	}
+
+	/*
+	 * If no lower power state found, fallback to the higher
+	 * power states.
+	 * PWRDM_POWER_ON is always valid.
+	 */
+	if (!found) {
+		new_pwrst = pwrst;
+		while (!(pwrdm->pwrsts & (1 << new_pwrst))) {
+			if (new_pwrst == PWRDM_POWER_ON)
+				break;
+			new_pwrst++;
+		}
+	}
+
+	/*
+	 * Logic RET state: if the requested state is not supported,
+	 * try the lower logic states.
+	 */
+	found = 1;
+	new_logic = logic;
+	while (!(pwrdm->pwrsts_logic_ret & (1 << new_logic))) {
+		if (new_logic == PWRDM_LOGIC_MEM_PWRST_OFF) {
+			found = 0;
+			break;
+		}
+		new_logic--;
+	}
+
+	/*
+	 * If no lower logic state found, fallback to the higher
+	 * logic states.
+	 * PWRDM_LOGIC_MEM_PWRST_RET is always valid.
+	 */
+	if (!found) {
+		new_logic = logic;
+		while (!(pwrdm->pwrsts_logic_ret & (1 << new_logic))) {
+			if (new_logic == PWRDM_LOGIC_MEM_PWRST_RET)
+				break;
+			new_logic++;
+		}
+	}
+
+	new_func_pwrst = pwrdm_pwrst_to_func(pwrdm, new_pwrst, new_logic);
+
+	pr_debug("%s(%s, func_pwrst=%0x) returns %0x\n", __func__,
+		 pwrdm->name, func_pwrst, new_func_pwrst);
+
+	return new_func_pwrst;
+}
+
 /* Types of sleep_switch used in omap_set_pwrdm_state */
 #define FORCEWAKEUP_SWITCH	0
 #define LOWPOWERSTATE_SWITCH	1
@@ -563,36 +665,32 @@ int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
  * @pwrdm: struct powerdomain * to set
  * @func_pwrst: power domain functional state, one of the PWRDM_FUNC_* macros
  *
- * This programs the pwrdm next functional state, sets the dependencies
- * and waits for the state to be applied.
+ * This looks for the more suited (or achievable) next functional power
+ * state, programs it, sets the dependencies and waits for the state to
+ * be applied to the power domain.
  */
 int omap_set_pwrdm_state(struct powerdomain *pwrdm,
 			 enum pwrdm_func_state func_pwrst)
 {
-	u8 curr_pwrst, next_pwrst;
-	int pwrst = pwrdm_func_to_pwrst(pwrdm, func_pwrst);
-	int logic = pwrdm_func_to_logic_pwrst(pwrdm, func_pwrst);
 	int sleep_switch = -1, ret = 0, hwsup = 0;
+	int new_func_pwrst, next_func_pwrst, pwrst, logic;
+	u8 curr_pwrst;
 
-	if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0) || (logic < 0)) {
-		pr_debug("%s: invalid params: pwrdm=%p, func_pwrst=%0x\n",
-			 __func__, pwrdm, func_pwrst);
+	if (!pwrdm || IS_ERR(pwrdm)) {
+		pr_debug("%s: invalid params: pwrdm=%p\n", __func__, pwrdm);
 		return -EINVAL;
 	}
 
-	pr_debug("%s: set func_pwrst %0x to pwrdm %s\n",
-		 __func__, func_pwrst, pwrdm->name);
+	pr_debug("%s(%s, func_pwrst=%0x)\n", __func__, pwrdm->name, func_pwrst);
 
 	mutex_lock(&pwrdm->lock);
 
-	while (!(pwrdm->pwrsts & (1 << pwrst))) {
-		if (pwrst == PWRDM_POWER_OFF)
-			goto out;
-		pwrst--;
-	}
+	new_func_pwrst = pwrdm_get_achievable_func_pwrst(pwrdm, func_pwrst);
+	pwrst = pwrdm_func_to_pwrst(pwrdm, new_func_pwrst);
+	logic = pwrdm_func_to_logic_pwrst(pwrdm, new_func_pwrst);
 
-	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	if (next_pwrst == pwrst)
+	next_func_pwrst = pwrdm_read_next_func_pwrst(pwrdm);
+	if (new_func_pwrst == next_func_pwrst)
 		goto out;
 
 	curr_pwrst = pwrdm_read_pwrst(pwrdm);
@@ -607,13 +705,25 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm,
 		}
 	}
 
-	if (logic != pwrdm_read_logic_retst(pwrdm))
-		pwrdm_set_logic_retst(pwrdm, logic);
+	pr_debug("%s: set func_pwrst %0x (%0x,%0x) to pwrdm %s\n",
+		 __func__, new_func_pwrst, pwrst, logic, pwrdm->name);
+
+	/* Trace the pwrdm desired target state */
+	trace_power_domain_target(pwrdm->name, new_func_pwrst,
+				  smp_processor_id());
+
+	/* Program next power state */
+	if (pwrst != pwrdm_func_to_pwrst(pwrdm, next_func_pwrst)) {
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
+	    (logic != pwrdm_func_to_logic_pwrst(pwrdm, next_func_pwrst)))
+		pwrdm_set_logic_retst(pwrdm, logic);
 
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index d08c25d..9dd68ab 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -247,6 +247,7 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
 int omap2_pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
 int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
+int pwrdm_get_achievable_func_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
 
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-- 
1.7.7.6

