From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
Date: Thu, 1 Apr 2010 03:26:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004010245420.27004@utopia.booyaka.com>
References: <> <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com> <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51786 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0DAJ0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:26:40 -0400
In-Reply-To: <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 1 Apr 2010, Vishwanath BS wrote:

> DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM
> UCs running DSP codec was earlier restricted as DSP crashed.
> The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
> The solution is to make sure DPLL1/DPLL2 bypass clock is always less
> than maximum supported frequency for the specific OPP.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index d5153b6..d8e57a6
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c

...

> @@ -3597,5 +3601,13 @@ int __init omap3xxx_clk_init(void)
>  	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
>  	arm_fck_p = clk_get(NULL, "arm_fck");
>  
> +	/* Set the bypass clock dividers for DPLL1 and DPLL2 */
> +	if (cpu_is_omap3630()) {
> +		clk_set_rate(&dpll1_fck, 400000000/2);
> +		clk_set_rate(&dpll2_fck, 400000000/2);
> +	} else {
> +		clk_set_rate(&dpll1_fck, 332000000/4);
> +		clk_set_rate(&dpll2_fck, 332000000/4);
> +	}

This code is highly OPP-specific.  Why is this code needed here?  
Shouldn't the code in resource34xx.c be sufficient?


- Paul
