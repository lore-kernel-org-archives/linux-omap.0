From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional states
Date: Thu, 14 Jun 2012 16:53:05 +0200
Message-ID: <1339685591-11177-3-git-send-email-j-pihet@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52899 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab2FNOxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 10:53:36 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1317216wey.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 07:53:35 -0700 (PDT)
In-Reply-To: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Introduce functional (or logical) states for power domains and the
API functions to read the power domains settings and to convert
between the functional (i.e. logical) and the internal (or registers)
values.

OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine.

In the new API only the function omap_set_pwrdm_state shall be used
to change a power domain target state, along with the associated
PWRDM_FUNC_* macros as the state parameters.
While at it the function is moved to the power domains code.

The power domain API in powerdomain.h is split in the external and the
internal parts; only the external API functions and defines shall be used
by external code, the internal API is only to be used in powerdomain*.[ch]
files.

The memory and logic states are not using the functional states, this
comes as a subsequent patch.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.c                   |   66 -----------
 arch/arm/mach-omap2/pm.h                   |    1 -
 arch/arm/mach-omap2/powerdomain-common.c   |   71 +++++++++++
 arch/arm/mach-omap2/powerdomain.c          |  174 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h          |   77 +++++++++----
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    5 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    2 +
 7 files changed, 306 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index a05f00c..dfe702b 100644
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
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7856489..5bc0848 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -18,7 +18,6 @@
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
-extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 extern int omap4_idle_init(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index c0aeabf..2973be7 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -108,3 +108,74 @@ u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank)
 	return 0;
 }
 
+/**
+ * omap2_pwrdm_func_to_pwrst - Convert functional (i.e. logical) to
+ * internal (i.e. registers) values for the power domains states.
+ * @struct powerdomain * to convert the values for
+ * @func_pwrst: functional power state
+ *
+ * Returns the internal power state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
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
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * omap2_pwrdm_pwrst_to_func - Convert internal (i.e. registers) to
+ * functional (i.e. logical) values for the power domains states.
+ * @struct powerdomain * to convert the values for
+ * @pwrst: internal power state
+ *
+ * Returns the functional power state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
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
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1641e72..e79b5ae 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -466,6 +466,135 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
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
+	if ((!pwrdm) || (func_pwrst >= PWRDM_MAX_FUNC_PWRSTS))
+		return -EINVAL;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_pwrst)
+		ret = arch_pwrdm->pwrdm_func_to_pwrst(pwrdm, func_pwrst);
+
+	pr_debug("powerdomain: convert func %0x to pwrst %0x for %s\n",
+		 func_pwrst, ret, pwrdm->name);
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
+	if ((!pwrdm) || (pwrst >= PWRDM_MAX_PWRSTS))
+		return -EINVAL;
+
+	pr_debug("powerdomain: convert %0x pwrst to func for %s\n",
+		 pwrst, pwrdm->name);
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func)
+		ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst);
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
+int omap_set_pwrdm_state(struct powerdomain *pwrdm,
+			 enum pwrdm_func_state func_pwrst)
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
@@ -522,6 +651,21 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
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
@@ -543,6 +687,21 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
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
@@ -564,6 +723,21 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
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
index bab84fc..0404f9f 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -9,9 +9,6 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * XXX This should be moved to the mach-omap2/ directory at the earliest
- * opportunity.
  */
 
 #ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_H
@@ -26,7 +23,51 @@
 
 #include "voltage.h"
 
-/* Powerdomain basic power states */
+/***************************************************************
+ * External API
+ ***************************************************************/
+
+/* Powerdomain functional power states, used by the external API functions */
+enum pwrdm_func_state {
+	PWRDM_FUNC_PWRST_OFF		= 0x0,
+	PWRDM_FUNC_PWRST_OSWR,
+	PWRDM_FUNC_PWRST_CSWR,
+	PWRDM_FUNC_PWRST_INACTIVE,
+	PWRDM_FUNC_PWRST_ON,
+	PWRDM_MAX_FUNC_PWRSTS		/* Last value, used as the max value */
+};
+
+struct clockdomain;
+struct powerdomain;
+
+struct powerdomain *pwrdm_lookup(const char *name);
+
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
+int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
+
+struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
+
+int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
+
+int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
+extern int omap_set_pwrdm_state(struct powerdomain *pwrdm,
+				enum pwrdm_func_state func_pwrst);
+
+extern void omap242x_powerdomains_init(void);
+extern void omap243x_powerdomains_init(void);
+extern void omap3xxx_powerdomains_init(void);
+extern void omap44xx_powerdomains_init(void);
+
+
+/***************************************************************
+ * Internal code, only used in powerdomain*.[ch]
+ ***************************************************************/
+
+/* Powerdomain internal power states, internal use only */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
 #define PWRDM_POWER_INACTIVE	0x2
@@ -45,7 +86,6 @@
 #define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
 
-
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
 #define PWRDM_HAS_MPU_QUIRK	(1 << 1) /* MPU pwr domain has MEM bank 0 bits
@@ -74,9 +114,6 @@
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
 
-struct clockdomain;
-struct powerdomain;
-
 /**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
@@ -130,6 +167,10 @@ struct powerdomain {
 
 /**
  * struct pwrdm_ops - Arch specific function implementations
+ * @pwrdm_func_to_pwrst: Convert the pd functional power state to
+ *  the internal state
+ * @pwrdm_pwrst_to_func: Convert the pd internal power state to
+ *  the functional state
  * @pwrdm_set_next_pwrst: Set the target power state for a pd
  * @pwrdm_read_next_pwrst: Read the target power state set for a pd
  * @pwrdm_read_pwrst: Read the current power state of a pd
@@ -150,6 +191,8 @@ struct powerdomain {
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
  */
 struct pwrdm_ops {
+	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
+	int	(*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 func_pwrst);
 	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
 	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
 	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
@@ -174,21 +217,11 @@ int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
 int pwrdm_register_pwrdms(struct powerdomain **pwrdm_list);
 int pwrdm_complete_init(void);
 
-struct powerdomain *pwrdm_lookup(const char *name);
-
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user);
-int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user);
-
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 			 int (*fn)(struct powerdomain *pwrdm,
 				   struct clockdomain *clkdm));
-struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
-
-int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
@@ -196,6 +229,9 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
+int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
+int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst);
+
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
 int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
@@ -220,11 +256,6 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
-extern void omap242x_powerdomains_init(void);
-extern void omap243x_powerdomains_init(void);
-extern void omap3xxx_powerdomains_init(void);
-extern void omap44xx_powerdomains_init(void);
-
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
 extern struct pwrdm_ops omap4_pwrdm_operations;
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

