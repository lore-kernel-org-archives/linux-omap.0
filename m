From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] kill warnings in gpmc
Date: Tue, 7 Oct 2008 16:35:27 +0300
Message-ID: <20081007133527.GY7437@gandalf.research.nokia.com>
References: <20081007130411.GX7437@gandalf.research.nokia.com> <EAF47CD23C76F840A9E7FCE10091EFAB028C62FBE6@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43715 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbYJGNgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:36:41 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028C62FBE6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Oct 07, 2008 at 06:39:20PM +0530, ext Pakaravoor, Jagadeesh wrote:
> 
> > Trivial cleanup patch. Do not return values in void
> > functions
> > 
> 
> I had sent that fix for the same, though not merged in yet. :)

True, now I remember. Tony, I'm ok with that patch if you are.

> 
> ==Cut here
> 
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> Return type of gpmc_init() function is void. Also, the error values
> returned by the function is not used by the caller. Hence it should
> not be returning any value.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> --
> Index: linux-omap-git/arch/arm/mach-omap2/gpmc.c
> ===================================================================
> --- linux-omap-git.orig/arch/arm/mach-omap2/gpmc.c	2008-09-25 17:30:24.000000000 +0530
> +++ linux-omap-git/arch/arm/mach-omap2/gpmc.c	2008-09-29 18:26:40.845433948 +0530
> @@ -427,16 +427,13 @@ void __init gpmc_init(void)
>  	}
>  
>  	gpmc_l3_clk = clk_get(NULL, ck);
> -	if (IS_ERR(gpmc_l3_clk)) {
> +	if (IS_ERR(gpmc_l3_clk))
>  		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
> -		return -ENODEV;
> -	}
>  
>  	gpmc_base = ioremap(l, SZ_4K);
>  	if (!gpmc_base) {
>  		clk_put(gpmc_l3_clk);
>  		printk(KERN_ERR "Could not get GPMC register memory\n");
> -		return -ENOMEM;
>  	}
>  
>  	BUG_ON(IS_ERR(gpmc_l3_clk));

-- 
balbi
