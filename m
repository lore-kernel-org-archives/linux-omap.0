From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/26] ARM: OMAP2/3: CM: make cm_split_idlest_reg SoC calls static
Date: Mon, 1 Sep 2014 21:08:59 +0300
Message-ID: <1409594955-1476-11-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624AbaIASKC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:02 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

CM driver has a generic API which calls the SoC specific split function
through cm_ll_data, so there is no need for the SoC specific functions to
be publicly available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c |    5 +++--
 arch/arm/mach-omap2/cm2xxx.h |    2 --
 arch/arm/mach-omap2/cm3xxx.c |    5 +++--
 arch/arm/mach-omap2/cm3xxx.h |    3 ---
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 365df9e..a96d901 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -204,8 +204,9 @@ void omap2xxx_cm_apll96_disable(void)
  * XXX This function is only needed until absolute register addresses are
  * removed from the OMAP struct clk records.
  */
-int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
-				 u8 *idlest_reg_id)
+static int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+					s16 *prcm_inst,
+					u8 *idlest_reg_id)
 {
 	unsigned long offs;
 	u8 idlest_offs;
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index a14094b..c89502b 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -56,8 +56,6 @@ extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
 
 int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
 				  u8 idlest_shift);
-extern int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
-					s16 *prcm_inst, u8 *idlest_reg_id);
 extern int omap2xxx_cm_fclks_active(void);
 extern int omap2xxx_cm_mpu_retention_allowed(void);
 extern u32 omap2xxx_cm_get_core_clk_src(void);
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index a29c2bf..c6622b7 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -118,8 +118,9 @@ static int omap3xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
  * XXX This function is only needed until absolute register addresses are
  * removed from the OMAP struct clk records.
  */
-int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
-				 u8 *idlest_reg_id)
+static int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+					s16 *prcm_inst,
+					u8 *idlest_reg_id)
 {
 	unsigned long offs;
 	u8 idlest_offs;
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 33491c7..734a858 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -68,9 +68,6 @@
 
 #ifndef __ASSEMBLER__
 
-extern int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
-					s16 *prcm_inst, u8 *idlest_reg_id);
-
 extern void omap3_cm_save_context(void);
 extern void omap3_cm_restore_context(void);
 extern void omap3_cm_save_scratchpad_contents(u32 *ptr);
-- 
1.7.9.5

