From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 19/28] OMAP3: PM: Save and restore also CM_CLKSEL1_PLL_IVA2
Date: Thu,  1 Oct 2009 16:58:49 -0700
Message-ID: <1254441538-9257-20-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-17-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-18-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-19-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58920 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbZJAX72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:28 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so574597pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:33 -0700 (PDT)
In-Reply-To: <1254441538-9257-19-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

CM_CLKSEL1_PLL_IVA2 is not saved/restored currently. This patch is
adding save and restore for it.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/prcm.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 9322447..99ff439 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -39,6 +39,7 @@ static void __iomem *cm_base;
 
 struct omap3_prcm_regs {
 	u32 control_padconf_sys_nirq;
+	u32 iva2_cm_clksel1;
 	u32 iva2_cm_clksel2;
 	u32 cm_sysconfig;
 	u32 sgx_cm_clksel;
@@ -261,6 +262,8 @@ void omap3_prcm_save_context(void)
 {
 	prcm_context.control_padconf_sys_nirq =
 			 omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	prcm_context.iva2_cm_clksel1 =
+			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
 	prcm_context.iva2_cm_clksel2 =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
 	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
@@ -414,6 +417,8 @@ void omap3_prcm_restore_context(void)
 {
 	omap_ctrl_writel(prcm_context.control_padconf_sys_nirq,
 					 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	cm_write_mod_reg(prcm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
+					 CM_CLKSEL1);
 	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
 					 CM_CLKSEL2);
 	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
-- 
1.6.4.3

