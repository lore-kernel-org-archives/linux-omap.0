From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 04/15] ARM: OMAP2+: hwmod: Update the reset API for AM33XX
Date: Fri, 2 Nov 2012 18:02:35 +0530
Message-ID: <1351859566-24818-5-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45216 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760978Ab2KBMec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:32 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

WKUP-M3 has a reset status bit (RM_WKUP_STST.WKUP_M3_LRST)
Update the hardreset API to take care of the same to ensure
that the reset line properly deasserted.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 +----
 arch/arm/mach-omap2/prm33xx.c    |   15 +++++++--------
 arch/arm/mach-omap2/prm33xx.h    |    2 +-
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 37eeb45..a1d5835 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2944,11 +2944,8 @@ static int _am33xx_assert_hardreset(struct omap_hwmod *oh,
 static int _am33xx_deassert_hardreset(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri)
 {
-	if (ohri->st_shift)
-		pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
-		       oh->name, ohri->name);
-
 	return am33xx_prm_deassert_hardreset(ohri->rst_shift,
+				ohri->st_shift,
 				oh->clkdm->pwrdm.ptr->prcm_offs,
 				oh->prcm.omap4.rstctrl_offs,
 				oh->prcm.omap4.rstst_offs);
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 53ec9cb..0f29cb9 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -112,23 +112,22 @@ int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs)
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
+int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
 		u16 rstctrl_offs, u16 rstst_offs)
 {
 	int c;
-	u32 mask = 1 << shift;
-
-	/* Check the current status to avoid  de-asserting the line twice */
-	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
-		return -EEXIST;
+	u32 mask = 1 << st_shift;
 
 	/* Clear the reset status by writing 1 to the status bit */
 	am33xx_prm_rmw_reg_bits(0xffffffff, mask, inst, rstst_offs);
+
 	/* de-assert the reset control line */
+	mask = 1 << shift;
+
 	am33xx_prm_rmw_reg_bits(mask, 0, inst, rstctrl_offs);
-	/* wait the status to be set */
 
-	omap_test_timeout(am33xx_prm_is_hardreset_asserted(shift, inst,
+	/* wait the status to be set */
+	omap_test_timeout(am33xx_prm_is_hardreset_asserted(st_shift, inst,
 							   rstst_offs),
 			  MAX_MODULE_HARDRESET_WAIT, c);
 
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 3f25c56..181fdab 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -124,6 +124,6 @@ extern void am33xx_prm_global_warm_sw_reset(void);
 extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
 		u16 rstctrl_offs);
 extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
-extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
+extern int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
 		u16 rstctrl_offs, u16 rstst_offs);
 #endif
-- 
1.7.0.4

