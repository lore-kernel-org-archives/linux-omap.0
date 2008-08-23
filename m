From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2EVM : Add nand support
Date: Sat, 23 Aug 2008 16:14:02 -0700
Message-ID: <20080823231402.GH4713@atomide.com>
References: <dfeb90390808230218r6d1cd9d0ied2bc8817e65881e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53348 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYHWXOE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 19:14:04 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390808230218r6d1cd9d0ied2bc8817e65881e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

* Arun KS <arunks@mistralsolutions.com> [080823 02:18]:
> This patch adds nand support to omap2evm board

Pushing today.

Tony

> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-omap2evm.c |  107 ++++++++++++++++++++++++++++++++++
>  1 files changed, 107 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap2evm.c
> b/arch/arm/mach-omap2/board-omap2evm.c
> index 4188222..138e80c 100644
> --- a/arch/arm/mach-omap2/board-omap2evm.c
> +++ b/arch/arm/mach-omap2/board-omap2evm.c
> @@ -19,17 +19,123 @@
>  #include <linux/io.h>
>  #include <linux/input.h>
>  #include <linux/i2c/twl4030.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> 
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> +#include <asm/mach/flash.h>
> 
>  #include <mach/gpio.h>
>  #include <mach/board.h>
>  #include <mach/common.h>
>  #include <mach/hsmmc.h>
>  #include <mach/keypad.h>
> +#include <mach/gpmc.h>
> +#include <mach/nand.h>
> +
> +#define GPMC_OFF_CONFIG1_0 0x60
> +
> +static struct mtd_partition omap2evm_nand_partitions[] = {
> +	{
> +		.name		= "X-Loader",
> +		.offset		= 0,
> +		.size		= 1 * (64 * 2048),
> +		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
> +	},
> +	{
> +		.name		= "U-Boot",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= 3 * (64 * 2048),
> +		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
> +	},
> +	{
> +		.name		= "U-Boot Environment",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= 1 * (64 * 2048),
> +	 },
> +	{
> +		.name		= "Kernel",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= 16 * (64 * 2048),	/* 2MB */
> +	},
> +	{
> +		.name		= "Ramdisk",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= 32 * (64 * 2048),	/* 4MB */
> +	},
> +	{
> +		.name		= "Filesystem",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= MTDPART_SIZ_FULL,
> +	}
> +};
> +
> +static struct omap_nand_platform_data omap2evm_nand_data = {
> +	.parts		= omap2evm_nand_partitions,
> +	.nr_parts	= ARRAY_SIZE(omap2evm_nand_partitions),
> +	.dma_channel	= -1,	/* disable DMA in OMAP NAND driver */
> +};
> +
> +static struct resource omap2evm_nand_resource = {
> +	.flags		= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device omap2evm_nand_device = {
> +	.name		= "omap2-nand",
> +	.id		= -1,
> +	.dev		= {
> +		.platform_data	= &omap2evm_nand_data,
> +	},
> +	.num_resources	= 1,
> +	.resource	= &omap2evm_nand_resource,
> +};
> +
> +void __init omap2evm_flash_init(void)
> +{
> +	void __iomem *gpmc_base_add, *gpmc_cs_base_add;
> +	unsigned char cs = 0;
> +
> +	gpmc_base_add = (__force void __iomem *)OMAP243X_GPMC_VIRT;
> +	while (cs < GPMC_CS_NUM) {
> +		int ret = 0;
> +
> +		/* Each GPMC set for a single CS is at offset 0x30 */
> +		gpmc_cs_base_add = (gpmc_base_add + GPMC_OFF_CONFIG1_0 +
> +				    (cs * 0x30));
> +
> +		/* xloader/Uboot would have programmed the NAND
> +		 * base address for us This is a ugly hack. The proper
> +		 * way of doing this is to pass the setup of u-boot up
> +		 * to kernel using kernel params - something on the
> +		 * lines of machineID. Check if Nand is
> +		 * configured */
> +		ret = __raw_readl(gpmc_cs_base_add + GPMC_CS_CONFIG1);
> +		if ((ret & 0xC00) == (0x800)) {
> +			/* Found it!! */
> +			printk(KERN_INFO "NAND: Found NAND on CS %d \n", cs);
> +			break;
> +		}
> +		cs++;
> +	}
> +	if (cs >= GPMC_CS_NUM) {
> +		printk(KERN_INFO "MTD: Unable to find MTD configuration in "
> +				 "GPMC   - not registering.\n");
> +		return;
> +	}
> +
> +	omap2evm_nand_data.cs			= cs;
> +	omap2evm_nand_data.gpmc_cs_baseaddr	= gpmc_cs_base_add;
> +	omap2evm_nand_data.gpmc_baseaddr	= gpmc_base_add;
> +
> +	if (platform_device_register(&omap2evm_nand_device) < 0) {
> +		printk(KERN_ERR "Unable to register NAND device\n");
> +		return;
> +	}
> +}
> 
>  static struct resource omap2evm_smc911x_resources[] = {
>  	[0] =   {
> @@ -160,6 +266,7 @@ static void __init omap2_evm_init(void)
>  	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
>  	omap_serial_init();
>  	hsmmc_init();
> +	omap2evm_flash_init();
>  }
> 
>  static void __init omap2_evm_map_io(void)
> -- 
> 1.5.3.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
