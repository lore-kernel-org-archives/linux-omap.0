From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: Fix redefinition of board_onenand_init
Date: Tue, 26 Jun 2012 06:46:50 -0700
Message-ID: <20120626134650.GB3483@atomide.com>
References: <1340716561-27750-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40456 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab2FZNqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 09:46:53 -0400
Content-Disposition: inline
In-Reply-To: <1340716561-27750-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-omap@vger.kernel.org, Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

Hi,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [120626 06:21]:
> Initialy defined in arch/arm/mach-omap2/board-flash.h and redefined in
> arch/arm/mach-omap2/board-flash.c when CONFIG_MTD_ONENAND_OMAP2 were not set.

Thanks, but I already have an earlier version from Kevin queued up that
I forgot to send upstream last week.

Regards,

Tony
 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> ---
>  arch/arm/mach-omap2/board-flash.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
> index 70a81f9..53c39d2 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -97,11 +97,6 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
>  
>  	gpmc_onenand_init(&board_onenand_data);
>  }
> -#else
> -void
> -__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
> -{
> -}
>  #endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE */
>  
>  #if defined(CONFIG_MTD_NAND_OMAP2) || \
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
