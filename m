From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/7] 34XX: PM: Workaround to enable autoidle for clocks
 and plls
Date: Wed, 25 Jun 2008 20:30:20 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806252027260.25954@utopia.booyaka.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com> <1214385223-25597-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32956 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYFZCaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 22:30:21 -0400
In-Reply-To: <1214385223-25597-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Jouni,

On Wed, 25 Jun 2008, Jouni Hogander wrote:

> +	/* XXX Set all plls to autoidle. This is needed until autoidle is
> +	 * enabled by clockfw */
> +	cm_write_mod_reg(1 << OMAP3430_CLKTRCTRL_IVA2_SHIFT,
> +			 OMAP3430_IVA2_MOD,
> +			 CM_AUTOIDLE2);
> +	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
> +			 MPU_MOD,
> +			 CM_AUTOIDLE2);
> +	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
> +			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
> +			 PLL_MOD,
> +			 CM_AUTOIDLE);
> +	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
> +			 PLL_MOD,
> +			 CM_AUTOIDLE2);

for the DPLLs, there is code to do this already in the clock framework - 
see omap3_dpll_allow_idle() in arch/arm/mach-omap2/clock34xx.c


- Paul
