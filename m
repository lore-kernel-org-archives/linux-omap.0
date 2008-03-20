From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2: mach-omap2/pm.c build fix
Date: Thu, 20 Mar 2008 14:54:46 +0200
Message-ID: <20080320125446.GI14978@atomide.com>
References: <47E11536.6000803@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60130 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbYCTMyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 08:54:49 -0400
Content-Disposition: inline
In-Reply-To: <47E11536.6000803@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [080319 15:34]:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> This patch fix the following build problem:
> 
>   CC      arch/arm/mach-omap2/pm.o
> arch/arm/mach-omap2/pm.c: In function 'omap2_pm_init':
> arch/arm/mach-omap2/pm.c:840: warning: passing argument 2 of 'sysfs_create_file' from incompatible pointer type
> 
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> ---
>  arch/arm/mach-omap2/pm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 3a455e8..fb77e33 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -837,7 +837,7 @@ int __init omap2_pm_init(void)
>  	suspend_set_ops(&omap_pm_ops);
>  	pm_idle = omap2_pm_idle;
>  
> -	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr);
> +	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
>  	if (error)
>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);

Pushing today.

Tony
