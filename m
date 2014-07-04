From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/10] ARM: OMAP3: PRM: add API for saving PRM scratchpad contents
Date: Fri, 4 Jul 2014 17:10:30 +0300
Message-ID: <1404483035-21666-6-git-send-email-t-kristo@ti.com>
References: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52124 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbaGDOKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2014 10:10:41 -0400
In-Reply-To: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This isolates the PRM register access within the PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   11 ++---------
 arch/arm/mach-omap2/prm3xxx.c |    9 +++++++++
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index f8eb3e4..8308094 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -44,8 +44,7 @@ struct omap3_scratchpad {
 };
 
 struct omap3_scratchpad_prcm_block {
-	u32 prm_clksrc_ctrl;
-	u32 prm_clksel;
+	u32 prm_contents[2];
 	u32 cm_contents[11];
 	u32 prcm_block_size;
 };
@@ -327,13 +326,7 @@ void omap3_save_scratchpad_contents(void)
 	scratchpad_contents.sdrc_block_offset = 0x64;
 
 	/* Populate the PRCM block contents */
-	prcm_block_contents.prm_clksrc_ctrl =
-		omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
-				       OMAP3_PRM_CLKSRC_CTRL_OFFSET);
-	prcm_block_contents.prm_clksel =
-		omap2_prm_read_mod_reg(OMAP3430_CCR_MOD,
-				       OMAP3_PRM_CLKSEL_OFFSET);
-
+	omap3_prm_save_scratchpad_contents(prcm_block_contents.prm_contents);
 	omap3_cm_save_scratchpad_contents(prcm_block_contents.cm_contents);
 
 	prcm_block_contents.prcm_block_size = 0x0;
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 4733c28..4d93b84 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -409,6 +409,15 @@ int omap3xxx_prm_clear_global_cold_reset(void)
 	return 0;
 }
 
+void omap3_prm_save_scratchpad_contents(u32 *ptr)
+{
+	*ptr++ = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+
+	*ptr++ = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_CLKSEL_OFFSET);
+}
+
 /* Powerdomain low-level functions */
 
 static int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 7548ae0..c5f9cba 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -166,6 +166,7 @@ int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
 void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
+void omap3_prm_save_scratchpad_contents(u32 *ptr);
 
 #endif /* __ASSEMBLER */
 
-- 
1.7.9.5

