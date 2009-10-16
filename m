From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 17/17] OMAP3: PM: Force disable OTG autoidle
Date: Fri, 16 Oct 2009 13:49:10 +0300
Message-ID: <1255690150-16853-18-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-14-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-15-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-16-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-17-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19656 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580AbZJPLEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:50 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB3L2F010020
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 06:03:23 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2faB022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:03:02 +0300
In-Reply-To: <1255690150-16853-17-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

OMAP3 sleep can be prevented in some cases where OTG autoidle is enabled.
This patch force disables autoidle during boot and after wakeup from off-mode.
See omap erratas 1.164 and 1.165.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ae83121..5f351f2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -94,6 +94,8 @@ u32 voltage_off_while_idle;
 		OMAP3430_ST_GPT5_MASK|OMAP3430_ST_GPT4_MASK|\
 		OMAP3430_ST_GPT3_MASK|OMAP3430_ST_GPT2_MASK)
 
+#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -423,6 +425,16 @@ static void restore_table_entry(void)
 	restore_control_register(control_reg_value);
 }
 
+static inline void disable_otg_autoidle(void)
+{
+	/*
+	 * OTG autoidle can prevent core domain sleep in some cases, thus
+	 * disable it. See omap erratas 1.164 and 1.165.
+	 */
+	cm_set_mod_reg_bits(OMAP3430_EN_HSOTGUSB, CORE_MOD, CM_ICLKEN1);
+	omap_writel(0x0, OTG_SYSCONFIG);
+}
+
 void omap_sram_idle(void)
 {
 	/* Variable to tell what needs to be saved and restored
@@ -628,6 +640,7 @@ void omap_sram_idle(void)
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
+			disable_otg_autoidle();
 		}
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
@@ -1417,6 +1430,7 @@ static int __init omap3_pm_early_init(void)
 				OMAP3_PRM_POLCTRL_OFFSET);
 
 	configure_vc();
+	disable_otg_autoidle();
 
 	return 0;
 }
-- 
1.5.4.3

