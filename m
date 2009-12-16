From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall in
 SDRC after a Warm-reset
Date: Wed, 16 Dec 2009 16:12:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9A2ED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59920 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760125AbZLPKmw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 05:42:52 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBGAgm60020434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 04:42:51 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBGAgmFk025248
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 16:12:48 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Updated with Kevin's comments.


From: Teerth Reddy <teerth@ti.com>

This patch has the workaround for errata 1.176.
In some cases, user is not able to access DDR memory after
warm-reset.This situation occurs while the warm-reset
happens during a read access to DDR memory. In that 
particular conditions, DDR memory does not respond to a 
corrupted read command due to the warm reset occurence but
SDRC is waiting for read completion.SDRC is not sensitive to
the warm reset, but the interconect is reset on the fly, 
thus causing a misalignment between SDRC logic, interconect
logic and DDR memory state.

Root cause description: A corrupted read transaction is 
issued to a closed row: (address0, bank0) instead of the 
expected read access, violating protocol.

Failure signature: Once the failure occurs and system has 
restarted, memory content is not accessible.SDRC registers 
can be accessed successfully, until 1st access to memory 
location is performed. After 1st access to memory is done,
SDRC is stuck.

WORKAROUND
Steps to perform before a SW reset is trigged, if user needs
to generate a SW reset and keep DDR memory content:
1. Enable self-refresh on idle request
2. Put SDRC in idle
3. Wait until SDRC goes to idle
4. Generate SW reset

Steps to perform after warm reset occurs:
If HW warm reset is the source, apply below steps before 
any accesses to SDRAM:
1. Reset SMS and SDRC
2. Re-initialize SMS, SDRC and memory

This would need the u-boot/x-loader workaround changes
as well for the reboot to work correctly.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/prcm.c             |    9 +++--
 arch/arm/mach-omap2/sram34xx.S         |   50 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/sram.h |    7 ++++
 arch/arm/plat-omap/sram.c              |   20 +++++++++++++
 4 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 3ea8177..0dedd91 100644
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
+		omap3_configure_core_dpll_warmreset();
 	} else
 		WARN_ON(1);
-
-	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
 }
 
 static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index de99ba2..0294b0f 100644
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
@@ -313,3 +318,48 @@ core_m2_mask_val:
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
 
+
+/* omap3_sram_configure_core_dpll_warmreset
+* Enable SDRC self refresh on idle request, put SDRC in idle,
+* wait until SDRC goes to idle
+* Enable DPLL3 reset bit in RM_RSTCTRL
+*/
+
+ENTRY(omap3_sram_configure_core_dpll_warmreset)
+
+	bl      sdram_in_selfrefresh1
+	ldr     r11, omap3_reset_cntrl
+	ldr     r12, [r11]
+	orr     r12, r12, #EN_DPLL3_RESET       @ Enable DPLL3 reset bit
+	str     r12, [r11]
+
+sdram_in_selfrefresh1:
+	ldr     r11, omap3_sdrc_power1  @ read the SDRC_POWER register
+	ldr     r12, [r11]              @ read the contents of SDRC_POWER
+	mov     r9, r12                 @ keep a copy of SDRC_POWER bits
+	orr     r12, r12, #SRFRONIDLEREQ_MASK   @ enable self refresh on idle
+	str     r12, [r11]              @ write back to SDRC_POWER register
+	ldr     r12, [r11]              @ posted-write barrier for SDRC
+	ldr     r11, omap3_cm_iclken1_core1     @ read the CM_ICLKEN1_CORE reg
+	ldr     r12, [r11]
+	bic     r12, r12, #EN_SDRC_MASK         @ disable iclk bit for SDRC
+	str     r12, [r11]
+wait_sdrc_idle2:
+	ldr     r11, omap3_cm_idlest1_core1
+	ldr     r12, [r11]
+	and     r12, r12, #ST_SDRC_MASK         @ check for SDRC idle
+	cmp     r12, #ST_SDRC_MASK
+	bne     wait_sdrc_idle2
+	bx      lr
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
+ENTRY(omap3_sram_configure_core_dpll_warmreset_sz)
+	.word   . - omap3_sram_configure_core_dpll_warmreset
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index 16a1b45..01187d6 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -27,6 +27,9 @@ extern u32 omap3_configure_core_dpll(
 			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
 			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+
+extern u32 omap3_configure_core_dpll_warmreset(void);
+
 extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
@@ -69,6 +72,10 @@ extern u32 omap3_sram_configure_core_dpll(
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
 
+extern u32 omap3_sram_configure_core_dpll_warmreset(void);
+
+extern unsigned long omap3_sram_configure_core_dpll_warmreset_sz;
+
 #ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
 #else
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index d8d5094..a8fee8b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -410,6 +410,17 @@ u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
 			sdrc_actim_ctrl_b_1, sdrc_mr_1);
 }
 
+/* Function for SDRC config for warm reset */
+static u32 (*_omap3_sram_configure_core_dpll_warmreset)(void);
+
+u32 omap3_configure_core_dpll_warmreset()
+{
+	if (WARN_ON(!_omap3_sram_configure_core_dpll_warmreset))
+		return;
+
+	return _omap3_sram_configure_core_dpll_warmreset();
+}
+
 #ifdef CONFIG_PM
 void omap3_sram_restore_context(void)
 {
@@ -418,6 +429,10 @@ void omap3_sram_restore_context(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+	_omap3_sram_configure_core_dpll_warmreset =
+	omap_sram_push(omap3_sram_configure_core_dpll_warmreset,
+		       omap3_sram_configure_core_dpll_warmreset_sz);
+
 	omap_push_sram_idle();
 }
 #endif /* CONFIG_PM */
@@ -427,6 +442,11 @@ int __init omap34xx_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+
+	_omap3_sram_configure_core_dpll_warmreset =
+	omap_sram_push(omap3_sram_configure_core_dpll_warmreset,
+		       omap3_sram_configure_core_dpll_warmreset_sz);
+
 	omap_push_sram_idle();
 	return 0;
 }
