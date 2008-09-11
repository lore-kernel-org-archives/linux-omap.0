From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Wed, 10 Sep 2008 17:11:36 -0700
Message-ID: <20080911001135.GA21163@atomide.com>
References: <41054.192.168.10.89.1219747318.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63018 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYIKALk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 20:11:40 -0400
Content-Disposition: inline
In-Reply-To: <41054.192.168.10.89.1219747318.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: linux-omap@vger.kernel.org

* vimal singh <vimalsingh@ti.com> [080826 03:42]:
> From: Teerth Reddy <teerth@ti.com>
> 
> This patch adds NAND support on 3430sdp board
> 
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp-flash.c |   88 ++++++++++++++++++++++++++++--
>  arch/arm/plat-omap/include/mach/gpmc.h    |   10 +++
>  2 files changed, 93 insertions(+), 5 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-flash.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp-flash.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-flash.c
> @@ -24,6 +24,7 @@
>  #include <mach/onenand.h>
>  #include <mach/board.h>
>  #include <mach/gpmc.h>
> +#include <mach/nand.h>
> 
>  static struct mtd_partition sdp_nor_partitions[] = {
>  	/* bootloader (U-Boot, etc) in first sector */
> @@ -137,6 +138,61 @@ static int sdp_onenand_setup(void __iome
>  	/* Onenand setup does nothing at present */
>  	return 0;
>  }
> +
> +static struct mtd_partition sdp_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name           = "X-Loader-NAND",
> +		.offset         = 0,
> +		.size           = 4 * (64 * 2048),
> +		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
> +	},
> +	{
> +		.name           = "U-Boot-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x80000 */
> +		.size           = 4 * (64 * 2048),
> +		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
> +	},
> +	{
> +		.name           = "Boot Env-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x100000 */
> +		.size           = 2 * (64 * 2048),
> +	},
> +	{
> +		.name           = "Kernel-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x140000 */
> +		.size           = 32 * (64 * 2048),
> +	},
> +	{
> +		.name           = "File System - NAND",
> +		.size           = MTDPART_SIZ_FULL,
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x540000 */
> +	},
> +};
> +

Can you please update this to use the SZ_.. defines for .size as done
now for sdp_nor_partitions?

Thanks,

Tony
