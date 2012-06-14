From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 4/8] ARM: OMAP2+: PM: introduce power domains logic and memory functional states
Date: Thu, 14 Jun 2012 16:53:07 +0200
Message-ID: <1339685591-11177-5-git-send-email-j-pihet@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:54453 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab2FNOxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 10:53:38 -0400
Received: by wibhm6 with SMTP id hm6so6538983wib.1
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 07:53:37 -0700 (PDT)
In-Reply-To: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

In the new API the functions pwrdm_*_logic_* and pwrdm_*_mem_* take the
functional states as parameter.

OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine
between the functional state and the logic power state.

The power domains logic state is now derived from the functional
state and the logic state is programmed from omap_set_pwrdm_state.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain-common.c   |   41 ++++++++++++--
 arch/arm/mach-omap2/powerdomain.c          |   79 +++++++++++++++++++++------
 arch/arm/mach-omap2/powerdomain.h          |   22 +++++++-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    2 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    1 +
 5 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index 2973be7..1ae3659 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -143,6 +143,36 @@ int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
 }
 
 /**
+ * omap2_pwrdm_func_to_logic_pwrst - Convert functional (i.e. logical) to
+ * internal (i.e. registers) values for the power domains logic states.
+ * @struct powerdomain * to convert the values for
+ * @func_pwrst: functional power state
+ *
+ * Returns the internal logic state value for the power domain, or
+ * -EINVAL in case of invalid parameters passed in.
+ */
+int omap2_pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
+{
+	int ret;
+
+	switch (func_pwrst) {
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
  * omap2_pwrdm_pwrst_to_func - Convert internal (i.e. registers) to
  * functional (i.e. logical) values for the power domains states.
  * @struct powerdomain * to convert the values for
@@ -151,7 +181,7 @@ int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
  * Returns the functional power state value for the power domain, or
  * -EINVAL in case of invalid parameters passed in.
  */
-int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
+int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
 {
 	int ret;
 
@@ -163,11 +193,10 @@ int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
 		ret = PWRDM_FUNC_PWRST_INACTIVE;
 		break;
 	case PWRDM_POWER_RET:
-		/*
-		 * XXX warning: return OSWR in case of pd in RET and
-		 * logic in OFF
-		 */
-		ret = PWRDM_FUNC_PWRST_CSWR;
+		if (logic == PWRDM_LOGIC_MEM_PWRST_RET)
+			ret = PWRDM_FUNC_PWRST_CSWR;
+		else
+			ret = PWRDM_FUNC_PWRST_OSWR;
 		break;
 	case PWRDM_POWER_OFF:
 		ret = PWRDM_FUNC_PWRST_OFF;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index ec2b21c..ce2685a 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -129,14 +129,14 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
 
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
@@ -493,27 +493,63 @@ int pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
 }
 
 /**
+ * pwrdm_func_to_logic_pwrst - get the internal (i.e. registers) value
+ * of the logic state mapped to the functional state
+ * @pwrdm: struct powerdomain * to query
+ * @func_pwrst: functional power state
+ *
+ * Convert the functional power state to the platform specific power
+ * domain logic state value.
+ * Returns the internal power domain logic state value or -EINVAL in
+ * case of invalid parameters passed in.
+ */
+int pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
+{
+	int ret = func_pwrst;
+
+	if ((!pwrdm) || (func_pwrst >= PWRDM_MAX_FUNC_PWRSTS))
+		return -EINVAL;
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_logic_pwrst)
+		ret = arch_pwrdm->pwrdm_func_to_logic_pwrst(pwrdm, func_pwrst);
+
+	pr_debug("powerdomain: convert func %0x to logic %0x pwrst for %s\n",
+		 func_pwrst, ret, pwrdm->name);
+
+	return ret;
+}
+
+/**
  * pwrdm_pwrst_to_func - get the functional (i.e. logical) value mapped
  * to the internal state
  * @pwrdm: struct powerdomain * to query
  * @pwrst: internal power state
+ * @logic: internal logic state
  *
- * Convert the internal power state to the power domain functional value.
+ * Convert the internal power state and logic power state
+ * to the power domain functional value.
  * Returns the functional power domain state value or -EINVAL in case
  * of invalid parameters passed in.
  */
-int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
+int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
 {
 	int ret = pwrst;
 
-	if ((!pwrdm) || (pwrst >= PWRDM_MAX_PWRSTS))
+	if ((!pwrdm) || (pwrst >= PWRDM_MAX_PWRSTS) ||
+	    (logic >= PWRDM_MAX_LOGIC_MEM_PWRST))
 		return -EINVAL;
 
-	pr_debug("powerdomain: convert %0x pwrst to func for %s\n",
-		 pwrst, pwrdm->name);
+	while (!(pwrdm->pwrsts_logic_ret & (1 << logic))) {
+		if (logic == PWRDM_LOGIC_MEM_PWRST_RET)
+			break;
+		logic++;
+	}
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func)
-		ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst);
+		ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst, logic);
+
+	pr_debug("powerdomain: convert pwrst (%0x,%0x) to func %0x for %s\n",
+		 pwrst, logic, ret, pwrdm->name);
 
 	return ret;
 }
@@ -535,9 +571,10 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm,
 {
 	u8 curr_pwrst, next_pwrst;
 	int pwrst = pwrdm_func_to_pwrst(pwrdm, func_pwrst);
+	int logic = pwrdm_func_to_logic_pwrst(pwrdm, func_pwrst);
 	int sleep_switch = -1, ret = 0, hwsup = 0;
 
-	if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0)) {
+	if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0) || (logic < 0)) {
 		pr_debug("%s: invalid params: pwrdm=%p, func_pwrst=%0x\n",
 			 __func__, pwrdm, func_pwrst);
 		return -EINVAL;
@@ -570,6 +607,9 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm,
 		}
 	}
 
+	if (logic != pwrdm_read_logic_retst(pwrdm))
+		pwrdm_set_logic_retst(pwrdm, logic);
+
 	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
 	if (ret)
 		pr_err("%s: unable to set power state of powerdomain: %s\n",
@@ -660,9 +700,10 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = pwrdm_read_next_pwrst(pwrdm);
+	int next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	int next_logic = pwrdm_read_logic_retst(pwrdm);
 
-	return pwrdm_pwrst_to_func(pwrdm, ret);
+	return pwrdm_pwrst_to_func(pwrdm, next_pwrst, next_logic);
 }
 
 /**
@@ -696,9 +737,10 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_func_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = pwrdm_read_pwrst(pwrdm);
+	int pwrst = pwrdm_read_pwrst(pwrdm);
+	int logic = pwrdm_read_logic_pwrst(pwrdm);
 
-	return pwrdm_pwrst_to_func(pwrdm, ret);
+	return pwrdm_pwrst_to_func(pwrdm, pwrst, logic);
 }
 
 /**
@@ -732,15 +774,16 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
  */
 int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm)
 {
-	int ret = pwrdm_read_prev_pwrst(pwrdm);
+	int prev_pwrst = pwrdm_read_prev_pwrst(pwrdm);
+	int prev_logic = pwrdm_read_prev_logic_pwrst(pwrdm);
 
-	return pwrdm_pwrst_to_func(pwrdm, ret);
+	return pwrdm_pwrst_to_func(pwrdm, prev_pwrst, prev_logic);
 }
 
 /**
  * pwrdm_set_logic_retst - set powerdomain logic power state upon retention
  * @pwrdm: struct powerdomain * to set
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that the logic portion of the
  * powerdomain @pwrdm will enter when the powerdomain enters retention.
@@ -771,7 +814,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
  * pwrdm_set_mem_onst - set memory power state while powerdomain ON
  * @pwrdm: struct powerdomain * to set
  * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the ON
@@ -808,7 +851,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  * pwrdm_set_mem_retst - set memory power state while powerdomain in RET
  * @pwrdm: struct powerdomain * to set
  * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0404f9f..d08c25d 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -37,6 +37,16 @@ enum pwrdm_func_state {
 	PWRDM_MAX_FUNC_PWRSTS		/* Last value, used as the max value */
 };
 
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
 struct clockdomain;
 struct powerdomain;
 
@@ -169,7 +179,9 @@ struct powerdomain {
  * struct pwrdm_ops - Arch specific function implementations
  * @pwrdm_func_to_pwrst: Convert the pd functional power state to
  *  the internal state
- * @pwrdm_pwrst_to_func: Convert the pd internal power state to
+ * @pwrdm_func_to_logic_pwrst: Convert the pd functional power state
+ *  to the internal logic state
+ * @pwrdm_pwrst_to_func: Convert the pd internal and logic power state to
  *  the functional state
  * @pwrdm_set_next_pwrst: Set the target power state for a pd
  * @pwrdm_read_next_pwrst: Read the target power state set for a pd
@@ -192,7 +204,10 @@ struct powerdomain {
  */
 struct pwrdm_ops {
 	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
-	int	(*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 func_pwrst);
+	int	(*pwrdm_func_to_logic_pwrst)(struct powerdomain *pwrdm,
+					     u8 func_pwrst);
+	int	(*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 func_pwrst,
+				       u8 logic);
 	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
 	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
 	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
@@ -230,7 +245,8 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
 int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
-int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst);
+int omap2_pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
+int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
 
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index 79c1293..6a3ea3d 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -212,6 +212,7 @@ static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 
 struct pwrdm_ops omap2_pwrdm_operations = {
 	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_func_to_logic_pwrst	= omap2_pwrdm_func_to_logic_pwrst,
 	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
@@ -226,6 +227,7 @@ struct pwrdm_ops omap2_pwrdm_operations = {
 
 struct pwrdm_ops omap3_pwrdm_operations = {
 	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_func_to_logic_pwrst	= omap2_pwrdm_func_to_logic_pwrst,
 	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 538b528..030d10c 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -210,6 +210,7 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
+	.pwrdm_func_to_logic_pwrst	= omap2_pwrdm_func_to_logic_pwrst,
 	.pwrdm_pwrst_to_func	= omap2_pwrdm_pwrst_to_func,
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
-- 
1.7.7.6

