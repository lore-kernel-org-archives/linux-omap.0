From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/8] ARM: OMAP2+: PM: introduce power domains functional states
Date: Wed, 15 Aug 2012 12:02:41 +0200
Message-ID: <1345024968-28951-2-git-send-email-j-pihet@ti.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49208 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2HOKDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 06:03:12 -0400
Received: by wgbdr13 with SMTP id dr13so1239141wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 03:03:10 -0700 (PDT)
In-Reply-To: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

Introduce the functional states for power domains, which include
the power states and the logic states.
This patch provides the API functions to set and read the power
domains settings and to convert between the functional (i.e. logical)
and the internal (or registers) values.
OMAP2, OMAP3 and OMAP4 platforms are using common conversion routines.

In the new API only the function pwrdm_set_next_fpwrst shall be used
to change a power domain target state, along with the associated
PWRDM_FUNC_* and PWRDM_LOGIC_* macros as the state parameters.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain-common.c   |   99 ++++++++++++
 arch/arm/mach-omap2/powerdomain.c          |  225 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/powerdomain.h          |   45 +++++-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    6 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    3 +
 5 files changed, 368 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index c0aeabf..a0fcee3 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -108,3 +108,102 @@ u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank)
 	return 0;
 }
 
+/**
+ * omap2_pwrdm_fpwrst_to_pwrst - Convert functional (i.e. logical) to
+ * internal (i.e. registers) values for the power domains states.
+ * @struct powerdomain * to convert the values for
+ * @fpwrst: functional power state
+ *
+ * Returns the internal power state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
+ */
+int omap2_pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst)
+{
+	int ret;
+
+	switch (fpwrst) {
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
+ * omap2_pwrdm_fpwrst_to_logic_pwrst - Convert functional (i.e. logical) to
+ * internal (i.e. registers) values for the power domains logic states.
+ * @struct powerdomain * to convert the values for
+ * @pwrst: functional power state
+ *
+ * Returns the internal logic state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
+ */
+int omap2_pwrdm_fpwrst_to_logic_pwrst(struct powerdomain *pwrdm, u8 fpwrst)
+{
+	int ret;
+
+	switch (fpwrst) {
+	case PWRDM_FUNC_PWRST_ON:
+	case PWRDM_FUNC_PWRST_INACTIVE:
+	case PWRDM_FUNC_PWRST_CSWR:
+		ret = PWRDM_LOGIC_MEM_PWRST_RET;
+		break;
+	case PWRDM_FUNC_PWRST_OSWR:
+	case PWRDM_FUNC_PWRST_OFF:
+		ret = PWRDM_LOGIC_MEM_PWRST_OFF;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * omap2_pwrdm_pwrst_to_fpwrst - Convert internal (i.e. registers) to
+ * functional (i.e. logical) values for the power domains states.
+ * @struct powerdomain * to convert the values for
+ * @pwrst: internal power state
+ *
+ * Returns the functional power state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
+ */
+int omap2_pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
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
+		if (logic == PWRDM_LOGIC_MEM_PWRST_RET)
+			ret = PWRDM_FUNC_PWRST_CSWR;
+		else
+			ret = PWRDM_FUNC_PWRST_OSWR;
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
index 69b36e1..6fc3c84 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1,7 +1,7 @@
 /*
  * OMAP powerdomain control
  *
- * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011-2012 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Written by Paul Walmsley
@@ -128,14 +128,14 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
 
 	prev_logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
 	if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
-	    (prev_logic_pwrst == PWRDM_POWER_OFF))
+	    (prev_logic_pwrst == PWRDM_LOGIC_MEM_PWRST_OFF))
 		pwrdm->ret_logic_off_counter++;
 
 	for (i = 0; i < pwrdm->banks; i++) {
 		prev_mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
 
 		if ((pwrdm->pwrsts_mem_ret[i] == PWRSTS_OFF_RET) &&
-		    (prev_mem_pwrst == PWRDM_POWER_OFF))
+		    (prev_mem_pwrst == PWRDM_LOGIC_MEM_PWRST_OFF))
 			pwrdm->ret_mem_off_counter[i]++;
 	}
 }
@@ -465,6 +465,171 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_fpwrst_to_pwrst - get the internal (i.e. registers) value mapped
+ * to the functional state
+ * @pwrdm: struct powerdomain * to query
+ * @fpwrst: functional power state
+ *
+ * Convert the functional power state to the platform specific power
+ * domain state value.
+ * Returns the internal power domain state value or -EINVAL in case
+ * of invalid parameters passed in.
+ */
+int pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst)
+{
+	int ret = fpwrst;
+
+	if ((!pwrdm) || (fpwrst >= PWRDM_MAX_FUNC_PWRSTS))
+		return -EINVAL;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_fpwrst_to_pwrst)
+		ret = arch_pwrdm->pwrdm_fpwrst_to_pwrst(pwrdm, fpwrst);
+
+	pr_debug("powerdomain: convert fwrst %0x to pwrst %0x for %s\n",
+		 fpwrst, ret, pwrdm->name);
+
+	return ret;
+}
+
+/**
+ * pwrdm_fpwrst_to_logic_pwrst - get the internal (i.e. registers) value
+ * of the logic state mapped to the functional state
+ * @pwrdm: struct powerdomain * to query
+ * @pwrst: functional power state
+ *
+ * Convert the functional power state to the platform specific power
+ * domain logic state value.
+ * Returns the internal power domain logic state value or -EINVAL in
+ * case of invalid parameters passed in.
+ */
+int pwrdm_fpwrst_to_logic_pwrst(struct powerdomain *pwrdm, u8 fpwrst)
+{
+	int ret = fpwrst;
+
+	if ((!pwrdm) || (fpwrst >= PWRDM_MAX_FUNC_PWRSTS))
+		return -EINVAL;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_fpwrst_to_logic_pwrst)
+		ret = arch_pwrdm->pwrdm_fpwrst_to_logic_pwrst(pwrdm, fpwrst);
+
+	pr_debug("powerdomain: convert fpwrst %0x to logic %0x pwrst for %s\n",
+		 fpwrst, ret, pwrdm->name);
+
+	return ret;
+}
+
+/**
+ * pwrdm_pwrst_to_fpwrst - get the functional (i.e. logical) value mapped
+ * to the internal state
+ * @pwrdm: struct powerdomain * to query
+ * @pwrst: internal power state
+ * @logic: internal logic state
+ *
+ * Convert the internal power state and logic power state
+ * to the power domain functional value.
+ * Returns the functional power domain state value or -EINVAL in case
+ * of invalid parameters passed in.
+ */
+int pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
+{
+	int ret = pwrst;
+
+	if ((!pwrdm) || (pwrst >= PWRDM_MAX_PWRSTS) ||
+	    (logic >= PWRDM_MAX_LOGIC_MEM_PWRST))
+		return -EINVAL;
+
+	while (!(pwrdm->pwrsts_logic_ret & (1 << logic))) {
+		if (logic == PWRDM_LOGIC_MEM_PWRST_RET)
+			break;
+		logic++;
+	}
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_fpwrst)
+		ret = arch_pwrdm->pwrdm_pwrst_to_fpwrst(pwrdm, pwrst, logic);
+
+	pr_debug("powerdomain: convert pwrst (%0x,%0x) to fpwrst %0x for %s\n",
+		 pwrst, logic, ret, pwrdm->name);
+
+	return ret;
+}
+
+/* Types of sleep_switch used in pwrdm_set_next_fpwrst */
+#define FORCEWAKEUP_SWITCH	0
+#define LOWPOWERSTATE_SWITCH	1
+
+/**
+ * pwrdm_set_next_fpwrst - program next powerdomain functional power state
+ * @pwrdm: struct powerdomain * to set
+ * @fpwrst: power domain functional state, one of the PWRDM_FUNC_* macros
+ *
+ * This programs the pwrdm next functional state, sets the dependencies
+ * and waits for the state to be applied.
+ */
+int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
+			  enum pwrdm_func_state fpwrst)
+{
+	u8 curr_pwrst, next_pwrst;
+	int pwrst = pwrdm_fpwrst_to_pwrst(pwrdm, fpwrst);
+	int logic = pwrdm_fpwrst_to_logic_pwrst(pwrdm, fpwrst);
+	int sleep_switch = -1, ret = 0, hwsup = 0;
+
+	if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0) || (logic < 0)) {
+		pr_debug("%s: invalid params: pwrdm=%p, fpwrst=%0x\n",
+			 __func__, pwrdm, fpwrst);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: set fpwrst %0x to pwrdm %s\n",
+		 __func__, fpwrst, pwrdm->name);
+
+	while (!(pwrdm->pwrsts & (1 << pwrst))) {
+		if (pwrst == PWRDM_POWER_OFF)
+			return ret;
+		pwrst--;
+	}
+
+	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	if (next_pwrst == pwrst)
+		return ret;
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
+	if (logic != pwrdm_read_logic_retst(pwrdm))
+		pwrdm_set_logic_retst(pwrdm, logic);
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
+	return ret;
+}
+
+/**
  * pwrdm_set_next_pwrst - set next powerdomain power state
  * @pwrdm: struct powerdomain * to set
  * @pwrst: one of the PWRDM_POWER_* macros
@@ -521,6 +686,22 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_next_fpwrst - get next powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain @pwrdm's next functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns
+ * the next power state upon success.
+ */
+int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm)
+{
+	int next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	int next_logic = pwrdm_read_logic_retst(pwrdm);
+
+	return pwrdm_pwrst_to_fpwrst(pwrdm, next_pwrst, next_logic);
+}
+
+/**
  * pwrdm_read_pwrst - get current powerdomain power state
  * @pwrdm: struct powerdomain * to get power state
  *
@@ -546,6 +727,22 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_fpwrst - get current powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get power state
+ *
+ * Return the powerdomain @pwrdm's current functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns
+ * the current power state upon success.
+ */
+int pwrdm_read_fpwrst(struct powerdomain *pwrdm)
+{
+	int pwrst = pwrdm_read_pwrst(pwrdm);
+	int logic = pwrdm_read_logic_pwrst(pwrdm);
+
+	return pwrdm_pwrst_to_fpwrst(pwrdm, pwrst, logic);
+}
+
+/**
  * pwrdm_read_prev_pwrst - get previous powerdomain power state
  * @pwrdm: struct powerdomain * to get previous power state
  *
@@ -567,9 +764,25 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 }
 
 /**
+ * pwrdm_read_prev_fpwrst - get previous powerdomain functional power state
+ * @pwrdm: struct powerdomain * to get previous power state
+ *
+ * Return the powerdomain @pwrdm's previous functional power state.
+ * Returns -EINVAL if the powerdomain pointer is null or returns the
+ * previous power state upon success.
+ */
+int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm)
+{
+	int prev_pwrst = pwrdm_read_prev_pwrst(pwrdm);
+	int prev_logic = pwrdm_read_prev_logic_pwrst(pwrdm);
+
+	return pwrdm_pwrst_to_fpwrst(pwrdm, prev_pwrst, prev_logic);
+}
+
+/**
  * pwrdm_set_logic_retst - set powerdomain logic power state upon retention
  * @pwrdm: struct powerdomain * to set
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that the logic portion of the
  * powerdomain @pwrdm will enter when the powerdomain enters retention.
@@ -600,7 +813,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
  * pwrdm_set_mem_onst - set memory power state while powerdomain ON
  * @pwrdm: struct powerdomain * to set
  * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the ON
@@ -637,7 +850,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  * pwrdm_set_mem_retst - set memory power state while powerdomain in RET
  * @pwrdm: struct powerdomain * to set
  * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index baee906..aa9f9b9 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -1,7 +1,7 @@
 /*
  * OMAP2/3/4 powerdomain control
  *
- * Copyright (C) 2007-2008, 2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2010, 2012 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley
@@ -9,9 +9,6 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * XXX This should be moved to the mach-omap2/ directory at the earliest
- * opportunity.
  */
 
 #ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_H
@@ -26,6 +23,26 @@
 
 #include "voltage.h"
 
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
+/*
+ * Powerdomains logic and memory functional power states,
+ * used by the external API functions
+ */
+enum pwrdm_logic_mem_state {
+	PWRDM_LOGIC_MEM_PWRST_OFF	= 0x0,
+	PWRDM_LOGIC_MEM_PWRST_RET,
+	PWRDM_MAX_LOGIC_MEM_PWRST	/* Last value, used as the max value */
+};
+
 /* Powerdomain basic power states */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
@@ -146,6 +163,12 @@ struct powerdomain {
 
 /**
  * struct pwrdm_ops - Arch specific function implementations
+ * @pwrdm_fpwrst_to_pwrst: Convert the pd functional power state to
+ *  the internal state
+ * @pwrdm_fpwrst_to_logic_pwrst: Convert the pd functional power state
+ *  to the internal logic state
+ * @pwrdm_pwrst_to_fpwrst: Convert the pd internal and logic power state to
+ *  the functional state
  * @pwrdm_set_next_pwrst: Set the target power state for a pd
  * @pwrdm_read_next_pwrst: Read the target power state set for a pd
  * @pwrdm_read_pwrst: Read the current power state of a pd
@@ -166,6 +189,11 @@ struct powerdomain {
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
  */
 struct pwrdm_ops {
+	int	(*pwrdm_fpwrst_to_pwrst)(struct powerdomain *pwrdm, u8 fpwrst);
+	int	(*pwrdm_fpwrst_to_logic_pwrst)(struct powerdomain *pwrdm,
+					       u8 fpwrst);
+	int	(*pwrdm_pwrst_to_fpwrst)(struct powerdomain *pwrdm, u8 fpwrst,
+					 u8 logic);
 	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
 	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
 	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
@@ -206,6 +234,15 @@ struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
 
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
+int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
+			  enum pwrdm_func_state fpwrst);
+int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm);
+int pwrdm_read_fpwrst(struct powerdomain *pwrdm);
+int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm);
+int omap2_pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
+int omap2_pwrdm_fpwrst_to_logic_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
+int omap2_pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
+
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_pwrst(struct powerdomain *pwrdm);
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index 0f0a9f1..aa883aa 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -210,6 +210,9 @@ static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 }
 
 struct pwrdm_ops omap2_pwrdm_operations = {
+	.pwrdm_fpwrst_to_pwrst	= omap2_pwrdm_fpwrst_to_pwrst,
+	.pwrdm_fpwrst_to_logic_pwrst	= omap2_pwrdm_fpwrst_to_logic_pwrst,
+	.pwrdm_pwrst_to_fpwrst	= omap2_pwrdm_pwrst_to_fpwrst,
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
@@ -222,6 +225,9 @@ struct pwrdm_ops omap2_pwrdm_operations = {
 };
 
 struct pwrdm_ops omap3_pwrdm_operations = {
+	.pwrdm_fpwrst_to_pwrst	= omap2_pwrdm_fpwrst_to_pwrst,
+	.pwrdm_fpwrst_to_logic_pwrst	= omap2_pwrdm_fpwrst_to_logic_pwrst,
+	.pwrdm_pwrst_to_fpwrst	= omap2_pwrdm_pwrst_to_fpwrst,
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 601325b..8c37cc9 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -209,6 +209,9 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 }
 
 struct pwrdm_ops omap4_pwrdm_operations = {
+	.pwrdm_fpwrst_to_pwrst	= omap2_pwrdm_fpwrst_to_pwrst,
+	.pwrdm_fpwrst_to_logic_pwrst	= omap2_pwrdm_fpwrst_to_logic_pwrst,
+	.pwrdm_pwrst_to_fpwrst	= omap2_pwrdm_pwrst_to_fpwrst,
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
-- 
1.7.7.6

