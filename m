From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/12] ARM: OMAP2+: powerdomain: assume memory bank power
 states follow powerdomain
Date: Sun, 09 Dec 2012 10:53:39 -0700
Message-ID: <20121209175337.6933.73518.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39999 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934332Ab2LIRyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 12:54:47 -0500
In-Reply-To: <20121209174545.6933.59371.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>

Assume that the memory bank power states follow the powerdomain power
states.  The motivations are to reduce the amount of powerdomain code,
decrease the execution time of the powerdomain state switch code, and
simplify the power state debug.

This assumption is true for the currently-implemented functional power
states.  If it ceases to be true, the memory bank power states should
be controlled via the functional power states, rather than controlled
via low-level functions.

For the moment, the underlying implementation code in
mach-omap2/prm*.c has been preserved, although some of that code may
be removable too.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c    |    4 -
 arch/arm/mach-omap2/pm24xx.c      |    9 -
 arch/arm/mach-omap2/powerdomain.c |  277 +++++++++++--------------------------
 arch/arm/mach-omap2/powerdomain.h |    9 -
 4 files changed, 79 insertions(+), 220 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 72cf9e0..03da2e3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -108,10 +108,6 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 		seq_printf(s, ",%s:%d", pwrdm_convert_fpwrst_to_name(i),
 			   pwrdm->fpwrst_counter[i - PWRDM_FPWRST_OFFSET]);
 
-	for (i = 0; i < pwrdm->banks; i++)
-		seq_printf(s, ",RET-MEMBANK%d-OFF:%d", i + 1,
-				pwrdm->ret_mem_off_counter[i]);
-
 	seq_printf(s, "\n");
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 29abb63..99c16c2 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -230,7 +230,6 @@ out:
 
 static void __init prcm_setup_regs(void)
 {
-	int i, num_mem_banks;
 	struct powerdomain *pwrdm;
 
 	/*
@@ -240,14 +239,6 @@ static void __init prcm_setup_regs(void)
 	omap2_prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
 			  OMAP2_PRCM_SYSCONFIG_OFFSET);
 
-	/*
-	 * Set CORE powerdomain memory banks to retain their contents
-	 * during RETENTION
-	 */
-	num_mem_banks = pwrdm_get_mem_bank_count(core_pwrdm);
-	for (i = 0; i < num_mem_banks; i++)
-		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
-
 	/* Force-power down DSP, GFX powerdomains */
 
 	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index a70e3f6..7a32fcc 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -118,9 +118,6 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	for (i = 0; i < PWRDM_FPWRSTS_COUNT; i++)
 		pwrdm->fpwrst_counter[i] = 0;
 
-	for (i = 0; i < pwrdm->banks; i++)
-		pwrdm->ret_mem_off_counter[i] = 0;
-
 	arch_pwrdm->pwrdm_wait_transition(pwrdm);
 	pwrdm->fpwrst = pwrdm_read_fpwrst(pwrdm);
 	pwrdm->fpwrst_counter[pwrdm->fpwrst - PWRDM_FPWRST_OFFSET] = 1;
@@ -364,7 +361,6 @@ static int _pwrdm_read_next_fpwrst(struct powerdomain *pwrdm)
 		if (next_logic < 0)
 			return next_logic;
 	}
-
 	ret = _pwrdm_pwrst_to_fpwrst(pwrdm, next_pwrst, next_logic, &fpwrst);
 
 	return (ret) ? ret : fpwrst;
@@ -437,12 +433,86 @@ static int _pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm)
 	return (ret) ? ret : fpwrst;
 }
 
+/**
+ * _pwrdm_set_mem_onst - set memory power state while powerdomain ON
+ * @pwrdm: struct powerdomain * to set
+ * @bank: memory bank number to set (0-3)
+ * @pwrst: one of the PWRDM_POWER_* macros
+ *
+ * Set the next power state @pwrst that memory bank @bank of the
+ * powerdomain @pwrdm will enter when the powerdomain enters the ON
+ * state.  @bank will be a number from 0 to 3, and represents different
+ * types of memory, depending on the powerdomain.  Returns -EINVAL if
+ * the powerdomain pointer is null or the target power state is not
+ * not supported for this memory bank, -EEXIST if the target memory
+ * bank does not exist or is not controllable, or returns 0 upon
+ * success.
+ */
+static int _pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
+{
+	int ret = -EINVAL;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	if (!(pwrdm->pwrsts_mem_on[bank] & (1 << pwrst)))
+		return -EINVAL;
+
+	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-ON to %0x\n",
+		 pwrdm->name, bank, pwrst);
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst)
+		ret = arch_pwrdm->pwrdm_set_mem_onst(pwrdm, bank, pwrst);
+
+	return ret;
+}
+
+/**
+ * _pwrdm_set_mem_retst - set memory power state while powerdomain in RET
+ * @pwrdm: struct powerdomain * to set
+ * @bank: memory bank number to set (0-3)
+ * @pwrst: one of the PWRDM_POWER_* macros
+ *
+ * Set the next power state @pwrst that memory bank @bank of the
+ * powerdomain @pwrdm will enter when the powerdomain enters the
+ * RETENTION state.  Bank will be a number from 0 to 3, and represents
+ * different types of memory, depending on the powerdomain.  @pwrst
+ * will be either RETENTION or OFF, if supported.  Returns -EINVAL if
+ * the powerdomain pointer is null or the target power state is not
+ * not supported for this memory bank, -EEXIST if the target memory
+ * bank does not exist or is not controllable, or returns 0 upon
+ * success.
+ */
+static int _pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
+{
+	int ret = -EINVAL;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	if (pwrdm->banks < (bank + 1))
+		return -EEXIST;
+
+	if (!(pwrdm->pwrsts_mem_ret[bank] & (1 << pwrst)))
+		return -EINVAL;
+
+	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-RET to %0x\n",
+		 pwrdm->name, bank, pwrst);
+
+	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst)
+		ret = arch_pwrdm->pwrdm_set_mem_retst(pwrdm, bank, pwrst);
+
+	return ret;
+}
+
+
 /* XXX Caller must hold pwrdm->_lock */
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 	int prev, next, fpwrst, trace_state = 0;
-	int i;
-	u8 prev_mem_pwrst;
 
 	if (pwrdm == NULL)
 		return -EINVAL;
@@ -457,17 +527,6 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		prev = _pwrdm_read_prev_fpwrst(pwrdm);
 		if (pwrdm->fpwrst != prev)
 			pwrdm->fpwrst_counter[prev - PWRDM_FPWRST_OFFSET]++;
-		if (prev == PWRDM_FUNC_PWRST_CSWR ||
-		    prev == PWRDM_FUNC_PWRST_OSWR) {
-			for (i = 0; i < pwrdm->banks; i++) {
-				prev_mem_pwrst =
-					pwrdm_read_prev_mem_pwrst(pwrdm, i);
-				if ((pwrdm->pwrsts_mem_ret[i] ==
-				     PWRSTS_OFF_RET) &&
-				    (prev_mem_pwrst == PWRDM_POWER_OFF))
-					pwrdm->ret_mem_off_counter[i]++;
-			}
-		}
 		/*
 		 * If the power domain did not hit the desired state,
 		 * generate a trace event with both the desired and hit states
@@ -580,8 +639,8 @@ int pwrdm_complete_init(void)
 
 	list_for_each_entry(temp_p, &pwrdm_list, node) {
 		for (i = 0; i < temp_p->banks; i++) {
-			pwrdm_set_mem_onst(temp_p, i, PWRDM_POWER_ON);
-			pwrdm_set_mem_retst(temp_p, i, PWRDM_POWER_RET);
+			_pwrdm_set_mem_onst(temp_p, i, PWRDM_POWER_ON);
+			_pwrdm_set_mem_retst(temp_p, i, PWRDM_POWER_RET);
 		}
 		WARN_ON(pwrdm_set_next_fpwrst(temp_p, PWRDM_FUNC_PWRST_ON));
 	}
@@ -789,181 +848,6 @@ struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm)
 }
 
 /**
- * pwrdm_get_mem_bank_count - get number of memory banks in this powerdomain
- * @pwrdm: struct powerdomain *
- *
- * Return the number of controllable memory banks in powerdomain @pwrdm,
- * starting with 1.  Returns -EINVAL if the powerdomain pointer is null.
- */
-int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
-{
-	if (!pwrdm)
-		return -EINVAL;
-
-	return pwrdm->banks;
-}
-
-/**
- * pwrdm_set_mem_onst - set memory power state while powerdomain ON
- * @pwrdm: struct powerdomain * to set
- * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
- *
- * Set the next power state @pwrst that memory bank @bank of the
- * powerdomain @pwrdm will enter when the powerdomain enters the ON
- * state.  @bank will be a number from 0 to 3, and represents different
- * types of memory, depending on the powerdomain.  Returns -EINVAL if
- * the powerdomain pointer is null or the target power state is not
- * not supported for this memory bank, -EEXIST if the target memory
- * bank does not exist or is not controllable, or returns 0 upon
- * success.
- */
-int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (pwrdm->banks < (bank + 1))
-		return -EEXIST;
-
-	if (!(pwrdm->pwrsts_mem_on[bank] & (1 << pwrst)))
-		return -EINVAL;
-
-	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-ON to %0x\n",
-		 pwrdm->name, bank, pwrst);
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst)
-		ret = arch_pwrdm->pwrdm_set_mem_onst(pwrdm, bank, pwrst);
-
-	return ret;
-}
-
-/**
- * pwrdm_set_mem_retst - set memory power state while powerdomain in RET
- * @pwrdm: struct powerdomain * to set
- * @bank: memory bank number to set (0-3)
- * @pwrst: one of the PWRDM_POWER_* macros
- *
- * Set the next power state @pwrst that memory bank @bank of the
- * powerdomain @pwrdm will enter when the powerdomain enters the
- * RETENTION state.  Bank will be a number from 0 to 3, and represents
- * different types of memory, depending on the powerdomain.  @pwrst
- * will be either RETENTION or OFF, if supported.  Returns -EINVAL if
- * the powerdomain pointer is null or the target power state is not
- * not supported for this memory bank, -EEXIST if the target memory
- * bank does not exist or is not controllable, or returns 0 upon
- * success.
- */
-int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (pwrdm->banks < (bank + 1))
-		return -EEXIST;
-
-	if (!(pwrdm->pwrsts_mem_ret[bank] & (1 << pwrst)))
-		return -EINVAL;
-
-	pr_debug("powerdomain: %s: setting next memory powerstate for bank %0x while pwrdm-RET to %0x\n",
-		 pwrdm->name, bank, pwrst);
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst)
-		ret = arch_pwrdm->pwrdm_set_mem_retst(pwrdm, bank, pwrst);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_mem_pwrst - get current memory bank power state
- * @pwrdm: struct powerdomain * to get current memory bank power state
- * @bank: memory bank number (0-3)
- *
- * Return the powerdomain @pwrdm's current memory power state for bank
- * @bank.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
- * the target memory bank does not exist or is not controllable, or
- * returns the current memory power state upon success.
- */
-int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return ret;
-
-	if (pwrdm->banks < (bank + 1))
-		return ret;
-
-	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
-		bank = 1;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_pwrst)
-		ret = arch_pwrdm->pwrdm_read_mem_pwrst(pwrdm, bank);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_prev_mem_pwrst - get previous memory bank power state
- * @pwrdm: struct powerdomain * to get previous memory bank power state
- * @bank: memory bank number (0-3)
- *
- * Return the powerdomain @pwrdm's previous memory power state for
- * bank @bank.  Returns -EINVAL if the powerdomain pointer is null,
- * -EEXIST if the target memory bank does not exist or is not
- * controllable, or returns the previous memory power state upon
- * success.
- */
-int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return ret;
-
-	if (pwrdm->banks < (bank + 1))
-		return ret;
-
-	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
-		bank = 1;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_mem_pwrst)
-		ret = arch_pwrdm->pwrdm_read_prev_mem_pwrst(pwrdm, bank);
-
-	return ret;
-}
-
-/**
- * pwrdm_read_mem_retst - get next memory bank power state
- * @pwrdm: struct powerdomain * to get mext memory bank power state
- * @bank: memory bank number (0-3)
- *
- * Return the powerdomain pwrdm's next memory power state for bank
- * x.  Returns -EINVAL if the powerdomain pointer is null, -EEXIST if
- * the target memory bank does not exist or is not controllable, or
- * returns the next memory power state upon success.
- */
-int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return ret;
-
-	if (pwrdm->banks < (bank + 1))
-		return ret;
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_retst)
-		ret = arch_pwrdm->pwrdm_read_mem_retst(pwrdm, bank);
-
-	return ret;
-}
-
-/**
  * pwrdm_clear_all_prev_pwrst - clear previous powerstate register for a pwrdm
  * @pwrdm: struct powerdomain * to clear
  *
@@ -1165,7 +1049,7 @@ static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
  */
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 {
-	int i, count;
+	int count;
 
 	if (!pwrdm) {
 		WARN(1, "powerdomain: %s: pwrdm is null\n", __func__);
@@ -1177,9 +1061,6 @@ int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 	count += pwrdm->fpwrst_counter[PWRDM_FUNC_PWRST_OSWR -
 				       PWRDM_FPWRST_OFFSET];
 
-	for (i = 0; i < pwrdm->banks; i++)
-		count += pwrdm->ret_mem_off_counter[i];
-
 	/*
 	 * Context loss count has to be a non-negative value. Clear the sign
 	 * bit to get a value range from 0 to INT_MAX.
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 52be8cd..7921f52 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -153,7 +153,6 @@ struct powerdomain {
 	struct list_head node;
 	struct list_head voltdm_node;
 	unsigned fpwrst_counter[PWRDM_FPWRSTS_COUNT];
-	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
 	spinlock_t _lock;
 	unsigned long _lock_flags;
 	const u8 pwrstctrl_offs;
@@ -230,16 +229,8 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 				   struct clockdomain *clkdm));
 struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
 
-int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
-
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
-int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
-
 int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
 bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);


