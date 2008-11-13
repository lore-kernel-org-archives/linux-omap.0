From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: Changed secure RAM storage size from 0x8000 to 0x803F
Date: Thu, 13 Nov 2008 05:54:14 -0800
Message-ID: <87fxlvlojd.fsf@deeprootsystems.com>
References: <1226576465-14387-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:15960 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbYKMNyU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 08:54:20 -0500
Received: by rn-out-0910.google.com with SMTP id k40so774758rnd.17
        for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 05:54:18 -0800 (PST)
In-Reply-To: <1226576465-14387-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 13 Nov 2008 13\:41\:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Without this, causes some random crashes related to memory management.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Looks like this is against pm-20081106.  Pulling into next PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0df3245..58d0479 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -883,7 +883,7 @@ int __init omap3_pm_init(void)
>  
>  	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
>  		omap3_secure_ram_storage =
> -			kmalloc(0x8000, GFP_KERNEL);
> +			kmalloc(0x803F, GFP_KERNEL);
>  		if (!omap3_secure_ram_storage)
>  			printk(KERN_ERR "Memory allocation failed when"
>  					"allocating for secure sram context\n");
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
