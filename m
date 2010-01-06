From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Wed, 6 Jan 2010 13:42:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001061338340.10034@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E0A30D4@dbde02.ent.ti.com> <alpine.DEB.2.00.1001061250030.10034@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40643 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012Ab0AFUmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 15:42:08 -0500
In-Reply-To: <alpine.DEB.2.00.1001061250030.10034@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Wed, 6 Jan 2010, Paul Walmsley wrote:

> On Tue, 5 Jan 2010, Reddy, Teerth wrote:
> 
> > Can you please push this patch if it looks OK to you?
> 
> Thanks queued for .33-rc*.

Well, I take that back.  I must be going senile.  During compile testing, 
your patch generated a compile warning.  This caused heightened scrutiny 
of your patch - no patch should add compile warnings and that should have 
been a red flag when you were working on it.  Please fix the compile 
warning.  Please also make the following changes:

- The assembly language code has no return value; please fix.
- The name of the assembly language code should be something short and
  to the point like 'omap3_sram_warmreset' rather than all the
  'configure_core_dpll' stuff, which does not make sense for this.
- Your multi-line comment is not in CodingStyle form.
- In the existing format of arch/arm/mach-omap2/sram34xx.S, there
  are tabs between assembly language instructions and their arguments,
  but you use spaces.  Please use tabs.
- You need an infinite loop after you write to RM_RSTCTRL.
  That write will be posted and the ARM will just re-execute your
  SDRC idle code which is presumably not what you want.
- Please re-test your patch after the above changes.

To help you understand what I'm looking for, I've done some of the above 
changes; patch below.


- Paul

---
 arch/arm/mach-omap2/prcm.c             |    9 +++--
 arch/arm/mach-omap2/sram34xx.S         |   51 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/sram.h |    7 ++++
 arch/arm/plat-omap/sram.c              |   18 +++++++++++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 3ea8177..d66711e 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -26,6 +26,7 @@
 #include <plat/prcm.h>
 #include <plat/irqs.h>
 #include <plat/control.h>
+#include <plat/sram.h>
 
 #include "clock.h"
 #include "cm.h"
@@ -134,9 +135,10 @@ void omap_prcm_arch_reset(char mode)
 	s16 prcm_offs;
 	omap2_clk_prepare_for_reboot();
 
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap24xx()) {
 		prcm_offs = WKUP_MOD;
-	else if (cpu_is_omap34xx()) {
+		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
+	} else if (cpu_is_omap34xx()) {
 		u32 l;
 
 		prcm_offs = OMAP3430_GR_MOD;
@@ -147,10 +149,9 @@ void omap_prcm_arch_reset(char mode)
 		 * cf. OMAP34xx TRM, Initialization / Software Booting
 		 * Configuration. */
 		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
+		omap3_warmreset();
 	} else
 		WARN_ON(1);
-
-	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
 }
 
 static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index de99ba2..432777a 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -33,6 +33,8 @@
 
 #include "sdrc.h"
 #include "cm.h"
+#include "prcm-common.h"
+#include "prm.h"
 
 	.text
 
@@ -68,6 +70,9 @@
 /* CM_CLKSEL1_PLL bit settings */
 #define CORE_DPLL_CLKOUT_DIV_SHIFT	0x1b
 
+/* PRM_RSTCTRL bit setting */
+#define EN_DPLL3_RESET                  0x4
+
 /*
  * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
  *
@@ -313,3 +318,49 @@ core_m2_mask_val:
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
 
+
+/*
+ * omap3_sram_warmreset
+ * Enable SDRC self refresh on idle request, put SDRC in idle,
+ * wait until SDRC goes to idle
+ * Enable DPLL3 reset bit in RM_RSTCTRL
+ */
+
+ENTRY(omap3_sram_warmreset)
+
+sdram_in_selfrefresh1:
+	ldr	r11, omap3_sdrc_power1	@ read the SDRC_POWER register
+	ldr	r12, [r11]		@ read the contents of SDRC_POWER
+	mov	r9, r12			@ keep a copy of SDRC_POWER bits
+	orr	r12, r12, #SRFRONIDLEREQ_MASK	@ enable self refresh on idle
+	str	r12, [r11]		@ write back to SDRC_POWER register
+	ldr	r12, [r11]		@ posted-write barrier for SDRC
+	ldr	r11, omap3_cm_iclken1_core1	@ read the CM_ICLKEN1_CORE reg
+	ldr	r12, [r11]
+	bic	r12, r12, #EN_SDRC_MASK		@ disable iclk bit for SDRC
+	str	r12, [r11]
+wait_sdrc_idle2:
+	ldr	r11, omap3_cm_idlest1_core1
+	ldr	r12, [r11]
+	and	r12, r12, #ST_SDRC_MASK		@ check for SDRC idle
+	cmp	r12, #ST_SDRC_MASK
+	bne	wait_sdrc_idle2
+osw_warm_reset:
+	ldr	r11, omap3_reset_cntrl
+	ldr	r12, [r11]
+	orr	r12, r12, #EN_DPLL3_RESET	@ Enable DPLL3 reset bit
+	str	r12, [r11]
+osw_loop:
+	b	osw_loop
+
+omap3_reset_cntrl:
+	.word OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, RM_RSTCTRL)
+omap3_sdrc_power1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
+omap3_cm_idlest1_core1:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
+omap3_cm_iclken1_core1:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
+	
+ENTRY(omap3_sram_warmreset_sz)
+	.word   . - omap3_sram_warmreset
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index 16a1b45..f39f07a 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -27,6 +27,9 @@ extern u32 omap3_configure_core_dpll(
 			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
 			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+
+extern void omap3_warmreset(void);
+
 extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
@@ -69,6 +72,10 @@ extern u32 omap3_sram_configure_core_dpll(
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
 
+extern u32 omap3_sram_warmreset(void);
+
+extern unsigned long omap3_sram_warmreset_sz;
+
 #ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
 #else
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index d8d5094..690314d 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -410,6 +410,17 @@ u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
 			sdrc_actim_ctrl_b_1, sdrc_mr_1);
 }
 
+/* Function for SDRC config for warm reset */
+static u32 (*_omap3_sram_warmreset)(void);
+
+void omap3_warmreset()
+{
+	if (WARN_ON(!_omap3_sram_warmreset))
+		return;
+
+	return;
+}
+
 #ifdef CONFIG_PM
 void omap3_sram_restore_context(void)
 {
@@ -418,6 +429,9 @@ void omap3_sram_restore_context(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+	_omap3_sram_warmreset = omap_sram_push(omap3_sram_warmreset,
+					       omap3_sram_warmreset_sz);
+
 	omap_push_sram_idle();
 }
 #endif /* CONFIG_PM */
@@ -427,6 +441,10 @@ int __init omap34xx_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+
+	_omap3_sram_warmreset = omap_sram_push(omap3_sram_warmreset,
+					       omap3_sram_warmreset_sz);
+
 	omap_push_sram_idle();
 	return 0;
 }
-- 
1.6.6.rc2.5.g49666

