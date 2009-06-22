From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Missing implementation of omap3evm_flash_init()
Date: Mon, 22 Jun 2009 12:06:52 +0300
Message-ID: <20090622090651.GA7352@atomide.com>
References: <1245331742-2536-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62781 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZFVJGw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 05:06:52 -0400
Content-Disposition: inline
In-Reply-To: <1245331742-2536-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Sanjeev Premi <premi@ti.com> [090618 16:29]:
> The function omap3evm_flash_init() earlier implemented
> in board-omap3evm-flash.c did not find its way into the
> board-omap3evm.c during the latest migration.
> 
> This patch brings in the earlier implementation with
> appropriate changes as necessary on current head.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |  176 +++++++++++++++++++++++++++++++++-
>  1 files changed, 175 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 1b7a797..5084b67 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -26,23 +26,197 @@
>  #include <linux/spi/ads7846.h>
>  #include <linux/i2c/twl4030.h>
>  
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> +#include <asm/mach/flash.h>
>  
> +#include <mach/common.h>
>  #include <mach/board.h>
>  #include <mach/mux.h>
> +#include <mach/gpmc.h>
> +#include <mach/nand.h>
> +#include <mach/onenand.h>
>  #include <mach/usb.h>
> -#include <mach/common.h>
>  #include <mach/mcspi.h>
>  #include <mach/keypad.h>
>  
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "mmc-twl4030.h"
>  
> +#define GPMC_CS0_BASE           0x60
> +#define GPMC_CS_SIZE            0x30
> +
>  #define OMAP3_EVM_TS_GPIO	175
>  
> +/*
> + * MTD - NAND, OneNAND
> + */
> +#define NAND_BLOCK_SIZE		SZ_128K
> +
> +static struct mtd_partition omap3evm_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name		= "xloader-nand",
> +		.offset		= 0,
> +		.size		= 4 * NAND_BLOCK_SIZE,
> +		.mask_flags	= MTD_WRITEABLE
> +	},
> +	{
> +		.name		= "uboot-nand",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= 14 * NAND_BLOCK_SIZE,
> +		.mask_flags	= MTD_WRITEABLE
> +	},
> +	{
> +		.name		= "params-nand",
> +
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= 2 * NAND_BLOCK_SIZE
> +	},
> +	{
> +		.name		= "linux-nand",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= 40 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name		= "jffs2-nand",
> +		.size		= MTDPART_SIZ_FULL,
> +		.offset		= MTDPART_OFS_APPEND,
> +	},
> +};
> +
> +static struct omap_nand_platform_data omap3evm_nand_data = {
> +	.parts		= omap3evm_nand_partitions,
> +	.nr_parts	= ARRAY_SIZE(omap3evm_nand_partitions),
> +	.nand_setup	= NULL,
> +	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
> +	.nand_setup	= NULL,
> +	.dev_ready	= NULL,
> +};
> +
> +static struct resource omap3evm_nand_resource = {
> +	.flags		= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device omap3evm_nand_device = {
> +	.name		= "omap2-nand",
> +	.id		= 0,
> +	.dev		= {
> +		.platform_data	= &omap3evm_nand_data,
> +	},
> +	.num_resources	= 1,
> +	.resource	= &omap3evm_nand_resource,
> +};
> +
> +#define ONENAND_MAP		0x20000000
> +#define ONENAND_BLOCK_SIZE	(64*2048)
> +
> +static struct mtd_partition omap3evm_onenand_partitions[] = {
> +	{
> +		.name           = "xloader-onenand",
> +		.offset         = 0,
> +		.size           = 4 * ONENAND_BLOCK_SIZE,
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "uboot-onenand",
> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 15 * ONENAND_BLOCK_SIZE,
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "params-onenand",
> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 1 * ONENAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name           = "linux-onenand",
> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 40 * ONENAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name           = "jffs2-onenand",
> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +static struct omap_onenand_platform_data omap3evm_onenand_data = {
> +	.parts		= omap3evm_onenand_partitions,
> +	.nr_parts	= ARRAY_SIZE(omap3evm_onenand_partitions),
> +	.onenand_setup	= NULL,
> +	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
> +};
> +
> +static struct platform_device omap3evm_onenand_device = {
> +	.name		= "omap2-onenand",
> +	.id		= -1,
> +	.dev = {
> +		.platform_data = &omap3evm_onenand_data,
> +	},
> +};
> +
> +void __init omap3evm_flash_init(void)
> +{
> +	u8		cs = 0;
> +	u8		onenandcs = GPMC_CS_NUM + 1, nandcs = GPMC_CS_NUM + 1;
> +	u32		gpmc_base_add = OMAP34XX_GPMC_VIRT;
> +
> +	while (cs < GPMC_CS_NUM) {
> +		u32 ret = 0;
> +		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +		/*
> +		* xloader/Uboot would have programmed the NAND/oneNAND
> +		* base address for us This is a ugly hack. The proper
> +		* way of doing this is to pass the setup of u-boot up
> +		* to kernel using kernel params - something on the
> +		* lines of machineID. Check if NAND/oneNAND is configured
> +		*/
> +		if ((ret & 0xC00) == 0x800) {
> +			/* Found it!! */
> +			if (nandcs > GPMC_CS_NUM)
> +				nandcs = cs;
> +		} else {
> +			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> +			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
> +				onenandcs = cs;
> +		}
> +		cs++;
> +	}

We already have code that initializes the GPMC for onenand in kernel.
And I posted a patch to enable onenand for the SDP boards last week [1].
And this is yet another copy of the same code that was duplicated for
multiple boards. So how about making the following changes: 

- Pass the onenand chip select for GPMC in platform data. I doubt that the
  chip select is changing?

- If you still need to probe for onenand, please create a generic function
  in gpmc-onenand.c to probe for onenand

Regards,

Tony


[1] http://patchwork.kernel.org/patch/30311/



> +	if ((nandcs > GPMC_CS_NUM) && (onenandcs > GPMC_CS_NUM)) {
> +		printk(KERN_INFO "NAND/OneNAND: Unable to find configuration "
> +				" in GPMC\n ");
> +		return;
> +	}
> +
> +	if (nandcs < GPMC_CS_NUM) {
> +		omap3evm_nand_data.cs	= nandcs;
> +		omap3evm_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
> +					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
> +		omap3evm_nand_data.gpmc_baseaddr   = (void *) (gpmc_base_add);
> +
> +		if (platform_device_register(&omap3evm_nand_device) < 0) {
> +			printk(KERN_ERR "Unable to register NAND device\n");
> +		}
> +	}
> +
> +	if (onenandcs < GPMC_CS_NUM) {
> +		omap3evm_onenand_data.cs = onenandcs;
> +		if (platform_device_register(&omap3evm_onenand_device) < 0)
> +			printk(KERN_ERR "Unable to register OneNAND device\n");
> +	}
> +}
> +
> +/*
> + * Ethernet
> + */
>  #define OMAP3EVM_ETHR_START	0x2c000000
>  #define OMAP3EVM_ETHR_SIZE	1024
>  #define OMAP3EVM_ETHR_GPIO_IRQ	176
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
