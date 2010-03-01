From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP4: prcm: Use logical OR instead of bitwise OR
Date: Mon,  1 Mar 2010 14:47:39 +0530
Message-ID: <1267435059-12865-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34646 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0CAJRo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 04:17:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o219HfZx017171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Mar 2010 03:17:43 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>

This patch fixes usage of bitwise OR in if conditions, and instead
uses logical OR.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Abhijit Pagare <abhijitpagare@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    6 +++---
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 arch/arm/mach-omap2/prcm.c        |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b87ad66..6e568ec 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -240,7 +240,7 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 			bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
 		else
 			bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
-	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		if (enable)
 			bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
 		else
@@ -812,7 +812,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE,
 			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 
 		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
 			 __ffs(clkdm->clktrctrl_mask));
@@ -856,7 +856,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE,
 			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 
 		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
 			 __ffs(clkdm->clktrctrl_mask));
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9a0fb38..ebfce7d 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -222,7 +222,7 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
 {
 	struct powerdomain **p = NULL;
 
-	if (cpu_is_omap24xx() | cpu_is_omap34xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		pwrstctrl_reg_offs = OMAP2_PM_PWSTCTRL;
 		pwrstst_reg_offs = OMAP2_PM_PWSTST;
 	} else if (cpu_is_omap44xx()) {
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 81872aa..fc3fd38 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -123,7 +123,7 @@ struct omap3_prcm_regs prcm_context;
 u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
-	if (cpu_is_omap24xx() | cpu_is_omap34xx())
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		return prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
 	if (cpu_is_omap44xx())
 		return prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
@@ -157,7 +157,7 @@ void omap_prcm_arch_reset(char mode)
 	else
 		WARN_ON(1);
 
-	if (cpu_is_omap24xx() | cpu_is_omap34xx())
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs,
 						 OMAP2_RM_RSTCTRL);
 	if (cpu_is_omap44xx())
-- 
1.5.4.7

