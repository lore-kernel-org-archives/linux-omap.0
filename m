From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/5] ARM: OMAP3EVM: Add NAND flash definition
Date: Mon, 11 Jun 2012 09:57:03 -0500
Message-ID: <4FD6073F.8080703@ti.com>
References: <zumeng.chen@gmail.com> <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com> <1339423216-1323-2-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51042 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab2FKO5L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:57:11 -0400
In-Reply-To: <1339423216-1323-2-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, ajay.gupta@ti.com, khasim@ti.com, hvaibhav@ti.com



On 06/11/2012 09:00 AM, Zumeng Chen wrote:
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Tested-by: Zumeng Chen <zumeng.chen@gmail.com>

I think that you need to have something in the changelog above, even if
this is a trivial change.

> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   39 ++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 639bd07..fef911d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -24,6 +24,10 @@
>  #include <linux/leds.h>
>  #include <linux/interrupt.h>
>  
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
>  #include <linux/i2c/twl.h>
> @@ -43,6 +47,7 @@
>  
>  #include <plat/board.h>
>  #include <plat/usb.h>
> +#include <plat/nand.h>
>  #include "common.h"
>  #include <plat/mcspi.h>
>  #include <video/omapdss.h>
> @@ -607,6 +612,37 @@ static struct regulator_consumer_supply dummy_supplies[] = {
>  	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>  };
>  
> +static struct mtd_partition omap3evm_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name           = "xloader-nand",

Is this the only non-volatile memory on the EVM? If so, you can probably
drop the "-nand" part from the name. Also, if you look at other board
files to be consistent in naming they use "X-Loader".

> +		.offset         = 0,
> +		.size           = 4*(SZ_128K),
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "uboot-nand",

"U-Boot"

> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 14*(SZ_128K),
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "params-nand",

"U-Boot Env"

> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 2*(SZ_128K)
> +	},
> +	{
> +		.name           = "linux-nand",

"Kernel"

> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 40*(SZ_128K)
> +	},
> +	{
> +		.name           = "jffs2-nand",

"File System"
> +		.size           = MTDPART_SIZ_FULL,
> +		.offset         = MTDPART_OFS_APPEND,
> +	},
> +};
> +
>  static void __init omap3_evm_init(void)
>  {
>  	struct omap_board_mux *obm;
> @@ -656,6 +692,9 @@ static void __init omap3_evm_init(void)
>  	}
>  	usb_musb_init(&musb_board_data);
>  	usbhs_init(&usbhs_bdata);
> +	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
> +			     ARRAY_SIZE(omap3evm_nand_partitions));
> +
>  	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
>  	omap3evm_init_smsc911x();
>  	omap3_evm_display_init();

Cheers
Jon
