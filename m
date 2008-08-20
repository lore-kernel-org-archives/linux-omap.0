From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] 34XX: PM: Workaround to enable autoidle for clocks
	and plls
Date: Wed, 20 Aug 2008 14:51:48 +0300
Message-ID: <20080820115147.GE29374@atomide.com>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com> <1218786441-28108-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63381 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYHTLvw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 07:51:52 -0400
Content-Disposition: inline
In-Reply-To: <1218786441-28108-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jouni Hogander <jouni.hogander@nokia.com> [080815 10:47]:
> From: ext Jouni Hogander <jouni.hogander@nokia.com>
> 
> This workaround enables autoidle for interface clocks and plls. Also
> automatic control of external oscillator through sys_clkreq is
> enabled.
> 
> Proper fix to this is to generalize omap3_dpll_allow_idle,
> omap3_dpll_deny_idle, omap3_dpll_autoidle_read and call it for each
> clock on init.

How about this prettified version? I doubt that we'll get to changing
the clock fwk for this until in about six months or so.

Tony

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=pm-34xx-autoidle

>From 558b9c500eb66b744bfa45eaf83ea501e7343e3c Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Aug 2008 14:50:14 +0300
Subject: [PATCH] From: ext Jouni Hogander <jouni.hogander@nokia.com>

ARM: OMAP: Enable 34xx autoidle for clocks and plls

Enable autoidle for interface clocks and plls. Also automatic
control of external oscillator through sys_clkreq is enabled.

In the long term, proper solution is to generalize
omap3_dpll_allow_idle, omap3_dpll_deny_idle,
omap3_dpll_autoidle_read and call it for each clock on init.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a145f80..a16eb33 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -383,6 +383,132 @@ static void __init prcm_setup_regs(void)
 	} else
 		prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
 
+	/*
+	 * Enable interface clock autoidle for all modules.
+	 * Note that in the long run this should be done by clockfw
+	 */
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
+	/*
+	 * Set all plls to autoidle. This is needed until autoidle is
+	 * enabled by clockfw
+	 */
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
+	/*
+	 * Enable control of expternal oscillator through
+	 * sys_clkreq. In the long run clock framework should
+	 * take care of this.
+	 */
+	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
+			     1 << OMAP_AUTOEXTCLKMODE_SHIFT,
+			     OMAP3430_GR_MOD,
+			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+
 	/* setup wakup source */
 	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1,
 			  WKUP_MOD, PM_WKEN);

--wq9mPyueHGvFACwf--
