From: "Saxena, Parth" <parth.saxena@ti.com>
Subject: RE: [PATCH] ti816x: add support for nand on ti8168 evm
Date: Tue, 27 Sep 2011 14:21:02 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC3121D6@dbde02.ent.ti.com>
References: <1316438648-25760-1-git-send-email-parth.saxena@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59078 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab1I0IvM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Sep 2011 04:51:12 -0400
In-Reply-To: <1316438648-25760-1-git-send-email-parth.saxena@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Saxena, Parth" <parth.saxena@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>

If there are no review comments on this patch, can this be merged?

Thanks and Regards,
Parth

> -----Original Message-----
> From: Saxena, Parth
> Sent: Monday, September 19, 2011 6:54 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org; tony@atomide.com; Saxena, Parth;
> Basheer, Mansoor Ahamed
> Subject: [PATCH] ti816x: add support for nand on ti8168 evm
> 
> Add partition table for NAND device on TI8168 EVM
> and initialise the NAND module.
> 
> Signed-off-by: Saxena, Parth <parth.saxena@ti.com>
> Signed-off-by: Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>
> ---
> 
> This patch is tested on top of linux-omap/master and
> Hemant's patches submitted recently.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53457.html
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg54296.html
> 
>  arch/arm/mach-omap2/board-ti8168evm.c |   39
> +++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-
> omap2/board-ti8168evm.c
> index e516a04..87953bb 100644
> --- a/arch/arm/mach-omap2/board-ti8168evm.c
> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> @@ -14,6 +14,7 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/mtd/nand.h>
> 
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -23,6 +24,42 @@
>  #include <plat/irqs.h>
>  #include <plat/board.h>
>  #include <plat/common.h>
> +#include <plat/gpmc.h>
> +#include <plat/nand.h>
> +
> +#include "board-flash.h"
> +
> +#define NAND_BLOCK_SIZE		SZ_128K
> +
> +static struct mtd_partition ti816x_nand_partitions[] = {
> +/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name		= "U-Boot",
> +		.offset		= 0,			/* Offset = 0x0 */
> +		.size		= 18 * NAND_BLOCK_SIZE,
> +		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
> +	},
> +	{
> +		.name		= "U-Boot Env",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x240000
> */
> +		.size		= 2 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name		= "Kernel",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000
> */
> +		.size		= 34 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name		= "File System",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x6C0000
> */
> +		.size		= 1601 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name		= "Reserved",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset =
> 0xCEE0000 */
> +		.size		= MTDPART_SIZ_FULL,
> +	},
> +};
> 
>  static struct omap_board_config_kernel ti8168_evm_config[] __initdata = {
>  };
> @@ -35,6 +72,8 @@ static void __init ti8168_init_early(void)
> 
>  static void __init ti8168_evm_init(void)
>  {
> +	board_nand_init(ti816x_nand_partitions,
> +		ARRAY_SIZE(ti816x_nand_partitions), 0, NAND_BUSWIDTH_16);
>  	omap_serial_init();
>  	omap_board_config = ti8168_evm_config;
>  	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
> --
> 1.6.2.4

