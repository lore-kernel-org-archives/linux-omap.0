From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional
 states
Date: Thu, 12 Jul 2012 23:39:17 -0500
Message-ID: <20120713043916.GA13513@horus>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
 <1339685591-11177-3-git-send-email-j-pihet@ti.com>
 <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37176 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680Ab2GMEjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 00:39:22 -0400
Received: by obbup19 with SMTP id up19so4470800obb.12
        for <linux-omap@vger.kernel.org>; Thu, 12 Jul 2012 21:39:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On 22:01-20120712, Menon, Nishanth wrote:
> On Thu, Jun 14, 2012 at 9:53 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> [..]
> > +int pwrdm_read_func_pwrst(struct powerdomain *pwrdm)
> should return enum pwrdm_func_state
> > +{
> > +       int ret = pwrdm_read_pwrst(pwrdm);
> > +
> > +       return pwrdm_pwrst_to_func(pwrdm, ret);
> > +}
> 
> my Crib about the above apis are lack of logic power state handling :(
> which forces code like cpuidle to use different apis for logic
> power state and force them to use these apis just for pwrst.
> 
[..]
> > +extern void omap242x_powerdomains_init(void);
> > +extern void omap243x_powerdomains_init(void);
> > +extern void omap3xxx_powerdomains_init(void);
> > +extern void omap44xx_powerdomains_init(void);
> > +
> > +
> 
> We should split the following out to a separate header which is not to
> be used by anyone else other than powerdomain*.[ch]
without doing this..
[..]
> >   */
> >  struct pwrdm_ops {
> > +       int     (*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
> should take in enum pwrdm_func_state
> > +       int     (*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 func_pwrst);
> should return enum pwrdm_func_state
> 
[...]
> otherwise, this is a nice concept

Here is how it might look like: (baseline internal tree)


diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index c426dc4..30a4bb1 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -129,10 +129,6 @@ static void __init omap2_init_processor_devices(void)
 	}
 }
 
-/* Types of sleep_switch used in omap_set_pwrdm_state */
-#define FORCEWAKEUP_SWITCH	0
-#define LOWPOWERSTATE_SWITCH	1
-
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
@@ -144,68 +140,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
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
-	spin_lock(&pwrdm->lock);
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
-	spin_unlock(&pwrdm->lock);
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
index 2741a9b..5f255c5 100644
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
index c0aeabf..57c135e 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -108,3 +108,93 @@ u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank)
 	return 0;
 }
 
+/**
+ * omap2_pwrdm_func_to_pwrst - Convert functional (i.e. logical) to
+ * internal (i.e. registers) values for the power domains states.
+ * @pwrdm: struct powerdomain * to convert values for
+ * @func_pwrst: functional power state
+ * @pwrst:	returned with power state
+ * @logic_pwrst: returned with logic power state
+ *
+ * Returns the internal power state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
+ */
+int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm,
+			      enum pwrdm_func_state func_pwrst,
+			      u8 *pwrst, u8 *logic_pwrst)
+{
+	int ret = 0;
+
+	if (!pwrst || !logic_pwrst) {
+		WARN(1, "bad pointer passage\n");
+		return -EINVAL;
+	}
+
+	switch (func_pwrst) {
+	case PWRDM_FUNC_PWRST_ON:
+		*pwrst = PWRDM_POWER_ON;
+		/* Does not matter which - RET is max which is configurable */
+		*logic_pwrst = PWRDM_POWER_RET;
+		break;
+	case PWRDM_FUNC_PWRST_INACTIVE:
+		*pwrst = PWRDM_POWER_INACTIVE;
+		/* Does not matter which - RET is max which is configurable */
+		*logic_pwrst = PWRDM_POWER_RET;
+		break;
+	case PWRDM_FUNC_PWRST_CSWR:
+		*pwrst = PWRDM_POWER_RET;
+		*logic_pwrst = PWRDM_POWER_RET;
+		break;
+	case PWRDM_FUNC_PWRST_OSWR:
+		*pwrst = PWRDM_POWER_RET;
+		*logic_pwrst = PWRDM_POWER_OFF;
+		break;
+	case PWRDM_FUNC_PWRST_OFF:
+		*pwrst = PWRDM_POWER_OFF;
+		/* Does not matter which here.. */
+		*logic_pwrst = PWRDM_POWER_OFF;
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
+ * @pwrdm: struct powerdomain * to convert values for
+ * @pwrst: internal power state
+ * @logic_pwrst: internal logic power state
+ *
+ * Returns the functional power state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
+ */
+enum pwrdm_func_state omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm,
+						u8 pwrst, u8 logic_pwrst)
+{
+	enum pwrdm_func_state ret;
+
+	switch (pwrst) {
+	case PWRDM_POWER_ON:
+		ret = PWRDM_FUNC_PWRST_ON;
+		break;
+	case PWRDM_POWER_INACTIVE:
+		ret = PWRDM_FUNC_PWRST_INACTIVE;
+		break;
+	case PWRDM_POWER_RET:
+		if (logic_pwrst == PWRDM_POWER_OFF)
+			ret = PWRDM_FUNC_PWRST_OSWR;
+		else
+			ret = PWRDM_FUNC_PWRST_CSWR;
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
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 624db97..319a863 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -468,6 +468,156 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_func_to_pwrst - get the internal (i.e. registers) value mapped
+ * to the functional state
+ * @pwrdm:	struct powerdomain * to query
+ * @func_pwrst:	functional power state
+ * @pwrst:	returned with power state
+ * @logic_pwrst: returned with logic power state
+ *
+ * Convert the functional power state to the platform specific power
+ * domain state value.
+ * Returns the internal power domain state value or -EINVAL in case
+ * of invalid parameters passed in.
+ */
+int pwrdm_func_to_pwrst(struct powerdomain *pwrdm,
+			enum pwrdm_func_state func_pwrst,
+			u8 *pwrst, u8 *logic_pwrst)
+{
+	int ret = -EEXIST;
+
+	if ((!pwrdm) || (func_pwrst >= PWRDM_MAX_FUNC_PWRSTS))
+		return -EINVAL;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_pwrst)
+		ret = arch_pwrdm->pwrdm_func_to_pwrst(pwrdm, func_pwrst,
+						      pwrst, logic_pwrst);
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
+ * @pwrdm:	struct powerdomain * to query
+ * @pwrst:	internal power state
+ * @pwrst:	power state
+ * @logic_pwrst: logic power state
+ *
+ * Convert the internal power state to the power domain functional value.
+ * Returns the functional power domain state value or -EINVAL in case
+ * of invalid parameters passed in.
+ */
+enum pwrdm_func_state pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst,
+					  u8 logic_pwrst)
+{
+	int ret = -EEXIST;
+
+	if ((!pwrdm) || (pwrst >= PWRDM_MAX_PWRSTS))
+		return -EINVAL;
+
+	pr_debug("powerdomain: convert %0x pwrst to func for %s\n",
+		 pwrst, pwrdm->name);
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func)
+		ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst,
+						      logic_pwrst);
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
+	u8 pwrst, logic_pwrst;
+	int sleep_switch = -1, ret = 0, hwsup = 0;
+
+	if (!pwrdm || IS_ERR(pwrdm)) {
+		pr_debug("%s: invalid params: pwrdm=%p, func_pwrst=%0x\n",
+			 __func__, pwrdm, func_pwrst);
+		return -EINVAL;
+	}
+
+	ret = pwrdm_func_to_pwrst(pwrdm, func_pwrst, &pwrst, &logic_pwrst);
+	if (ret < 0) {
+		pr_debug("%s: invalid params: pwrdm=%s, func_pwrst=%0x\n",
+			 __func__, pwrdm->name, func_pwrst);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: set func_pwrst %0x to pwrdm %s\n",
+		 __func__, func_pwrst, pwrdm->name);
+
+	spin_lock(&pwrdm->lock);
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
+		    (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
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
+		pr_err("%s: unable to set power state of powerdomain: %s (%d)\n",
+		       __func__, pwrdm->name, ret);
+	ret = pwrdm_set_logic_retst(pwrdm, logic_pwrst);
+	if (ret)
+		pr_err("%s: unable to set logic power state of powerdomain: %s (%d)\n",
+		       __func__, pwrdm->name, ret);
+
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
+	spin_unlock(&pwrdm->lock);
+	return ret;
+}
+
+/**
  * pwrdm_set_next_pwrst - set next powerdomain power state
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
@@ -524,6 +674,22 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_next_func_pwrst - get next powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain @pwrdm's next functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns
+ * the next power state upon success.
+ */
+enum pwrdm_func_state pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
+{
+	int pwrst = pwrdm_read_next_pwrst(pwrdm);
+	int logic_st = pwrdm_read_logic_retst(pwrdm);
+
+	return pwrdm_pwrst_to_func(pwrdm, pwrst, logic_st);
+}
+
+/**
  * pwrdm_read_pwrst - get current powerdomain power state
  * @pwrdm: struct powerdomain * to get power state
  *
@@ -549,6 +715,22 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_func_pwrst - get current powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain @pwrdm's current functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns
+ * the current power state upon success.
+ */
+enum pwrdm_func_state pwrdm_read_func_pwrst(struct powerdomain *pwrdm)
+{
+	int pwrst = pwrdm_read_pwrst(pwrdm);
+	int logic_pwrst = pwrdm_read_logic_pwrst(pwrdm);
+
+	return pwrdm_pwrst_to_func(pwrdm, pwrst, logic_pwrst);
+}
+
+/**
  * pwrdm_read_prev_pwrst - get previous powerdomain power state
  * @pwrdm: struct powerdomain * to get previous power state
  *
@@ -570,6 +752,31 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_prev_func_pwrst - get previous powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get previous power state
+ *
+ * Return the powerdomain @pwrdm's previous functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns the
+ * previous power state upon success.
+ */
+enum pwrdm_func_state pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm)
+{
+	int pwrst = pwrdm_read_prev_pwrst(pwrdm);
+	int logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
+
+	/* Fake Logic off if SoC has no such state register */
+	if (logic_pwrst < 0 && pwrdm) {
+		if (pwrdm->pwrsts_logic_ret & PWRDM_POWER_OFF &&
+		    pwrdm_read_logic_retst(pwrdm) == PWRDM_POWER_OFF)
+			logic_pwrst = PWRDM_POWER_OFF;
+		else
+			logic_pwrst = PWRDM_POWER_RET;
+	}
+
+	return pwrdm_pwrst_to_func(pwrdm, pwrst, logic_pwrst);
+}
+
+/**
  * pwrdm_set_logic_retst - set powerdomain logic power state upon retention
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 20fcb06..bdb6c0f 100644
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
+enum pwrdm_func_state pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
+enum pwrdm_func_state pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
+enum pwrdm_func_state pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
+extern int omap_set_pwrdm_state(struct powerdomain *pwrdm,
+				enum pwrdm_func_state func_pwrst);
+
+extern void omap242x_powerdomains_init(void);
+extern void omap243x_powerdomains_init(void);
+extern void omap3xxx_powerdomains_init(void);
+extern void omap44xx_powerdomains_init(void);
+extern void omap54xx_powerdomains_init(void);
+
+/***************************************************************
+ * Internal code, only used in powerdomain*.[ch]
+ ***************************************************************/
+
+/* Powerdomain internal power states, internal use only */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
 #define PWRDM_POWER_INACTIVE	0x2
@@ -85,9 +126,6 @@
 #define PWRDM_TRANSITION_BAILOUT 100000
 #endif
 
-struct clockdomain;
-struct powerdomain;
-
 /**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
@@ -143,6 +181,10 @@ struct powerdomain {
 
 /**
  * struct pwrdm_ops - Arch specific function implementations
+ * @pwrdm_func_to_pwrst: Convert the pd functional power state to
+ *  the internal state
+ * @pwrdm_pwrst_to_func: Convert the pd internal power state to
+ *  the functional state
  * @pwrdm_set_next_pwrst: Set the target power state for a pd
  * @pwrdm_read_next_pwrst: Read the target power state set for a pd
  * @pwrdm_read_pwrst: Read the current power state of a pd
@@ -165,6 +207,8 @@ struct powerdomain {
  * @pwrdm_disable_force_off: Disable force off transition feature for the pd
  */
 struct pwrdm_ops {
+	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, enum pwrdm_func_state  func_pwrst, u8 *pwrst, u8 *logic_pwrst);
+	enum pwrdm_func_state (*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 pwrst, u8 logic_pwrst);
 	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
 	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
 	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
@@ -191,21 +235,11 @@ int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
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
@@ -213,6 +247,12 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
+int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm,
+			      enum pwrdm_func_state func_pwrst, u8 *pwrst,
+			      u8 *logic_pwrst);
+enum pwrdm_func_state omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm,
+						u8 pwrst, u8 logic_pwrst);
+
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
 int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
@@ -240,11 +280,11 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 int pwrdm_enable_force_off(struct powerdomain *pwrdm);
 int pwrdm_disable_force_off(struct powerdomain *pwrdm);
 
-extern void omap242x_powerdomains_init(void);
-extern void omap243x_powerdomains_init(void);
-extern void omap3xxx_powerdomains_init(void);
-extern void omap44xx_powerdomains_init(void);
-extern void omap54xx_powerdomains_init(void);
+enum pwrdm_func_state pwrdm_pwrst_to_func(struct powerdomain *pwrdm,
+					  u8 pwrst, u8 logic_pwrst);
+int pwrdm_func_to_pwrst(struct powerdomain *pwrdm,
+			enum pwrdm_func_state func_pwrst,
+			u8 *pwrst, u8 *logic_pwrst);
 
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
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
diff --git a/arch/arm/mach-omap2/powerdomain4xxx_5xxx.c b/arch/arm/mach-omap2/powerdomain4xxx_5xxx.c
index e1e7d44..ad32f70 100644
--- a/arch/arm/mach-omap2/powerdomain4xxx_5xxx.c
+++ b/arch/arm/mach-omap2/powerdomain4xxx_5xxx.c
@@ -229,6 +229,8 @@ static int omap5_pwrdm_disable_force_off(struct powerdomain *pwrdm)
 
 
 struct pwrdm_ops omap4_pwrdm_operations = {
+	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
@@ -246,6 +248,8 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 };
 
 struct pwrdm_ops omap5_pwrdm_operations = {
+	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
-- 
1.7.9.5

-- 
Regards,
Nishanth Menon
