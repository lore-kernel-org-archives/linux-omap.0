From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM 1/1] OMAP3: PM: Save and restore also CM_CLKSEL1_PLL_IVA2
Date: Thu,  5 Feb 2009 13:34:01 +0200
Message-ID: <1233833641-5329-2-git-send-email-jouni.hogander@nokia.com>
References: <1233833641-5329-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57391 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbZBELeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 06:34:19 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n15BXwBH015937
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 05:34:16 -0600
Received: from localhost.localdomain (trdhcp147193.ntc.nokia.com [172.22.147.193])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n15BVnvH013689
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 13:31:51 +0200
In-Reply-To: <1233833641-5329-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

CM_CLKSEL1_PLL_IVA2 is not saved/restored currently. This patch is
adding save and restore for it.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/prcm.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c64b668..7ccaf7f 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -36,6 +36,7 @@ static void __iomem *cm_base;
 
 struct omap3_prcm_regs {
 	u32 control_padconf_sys_nirq;
+	u32 iva2_cm_clksel1;
 	u32 iva2_cm_clksel2;
 	u32 cm_sysconfig;
 	u32 sgx_cm_clksel;
@@ -218,6 +219,8 @@ void omap3_prcm_save_context(void)
 {
 	prcm_context.control_padconf_sys_nirq =
 			 omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	prcm_context.iva2_cm_clksel1 =
+			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
 	prcm_context.iva2_cm_clksel2 =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
 	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
@@ -371,6 +374,8 @@ void omap3_prcm_restore_context(void)
 {
 	omap_ctrl_writel(prcm_context.control_padconf_sys_nirq,
 					 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	cm_write_mod_reg(prcm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
+					 CM_CLKSEL1);
 	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
 					 CM_CLKSEL2);
 	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
-- 
1.6.0.1

