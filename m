From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 5/7] omap: dpll: Enable all OMAP3/4 dpll autoidle late
 at boot
Date: Mon, 14 Feb 2011 18:02:02 +0530
Message-ID: <ee3e93f406daf1a283b8d551f57933e3@mail.gmail.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
 <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com>
 <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102121741340.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33746 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753975Ab1BNMcT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 07:32:19 -0500
Received: by fxm16 with SMTP id 16so5543762fxm.27
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 04:32:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102121741340.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Sunday, February 13, 2011 6:13 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com; khilman@ti.com;
santosh.shilimkar@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 5/7] omap: dpll: Enable all OMAP3/4 dpll autoidle
late at boot
>
> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
>
> > Enable all dpll autoidle for OMAP4 and OMAP3 (OMAP3
> > already had dpll autoidle turned on, but was done
> > using low level cm accessor apis).
> > On OMAP3, replace the cm accessor apis doing this
> > with the now available support for doing this in
> > clock framework, using omap_clk_enable_autoidle().
>
> I propose this patch instead.  What do you think?  Care to reply with a
> Reviewed-by: and/or Tested-by: ?

I agree, this is a better approach than what I proposed
in my patch.
Since I already tested the clk_autoidle_a_2.6.39 branch
which also has this patch included, you can add a
Tested-by: Rajendra Nayak <rnayak@ti.com>

Regards,
Rajendra

>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sat, 12 Feb 2011 17:36:38 -0600
> Subject: [PATCH] OMAP2+: clock: autoidle as many clocks as possible in
OMAP2+-common PM code
>
> Attempt to enable autoidle for as many clocks as possible in the
> OMAP2+-common PM code.  Currently, this only enables DPLL autoidle for
> OMAP3/4 DPLLs; but it should also eventually enable autoidle for other
> clocks and the OMAP2 DPLL/APLLs.
>
> Based on a patch by Rajendra Nayak <rnayak@ti.com> that did this in
> the pm34xx.c/pm44xx.c code, rather than the common PM code.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/pm.c     |    8 ++++++++
>  arch/arm/mach-omap2/pm34xx.c |   17 -----------------
>  2 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d5a102c..b507702 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -262,6 +262,14 @@ static int __init omap2_common_pm_late_init(void)
>  	/* Smartreflex device init */
>  	omap_devinit_smartreflex();
>
> +	/*
> +	 * Set all OMAP3/4 DPLLs to autoidle.
> +	 * XXX TODO: Add all the iclk autoidles in here as well,
> +	 * the OMAP2 DPLL, the OMAP2 APLLs, and the AUTOEXTCLKMODE
> +	 * control here too.
> +	 */
> +	omap_clk_enable_autoidle_all();
> +
>  	return 0;
>  }
>  late_initcall(omap2_common_pm_late_init);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 2f864e4..1fe2e73 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -814,23 +814,6 @@ static void __init prcm_setup_regs(void)
>  	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
>
>  	/*
> -	 * Set all plls to autoidle. This is needed until autoidle is
> -	 * enabled by clockfw
> -	 */
> -	omap2_cm_write_mod_reg(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
> -			 OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
> -	omap2_cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
> -			 MPU_MOD,
> -			 CM_AUTOIDLE2);
> -	omap2_cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
> -			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
> -			 PLL_MOD,
> -			 CM_AUTOIDLE);
> -	omap2_cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
> -			 PLL_MOD,
> -			 CM_AUTOIDLE2);
> -
> -	/*
>  	 * Enable control of expternal oscillator through
>  	 * sys_clkreq. In the long run clock framework should
>  	 * take care of this.
> --
> 1.7.2.3
