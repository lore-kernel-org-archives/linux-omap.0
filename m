From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] ARM: OMAP2+: PM: share clkdms_setup() across OMAP2, 3, 4
Date: Thu, 02 Feb 2012 02:38:50 -0700
Message-ID: <20120202093848.12509.92747.stgit@dusk>
References: <20120202093600.12509.35052.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab2BBJj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 04:39:58 -0500
In-Reply-To: <20120202093600.12509.35052.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

clkdms_setup() is identical across OMAP2, 3, and 4, so share it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm.c     |   10 ++++++++++
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm24xx.c |   13 +------------
 arch/arm/mach-omap2/pm34xx.c |   17 +----------------
 arch/arm/mach-omap2/pm44xx.c |   18 +-----------------
 5 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..0118614 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -68,6 +68,16 @@ static void omap2_init_processor_devices(void)
 #define FORCEWAKEUP_SWITCH	0
 #define LOWPOWERSTATE_SWITCH	1
 
+int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
+{
+	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+		clkdm_allow_idle(clkdm);
+	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
+		 atomic_read(&clkdm->usecount) == 0)
+		clkdm_sleep(clkdm);
+	return 0;
+}
+
 /*
  * This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported.
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b737b11..eef67f6 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,6 +22,7 @@ extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 extern int omap4_idle_init(void);
+extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index b8822f8..bfd7905 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -312,17 +312,6 @@ static const struct platform_suspend_ops omap_pm_ops = {
 static const struct platform_suspend_ops __initdata omap_pm_ops;
 #endif /* CONFIG_SUSPEND */
 
-/* XXX This function should be shareable between OMAP2xxx and OMAP3 */
-static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
-{
-	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
-		clkdm_allow_idle(clkdm);
-	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
-		 atomic_read(&clkdm->usecount) == 0)
-		clkdm_sleep(clkdm);
-	return 0;
-}
-
 static void __init prcm_setup_regs(void)
 {
 	int i, num_mem_banks;
@@ -364,7 +353,7 @@ static void __init prcm_setup_regs(void)
 	clkdm_sleep(gfx_clkdm);
 
 	/* Enable hardware-supervised idle for all clkdms */
-	clkdm_for_each(clkdms_setup, NULL);
+	clkdm_for_each(omap_pm_clkdms_setup, NULL);
 	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
 
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..ae962b5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -743,21 +743,6 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 }
 
 /*
- * Enable hw supervised mode for all clockdomains if it's
- * supported. Initiate sleep transition for other clockdomains, if
- * they are not used
- */
-static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
-{
-	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
-		clkdm_allow_idle(clkdm);
-	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
-		 atomic_read(&clkdm->usecount) == 0)
-		clkdm_sleep(clkdm);
-	return 0;
-}
-
-/*
  * Push functions to SRAM
  *
  * The minimum set of functions is pushed to SRAM for execution:
@@ -826,7 +811,7 @@ static int __init omap3_pm_init(void)
 		goto err2;
 	}
 
-	(void) clkdm_for_each(clkdms_setup, NULL);
+	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index c264ef7..a6fb31b 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -120,22 +120,6 @@ static const struct platform_suspend_ops omap_pm_ops = {
 };
 #endif /* CONFIG_SUSPEND */
 
-/*
- * Enable hardware supervised mode for all clockdomains if it's
- * supported. Initiate sleep transition for other clockdomains, if
- * they are not used
- */
-static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
-{
-	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
-		clkdm_allow_idle(clkdm);
-	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
-			atomic_read(&clkdm->usecount) == 0)
-		clkdm_sleep(clkdm);
-	return 0;
-}
-
-
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -249,7 +233,7 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
-	(void) clkdm_for_each(clkdms_setup, NULL);
+	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);


