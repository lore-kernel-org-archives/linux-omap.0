From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/12] ARM: OMAP2+: powerdomain: drop many low-level
 powerdomain funcs
Date: Sun, 09 Dec 2012 10:53:26 -0700
Message-ID: <20121209175317.6933.82928.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39991 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325Ab2LIRyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 12:54:46 -0500
In-Reply-To: <20121209174545.6933.59371.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The powerdomain code that exported the ability to read or change the
previous, current, or next powerdomain or logic power states can now
be removed.  All this is controlled via the powerdomain functional
power state interface now.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |  270 +++----------------------------------
 arch/arm/mach-omap2/powerdomain.h |    9 -
 2 files changed, 21 insertions(+), 258 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 3e2e263..86fe84c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -253,9 +253,6 @@ static int _match_pwrst(u32 pwrsts, int pwrst, int min, int max)
 static int _pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst,
 				  u8 *pwrdm_pwrst, u8 *logic_retst)
 {
-	if (!pwrdm || !pwrdm_pwrst || !logic_retst)
-		return -EINVAL;
-
 	switch (fpwrst) {
 	case PWRDM_FUNC_PWRST_ON:
 		*pwrdm_pwrst = PWRDM_POWER_ON;
@@ -317,9 +314,6 @@ static int _pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst,
 static int _pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic,
 				  u8 *fpwrst)
 {
-	if (!pwrdm || !fpwrst)
-		return -EINVAL;
-
 	switch (pwrst) {
 	case PWRDM_POWER_ON:
 		*fpwrst = PWRDM_FUNC_PWRST_ON;
@@ -370,16 +364,27 @@ static int _set_logic_retst_and_pwrdm_pwrst(struct powerdomain *pwrdm,
 	if (!_pwrdm_pwrst_is_controllable(pwrdm))
 		return 0;
 
+	if (!arch_pwrdm || !arch_pwrdm->pwrdm_set_next_pwrst)
+		return -EINVAL;
+
+	if (!(pwrdm->pwrsts & (1 << pwrst)))
+		return -EINVAL;
+
 	if (pwrdm->pwrsts_logic_ret && pwrst == PWRDM_POWER_RET) {
-		ret = pwrdm_set_logic_retst(pwrdm, logic);
-		if (ret) {
-			pr_err("%s: unable to set logic state %0x of powerdomain: %s\n",
-			       __func__, logic, pwrdm->name);
-			return ret;
+		if (!(pwrdm->pwrsts_logic_ret & (1 << logic)))
+			return -EINVAL;
+
+		if (arch_pwrdm->pwrdm_set_logic_retst) {
+			ret = arch_pwrdm->pwrdm_set_logic_retst(pwrdm, logic);
+			if (ret) {
+				pr_err("%s: unable to set logic state %0x of powerdomain: %s\n",
+				       __func__, logic, pwrdm->name);
+				return ret;
+			}
 		}
 	}
 
-	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+	ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	if (ret)
 		pr_err("%s: unable to set power state %0x of powerdomain: %s\n",
 		       __func__, pwrst, pwrdm->name);
@@ -847,133 +852,6 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
 }
 
 /**
- * pwrdm_set_next_pwrst - set next powerdomain power state
- * @pwrdm: struct powerdomain * to set
- * @pwrst: one of the PWRDM_POWER_* macros
- *
- * Set the powerdomain @pwrdm's next power state to @pwrst.  The powerdomain
- * may not enter this state immediately if the preconditions for this state
- * have not been satisfied.  Returns -EINVAL if the powerdomain pointer is
- * null or if the power state is invalid for the powerdomin, or returns 0
- * upon success.
- */
-int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (!(pwrdm->pwrsts & (1 << pwrst)))
-		return -EINVAL;
-
-	pr_debug("powerdomain: %s: setting next powerstate to %0x\n",
-		 pwrdm->name, pwrst);
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
-		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_next_pwrst - get next powerdomain power state
- * @pwrdm: struct powerdomain * to get power state
- *
- * Return the powerdomain @pwrdm's next power state.  Returns -EINVAL
- * if the powerdomain pointer is null or returns the next power state
- * upon success.
- */
-int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_next_pwrst)
-		ret = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_pwrst - get current powerdomain power state
- * @pwrdm: struct powerdomain * to get power state
- *
- * Return the powerdomain @pwrdm's current power state.	Returns -EINVAL
- * if the powerdomain pointer is null or returns the current power state
- * upon success. Note that if the power domain only supports the ON state
- * then just return ON as the current state.
- */
-int pwrdm_read_pwrst(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (!_pwrdm_pwrst_can_change(pwrdm))
-		return PWRDM_POWER_ON;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
-		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_prev_pwrst - get previous powerdomain power state
- * @pwrdm: struct powerdomain * to get previous power state
- *
- * Return the powerdomain @pwrdm's previous power state.  Returns -EINVAL
- * if the powerdomain pointer is null or returns the previous power state
- * upon success.
- */
-int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_pwrst)
-		ret = arch_pwrdm->pwrdm_read_prev_pwrst(pwrdm);
-
-	return ret;
-}
-
-/**
- * pwrdm_set_logic_retst - set powerdomain logic power state upon retention
- * @pwrdm: struct powerdomain * to set
- * @pwrst: one of the PWRDM_POWER_* macros
- *
- * Set the next power state @pwrst that the logic portion of the
- * powerdomain @pwrdm will enter when the powerdomain enters retention.
- * This will be either RETENTION or OFF, if supported.  Returns
- * -EINVAL if the powerdomain pointer is null or the target power
- * state is not not supported, or returns 0 upon success.
- */
-int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (!(pwrdm->pwrsts_logic_ret & (1 << pwrst)))
-		return -EINVAL;
-
-	pr_debug("powerdomain: %s: setting next logic powerstate to %0x\n",
-		 pwrdm->name, pwrst);
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_logic_retst)
-		ret = arch_pwrdm->pwrdm_set_logic_retst(pwrdm, pwrst);
-
-	return ret;
-}
-
-/**
  * pwrdm_set_mem_onst - set memory power state while powerdomain ON
  * @pwrdm: struct powerdomain * to set
  * @bank: memory bank number to set (0-3)
@@ -1049,70 +927,6 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 }
 
 /**
- * pwrdm_read_logic_pwrst - get current powerdomain logic retention power state
- * @pwrdm: struct powerdomain * to get current logic retention power state
- *
- * Return the power state that the logic portion of powerdomain @pwrdm
- * will enter when the powerdomain enters retention.  Returns -EINVAL
- * if the powerdomain pointer is null or returns the logic retention
- * power state upon success.
- */
-int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_pwrst)
-		ret = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_prev_logic_pwrst - get previous powerdomain logic power state
- * @pwrdm: struct powerdomain * to get previous logic power state
- *
- * Return the powerdomain @pwrdm's previous logic power state.  Returns
- * -EINVAL if the powerdomain pointer is null or returns the previous
- * logic power state upon success.
- */
-int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_logic_pwrst)
-		ret = arch_pwrdm->pwrdm_read_prev_logic_pwrst(pwrdm);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_logic_retst - get next powerdomain logic power state
- * @pwrdm: struct powerdomain * to get next logic power state
- *
- * Return the powerdomain pwrdm's logic power state.  Returns -EINVAL
- * if the powerdomain pointer is null or returns the next logic
- * power state upon success.
- */
-int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_retst)
-		ret = arch_pwrdm->pwrdm_read_logic_retst(pwrdm);
-
-	return ret;
-}
-
-/**
  * pwrdm_read_mem_pwrst - get current memory bank power state
  * @pwrdm: struct powerdomain * to get current memory bank power state
  * @bank: memory bank number (0-3)
@@ -1342,7 +1156,7 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
-/* Types of sleep_switch used in omap_set_pwrdm_state */
+/* Types of sleep_switch used in pwrdm_set_fpwrst() */
 #define ALREADYACTIVE_SWITCH	0
 #define FORCEWAKEUP_SWITCH	1
 #define LOWPOWERSTATE_SWITCH	2
@@ -1352,7 +1166,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
 {
 	u8 curr_pwrst, sleep_switch;
 
-	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	curr_pwrst = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
 	if (curr_pwrst < PWRDM_POWER_ON) {
 		if (curr_pwrst > pwrst &&
 		    pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
@@ -1389,48 +1203,6 @@ static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
 	}
 }
 
-/*
- * This sets pwrdm state (other than mpu & core. Currently only ON &
- * RET are supported.
- */
-int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
-{
-	u8 next_pwrst, sleep_switch;
-	int ret = 0;
-	bool hwsup = false;
-
-	if (!pwrdm || IS_ERR(pwrdm))
-		return -EINVAL;
-
-	while (!(pwrdm->pwrsts & (1 << pwrst))) {
-		if (pwrst == PWRDM_POWER_OFF)
-			return ret;
-		pwrst--;
-	}
-
-	pwrdm_lock(pwrdm);
-
-	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	if (next_pwrst == pwrst) {
-		pwrdm_unlock(pwrdm);
-		return ret;
-	}
-
-	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
-							    &hwsup);
-
-	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
-	if (ret)
-		pr_err("%s: unable to set power state of powerdomain: %s\n",
-		       __func__, pwrdm->name);
-
-	_pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
-
-	pwrdm_unlock(pwrdm);
-
-	return ret;
-}
-
 /**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
  * @pwrdm: struct powerdomain * to wait for
@@ -1621,7 +1393,7 @@ int pwrdm_set_fpwrst(struct powerdomain *pwrdm, enum pwrdm_func_state fpwrst)
 {
 	u8 next_fpwrst, pwrst, logic, sleep_switch;
 	int ret = 0;
-	bool hwsup;
+	bool hwsup = false;
 
 	if (!pwrdm || IS_ERR(pwrdm) || !arch_pwrdm ||
 	    !arch_pwrdm->pwrdm_read_pwrst)
@@ -1651,7 +1423,7 @@ int pwrdm_set_fpwrst(struct powerdomain *pwrdm, enum pwrdm_func_state fpwrst)
 	trace_power_domain_target(pwrdm->name, next_fpwrst,
 				  smp_processor_id());
 
-	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
+	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, fpwrst,
 							    &hwsup);
 
 	ret = _set_logic_retst_and_pwrdm_pwrst(pwrdm, logic, pwrst);
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 849bc55..aa1c9ae 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -232,19 +232,10 @@ struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
 
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
-int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
-int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
-int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
 int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-
-int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_logic_retst(struct powerdomain *pwrdm);
 int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
 int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);


