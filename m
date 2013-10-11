From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/11] ARM: OMAP3: CM/PM: add API for forcing IVA2 clk enable/disable
Date: Fri, 11 Oct 2013 19:15:36 +0300
Message-ID: <1381508141-15244-7-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54097 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab3JKQQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 12:16:27 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP3 PM code directly writes to CM register space to enable/disable IVA2
clock during boot during the IVA2 reset. Direct access shall be avoided,
thus implement an API call for this, and change the PM core to use this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm3xxx.c |   10 ++++++++++
 arch/arm/mach-omap2/cm3xxx.h |    1 +
 arch/arm/mach-omap2/pm34xx.c |    7 +++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index f13742b..55bf939 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -686,6 +686,16 @@ u32 omap3_cm_write_module_clken(s16 module, u8 regs, bool fck, u32 val)
 	return omap3_cm_access_module_clken(module, regs, fck, val, true);
 }
 
+void omap3_cm_force_iva_clk(bool enable)
+{
+	u32 val = 0;
+
+	if (enable)
+		val = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK;
+
+	omap2_cm_write_mod_reg(val, OMAP3430_IVA2_MOD, CM_FCLKEN);
+}
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 2481781..61fdfc7 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -86,6 +86,7 @@ extern void omap3_cm_restore_context(void);
 extern void omap3_cm_save_scratchpad_contents(u32 *ptr);
 extern u32 omap3_cm_write_module_clken(s16 module, u8 regs, bool fck, u32 val);
 extern u32 omap3_cm_read_module_clken(s16 module, u8 regs, bool fck);
+extern void omap3_cm_force_iva_clk(bool enable);
 
 extern int __init omap3xxx_cm_init(void);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f3ba439..ede058a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -412,7 +412,7 @@ restore:
 static void __init omap3_iva_idle(void)
 {
 	/* ensure IVA2 clock is disabled */
-	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+	omap3_cm_force_iva_clk(false);
 
 	/* if no clock activity, nothing else to do */
 	if (!(omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
@@ -426,8 +426,7 @@ static void __init omap3_iva_idle(void)
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Enable IVA2 clock */
-	omap2_cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
-			 OMAP3430_IVA2_MOD, CM_FCLKEN);
+	omap3_cm_force_iva_clk(true);
 
 	/* Set IVA2 boot mode to 'idle' */
 	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
@@ -437,7 +436,7 @@ static void __init omap3_iva_idle(void)
 	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Disable IVA2 clock */
-	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+	omap3_cm_force_iva_clk(false);
 
 	/* Reset IVA2 */
 	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
-- 
1.7.9.5

