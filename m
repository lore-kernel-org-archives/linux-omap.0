From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v5 4/5] ARM: omap3: Thumb-2 compatibility for sram34xx.S
Date: Fri,  4 Mar 2011 15:33:56 +0000
Message-ID: <1299252837-18074-5-git-send-email-dave.martin@linaro.org>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59135 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759459Ab1CDPea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 10:34:30 -0500
Received: by mail-ww0-f44.google.com with SMTP id 22so2834143wwb.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 07:34:30 -0800 (PST)
In-Reply-To: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

 * Build unconditionally as ARM for correct interoperation with
   OMAP firmware.

 * Remove deprecated PC-relative stores

 * Add the required ENDPROC() directive for each ENTRY().

 * .align before data words

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mach-omap2/sram34xx.S |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 7f893a2..fd1531c 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -34,6 +34,12 @@
 #include "sdrc.h"
 #include "cm2xxx_3xxx.h"
 
+/*
+ * This file needs be built unconditionally as ARM to interoperate correctly
+ * with non-Thumb-2-capable firmware. 
+ */
+	.arm
+
 	.text
 
 /* r1 parameters */
@@ -116,24 +122,36 @@ ENTRY(omap3_sram_configure_core_dpll)
 
 					@ pull the extra args off the stack
 					@  and store them in SRAM
+
+/*
+ * PC-relative stores are deprecated in ARMv7 and lead to undefined behaviour
+ * in Thumb-2: use a r7 as a base instead.
+ * Be careful not to clobber r7 when maintaing this file.
+ */
+ THUMB(	adr	r7, omap3_sram_configure_core_dpll			)
+	.macro strtext Rt:req, label:req
+ ARM(	str	\Rt, \label						)
+ THUMB(	str	\Rt, [r7, \label - omap3_sram_configure_core_dpll]	)
+	.endm
+
 	ldr	r4, [sp, #52]
-	str     r4, omap_sdrc_rfr_ctrl_0_val
+	strtext	r4, omap_sdrc_rfr_ctrl_0_val
 	ldr	r4, [sp, #56]
-	str     r4, omap_sdrc_actim_ctrl_a_0_val
+	strtext	r4, omap_sdrc_actim_ctrl_a_0_val
 	ldr	r4, [sp, #60]
-	str     r4, omap_sdrc_actim_ctrl_b_0_val
+	strtext	r4, omap_sdrc_actim_ctrl_b_0_val
 	ldr	r4, [sp, #64]
-	str     r4, omap_sdrc_mr_0_val
+	strtext	r4, omap_sdrc_mr_0_val
 	ldr	r4, [sp, #68]
-	str     r4, omap_sdrc_rfr_ctrl_1_val
+	strtext	r4, omap_sdrc_rfr_ctrl_1_val
 	cmp	r4, #0			@ if SDRC_RFR_CTRL_1 is 0,
 	beq	skip_cs1_params		@  do not use cs1 params
 	ldr	r4, [sp, #72]
-	str     r4, omap_sdrc_actim_ctrl_a_1_val
+	strtext	r4, omap_sdrc_actim_ctrl_a_1_val
 	ldr	r4, [sp, #76]
-	str     r4, omap_sdrc_actim_ctrl_b_1_val
+	strtext	r4, omap_sdrc_actim_ctrl_b_1_val
 	ldr	r4, [sp, #80]
-	str     r4, omap_sdrc_mr_1_val
+	strtext	r4, omap_sdrc_mr_1_val
 skip_cs1_params:
 	mrc	p15, 0, r8, c1, c0, 0	@ read ctrl register
 	bic	r10, r8, #0x800		@ clear Z-bit, disable branch prediction
@@ -271,6 +289,7 @@ skip_cs1_prog:
 	ldr	r12, [r11]		@ posted-write barrier for SDRC
 	bx	lr
 
+	.align
 omap3_sdrc_power:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 omap3_cm_clksel1_pll:
@@ -319,6 +338,7 @@ omap3_sdrc_dlla_ctrl:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 core_m2_mask_val:
 	.word 0x07FFFFFF
+ENDPROC(omap3_sram_configure_core_dpll)
 
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
-- 
1.7.1

