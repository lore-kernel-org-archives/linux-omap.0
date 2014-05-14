From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: nand: Fix NAND on OMAP2 and OMAP3 boards
Date: Wed, 14 May 2014 08:30:29 -0700
Message-ID: <20140514153028.GC18463@atomide.com>
References: <1400070908-2929-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49093 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbaENPaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 11:30:35 -0400
Content-Disposition: inline
In-Reply-To: <1400070908-2929-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@ti.com, balbi@ti.com, ezequiel.garcia@free-electrons.com, computersforpeace@gmail.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140514 05:36]:
> Commit c66d039197e4 broke NAND for non-DT boot on all OMAP2 and OMAP3
> boards using board_nand_init(). Following error is seen at boot
> 
> [    0.154998]  (null): Unsupported NAND ECC scheme selected
> 
> For OMAP2 and OMAP3 platforms, the ecc_opt parameter in platform data
> must be set to OMAP_ECC_HAM1_CODE_HW to work properly.
> 
> Tested on omap3-beagle c4.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Thanks applying into fixes with Cc stable v3.12+.

Regards,

Tony

>  arch/arm/mach-omap2/board-flash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
> index ac82512..b6885e4 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -142,7 +142,7 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs,
>  	board_nand_data.nr_parts	= nr_parts;
>  	board_nand_data.devsize		= nand_type;
>  
> -	board_nand_data.ecc_opt = OMAP_ECC_BCH8_CODE_HW;
> +	board_nand_data.ecc_opt = OMAP_ECC_HAM1_CODE_HW;
>  	gpmc_nand_init(&board_nand_data, gpmc_t);
>  }
>  #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
> -- 
> 1.8.3.2
> 
