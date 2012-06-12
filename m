From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 03/20] ARM: OMAP4: PM: add support for device off
Date: Tue, 12 Jun 2012 18:31:18 +0300
Message-ID: <1339515095-9908-4-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45648 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab2FLPbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:31:55 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

On OMAP4+, device wide off-mode has its own enable mechanism in addition
to powerdomain target states. This patch adds support for this on top
of functional power states by overloading the OFF state for core pwrdm.
On pwrdm level, the deepest power state supported by core pwrdm is OSWR.
When user (e.g. suspend) programs core pwrdm target as OFF, the functional
power state for the domain will be OSWR with the additional device off
enabled. Previous power state information will reflect this also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c           |   17 +++++++++
 arch/arm/mach-omap2/powerdomain.h           |   13 +++++++-
 arch/arm/mach-omap2/powerdomain44xx.c       |   48 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains44xx_data.c |    3 +-
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index ac63f86..78a9308 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -677,6 +677,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
 	int sleep_switch = -1, ret = 0, hwsup = 0;
 	int new_func_pwrst, next_func_pwrst, pwrst, logic;
 	u8 curr_pwrst;
+	bool extra_off_enable = false;
+	bool has_extra_off = false;
 
 	if (!pwrdm || IS_ERR(pwrdm)) {
 		pr_debug("%s: invalid params: pwrdm=%p\n", __func__, pwrdm);
@@ -687,6 +689,13 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
 
 	mutex_lock(&pwrdm->lock);
 
+	/* Check if powerdomain has extra off mode handling */
+	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE) {
+		has_extra_off = true;
+		if (func_pwrst == PWRDM_FUNC_PWRST_OFF)
+			extra_off_enable = true;
+	}
+
 	new_func_pwrst = pwrdm_get_achievable_func_pwrst(pwrdm, func_pwrst);
 	pwrst = pwrdm_func_to_pwrst(pwrdm, new_func_pwrst);
 	logic = pwrdm_func_to_logic_pwrst(pwrdm, new_func_pwrst);
@@ -741,6 +750,9 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
 		break;
 	}
 
+	if (has_extra_off && arch_pwrdm->pwrdm_enable_off)
+		arch_pwrdm->pwrdm_enable_off(pwrdm, extra_off_enable);
+
 out:
 	mutex_unlock(&pwrdm->lock);
 	return ret;
@@ -810,6 +822,11 @@ int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
 	int next_pwrst = pwrdm_read_next_pwrst(pwrdm);
 	int next_logic = pwrdm_read_logic_retst(pwrdm);
 
+	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE &&
+	    arch_pwrdm->pwrdm_read_next_off &&
+	    arch_pwrdm->pwrdm_read_next_off(pwrdm))
+		return PWRDM_FUNC_PWRST_OFF;
+
 	return pwrdm_pwrst_to_func(pwrdm, next_pwrst, next_logic);
 }
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0729d91..cc30b94 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -75,6 +75,13 @@
 						  * state without waking up the
 						  * powerdomain
 						  */
+/*
+ * OMAP4+ has device off feature, which must be enabled separately in
+ * addition to power domain next state setup. This feature is overloaded
+ * as EXTRA_OFF_ENABLE for core_pwrdm, and is implemented on top of
+ * functional power state
+ */
+#define PWRDM_HAS_EXTRA_OFF_ENABLE	(1 << 3)
 
 /*
  * Number of memory banks that are power-controllable.	On OMAP4430, the
@@ -173,7 +180,9 @@ struct powerdomain {
  * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
  * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
- * @pwrdm_lost_context_rff: Check if pd has lost RFF context (entered off)
+ * @pwrdm_lost_context_rff: Check if pd has lost RFF context (omap4+ device off)
+ * @pwrdm_enable_off: Extra off mode enable for pd (omap4+ device off)
+ * @pwrdm_read_next_off: Check if pd next state is off (omap4+ device off)
  */
 struct pwrdm_ops {
 	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
@@ -199,6 +208,8 @@ struct pwrdm_ops {
 	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
 	bool	(*pwrdm_lost_context_rff)(struct powerdomain *pwrdm);
+	void	(*pwrdm_enable_off)(struct powerdomain *pwrdm, bool enable);
+	bool	(*pwrdm_read_next_off)(struct powerdomain *pwrdm);
 };
 
 int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 562f78a..b2bdc0f 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -358,6 +358,52 @@ bool omap4_pwrdm_lost_context_rff(struct powerdomain *pwrdm)
 	return false;
 }
 
+/**
+ * omap4_device_set_next_state_off - setup device off state
+ * @pwrdm: struct powerdomain * to target powerdomain
+ * @enable: true if off-mode should be enabled
+ *
+ * When Device OFF is enabled, Device is allowed to perform
+ * transition to off mode as soon as all power domains in MPU, IVA
+ * and CORE voltage are in OFF or OSWR state (open switch retention)
+ */
+void omap4_device_set_next_state_off(struct powerdomain *pwrdm, bool enable)
+{
+	u8 val = enable ? 0x1 : 0x0;
+
+	if (!(pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE))
+		return;
+
+	omap4_prminst_write_inst_reg(val << OMAP4430_DEVICE_OFF_ENABLE_SHIFT,
+				     OMAP4430_PRM_PARTITION,
+				     OMAP4430_PRM_DEVICE_INST,
+				     OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET);
+}
+
+
+/**
+ * omap4_device_read_next_state_off - read device off state
+ * @pwrdm: struct powerdomain * to target powerdomain
+ *
+ * Checks if device off is enabled or not.
+ * Returns true if enabled, false otherwise.
+ */
+bool omap4_device_read_next_state_off(struct powerdomain *pwrdm)
+{
+	u32 val;
+
+	if (!(pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE))
+		return false;
+
+	val = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+					  OMAP4430_PRM_DEVICE_INST,
+					  OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET);
+
+	val &= OMAP4430_DEVICE_OFF_ENABLE_MASK;
+
+	return val ? true : false;
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
 	.pwrdm_func_to_logic_pwrst	= omap2_pwrdm_func_to_logic_pwrst,
@@ -381,4 +427,6 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_enable_hdwr_sar	= omap4_pwrdm_enable_hdwr_sar,
 	.pwrdm_disable_hdwr_sar	= omap4_pwrdm_disable_hdwr_sar,
 	.pwrdm_lost_context_rff = omap4_pwrdm_lost_context_rff,
+	.pwrdm_enable_off	= omap4_device_set_next_state_off,
+	.pwrdm_read_next_off	= omap4_device_read_next_state_off,
 };
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index c4de02f..13db876 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -54,7 +54,8 @@ static struct powerdomain core_44xx_pwrdm = {
 		[3] = PWRSTS_ON,	/* ducati_l2ram */
 		[4] = PWRSTS_ON,	/* ducati_unicache */
 	},
-	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE |
+			    PWRDM_HAS_EXTRA_OFF_ENABLE,
 };
 
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
-- 
1.7.4.1

