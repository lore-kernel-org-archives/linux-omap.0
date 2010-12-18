From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] omap3630: nand: fix device size to work in polled
 mode
Date: Fri, 17 Dec 2010 16:03:45 -0800
Message-ID: <20101218000344.GV5941@atomide.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
 <1290785677-16005-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14467 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab0LRADt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 19:03:49 -0500
Content-Disposition: inline
In-Reply-To: <1290785677-16005-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [101126 07:25]:
> zoom3 and 3630-sdp having the x16 nand device.
> This patch configure gpmc as x16 and select the currect function in driver
> for polled mode (without prefetch enable) transfer.
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  arch/arm/mach-omap2/board-flash.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
> index fd38c05..001c605 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -145,6 +145,9 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
>  	board_nand_data.parts		= nand_parts;
>  	board_nand_data.nr_parts		= nr_parts;
>  
> +	if (cpu_is_omap3630())
> +		board_nand_data.devsize = 1;
> +
>  	gpmc_nand_init(&board_nand_data);
>  }
>  #else

I guess this is board specific for the size, not omap specific?

Regards,

Tony
