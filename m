From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 05/14] ARM: OMAP2: Add functions to save and restore powerdomain context
Date: Thu, 12 Apr 2018 09:23:50 +0530
Message-ID: <1523505239-16229-6-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <Russ.Dill@ti.com>

The powerdomain control registers are stored in the WKUP powerdomain on
AM33XX/AM43XX, which is lost on RTC-only suspend and also hibernate. This
adds context save and restore functions for those registers.
Sometimes the powerdomain state does not need to change,
perhaps we only need to change memory retention states, so make
sure the restored state is different from the current state before we wait
for a transition.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c | 60 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |  7 +++++
 arch/arm/mach-omap2/prm33xx.c     | 31 ++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.c     | 50 ++++++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 76eb6ec..ee693f6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1199,3 +1199,63 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
 
 	return 0;
 }
+
+/**
+ * pwrdm_save_context - save powerdomain registers
+ *
+ * Register state is going to be lost due to a suspend or hibernate
+ * event. Save the powerdomain registers.
+ */
+static int pwrdm_save_context(struct powerdomain *pwrdm, void *unused)
+{
+	if (arch_pwrdm && arch_pwrdm->pwrdm_save_context)
+		arch_pwrdm->pwrdm_save_context(pwrdm);
+	return 0;
+}
+
+/**
+ * pwrdm_save_context - restore powerdomain registers
+ *
+ * Restore powerdomain control registers after a suspend or resume
+ * event.
+ */
+static int pwrdm_restore_context(struct powerdomain *pwrdm, void *unused)
+{
+	if (arch_pwrdm && arch_pwrdm->pwrdm_restore_context)
+		arch_pwrdm->pwrdm_restore_context(pwrdm);
+	return 0;
+}
+
+static int pwrdm_lost_power(struct powerdomain *pwrdm, void *unused)
+{
+	int state;
+
+	/*
+	 * Power has been lost across all powerdomains, increment the
+	 * counter.
+	 */
+
+	state = pwrdm_read_pwrst(pwrdm);
+	if (state != PWRDM_POWER_OFF) {
+		pwrdm->state_counter[state]++;
+		pwrdm->state_counter[PWRDM_POWER_OFF]++;
+	}
+	pwrdm->state = state;
+
+	return 0;
+}
+
+void pwrdms_save_context(void)
+{
+	pwrdm_for_each(pwrdm_save_context, NULL);
+}
+
+void pwrdms_restore_context(void)
+{
+	pwrdm_for_each(pwrdm_restore_context, NULL);
+}
+
+void pwrdms_lost_power(void)
+{
+	pwrdm_for_each(pwrdm_lost_power, NULL);
+}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 28a796c..9a907fb 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -144,6 +144,7 @@ struct powerdomain {
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
 #endif
+	u32 context;
 };
 
 /**
@@ -198,6 +199,8 @@ struct pwrdm_ops {
 	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
 	int	(*pwrdm_has_voltdm)(void);
+	void	(*pwrdm_save_context)(struct powerdomain *pwrdm);
+	void	(*pwrdm_restore_context)(struct powerdomain *pwrdm);
 };
 
 int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
@@ -273,4 +276,8 @@ u8 pwrdm_get_valid_lp_state(struct powerdomain *pwrdm,
 extern void pwrdm_lock(struct powerdomain *pwrdm);
 extern void pwrdm_unlock(struct powerdomain *pwrdm);
 
+extern void pwrdms_save_context(void);
+extern void pwrdms_restore_context(void);
+
+extern void pwrdms_lost_power(void);
 #endif
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index ebaf80d..d514166 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -342,6 +342,35 @@ static void am33xx_prm_global_warm_sw_reset(void)
 				  AM33XX_PRM_RSTCTRL_OFFSET);
 }
 
+static void am33xx_pwrdm_save_context(struct powerdomain *pwrdm)
+{
+	pwrdm->context = am33xx_prm_read_reg(pwrdm->prcm_offs,
+						pwrdm->pwrstctrl_offs);
+	/*
+	 * Do not save LOWPOWERSTATECHANGE, writing a 1 indicates a request,
+	 * reading back a 1 indicates a request in progress.
+	 */
+	pwrdm->context &= ~AM33XX_LOWPOWERSTATECHANGE_MASK;
+}
+
+static void am33xx_pwrdm_restore_context(struct powerdomain *pwrdm)
+{
+	int st, ctrl;
+
+	st = am33xx_prm_read_reg(pwrdm->prcm_offs,
+				 pwrdm->pwrstst_offs);
+
+	am33xx_prm_write_reg(pwrdm->context, pwrdm->prcm_offs,
+			     pwrdm->pwrstctrl_offs);
+
+	/* Make sure we only wait for a transition if there is one */
+	st &= OMAP_POWERSTATEST_MASK;
+	ctrl = OMAP_POWERSTATEST_MASK & pwrdm->context;
+
+	if (st != ctrl)
+		am33xx_pwrdm_wait_transition(pwrdm);
+}
+
 struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
@@ -357,6 +386,8 @@ struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_set_mem_retst		= am33xx_pwrdm_set_mem_retst,
 	.pwrdm_wait_transition		= am33xx_pwrdm_wait_transition,
 	.pwrdm_has_voltdm		= am33xx_check_vcvp,
+	.pwrdm_save_context		= am33xx_pwrdm_save_context,
+	.pwrdm_restore_context		= am33xx_pwrdm_restore_context,
 };
 
 static struct prm_ll_data am33xx_prm_ll_data = {
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index acb9593..47b657c 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -667,6 +667,54 @@ static int omap4_check_vcvp(void)
 	return 0;
 }
 
+/**
+ * omap4_pwrdm_save_context - Saves the powerdomain state
+ * @pwrdm: pointer to individual powerdomain
+ *
+ * The function saves the powerdomain state control information.
+ * This is needed in rtc+ddr modes where we lose powerdomain context.
+ */
+static void omap4_pwrdm_save_context(struct powerdomain *pwrdm)
+{
+	pwrdm->context = omap4_prminst_read_inst_reg(pwrdm->prcm_partition,
+						     pwrdm->prcm_offs,
+						     pwrdm->pwrstctrl_offs);
+
+	/*
+	 * Do not save LOWPOWERSTATECHANGE, writing a 1 indicates a request,
+	 * reading back a 1 indicates a request in progress.
+	 */
+	pwrdm->context &= ~OMAP4430_LOWPOWERSTATECHANGE_MASK;
+}
+
+/**
+ * omap4_pwrdm_restore_context - Restores the powerdomain state
+ * @pwrdm: pointer to individual powerdomain
+ *
+ * The function restores the powerdomain state control information.
+ * This is needed in rtc+ddr modes where we lose powerdomain context.
+ */
+static void omap4_pwrdm_restore_context(struct powerdomain *pwrdm)
+{
+	int st, ctrl;
+
+	st = omap4_prminst_read_inst_reg(pwrdm->prcm_partition,
+					 pwrdm->prcm_offs,
+					 pwrdm->pwrstctrl_offs);
+
+	omap4_prminst_write_inst_reg(pwrdm->context,
+				     pwrdm->prcm_partition,
+				     pwrdm->prcm_offs,
+				     pwrdm->pwrstctrl_offs);
+
+	/* Make sure we only wait for a transition if there is one */
+	st &= OMAP_POWERSTATEST_MASK;
+	ctrl = OMAP_POWERSTATEST_MASK & pwrdm->context;
+
+	if (st != ctrl)
+		omap4_pwrdm_wait_transition(pwrdm);
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
@@ -685,6 +733,8 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
 	.pwrdm_has_voltdm	= omap4_check_vcvp,
+	.pwrdm_save_context	= omap4_pwrdm_save_context,
+	.pwrdm_restore_context	= omap4_pwrdm_restore_context,
 };
 
 static int omap44xx_prm_late_init(void);
-- 
1.9.1
