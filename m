From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 2/3] OMAP3 Beagle: add nand support
Date: Mon, 4 Aug 2008 16:56:30 +0200
Message-ID: <150F4E30-B03F-4536-B65B-6FD8E96B654D@student.utwente.nl>
References: <1213208341-18111-1-git-send-email-steve@sakoman.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9--963578066"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:55919 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbYHDO5F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Aug 2008 10:57:05 -0400
Received: from [172.20.1.5] (vpn006010.vpn.utwente.nl [130.89.6.10])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m74EuWDf018635
          for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 16:56:32 +0200
In-Reply-To: <1213208341-18111-1-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-9--963578066
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Can this patch go in as well today?

regards,

Koen

Op 11 jun 2008, om 20:19 heeft Steve Sakoman het volgende geschreven:

> Add nand support to omap3beagle
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
> arch/arm/mach-omap2/Makefile                  |    3
> arch/arm/mach-omap2/board-omap3beagle-flash.c |  119 ++++++++++++++++ 
> ++++++++++
> arch/arm/mach-omap2/board-omap3beagle.c       |    1
> include/asm-arm/arch-omap/board-omap3beagle.h |    2
> 4 files changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/ 
> Makefile
> index 13d0043..d582b8f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -44,7 +44,8 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
> 					   board-omap3evm-flash.o
> obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
> 					   usb-musb.o usb-ehci.o \
> -					   hsmmc.o
> +					   hsmmc.o \
> +					   board-omap3beagle-flash.o
> obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
> 					   hsmmc.o \
> 					   usb-musb.o
> diff --git a/arch/arm/mach-omap2/board-omap3beagle-flash.c b/arch/ 
> arm/mach-omap2/board-omap3beagle-flash.c
> new file mode 100644
> index 0000000..5346df0
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3beagle-flash.c
> @@ -0,0 +1,119 @@
> +/*
> + * board-omap3beagle-flash.c
> + *
> + * Copyright (c) 2008 Texas Instruments
> + *
> + * Modified from board-omap3evm-flash.c
> + *
> + * This program is free software; you can redistribute it and/or  
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +
> +#include <asm/mach/flash.h>
> +#include <asm/arch/board.h>
> +#include <asm/arch/gpmc.h>
> +#include <asm/arch/nand.h>
> +
> +#define GPMC_CS0_BASE  0x60
> +#define GPMC_CS_SIZE   0x30
> +
> +static struct mtd_partition omap3beagle_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name		= "X-Loader",
> +		.offset		= 0,
> +		.size		= 4*(64 * 2048),
> +		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
> +	},
> +	{
> +		.name		= "U-Boot",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
> +		.size		= 15*(64 * 2048),
> +		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
> +	},
> +	{
> +		.name		= "U-Boot Env",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
> +		.size		= 1*(64 * 2048),
> +	},
> +	{
> +		.name		= "Kernel",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
> +		.size		= 32*(64 * 2048),
> +	},
> +	{
> +		.name		= "File System",
> +		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
> +		.size		= MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +static struct omap_nand_platform_data omap3beagle_nand_data = {
> +	.parts		= omap3beagle_nand_partitions,
> +	.nr_parts	= ARRAY_SIZE(omap3beagle_nand_partitions),
> +	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
> +	.nand_setup	= NULL,
> +	.dev_ready	= NULL,
> +};
> +
> +static struct resource omap3beagle_nand_resource = {
> +	.flags		= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device omap3beagle_nand_device = {
> +	.name		= "omap2-nand",
> +	.id		= -1,
> +	.dev		= {
> +		.platform_data	= &omap3beagle_nand_data,
> +	},
> +	.num_resources	= 1,
> +	.resource	= &omap3beagle_nand_resource,
> +};
> +
> +
> +void __init omap3beagle_flash_init(void)
> +{
> +	u8 cs = 0;
> +	u8 nandcs = GPMC_CS_NUM + 1;
> +
> +	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
> +
> +	/* find out the chip-select on which NAND exists */
> +	while (cs < GPMC_CS_NUM) {
> +		u32 ret = 0;
> +		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +		if ((ret & 0xC00) == 0x800) {
> +			printk(KERN_INFO "Found NAND on CS%d\n", cs);
> +			if (nandcs > GPMC_CS_NUM)
> +				nandcs = cs;
> +		}
> +		cs++;
> +	}
> +
> +	if (nandcs > GPMC_CS_NUM) {
> +		printk(KERN_INFO "NAND: Unable to find configuration "
> +				 "in GPMC\n ");
> +		return;
> +	}
> +
> +	if (nandcs < GPMC_CS_NUM) {
> +		omap3beagle_nand_data.cs = nandcs;
> +		omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)
> +			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
> +		omap3beagle_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
> +
> +		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
> +		if (platform_device_register(&omap3beagle_nand_device) < 0)
> +			printk(KERN_ERR "Unable to register NAND device\n");
> +	}
> +}
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> omap2/board-omap3beagle.c
> index c992cc7..99e042e 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -94,6 +94,7 @@ static void __init omap3_beagle_init(void)
> 	hsmmc_init();
> 	usb_musb_init();
> 	usb_ehci_init();
> +	omap3beagle_flash_init();
> }
>
> arch_initcall(omap3_beagle_i2c_init);
> diff --git a/include/asm-arm/arch-omap/board-omap3beagle.h b/include/ 
> asm-arm/arch-omap/board-omap3beagle.h
> index 46dff31..26ecfb8 100644
> --- a/include/asm-arm/arch-omap/board-omap3beagle.h
> +++ b/include/asm-arm/arch-omap/board-omap3beagle.h
> @@ -29,5 +29,7 @@
> #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
> #define __ASM_ARCH_OMAP3_BEAGLE_H
>
> +extern void omap3beagle_flash_init(void);
> +
> #endif /* __ASM_ARCH_OMAP3_BEAGLE_H */
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-9--963578066
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIlxigMkyGM64RGpERAgM9AJ9/7kkBZ4Sb+IYfuzT/6G5lQkCioACgkX+a
idIJ7ngYjd6Mu3DNC8E4X2E=
=gtXB
-----END PGP SIGNATURE-----

--Apple-Mail-9--963578066--
