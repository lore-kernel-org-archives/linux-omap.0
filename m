From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/11] ARM: OMAP3: CM/PM: add API for accessing module clock enable registers
Date: Fri, 11 Oct 2013 19:15:35 +0300
Message-ID: <1381508141-15244-6-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54830 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754845Ab3JKQQZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:25 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

PRCM chain handler needs these to properly acknowledge wakeup events.
Currently this functionality is implemented as direct register accesses,
but as the CM code should eventually move to its own driver, separate
API calls are now added for this purpose. PM core code is also changed
to use these APIs.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm3xxx.c |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm3xxx.h |    2 ++
 arch/arm/mach-omap2/pm34xx.c |   16 ++++++++--------
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index f6f0288..f13742b 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -658,6 +658,34 @@ void omap3_cm_save_scratchpad_contents(u32 *ptr)
 	*ptr++ = omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL);
 }
 
+static u32 omap3_cm_access_module_clken(s16 module, u8 regs, bool fck, u32 val,
+					bool write)
+{
+	u16 offset;
+
+	if (fck)
+		offset = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
+	else
+		offset = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
+
+	if (write)
+		omap2_cm_write_mod_reg(val, module, offset);
+	else
+		val = omap2_cm_read_mod_reg(module, offset);
+
+	return val;
+}
+
+u32 omap3_cm_read_module_clken(s16 module, u8 regs, bool fck)
+{
+	return omap3_cm_access_module_clken(module, regs, fck, 0, false);
+}
+
+u32 omap3_cm_write_module_clken(s16 module, u8 regs, bool fck, u32 val)
+{
+	return omap3_cm_access_module_clken(module, regs, fck, val, true);
+}
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 8224c91..2481781 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -84,6 +84,8 @@ extern int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 extern void omap3_cm_save_context(void);
 extern void omap3_cm_restore_context(void);
 extern void omap3_cm_save_scratchpad_contents(u32 *ptr);
+extern u32 omap3_cm_write_module_clken(s16 module, u8 regs, bool fck, u32 val);
+extern u32 omap3_cm_read_module_clken(s16 module, u8 regs, bool fck);
 
 extern int __init omap3xxx_cm_init(void);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5a2d803..f3ba439 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -146,8 +146,6 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 {
 	u32 wkst, fclk, iclk, clken;
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
-	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
-	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
 	u16 grpsel_off = (regs == 3) ?
 		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
 	int c = 0;
@@ -156,25 +154,27 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
 	wkst &= ~ignore_bits;
 	if (wkst) {
-		iclk = omap2_cm_read_mod_reg(module, iclk_off);
-		fclk = omap2_cm_read_mod_reg(module, fclk_off);
+		iclk = omap3_cm_read_module_clken(module, regs, false);
+		fclk = omap3_cm_read_module_clken(module, regs, true);
 		while (wkst) {
 			clken = wkst;
-			omap2_cm_set_mod_reg_bits(clken, module, iclk_off);
+			omap3_cm_write_module_clken(module, regs, false,
+						    iclk | clken);
 			/*
 			 * For USBHOST, we don't know whether HOST1 or
 			 * HOST2 woke us up, so enable both f-clocks
 			 */
 			if (module == OMAP3430ES2_USBHOST_MOD)
 				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
-			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
+			omap3_cm_write_module_clken(module, regs, true,
+						    fclk | clken);
 			omap2_prm_write_mod_reg(wkst, module, wkst_off);
 			wkst = omap2_prm_read_mod_reg(module, wkst_off);
 			wkst &= ~ignore_bits;
 			c++;
 		}
-		omap2_cm_write_mod_reg(iclk, module, iclk_off);
-		omap2_cm_write_mod_reg(fclk, module, fclk_off);
+		omap3_cm_write_module_clken(module, regs, false, iclk);
+		omap3_cm_write_module_clken(module, regs, true, fclk);
 	}
 
 	return c;
-- 
1.7.9.5

