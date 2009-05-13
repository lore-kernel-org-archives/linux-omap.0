From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 1/1] ARM: OMAP3: Add missing iva2 clken_pll save/restore
Date: Wed, 13 May 2009 09:48:53 +0300
Message-ID: <1242197333-26981-2-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1242197333-26981-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:13739 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbZEMGsl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2009 02:48:41 -0400
In-Reply-To: <1242197333-26981-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The CM_CLKEN_PLL_IVA2 register was not being saved by the
current prcm save/restore code. This patch adds the proper
save/restore for that register.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/prcm.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index a24792a..4f7fd99 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -54,6 +54,7 @@ struct omap3_prcm_regs {
 	u32 pll_cm_clken2;
 	u32 cm_polctrl;
 	u32 iva2_cm_fclken;
+	u32 iva2_cm_clken_pll;
 	u32 core_cm_fclken1;
 	u32 core_cm_fclken3;
 	u32 sgx_cm_fclken;
@@ -260,6 +261,8 @@ void omap3_prcm_save_context(void)
 	prcm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
 	prcm_context.iva2_cm_fclken =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
+	prcm_context.iva2_cm_clken_pll = cm_read_mod_reg(OMAP3430_IVA2_MOD,
+			OMAP3430_CM_CLKEN_PLL);
 	prcm_context.core_cm_fclken1 =
 			 cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	prcm_context.core_cm_fclken3 =
@@ -414,6 +417,8 @@ void omap3_prcm_restore_context(void)
 	__raw_writel(prcm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
 	cm_write_mod_reg(prcm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
 					 CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.iva2_cm_clken_pll, OMAP3430_IVA2_MOD,
+					OMAP3430_CM_CLKEN_PLL);
 	cm_write_mod_reg(prcm_context.core_cm_fclken1, CORE_MOD, CM_FCLKEN1);
 	cm_write_mod_reg(prcm_context.core_cm_fclken3, CORE_MOD,
 					 OMAP3430ES2_CM_FCLKEN3);
-- 
1.5.4.3

