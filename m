From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/10] OMAP3: PM: CPUidle: fix init sequencing
Date: Fri, 23 Oct 2009 09:59:03 -0700
Message-ID: <1256317148-25506-6-git-send-email-khilman@deeprootsystems.com>
References: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-4-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:11746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZJWQ7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:59:25 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1391355qwb.37
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 09:59:30 -0700 (PDT)
In-Reply-To: <1256317148-25506-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Previously omap3_idle_init() was called in device_init, while
omap_pm_init() is called at late_initcall. This causes the cpu idle
driver to call omap_sram_idle before it is properly initialized. This
patch fixes the issue by moving omap3_idle_init into omap3_pm_init.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    8 ++++++--
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm34xx.c      |    3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index b0bee34..ad3af11 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -227,7 +227,7 @@ struct cpuidle_driver omap3_idle_driver = {
  * Registers the OMAP3 specific cpuidle driver with the cpuidle
  * framework with the valid set of states.
  */
-int omap3_idle_init(void)
+int __init omap3_idle_init(void)
 {
 	int i, count = 0;
 	struct omap3_processor_cx *cx;
@@ -272,5 +272,9 @@ int omap3_idle_init(void)
 
 	return 0;
 }
-device_initcall(omap3_idle_init);
+#else
+int __init omap3_idle_init(void)
+{
+	return 0;
+}
 #endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 379e350..0bf345d 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -21,6 +21,7 @@ extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
+extern int omap3_idle_init(void);
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 67412b8..a6624a1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1098,9 +1098,8 @@ static int __init omap3_pm_init(void)
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
-#ifndef CONFIG_CPU_IDLE
 	pm_idle = omap3_pm_idle;
-#endif
+	omap3_idle_init();
 
 	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
 	/*
-- 
1.6.4.3

