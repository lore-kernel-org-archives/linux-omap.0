From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Adding support for NAND partitions in OMAP3 EVM.
Date: Thu, 8 Jan 2009 16:56:58 +0200
Message-ID: <20090108145656.GP27566@atomide.com>
References: <1227850600-19842-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52943 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627AbZAHO5A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 09:57:00 -0500
Content-Disposition: inline
In-Reply-To: <1227850600-19842-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

* Manikandan Pillai <mani.pillai@ti.com> [081128 07:36]:
> Flash initialization has been modified to take care on NAND initialization
> and creation of NAND partitions.

Pushing to l-o tree. Do you also want to prepare patches against
the mainline tree for minimal omap3evm support for the next merge
window?

Regards,

Tony


> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm-flash.c       |   85 ++++++++++++++++++++--
>  arch/arm/plat-omap/include/mach/board-omap3evm.h |    2 +
>  2 files changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm-flash.c b/arch/arm/mach-omap2/board-omap3evm-flash.c
> index 5f3663d..72c7f5b 100644
> --- a/arch/arm/mach-omap2/board-omap3evm-flash.c
> +++ b/arch/arm/mach-omap2/board-omap3evm-flash.c
> @@ -23,6 +23,9 @@
>  #include <mach/gpmc.h>
>  #include <mach/nand.h>
>  
> +#define GPMC_CS0_BASE  0x60
> +#define GPMC_CS_SIZE   0x30
> +
>  static int omap3evm_onenand_setup(void __iomem *, int freq);
>  
>  static struct mtd_partition omap3evm_onenand_partitions[] = {
> @@ -70,6 +73,63 @@ static struct platform_device omap3evm_onenand_device = {
>  	},
>  };
>  
> +static struct mtd_partition omap3evm_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name           = "X-Loader-NAND",
> +		.offset         = 0,
> +		.size           = 4*(128 * 1024),
> +		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
> +	},
> +	{
> +		.name           = "U-Boot-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x80000 */
> +		.size           = 14*(128 * 1024),
> +		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
> +	},
> +	{
> +		.name           = "Boot Env-NAND",
> +
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x100000 */
> +		.size           = 2*(128 * 1024),
> +	},
> +	{
> +		.name           = "Kernel-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x140000 */
> +		.size           = 40*(128 * 1024),
> +	},
> +	{
> +		.name           = "File System - NAND",
> +		.size           = MTDPART_SIZ_FULL,
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x540000 */
> +	},
> +};
> +
> +/* dip switches control NAND chip access:  8 bit, 16 bit, or neither */
> +static struct omap_nand_platform_data omap3evm_nand_data = {
> +	.parts          = omap3evm_nand_partitions,
> +	.nr_parts       = ARRAY_SIZE(omap3evm_nand_partitions),
> +	.nand_setup     = NULL,
> +	.dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
> +	.dev_ready      = NULL,
> +	.options        = NAND_SAMSUNG_LP_OPTIONS,
> +};
> +
> +static struct resource omap3evm_nand_resource = {
> +	.flags          = IORESOURCE_MEM,
> +};
> +
> +static struct platform_device omap3evm_nand_device = {
> +	.name           = "omap2-nand",
> +	.id             = 0,
> +	.dev            = {
> +		.platform_data  = &omap3evm_nand_data,
> +	},
> +	.num_resources  = 1,
> +	.resource       = &omap3evm_nand_resource,
> +};
> +
> +
>  /*
>   *      omap3evm_onenand_setup - Set the onenand sync mode
>   *      @onenand_base:  The onenand base address in GPMC memory map
> @@ -86,6 +146,8 @@ void __init omap3evm_flash_init(void)
>  {
>  	u8		cs = 0;
>  	u8		onenandcs = GPMC_CS_NUM + 1;
> +	u8 		nandcs = GPMC_CS_NUM + 1;
> +	u32 		gpmc_base_add = OMAP34XX_GPMC_VIRT;
>  
>  	while (cs < GPMC_CS_NUM) {
>  		u32 ret = 0;
> @@ -100,18 +162,31 @@ void __init omap3evm_flash_init(void)
>  		*/
>  		if ((ret & 0x3F) == (ONENAND_MAP >> 24))
>  			onenandcs = cs;
> +		else if ((ret & 0x3F) == (NAND_MAP >> 24))
> +			nandcs = cs;
>  		cs++;
>  	}
>  	if (onenandcs > GPMC_CS_NUM) {
>  		printk(KERN_INFO "OneNAND: Unable to find configuration "
>  				" in GPMC\n ");
> -		return;
> -	}
> -
> -	if (onenandcs < GPMC_CS_NUM) {
> +	} else if (onenandcs < GPMC_CS_NUM) {
> +		printk(KERN_INFO "OneNAND: on CS%d\n", onenandcs);
>  		omap3evm_onenand_data.cs = onenandcs;
>  		if (platform_device_register(&omap3evm_onenand_device) < 0)
>  			printk(KERN_ERR "Unable to register OneNAND device\n");
>  	}
> -}
>  
> +	if (nandcs > GPMC_CS_NUM) {
> +		printk(KERN_INFO "NAND: Unable to find configuration "
> +				"in GPMC\n ");
> +	} else if (nandcs < GPMC_CS_NUM) {
> +		printk(KERN_INFO "NAND: on CS%d\n", nandcs);
> +		omap3evm_nand_data.cs = nandcs;
> +		omap3evm_nand_data.gpmc_cs_baseaddr = (void *)
> +			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
> +		omap3evm_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
> +		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
> +		if (platform_device_register(&omap3evm_nand_device) < 0)
> +			printk(KERN_ERR "Unable to register NAND device\n");
> +	}
> +}
> diff --git a/arch/arm/plat-omap/include/mach/board-omap3evm.h b/arch/arm/plat-omap/include/mach/board-omap3evm.h
> index 7a540e9..0c7c05c 100644
> --- a/arch/arm/plat-omap/include/mach/board-omap3evm.h
> +++ b/arch/arm/plat-omap/include/mach/board-omap3evm.h
> @@ -40,5 +40,7 @@ extern void omap3evm_flash_init(void);
>  #define OMAP3EVM_ETHR_GPIO_IRQ	176
>  #define OMAP3EVM_SMC911X_CS	5
>  
> +#define NAND_MAP		0x30000000
> +
>  #endif /* __ASM_ARCH_OMAP3_EVM_H */
>  
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
