From: jean.pihet@newoldbits.com
Subject: [PATCH 4/6] ARM: OMAP2+: PM: introduce power domains logic and memory functional states
Date: Wed, 11 Apr 2012 22:46:10 +0200
Message-ID: <1334177172-28583-5-git-send-email-j-pihet@ti.com>
References: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37301 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761199Ab2DKUqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 16:46:46 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so1271460wib.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 13:46:46 -0700 (PDT)
In-Reply-To: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ldc_pm_all@list.ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

In the new API the functions pwrdm_*_logic_* and pwrdm_*_mem_* take the
functional states as parameter.

OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine
between the functional state and the logic power state.

The power domains logic state is now derived from the functional
state and the logic state is programmed from omap_set_pwrdm_state.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain-common.c   |   36 ++++++++++--
 arch/arm/mach-omap2/powerdomain.c          |   80 +++++++++++++++++++++------
 arch/arm/mach-omap2/powerdomain.h          |   20 ++++++-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    2 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    1 +
 5 files changed, 112 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index 098dc42..ecaf405 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -138,10 +138,35 @@ int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
 }
 
 /*
+ * Functional (i.e. logical) to internal (i.e. registers)
+ * values for the power domains logic states
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
+		ret = -1;
+	}
+
+	return ret;
+ }
+
+/*
  * Internal (i.e. registers) to functional (i.e. logical) values
  * for the power domains states
  */
-int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
+int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
 {
 	int ret;
 
@@ -153,11 +178,10 @@ int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
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
index 28d5599..3faac62 100644
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
@@ -494,27 +494,64 @@ int pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
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
+	if ((!pwrdm)|| (func_pwrst >= PWRDM_MAX_FUNC_PWRSTS))
+		return -EINVAL;
+
+	pr_debug("powerdomain: convert %0x func to logic pwrst for %s\n",
+		 func_pwrst, pwrdm->name);
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_logic_pwrst) {
+		ret = arch_pwrdm->pwrdm_func_to_logic_pwrst(pwrdm, func_pwrst);
+	}
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
+ * Convert the internal power state and logic power state to the
+ * power domain functional value.
  * Returns the functional power domain state value or -EINVAL in case
  * of invalid parameters passed in.
  */
-int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
+int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic)
 {
 	int ret = pwrst;
 
-	if ((!pwrdm)|| (pwrst >= PWRDM_MAX_PWRSTS))
+	if ((!pwrdm) || (pwrst >= PWRDM_MAX_PWRSTS) ||
+	    (logic >= PWRDM_MAX_LOGIC_MEM_PWRST))
 		return -EINVAL;
 
-	pr_debug("powerdomain: convert %0x pwrst to func for %s\n",
-		 pwrst, pwrdm->name);
+	pr_debug("powerdomain: convert (%0x,%0x) pwrst to func for %s\n",
+		 pwrst, logic, pwrdm->name);
+
+	while (!(pwrdm->pwrsts_logic_ret & (1 << logic))) {
+		if (logic == PWRDM_LOGIC_MEM_PWRST_RET)
+			break;
+		logic++;
+	}
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func) {
-		ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst);
+		ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst, logic);
 	}
 
 	return ret;
@@ -536,9 +573,10 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
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
@@ -571,6 +609,9 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
 		}
 	}
 
+	if (logic != pwrdm_read_logic_retst(pwrdm))
+		pwrdm_set_logic_retst(pwrdm, logic);
+
 	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
 	if (ret)
 		pr_err("%s: unable to set power state of powerdomain: %s\n",
@@ -661,9 +702,10 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
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
@@ -697,9 +739,10 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
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
@@ -733,15 +776,16 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
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
@@ -772,7 +816,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
  * pwrdm_set_mem_onst - set memory power state while powerdomain ON
  * @pwrdm: struct powerdomain * to set
  * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the ON
@@ -809,7 +853,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  * pwrdm_set_mem_retst - set memory power state while powerdomain in RET
  * @pwrdm: struct powerdomain * to set
  * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
+ * @pwrst: one of the PWRDM_LOGIC_MEM_PWRST_* macros
  *
  * Set the next power state @pwrst that memory bank @bank of the
  * powerdomain @pwrdm will enter when the powerdomain enters the
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 460af0e..4e5ce15 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -54,6 +54,15 @@
 
 #define PWRDM_MAX_FUNC_PWRSTS	5
 
+/*
+ * Powerdomains logic and memory functional power states,
+ * used by the external API functions
+ */
+#define PWRDM_LOGIC_MEM_PWRST_OFF	0x0
+#define PWRDM_LOGIC_MEM_PWRST_RET	0x1
+
+#define PWRDM_MAX_LOGIC_MEM_PWRST	2
+
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
 #define PWRDM_HAS_MPU_QUIRK	(1 << 1) /* MPU pwr domain has MEM bank 0 bits
@@ -140,7 +149,9 @@ struct powerdomain {
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
@@ -163,7 +174,9 @@ struct powerdomain {
  */
 struct pwrdm_ops {
 	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
-	int	(*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 func_pwrst);
+	int	(*pwrdm_func_to_logic_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
+	int	(*pwrdm_pwrst_to_func)(struct powerdomain *pwrdm, u8 func_pwrst,
+				       u8 logic);
 	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
 	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
 	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
@@ -209,7 +222,8 @@ int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
 
 int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
-int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst);
+int omap2_pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
+int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
 
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
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

