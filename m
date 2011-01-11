From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: igep3: Add omap_reserve functionality
Date: Tue, 11 Jan 2011 15:29:08 -0800
Message-ID: <20110111232908.GZ4957@atomide.com>
References: <1294760874-28088-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57868 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab1AKX3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 18:29:22 -0500
Content-Disposition: inline
In-Reply-To: <1294760874-28088-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rmk+kernel@arm.linux.org.uk

* Enric Balletbo i Serra <eballetbo@gmail.com> [110111 07:47]:
> This patch adds omap_reserve functionality to board-igep0030.c.
> 
> This patch is in similar lines to commit id 71ee7dad9b6991, from
> Russell king

Applying to devel-board.

Tony
 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/mach-omap2/board-igep0030.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
> index 11b944f..4dc62a9 100644
> --- a/arch/arm/mach-omap2/board-igep0030.c
> +++ b/arch/arm/mach-omap2/board-igep0030.c
> @@ -450,6 +450,7 @@ static void __init igep3_init(void)
>  
>  MACHINE_START(IGEP0030, "IGEP OMAP3 module")
>  	.boot_params	= 0x80000100,
> +	.reserve	= omap_reserve,
>  	.map_io		= omap3_map_io,
>  	.init_irq	= igep3_init_irq,
>  	.init_machine	= igep3_init,
> -- 
> 1.7.0.4
> 
