From: Paul Walmsley <paul@pwsan.com>
Subject: ARM: OMAP2xxx: PM: remove obsolete timer disable code in the suspend
 path
Date: Thu, 9 Feb 2012 20:08:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202092007540.17520@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40829 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323Ab2BJDIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 22:08:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, robherring2@gmail.com, tony@atomide.com


Remove omap_{read,write}l() from the 24xx PM code.  The clocksource
code should now handle what this was supposed to do.

Tested on N800 -- but it's hard to say whether this fixes anything.
OMAP24xx static suspend path is currently broken, and this patch
doesn't change that.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rob Herring <robherring2@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm24xx.c |   24 ++----------------------
 1 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index b8822f8..7690b53 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -245,7 +245,7 @@ static void omap2_pm_idle(void)
 	if (omap_irq_pending())
 		goto out;
 
-	omap2_enter_full_retention();
+	omap2_enter_mpu_retention();
 
 out:
 	local_fiq_enable();
@@ -260,26 +260,6 @@ static int omap2_pm_begin(suspend_state_t state)
 	return 0;
 }
 
-static int omap2_pm_suspend(void)
-{
-	u32 wken_wkup, mir1;
-
-	wken_wkup = omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
-	wken_wkup &= ~OMAP24XX_EN_GPT1_MASK;
-	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
-
-	/* Mask GPT1 */
-	mir1 = omap_readl(0x480fe0a4);
-	omap_writel(1 << 5, 0x480fe0ac);
-
-	omap2_enter_full_retention();
-
-	omap_writel(mir1, 0x480fe0a4);
-	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
-
-	return 0;
-}
-
 static int omap2_pm_enter(suspend_state_t state)
 {
 	int ret = 0;
@@ -287,7 +267,7 @@ static int omap2_pm_enter(suspend_state_t state)
 	switch (state) {
 	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
-		ret = omap2_pm_suspend();
+		omap2_enter_full_retention();
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.7.9

