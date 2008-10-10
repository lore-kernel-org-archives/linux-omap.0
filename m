From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [omap2] Fix compiler warnings in gpmc.c
Date: Fri, 10 Oct 2008 14:27:08 +0300
Message-ID: <20081010112708.GS3044@atomide.com>
References: <1223633991-32406-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50660 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbYJJL1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 07:27:11 -0400
Content-Disposition: inline
In-Reply-To: <1223633991-32406-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [081010 13:22]:
> Fix these compiler warnings:
> 
> gpmc.c: In function 'gpmc_init':
> gpmc.c:432: warning: 'return' with a value, in function returning void
> gpmc.c:439: warning: 'return' with a value, in function returning void

Pushing.

Tony

> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index f3e0271..4365c59 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -429,18 +429,16 @@ void __init gpmc_init(void)
>  	gpmc_l3_clk = clk_get(NULL, ck);
>  	if (IS_ERR(gpmc_l3_clk)) {
>  		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
> -		return -ENODEV;
> +		BUG();
>  	}
>  
>  	gpmc_base = ioremap(l, SZ_4K);
>  	if (!gpmc_base) {
>  		clk_put(gpmc_l3_clk);
>  		printk(KERN_ERR "Could not get GPMC register memory\n");
> -		return -ENOMEM;
> +		BUG();
>  	}
>  
> -	BUG_ON(IS_ERR(gpmc_l3_clk));
> -
>  	l = gpmc_read_reg(GPMC_REVISION);
>  	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
>  	/* Set smart idle mode and automatic L3 clock gating */
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
