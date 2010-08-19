From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH 12/14] omap2/3: Fix initcalls for multi-omap
Date: Thu, 19 Aug 2010 12:03:13 +0300
Message-ID: <20100819090313.GC3003@shisha.kicks-ass.net>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
 <20100126201304.15382.73756.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:53849 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0HSJMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 05:12:00 -0400
Content-Disposition: inline
In-Reply-To: <20100126201304.15382.73756.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>

On Tue, Jan 26, 2010 at 12:13:04 -0800, Tony Lindgren wrote:
> Otherwise the wrong initcalls can run.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/clock2xxx.c |    2 +-
>  arch/arm/mach-omap2/clock34xx.c |    2 +-
>  arch/arm/mach-omap2/emu.c       |    3 +++

May I ask what stopped you from CCing me on this patch?

>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
> index 43e7404..1a31b72 100644
> --- a/arch/arm/mach-omap2/clock2xxx.c
> +++ b/arch/arm/mach-omap2/clock2xxx.c
> @@ -598,7 +598,7 @@ static int __init omap2_clk_arch_init(void)
>  	struct clk *virt_prcm_set, *sys_ck, *dpll_ck, *mpu_ck;
>  	unsigned long sys_ck_rate;
>  
> -	if (!mpurate)
> +	if (!(cpu_is_omap24xx() && mpurate))
>  		return -EINVAL;
>  
>  	virt_prcm_set = clk_get(NULL, "virt_prcm_set");
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index f485a89..03720bc 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -317,7 +317,7 @@ static int __init omap2_clk_arch_init(void)
>  	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
>  	unsigned long osc_sys_rate;
>  
> -	if (!mpurate)
> +	if (!(cpu_is_omap34xx() && mpurate))
>  		return -EINVAL;
>  
>  	/* XXX test these for success */
> diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
> index ec0d984..9c442e2 100644
> --- a/arch/arm/mach-omap2/emu.c
> +++ b/arch/arm/mach-omap2/emu.c
> @@ -56,6 +56,9 @@ static struct amba_device omap3_etm_device = {
>  
>  static int __init emu_init(void)
>  {
> +	if (!cpu_is_omap34xx())
> +		return -ENODEV;
> +
>  	amba_device_register(&omap3_etb_device, &iomem_resource);
>  	amba_device_register(&omap3_etm_device, &iomem_resource);
>  
> 
> 

Regards,
--
Alex
