From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Mon, 6 Oct 2008 14:20:40 +0300
Message-ID: <20081006112039.GF2806@atomide.com>
References: <41054.192.168.10.89.1219747319.squirrel@dbdmail.itg.ti.com> <33923.192.168.10.89.1221112795.squirrel@dbdmail.itg.ti.com> <48232.192.168.10.89.1221127616.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56352 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYJFLRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 07:17:42 -0400
Content-Disposition: inline
In-Reply-To: <48232.192.168.10.89.1221127616.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: linux-omap@vger.kernel.org

* vimal singh <vimalsingh@ti.com> [080911 13:07]:
> From: Teerth Reddy <teerth@ti.com>
> 
> This patch adds NAND support on 3430sdp board
> 
> [VS: updated for NAND_BLOCK_SIZE macros]

Pushing today.

Tony

> Signed-off-by: Teerth Reddy <teerth@ti.com>
> Signed-off-by: Vimal Singh <vimal.singh@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp-flash.c |   87 ++++++++++++++++++++++++++++--
>  arch/arm/plat-omap/include/mach/gpmc.h    |   10 +++
>  include/linux/mtd/nand.h                  |    2
>  3 files changed, 93 insertions(+), 6 deletions(-)
> 
> Index: linux-omap-2.6_27_08_2008/arch/arm/mach-omap2/board-3430sdp-flash.c
> ===================================================================
> ---
> linux-omap-2.6_27_08_2008.orig/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-08-27
> 11:40:26.000000000 +0530
> +++
> linux-omap-2.6_27_08_2008/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-09-11
> 15:21:10.000000000 +0530
> @@ -24,6 +24,7 @@
>  #include <mach/onenand.h>
>  #include <mach/board.h>
>  #include <mach/gpmc.h>
> +#include <mach/nand.h>
> 
>  static struct mtd_partition sdp_nor_partitions[] = {
>  	/* bootloader (U-Boot, etc) in first sector */
> @@ -137,6 +138,61 @@
>  	/* Onenand setup does nothing at present */
>  	return 0;
>  }
> +
> +static struct mtd_partition sdp_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name           = "X-Loader-NAND",
> +		.offset         = 0,
> +		.size           = 4 * NAND_BLOCK_SIZE,
> +		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
> +	},
> +	{
> +		.name           = "U-Boot-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x80000 */
> +		.size           = 4 * NAND_BLOCK_SIZE,
> +		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
> +	},
> +	{
> +		.name           = "Boot Env-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x100000 */
> +		.size           = 2 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name           = "Kernel-NAND",
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x140000 */
> +		.size           = 32 * NAND_BLOCK_SIZE,
> +	},
> +	{
> +		.name           = "File System - NAND",
> +		.size           = MTDPART_SIZ_FULL,
> +		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x540000 */
> +	},
> +};
> +
> +static struct omap_nand_platform_data sdp_nand_data = {
> +	.parts          = sdp_nand_partitions,
> +	.nr_parts       = ARRAY_SIZE(sdp_nand_partitions),
> +	.nand_setup     = NULL,
> +	.dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
> +	.dev_ready      = NULL,
> +};
> +
> +static struct resource sdp_nand_resource = {
> +	.flags          = IORESOURCE_MEM,
> +};
> +
> +static struct platform_device sdp_nand_device = {
> +	.name           = "omap2-nand",
> +	.id             = 0,
> +	.dev            = {
> +	.platform_data  = &sdp_nand_data,
> +	},
> +	.num_resources  = 1,
> +	.resource       = &sdp_nand_resource,
> +};
> +
> +
>  /**
>   * sdp3430_flash_init - Identify devices connected to GPMC and register.
>   *
> @@ -145,7 +201,11 @@
>  void __init sdp3430_flash_init(void)
>  {
>  	u8		cs = 0;
> +	u8              nandcs = GPMC_CS_NUM + 1;
>  	u8		onenandcs = GPMC_CS_NUM + 1;
> +	unsigned long	gpmc_base_add;
> +
> +	gpmc_base_add   = OMAP34XX_GPMC_VIRT;
> 
>  	/* Configure start address and size of NOR device */
>  	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> @@ -163,25 +223,42 @@
> 
>  	while (cs < GPMC_CS_NUM) {
>  		u32 ret = 0;
> -		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> +		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> 
>  		/*
> -		* xloader/Uboot would have programmed the oneNAND
> +		* xloader/Uboot would have programmed the NAND/oneNAND
>  		* base address for us This is a ugly hack. The proper
>  		* way of doing this is to pass the setup of u-boot up
>  		* to kernel using kernel params - something on the
>  		* lines of machineID. Check if oneNAND is configured
>  		*/
> -		if ((ret & 0x3F) == (ONENAND_MAP >> 24))
> +		if ((ret & 0xC00) == 0x800) {
> +			/* Found it!! */
> +			if (nandcs > GPMC_CS_NUM)
> +				nandcs = cs;
> +		} else {
> +			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> +			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
>  			onenandcs = cs;
> +		}
>  		cs++;
>  	}
> -	if (onenandcs > GPMC_CS_NUM) {
> -		printk(KERN_INFO "OneNAND: Unable to find configuration "
> +	if ((nandcs > GPMC_CS_NUM) && (onenandcs > GPMC_CS_NUM)) {
> +		printk(KERN_INFO "NAND/OneNAND: Unable to find configuration "
>  				" in GPMC\n ");
>  		return;
>  	}
> 
> +	if (nandcs < GPMC_CS_NUM) {
> +		sdp_nand_data.cs        = nandcs;
> +		sdp_nand_data.gpmc_cs_baseaddr   = (void *)(gpmc_base_add +
> +					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
> +		sdp_nand_data.gpmc_baseaddr     = (void *) (gpmc_base_add);
> +
> +		if (platform_device_register(&sdp_nand_device) < 0)
> +			printk(KERN_ERR "Unable to register NAND device\n");
> +	}
> +
>  	if (onenandcs < GPMC_CS_NUM) {
>  		sdp_onenand_data.cs = onenandcs;
>  		if (platform_device_register(&sdp_onenand_device) < 0)
> Index: linux-omap-2.6_27_08_2008/arch/arm/plat-omap/include/mach/gpmc.h
> ===================================================================
> ---
> linux-omap-2.6_27_08_2008.orig/arch/arm/plat-omap/include/mach/gpmc.h	2008-08-27
> 11:40:27.000000000 +0530
> +++ linux-omap-2.6_27_08_2008/arch/arm/plat-omap/include/mach/gpmc.h	2008-08-27
> 15:21:22.000000000 +0530
> @@ -25,8 +25,18 @@
>  #define GPMC_CS_NAND_ADDRESS	0x20
>  #define GPMC_CS_NAND_DATA	0x24
> 
> +/*
> + * The following gpmc registers are being used by
> + * nand driver and hence is defined here.
> + * TBD: Move them to gpmc.c by providing appropriate
> + *  methods to read and write into these registers
> + */
> +#define GPMC_IRQSTATUS		0x18
>  #define GPMC_CONFIG		0x50
>  #define GPMC_STATUS		0x54
> +#define GPMC_CS0_BASE           0x60
> +#define GPMC_CS_SIZE            0x30
> +
> 
>  #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
>  #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
> Index: linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h
> ===================================================================
> --- linux-omap-2.6_27_08_2008.orig/include/linux/mtd/nand.h	2008-09-11
> 12:18:05.000000000 +0530
> +++ linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h	2008-09-11
> 15:04:31.000000000 +0530
> @@ -45,7 +45,7 @@
>   */
>  #define NAND_MAX_OOBSIZE	64
>  #define NAND_MAX_PAGESIZE	2048
> -
> +#define NAND_BLOCK_SIZE		SZ_128K
>  /*
>   * Constants for hardware specific CLE/ALE/NCE function
>   *
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
