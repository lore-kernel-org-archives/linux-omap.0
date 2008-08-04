From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 2/3 v2] OMAP3 Beagle: add nand support
Date: Mon, 4 Aug 2008 18:27:33 +0200
Message-ID: <1F0707CB-105A-4E40-820A-4867076B1502@student.utwente.nl>
References: <4897271E.6000408@googlemail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11--958114576"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:11159 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbYHDQ1q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Aug 2008 12:27:46 -0400
In-Reply-To: <4897271E.6000408@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Steve Sakoman <steve@sakoman.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-11--958114576
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Acked-by: Koen Kooi <koen@openembedded dot org>

Op 4 aug 2008, om 17:58 heeft Dirk Behme het volgende geschreven:

> From: Steve Sakoman <steve@sakoman.com>, Dirk Behme <dirk.behme@gmail.com 
> >
>
> Add nand support to omap3beagle
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>
> Index: linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
> ===================================================================
> --- linux-beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c
> +++ linux-beagle/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -20,11 +20,15 @@
> #include <linux/clk.h>
> #include <linux/io.h>
> #include <linux/leds.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
>
> #include <asm/hardware.h>
> #include <asm/mach-types.h>
> #include <asm/mach/arch.h>
> #include <asm/mach/map.h>
> +#include <asm/mach/flash.h>
>
> #include <asm/arch/gpio.h>
> #include <asm/arch/board.h>
> @@ -32,6 +36,64 @@
> #include <asm/arch/usb-ehci.h>
> #include <asm/arch/hsmmc.h>
> #include <asm/arch/common.h>
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
>
> static struct omap_uart_config omap3_beagle_uart_config __initdata = {
> 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> @@ -113,6 +175,44 @@ static struct platform_device *omap3_bea
> 	&leds_gpio,
> };
>
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
> +
> static void __init omap3_beagle_init(void)
> {
> 	platform_add_devices(omap3_beagle_devices,  
> ARRAY_SIZE(omap3_beagle_devices));
> @@ -122,6 +222,7 @@ static void __init omap3_beagle_init(voi
> 	hsmmc_init();
> 	usb_musb_init();
> 	usb_ehci_init();
> +	omap3beagle_flash_init();
> }
>
> arch_initcall(omap3_beagle_i2c_init);


--Apple-Mail-11--958114576
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIly31MkyGM64RGpERAs5bAJ4m2mH+KO1aq7ELB6QhDzMlcNvawACgpUBZ
yzt8zS8I+wH3bp9I8/8qxLk=
=grlp
-----END PGP SIGNATURE-----

--Apple-Mail-11--958114576--
