From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP4: clockdomain: Use logical OR instead of bitwise OR
Date: Fri, 26 Feb 2010 18:17:25 +0530
Message-ID: <1267188445-25652-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53907 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935858Ab0BZMrb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Feb 2010 07:47:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>

This patch fixes usage of bitwise OR in if conditions, and instead
uses logical OR.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Abhijit Pagare <abhijitpagare@ti.com>
---

Patch generated on top of for_2.6.34_b branch from
git://git.pwsan.com/linux-2.6 tree.

 arch/arm/mach-omap2/clockdomain.c |    4 ++--
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b87ad66..be846e6 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
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
-- 
1.5.4.7

