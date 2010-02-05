From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2] omap3: Check return values for clk_get()
Date: Fri, 5 Feb 2010 13:24:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002051323560.18110@utopia.booyaka.com>
References: <1264691804-29427-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37136 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0BEUYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 15:24:49 -0500
In-Reply-To: <1264691804-29427-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 28 Jan 2010, Sanjeev Premi wrote:

> This patch checks if clk_get() returned success for
> the clocks used in function omap2_clk_arch_init().
> 
> This version incorporates review comments from
> Kevin Hilman and Paul Walmsley.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Thanks, queued for 2.6.34 with one change:

> ---
>  arch/arm/mach-omap2/clock34xx.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 1f1b5a6..ad09f04 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -184,6 +185,7 @@ static int __init omap3xxx_clk_arch_init(void)
>  {
>  	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
>  	unsigned long osc_sys_rate;
> +	bool err = 0 ;

There should not be a space before the semicolon in the above line and so 
the space has been removed.

>  
>  	if (!cpu_is_omap34xx())
>  		return 0;

- Paul
