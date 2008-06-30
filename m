From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 6/6] 34XX: PM: Workaround to enable autoidle for clocks and plls
Date: Mon, 30 Jun 2008 11:52:54 +0300
Message-ID: <1214815974-23216-1-git-send-email-jouni.hogander@nokia.com>
References: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57696 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYF3IxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 04:53:09 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5U8qxCM006197
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 11:53:07 +0300
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5U8qshm002810
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 11:52:54 +0300
In-Reply-To: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This workaround enables autoidle for interface clocks and plls. Also
automatic control of external oscillator through sys_clkreq is
enabled.

Proper fix to this is to generalize omap3_dpll_allow_idle,
omap3_dpll_deny_idle, omap3_dpll_autoidle_read and call it for each
clock on init.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |  120 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e1799a5..2008665 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -433,6 +433,126 @@ static void __init prcm_setup_regs(void)
 	} else
 		prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
 
+	/* XXX Enable interface clock autoidle for all modules. This
+	 * should be done by clockfw */
+	cm_write_mod_reg(
+		OMAP3430ES2_AUTO_MMC3 |
+		OMAP3430ES2_AUTO_ICR |
+		OMAP3430_AUTO_AES2 |
+		OMAP3430_AUTO_SHA12 |
+		OMAP3430_AUTO_DES2 |
+		OMAP3430_AUTO_MMC2 |
+		OMAP3430_AUTO_MMC1 |
+		OMAP3430_AUTO_MSPRO |
+		OMAP3430_AUTO_HDQ |
+		OMAP3430_AUTO_MCSPI4 |
+		OMAP3430_AUTO_MCSPI3 |
+		OMAP3430_AUTO_MCSPI2 |
+		OMAP3430_AUTO_MCSPI1 |
+		OMAP3430_AUTO_I2C3 |
+		OMAP3430_AUTO_I2C2 |
+		OMAP3430_AUTO_I2C1 |
+		OMAP3430_AUTO_UART2 |
+		OMAP3430_AUTO_UART1 |
+		OMAP3430_AUTO_GPT11 |
+		OMAP3430_AUTO_GPT10 |
+		OMAP3430_AUTO_MCBSP5 |
+		OMAP3430_AUTO_MCBSP1 |
+		OMAP3430ES1_AUTO_FAC | /* This is es1 only */
+		OMAP3430_AUTO_MAILBOXES |
+		OMAP3430_AUTO_OMAPCTRL |
+		OMAP3430ES1_AUTO_FSHOSTUSB |
+		OMAP3430_AUTO_HSOTGUSB |
+		OMAP3430ES1_AUTO_D2D | /* This is es1 only */
+		OMAP3430_AUTO_SSI,
+		CORE_MOD, CM_AUTOIDLE1);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_PKA |
+		OMAP3430_AUTO_AES1 |
+		OMAP3430_AUTO_RNG |
+		OMAP3430_AUTO_SHA11 |
+		OMAP3430_AUTO_DES1,
+		CORE_MOD, CM_AUTOIDLE2);
+
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		cm_write_mod_reg(
+			OMAP3430ES2_AUTO_USBTLL,
+			CORE_MOD, CM_AUTOIDLE3);
+	}
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_WDT2 |
+		OMAP3430_AUTO_WDT1 |
+		OMAP3430_AUTO_GPIO1 |
+		OMAP3430_AUTO_32KSYNC |
+		OMAP3430_AUTO_GPT12 |
+		OMAP3430_AUTO_GPT1 ,
+		WKUP_MOD, CM_AUTOIDLE);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_DSS,
+		OMAP3430_DSS_MOD,
+		CM_AUTOIDLE);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_CAM,
+		OMAP3430_CAM_MOD,
+		CM_AUTOIDLE);
+
+	cm_write_mod_reg(
+		OMAP3430_AUTO_GPIO6 |
+		OMAP3430_AUTO_GPIO5 |
+		OMAP3430_AUTO_GPIO4 |
+		OMAP3430_AUTO_GPIO3 |
+		OMAP3430_AUTO_GPIO2 |
+		OMAP3430_AUTO_WDT3 |
+		OMAP3430_AUTO_UART3 |
+		OMAP3430_AUTO_GPT9 |
+		OMAP3430_AUTO_GPT8 |
+		OMAP3430_AUTO_GPT7 |
+		OMAP3430_AUTO_GPT6 |
+		OMAP3430_AUTO_GPT5 |
+		OMAP3430_AUTO_GPT4 |
+		OMAP3430_AUTO_GPT3 |
+		OMAP3430_AUTO_GPT2 |
+		OMAP3430_AUTO_MCBSP4 |
+		OMAP3430_AUTO_MCBSP3 |
+		OMAP3430_AUTO_MCBSP2,
+		OMAP3430_PER_MOD,
+		CM_AUTOIDLE);
+
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		cm_write_mod_reg(
+			OMAP3430ES2_AUTO_USBHOST,
+			OMAP3430ES2_USBHOST_MOD,
+			CM_AUTOIDLE);
+	}
+
+	/* XXX Set all plls to autoidle. This is needed until autoidle is
+	 * enabled by clockfw */
+	cm_write_mod_reg(1 << OMAP3430_CLKTRCTRL_IVA2_SHIFT,
+			 OMAP3430_IVA2_MOD,
+			 CM_AUTOIDLE2);
+	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
+			 MPU_MOD,
+			 CM_AUTOIDLE2);
+	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
+			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
+			 PLL_MOD,
+			 CM_AUTOIDLE);
+	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
+			 PLL_MOD,
+			 CM_AUTOIDLE2);
+
+	/* XXX Enable control of expternal oscillator through
+	 * sys_clkreq. I think clockfw should provide means to do this
+	 */
+	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
+			     1 << OMAP_AUTOEXTCLKMODE_SHIFT,
+			     OMAP3430_GR_MOD,
+			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+
 	/* setup wakup source */
 	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1,
 			  WKUP_MOD, PM_WKEN);
-- 
1.5.5

