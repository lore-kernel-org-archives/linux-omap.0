From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 20/20] ARM: OMAP4430: PM: errata i625, WUGEN lost for GP devices after OFF mode
Date: Tue, 12 Jun 2012 18:41:07 +0300
Message-ID: <1339515667-10270-1-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39105 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530Ab2FLPlQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:41:16 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

This patch implements errata i625.

When coming back from device off mode, the Cortex-A9 WUGEN enable registers
are not restored by ROM code. The work around disables device power OFF
to maintain the proper register settings.
The affected devices are OMAP4430GP ES2.0 to ES2.2.

Based on work done by Mykola Oleksiienko and Konstantin Shlyakhovoy.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm44xx.c |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 63af57e..f85ef2d 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -92,6 +92,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #define PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx	(1 << 1)
 #define PM_OMAP4_ROM_L3INSTR_ERRATUM_xxx	(1 << 2)
 #define PM_OMAP4_ROM_CPU1_BACKUP_ERRATUM_xxx	(1 << 3)
+#define PM_OMAP4_ROM_WUGEN_LOST_ERRATUM_i625	(1 << 4)
 
 #if defined(CONFIG_ARCH_OMAP4)
 extern u16 pm44xx_errata;
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 8054afc..c1dc0d9 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -116,7 +116,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 						pwrdm,
 						PWRDM_FUNC_PWRST_OFF);
 
-	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE)
+	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE &&
+	    !IS_PM44XX_ERRATUM(PM_OMAP4_ROM_WUGEN_LOST_ERRATUM_i625))
 		pwrst->next_state = PWRDM_FUNC_PWRST_OFF;
 
 	list_add(&pwrst->node, &pwrst_list);
@@ -276,6 +277,15 @@ int __init omap4_pm_init(void)
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
 		pm44xx_errata |= PM_OMAP4_ROM_L3INSTR_ERRATUM_xxx;
 
+	/*
+	 * The OFF mode isn't fully supported for OMAP4430GP ES2.0 - ES2.2
+	 * due to errata i625
+	 * On ES1.0 OFF mode is not supported due to errata i498
+	 */
+	if (cpu_is_omap443x() && omap_type() == OMAP2_DEVICE_TYPE_GP &&
+	    omap_rev() < OMAP4430_REV_ES2_3)
+		pm44xx_errata |= PM_OMAP4_ROM_WUGEN_LOST_ERRATUM_i625;
+
 #ifdef CONFIG_SUSPEND
 	omap_pm_suspend = omap4_pm_suspend;
 #endif
-- 
1.7.4.1

