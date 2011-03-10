From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] omap2plus: clock: Add an alias cpu_ck to be used in common cpufreq driver
Date: Thu, 10 Mar 2011 14:13:29 -0800
Message-ID: <87zkp2hbee.fsf@ti.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
	<1298614239-32196-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51760 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751158Ab1CJWNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 17:13:33 -0500
Received: by mail-qy0-f181.google.com with SMTP id 14so1958437qyg.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 14:13:32 -0800 (PST)
In-Reply-To: <1298614239-32196-2-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 25 Feb 2011 11:40:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, vishwanath.bs@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Add an alias clock node for cpu clock control on all OMAP2PLUS devices.
> The intention is avoid cpu_is_xxxx() checks in the common cpufreq driver.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Rather than having hard-coded clkdev nodes, Since CPUfreq will be the
only user of these clocks, it might make sense to just use cpu_is_* in
the CPUfreq init and do clk_add_alias().

> ---
>  arch/arm/mach-omap2/clock2420_data.c |    1 +
>  arch/arm/mach-omap2/clock2430_data.c |    1 +
>  arch/arm/mach-omap2/clock3xxx_data.c |    1 +
>  arch/arm/mach-omap2/clock44xx_data.c |    1 +
>  4 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
> index 0a992bc..3efe45b 100644
> --- a/arch/arm/mach-omap2/clock2420_data.c
> +++ b/arch/arm/mach-omap2/clock2420_data.c
> @@ -1799,6 +1799,7 @@ static struct omap_clk omap2420_clks[] = {
>  	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
>  	/* virtual meta-group clock */
>  	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
> +	CLK(NULL,	"cpu_ck", &virt_prcm_set, CK_242X),

Are there any other users of virt_prcm_set?  Probably could get rid of
it now.

>  	/* general l4 interface ck, multi-parent functional clk */
>  	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
>  	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
> diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
> index c047dcd..25b1c2d 100644
> --- a/arch/arm/mach-omap2/clock2430_data.c
> +++ b/arch/arm/mach-omap2/clock2430_data.c
> @@ -1903,6 +1903,7 @@ static struct omap_clk omap2430_clks[] = {
>  	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X),
>  	/* virtual meta-group clock */
>  	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
> +	CLK(NULL,	"cpu_ck", &virt_prcm_set, CK_243X),

ditto

>  	/* general l4 interface ck, multi-parent functional clk */
>  	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
>  	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index 403a4a1..655d1a9 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3224,6 +3224,7 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_3XXX),
>  	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_3XXX),
>  	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_3XXX),
> +	CLK(NULL,	"cpu_ck",	&dpll1_ck,	CK_3XXX),
>  	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_3XXX),
>  	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_3XXX),
>  	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_34XX | CK_36XX),
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index e8cb32f..4d5ede3 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3058,6 +3058,7 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck,	CK_443X),
>  	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck,	CK_443X),
>  	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
> +	CLK(NULL,	"cpu_ck",			&dpll_mpu_ck,	CK_443X),
>  	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
>  	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_443X),
>  	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck,	CK_443X),

Kevin
