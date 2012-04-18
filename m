From: jean.pihet@newoldbits.com
Subject: [PATCH 2/6] ARM: OMAP2+: PM: introduce power domains functional states
Date: Wed, 18 Apr 2012 14:39:38 +0200
Message-ID: <1334752782-28804-3-git-send-email-j-pihet@ti.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49049 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab2DRMkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 08:40:11 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so7480976wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 05:40:10 -0700 (PDT)
In-Reply-To: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Introduce functional (or logical) states for power domains and the
API functions to read the power domains settings and to convert
between the functional (i.e. logical) and the internal (or registers)
values.

OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine.

In the new API the function omap_set_pwrdm_state takes the functional
states as parameter; while at it the function is moved to the power
domains code.

The memory and logic states are not using the functional states, this
comes as a subsequent patch.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.c                   |   66 -----------
 arch/arm/mach-omap2/powerdomain-common.c   |   61 ++++++++++
 arch/arm/mach-omap2/powerdomain.c          |  175 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h          |   21 ++++
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    5 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    2 +
 6 files changed, 264 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 6918a13..8670c4b 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -74,10 +74,6 @@ static void __init omap2_init_processor_devices(void)
 	}
 }
 
-/* Types of sleep_switch used in omap_set_pwrdm_state */
-#define FORCEWAKEUP_SWITCH	0
-#define LOWPOWERSTATE_SWITCH	1
-
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
@@ -89,68 +85,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 }
 
 /*
- * This sets pwrdm state (other than mpu & core. Currently only ON &
- * RET are supported.
- */
-int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
-{
-	u8 curr_pwrst, next_pwrst;
-	int sleep_switch = -1, ret = 0, hwsup = 0;
-
-	if (!pwrdm || IS_ERR(pwrdm))
-		return -EINVAL;
-
-	mutex_lock(&pwrdm->lock);
-
-	while (!(pwrdm->pwrsts & (1 << pwrst))) {
-		if (pwrst == PWRDM_POWER_OFF)
-			goto out;
-		pwrst--;
-	}
-
-	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	if (next_pwrst == pwrst)
-		goto out;
-
-	curr_pwrst = pwrdm_read_pwrst(pwrdm);
-	if (curr_pwrst < PWRDM_POWER_ON) {
-		if ((curr_pwrst > pwrst) &&
-			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
-			sleep_switch = LOWPOWERSTATE_SWITCH;
-		} else {
-			hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
-			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
-			sleep_switch = FORCEWAKEUP_SWITCH;
-		}
-	}
-
-	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
-	if (ret)
-		pr_err("%s: unable to set power state of powerdomain: %s\n",
-		       __func__, pwrdm->name);
-
-	switch (sleep_switch) {
-	case FORCEWAKEUP_SWITCH:
-		if (hwsup)
-			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
-		else
-			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
-		break;
-	case LOWPOWERSTATE_SWITCH:
-		pwrdm_set_lowpwrstchange(pwrdm);
-		pwrdm_wait_transition(pwrdm);
-		pwrdm_state_switch(pwrdm);
-		break;
-	}
-
-out:
-	mutex_unlock(&pwrdm->lock);
-	return ret;
-}
-
-
-
-/*
  * This API is to be called during init to set the various voltage
  * domains to the voltage as per the opp table. Typically we boot up
  * at the nominal voltage. So this function finds out the rate of
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index c0aeabf..098dc42 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -108,3 +108,64 @@ u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank)
 	return 0;
 }
 
+/*
+ * Functional (i.e. logical) to internal (i.e. registers)
+ * values for the power domains states
+ */
+int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
+{
+	int ret;
+
+	switch (func_pwrst) {
+	case PWRDM_FUNC_PWRST_ON:
+		ret = PWRDM_POWER_ON;
+		break;
+	case PWRDM_FUNC_PWRST_INACTIVE:
+		ret = PWRDM_POWER_INACTIVE;
+		break;
+	case PWRDM_FUNC_PWRST_CSWR:
+	case PWRDM_FUNC_PWRST_OSWR:
+		ret = PWRDM_POWER_RET;
+		break;
+	case PWRDM_FUNC_PWRST_OFF:
+		ret = PWRDM_POWER_OFF;
+		break;
+	default:
+		ret = -1;
+	}
+
+	return ret;
+}
+
+/*
+ * Internal (i.e. registers) to functional (i.e. logical) values
+ * for the power domains states
+ */
+int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
+{
+	int ret;
+
+	switch (pwrst) {
+	case PWRDM_POWER_ON:
+		ret = PWRDM_FUNC_PWRST_ON;
+		break;
+	case PWRDM_POWER_INACTIVE:
+		ret = PWRDM_FUNC_PWRST_INACTIVE;
+		break;
+	case PWRDM_POWER_RET:
+		/*
+		 * XXX warning: return OSWR in case of pd in RET and
+		 * logic in OFF
+		 */
+		ret = PWRDM_FUNC_PWRST_CSWR;
+		break;
+	case PWRDM_POWER_OFF:
+		ret = PWRDM_FUNC_PWRST_OFF;
+		break;
+	default:
+		ret = -1;
+	}
+
+	return ret;
+}
+
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 319b277..718fa43 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -466,6 +466,136 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_func_to_pwrst - get the internal (i.e. registers) value mapped
+ * to the functional state
+ * @pwrdm: struct powerdomain * to query
+ * @func_pwrst: functional power state
+ *
+ * Convert the functional power state to the platform specific power
+ * domain state value.
+ * Returns the internal power domain state value or -EINVAL in case
+ * of invalid parameters passed in.
+ */
+int pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
+{
+	int ret = func_pwrst;
+
+	if ((!pwrdm)|| (func_pwrst >= PWRDM_MAX_FUNC_PWRSTS))
+		return -EINVAL;
+
+	pr_debug("powerdomain: convert %0x func to pwrst for %s\n",
+		 func_pwrst, pwrdm->name);
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_pwrst) {
+		ret = arch_pwrdm->pwrdm_func_to_pwrst(pwrdm, func_pwrst);
+	}
+
+	return ret;
+}
+
+/**
+ * pwrdm_pwrst_to_func - get the functional (i.e. logical) value mapped
+ * to the internal state
+ * @pwrdm: struct powerdomain * to query
+ * @pwrst: internal power state
+ *
+ * Convert the internal power state to the power domain functional value.
+ * Returns the functional power domain state value or -EINVAL in case
+ * of invalid parameters passed in.
+ */
+int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
+{
+	int ret = pwrst;
+
+	if ((!pwrdm)|| (pwrst >= PWRDM_MAX_PWRSTS))
+		return -EINVAL;
+
+	pr_debug("powerdomain: convert %0x pwrst to func for %s\n",
+		 pwrst, pwrdm->name);
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func) {
+		ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst);
+	}
+
+	return ret;
+}
+
+/* Types of sleep_switch used in omap_set_pwrdm_state */
+#define FORCEWAKEUP_SWITCH	0
+#define LOWPOWERSTATE_SWITCH	1
+
+/**
+ * omap_set_pwrdm_state - program next powerdomain power state
+ * @pwrdm: struct powerdomain * to set
+ * @func_pwrst: power domain functional state, one of the PWRDM_FUNC_* macros
+ *
+ * This programs the pwrdm next functional state, sets the dependencies
+ * and waits for the state to be applied.
+ */
+int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
+{
+	u8 curr_pwrst, next_pwrst;
+	int pwrst = pwrdm_func_to_pwrst(pwrdm, func_pwrst);
+	int sleep_switch = -1, ret = 0, hwsup = 0;
+
+	if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0)) {
+		pr_debug("%s: invalid params: pwrdm=%p, func_pwrst=%0x\n",
+			 __func__, pwrdm, func_pwrst);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: set func_pwrst %0x to pwrdm %s\n",
+		 __func__, func_pwrst, pwrdm->name);
+
+	mutex_lock(&pwrdm->lock);
+
+	while (!(pwrdm->pwrsts & (1 << pwrst))) {
+		if (pwrst == PWRDM_POWER_OFF)
+			goto out;
+		pwrst--;
+	}
+
+	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	if (next_pwrst == pwrst)
+		goto out;
+
+	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	if (curr_pwrst < PWRDM_POWER_ON) {
+		if ((curr_pwrst > pwrst) &&
+			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
+			sleep_switch = LOWPOWERSTATE_SWITCH;
+		} else {
+			hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
+			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			sleep_switch = FORCEWAKEUP_SWITCH;
+		}
+	}
+
+	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+	if (ret)
+		pr_err("%s: unable to set power state of powerdomain: %s\n",
+		       __func__, pwrdm->name);
+
+	switch (sleep_switch) {
+	case FORCEWAKEUP_SWITCH:
+		if (hwsup)
+			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		else
+			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
+		break;
+	case LOWPOWERSTATE_SWITCH:
+		pwrdm_set_lowpwrstchange(pwrdm);
+		pwrdm_wait_transition(pwrdm);
+		pwrdm_state_switch(pwrdm);
+		break;
+	}
+
+out:
+	mutex_unlock(&pwrdm->lock);
+	return ret;
+}
+
+/**
  * pwrdm_set_next_pwrst - set next powerdomain power state
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
@@ -522,6 +652,21 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_next_func_pwrst - get next powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain @pwrdm's next functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns
+ * the next power state upon success.
+ */
+int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
+{
+	int ret = pwrdm_read_next_pwrst(pwrdm);
+
+	return pwrdm_pwrst_to_func(pwrdm, ret);
+}
+
+/**
  * pwrdm_read_pwrst - get current powerdomain power state
  * @pwrdm: struct powerdomain * to get power state
  *
@@ -543,6 +688,21 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_func_pwrst - get current powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain @pwrdm's current functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns
+ * the current power state upon success.
+ */
+int pwrdm_read_func_pwrst(struct powerdomain *pwrdm)
+{
+	int ret = pwrdm_read_pwrst(pwrdm);
+
+	return pwrdm_pwrst_to_func(pwrdm, ret);
+}
+
+/**
  * pwrdm_read_prev_pwrst - get previous powerdomain power state
  * @pwrdm: struct powerdomain * to get previous power state
  *
@@ -564,6 +724,21 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_prev_func_pwrst - get previous powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get previous power state
+ *
+ * Return the powerdomain @pwrdm's previous functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns the
+ * previous power state upon success.
+ */
+int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm)
+{
+	int ret = pwrdm_read_prev_pwrst(pwrdm);
+
+	return pwrdm_pwrst_to_func(pwrdm, ret);
+}
+
+/**
  * pwrdm_set_logic_retst - set powerdomain logic power state upon retention
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 6c6567d..460af0e 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -45,6 +45,14 @@
 #define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
 
+/* Powerdomain functional power states, used by the external API functions */
+#define PWRDM_FUNC_PWRST_OFF		0x0
+#define PWRDM_FUNC_PWRST_OSWR		0x1
+#define PWRDM_FUNC_PWRST_CSWR		0x2
+#define PWRDM_FUNC_PWRST_INACTIVE	0x3
+#define PWRDM_FUNC_PWRST_ON		0x4
+
+#define PWRDM_MAX_FUNC_PWRSTS	5
 
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
@@ -130,6 +138,10 @@ struct powerdomain {
 
 /**
  * struct pwrdm_ops - Arch specific function implementations
+ * @pwrdm_func_to_pwrst: Convert the pd functional power state to
+ *  the internal state
+ * @pwrdm_pwrst_to_func: Convert the pd internal power state to
+ *  the functional state
  * @pwrdm_set_next_pwrst: Set the target power state for a pd
  * @pwrdm_read_next_pwrst: Read the target power state set for a pd
  * @pwrdm_read_pwrst: Read the current power state of a pd
@@ -150,6 +162,8 @@ struct powerdomain {
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
  */
 struct pwrdm_ops {
+	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
+	int	(*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 func_pwrst);
 	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
 	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
 	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
@@ -190,6 +204,13 @@ struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
 
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
+int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
+
+int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
+int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst);
+
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_pwrst(struct powerdomain *pwrdm);
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index 0f0a9f1..79c1293 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -26,6 +26,7 @@
 
 
 /* Common functions across OMAP2 and OMAP3 */
+
 static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
@@ -210,6 +211,8 @@ static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 }
 
 struct pwrdm_ops omap2_pwrdm_operations = {
+	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
@@ -222,6 +225,8 @@ struct pwrdm_ops omap2_pwrdm_operations = {
 };
 
 struct pwrdm_ops omap3_pwrdm_operations = {
+	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 601325b..538b528 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -209,6 +209,8 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 }
 
 struct pwrdm_ops omap4_pwrdm_operations = {
+	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
-- 
1.7.7.6

