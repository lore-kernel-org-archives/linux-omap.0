From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2] ARM: OMAP2+: Remove suspend_set_ops from common pm late init
Date: Mon, 12 May 2014 13:33:21 -0500
Message-ID: <1399919601-15543-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42745 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaELSeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 14:34:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>

In omap2_common_pm_late_init suspend_set_ops was called to set common
suspend handling functions for all omap platforms. This created two
problems. First, these suspend ops were being set for all platforms,
regardless of whether or not suspend support has been integrated so in
the case of AM33XX, suspend to mem was presented as available but
failed every time. Second, some platforms will need to define a
completely separate set of suspend ops, such as AM33XX, due to
differences from previous omap platforms so there is no need to
always set the common omap ops.

This patch moves the suspend_set_ops call from omap2_common_pm_late_init
into a separate function that then gets called in the omap*_pm_init
functions for each platform.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---

v2:
Don't need to expose omap_pm_ops, use omap_common_suspend_init to set
Add kernel-doc for omap_common_suspend_init

 arch/arm/mach-omap2/pm.c     | 17 ++++++++++++-----
 arch/arm/mach-omap2/pm.h     |  8 +++++++-
 arch/arm/mach-omap2/pm24xx.c |  4 +---
 arch/arm/mach-omap2/pm34xx.c |  7 +++----
 arch/arm/mach-omap2/pm44xx.c |  6 +++---
 5 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e1b4141..dd31212 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -32,11 +32,13 @@
 #include "pm.h"
 #include "twl-common.h"
 
+#ifdef CONFIG_SUSPEND
 /*
  * omap_pm_suspend: points to a function that does the SoC-specific
  * suspend work
  */
-int (*omap_pm_suspend)(void);
+static int (*omap_pm_suspend)(void);
+#endif
 
 #ifdef CONFIG_PM
 /**
@@ -243,6 +245,15 @@ static const struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+/**
+ * omap_common_suspend_init - Set common suspend routines for OMAP SoCs
+ * @pm_suspend: function pointer to SoC specific suspend function
+ */
+void omap_common_suspend_init(void *pm_suspend)
+{
+	omap_pm_suspend = pm_suspend;
+	suspend_set_ops(&omap_pm_ops);
+}
 #endif /* CONFIG_SUSPEND */
 
 static void __init omap3_init_voltages(void)
@@ -310,9 +321,5 @@ int __init omap2_common_pm_late_init(void)
 	/* cpufreq dummy device instantiation */
 	omap_init_cpufreq();
 
-#ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
-#endif
-
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index d4d0fce..e150102 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -34,7 +34,6 @@ extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
-extern int (*omap_pm_suspend)(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
@@ -147,4 +146,11 @@ static inline void omap_pm_get_oscillator(u32 *tstart, u32 *tshut) { *tstart = *
 static inline void omap_pm_setup_sr_i2c_pcb_length(u32 mm) { }
 #endif
 
+#ifdef CONFIG_SUSPEND
+void omap_common_suspend_init(void *pm_suspend);
+#else
+static inline void omap_common_suspend_init(void *pm_suspend)
+{
+}
+#endif /* CONFIG_SUSPEND */
 #endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 8c07594..a5ea988 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -229,9 +229,7 @@ static void __init prcm_setup_regs(void)
 	clkdm_for_each(omap_pm_clkdms_setup, NULL);
 	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
 
-#ifdef CONFIG_SUSPEND
-	omap_pm_suspend = omap2_enter_full_retention;
-#endif
+	omap_common_suspend_init(omap2_enter_full_retention);
 
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
 	 * stabilisation */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 87099bb..90ea2d3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -391,7 +391,8 @@ restore:
 
 	return ret;
 }
-
+#else
+#define omap3_pm_suspend NULL
 #endif /* CONFIG_SUSPEND */
 
 
@@ -705,9 +706,7 @@ int __init omap3_pm_init(void)
 	per_clkdm = clkdm_lookup("per_clkdm");
 	wkup_clkdm = clkdm_lookup("wkup_clkdm");
 
-#ifdef CONFIG_SUSPEND
-	omap_pm_suspend = omap3_pm_suspend;
-#endif
+	omap_common_suspend_init(omap3_pm_suspend);
 
 	arm_pm_idle = omap3_pm_idle;
 	omap3_idle_init();
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index eefb30c..0dda6cf 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -96,6 +96,8 @@ static int omap4_pm_suspend(void)
 
 	return 0;
 }
+#else
+#define omap4_pm_suspend NULL
 #endif /* CONFIG_SUSPEND */
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
@@ -251,9 +253,7 @@ int __init omap4_pm_init(void)
 
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
-#ifdef CONFIG_SUSPEND
-	omap_pm_suspend = omap4_pm_suspend;
-#endif
+	omap_common_suspend_init(omap4_pm_suspend);
 
 	/* Overwrite the default cpu_do_idle() */
 	arm_pm_idle = omap_default_idle;
-- 
1.9.0

