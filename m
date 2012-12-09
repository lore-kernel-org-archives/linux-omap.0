From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/10] ARM: OMAP2+: PM/powerdomain: move
 omap_set_pwrdm_state() to powerdomain code
Date: Sat, 08 Dec 2012 18:23:40 -0700
Message-ID: <20121209012339.19716.10548.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38999 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240Ab2LIBYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Dec 2012 20:24:32 -0500
In-Reply-To: <20121209011755.19716.25244.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>

Move omap_set_pwrdm_state() from the PM code to the powerdomain code,
and refactor it to split it up into several functions.  A subsequent patch
will rename it to conform with the existing powerdomain function names.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c          |   61 --------------------
 arch/arm/mach-omap2/pm.h          |    1 
 arch/arm/mach-omap2/powerdomain.c |  112 +++++++++++++++++++++++++++----------
 arch/arm/mach-omap2/powerdomain.h |    3 +
 4 files changed, 85 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index cc8ed0f..2e2a897 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -76,10 +76,6 @@ static void __init omap2_init_processor_devices(void)
 	}
 }
 
-/* Types of sleep_switch used in omap_set_pwrdm_state */
-#define FORCEWAKEUP_SWITCH	0
-#define LOWPOWERSTATE_SWITCH	1
-
 int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	if ((clkdm->flags & CLKDM_CAN_ENABLE_AUTO) &&
@@ -92,63 +88,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
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
-	while (!(pwrdm->pwrsts & (1 << pwrst))) {
-		if (pwrst == PWRDM_POWER_OFF)
-			return ret;
-		pwrst--;
-	}
-
-	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	if (next_pwrst == pwrst)
-		return ret;
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
-		pwrdm_state_switch(pwrdm);
-		break;
-	}
-
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
index 686137d..707e9cb 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -33,7 +33,6 @@ static inline int omap4_idle_init(void)
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
-extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 extern int (*omap_pm_suspend)(void);
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 97b3881..05f00660 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -921,35 +921,6 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
 	return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
 }
 
-/**
- * pwrdm_set_lowpwrstchange - Request a low power state change
- * @pwrdm: struct powerdomain *
- *
- * Allows a powerdomain to transtion to a lower power sleep state
- * from an existing sleep state without waking up the powerdomain.
- * Returns -EINVAL if the powerdomain pointer is null or if the
- * powerdomain does not support LOWPOWERSTATECHANGE, or returns 0
- * upon success.
- */
-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
-{
-	int ret = -EINVAL;
-
-	if (!pwrdm)
-		return -EINVAL;
-
-	if (!(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE))
-		return -EINVAL;
-
-	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
-		 pwrdm->name);
-
-	if (arch_pwrdm && arch_pwrdm->pwrdm_set_lowpwrstchange)
-		ret = arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
-
-	return ret;
-}
-
 int pwrdm_state_switch(struct powerdomain *pwrdm)
 {
 	int ret;
@@ -984,6 +955,89 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+/* Types of sleep_switch used in omap_set_pwrdm_state */
+#define ALREADYACTIVE_SWITCH	0
+#define FORCEWAKEUP_SWITCH	1
+#define LOWPOWERSTATE_SWITCH	2
+
+static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
+					       u8 pwrst, bool *hwsup)
+{
+	u8 curr_pwrst, sleep_switch;
+
+	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	if (curr_pwrst < PWRDM_POWER_ON) {
+		if (curr_pwrst > pwrst &&
+		    pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
+		    arch_pwrdm->pwrdm_set_lowpwrstchange) {
+			sleep_switch = LOWPOWERSTATE_SWITCH;
+		} else {
+			*hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
+			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			sleep_switch = FORCEWAKEUP_SWITCH;
+		}
+	} else {
+		sleep_switch = ALREADYACTIVE_SWITCH;
+	}
+
+	return sleep_switch;
+}
+
+static void _pwrdm_restore_clkdm_state(struct powerdomain *pwrdm,
+				       u8 sleep_switch, bool hwsup)
+{
+	switch (sleep_switch) {
+	case FORCEWAKEUP_SWITCH:
+		if (hwsup)
+			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		else
+			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
+		break;
+	case LOWPOWERSTATE_SWITCH:
+		if (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
+		    arch_pwrdm->pwrdm_set_lowpwrstchange)
+			arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
+		pwrdm_state_switch(pwrdm);
+		break;
+	}
+}
+
+/*
+ * This sets pwrdm state (other than mpu & core. Currently only ON &
+ * RET are supported.
+ */
+int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
+{
+	u8 next_pwrst, sleep_switch;
+	int ret = 0;
+	bool hwsup = false;
+
+	if (!pwrdm || IS_ERR(pwrdm))
+		return -EINVAL;
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
+	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
+							    &hwsup);
+
+	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+	if (ret)
+		pr_err("%s: unable to set power state of powerdomain: %s\n",
+		       __func__, pwrdm->name);
+
+	_pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
+
+	return ret;
+}
+
 /**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
  * @pwrdm: struct powerdomain * to wait for
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 7c1534b..1edb3b7 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -228,10 +228,11 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_pre_transition(struct powerdomain *pwrdm);
 int pwrdm_post_transition(struct powerdomain *pwrdm);
-int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
+extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
+
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);


