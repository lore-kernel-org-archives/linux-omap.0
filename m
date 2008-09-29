From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] gpmc: Remove compilation warning
Date: Mon, 29 Sep 2008 16:16:34 +0300
Message-ID: <20080929131634.GJ13245@gandalf.research.nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028C31912F@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52774 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbYI2NR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:17:27 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028C31912F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Mon, Sep 29, 2008 at 06:40:43PM +0530, ext Pakaravoor, Jagadeesh wrote:
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

This has to stop somehow if we can't get the clock or can't
ioremap. How about changing to:

BUG_ON(IS_ERR(gpmc_l3_clk));

and

BUG_ONG(!gpmc_base);

-- 
balbi
