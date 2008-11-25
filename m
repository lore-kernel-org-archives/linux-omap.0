From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: readability fix for IVA2 DPLL autoidle
Date: Tue, 25 Nov 2008 07:23:35 -0800
Message-ID: <1227626615-2949-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:48494 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYKYPXz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 10:23:55 -0500
Received: by qyk4 with SMTP id 4so10786qyk.13
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 07:23:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

No functional change, just a readability fix.

The symbolic name of the shift value used in writing
CM_AUTOIDLE_PLL_IVA2 referred values in the CM_CLKSTCTRL_IVA2
register.  Fix this to use the AUTOIDLE fields.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 804b3ac..05de1f7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -501,9 +501,8 @@ static void __init prcm_setup_regs(void)
 	 * Set all plls to autoidle. This is needed until autoidle is
 	 * enabled by clockfw
 	 */
-	cm_write_mod_reg(1 << OMAP3430_CLKTRCTRL_IVA2_SHIFT,
-			 OMAP3430_IVA2_MOD,
-			 CM_AUTOIDLE2);
+	cm_write_mod_reg(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
+			 OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
 	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
 			 MPU_MOD,
 			 CM_AUTOIDLE2);
-- 
1.6.0.3

