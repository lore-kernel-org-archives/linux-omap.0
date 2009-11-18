From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-v5 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
Date: Wed, 18 Nov 2009 09:07:46 -0800
Message-ID: <20091118170745.GL29266@atomide.com>
References: <ce9ab5790911100208g42c886b3g13261ea8a1d79a04@mail.gmail.com>
 <20091112204428.GC24837@atomide.com>
 <ce9ab5790911180638x70da2e61n964f94d61d403adc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52472 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491AbZKRRHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 12:07:43 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5790911180638x70da2e61n964f94d61d403adc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

* Vimal Singh <vimal.newwork@gmail.com> [091118 06:38]:
> Tony,
>=20
> On Fri, Nov 13, 2009 at 2:14 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Vimal Singh <vimal.newwork@gmail.com> [091110 02:08]:
> >> From 6f535d7128ca392458dd0cb31d138cda84747c06 Mon Sep 17 00:00:00 =
2001
> >> From: Vimal Singh <vimalsingh@ti.com>
> >> Date: Tue, 10 Nov 2009 11:42:45 +0530
> >> Subject: [PATCH] OMAP3: Add support for NAND on ZOOM2/LDP boards
>=20
> [...]
>=20
> >> +static int omap_ldp_nand_unlock(struct mtd_info *mtd, loff_t ofs,=
 uint64_t len)
> >> +{
> >> + =A0 =A0 int ret =3D 0;
> >> + =A0 =A0 int chipnr;
> >> + =A0 =A0 int status;
> >> + =A0 =A0 unsigned long page;
> >> + =A0 =A0 struct nand_chip *this =3D mtd->priv;
> >> + =A0 =A0 printk(KERN_INFO "nand_unlock: start: %08x, length: %d!\=
n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (int)ofs, (int)len);
> >> +
> >> + =A0 =A0 /* select the NAND device */
> >> + =A0 =A0 chipnr =3D (int)(ofs >> this->chip_shift);
> >> + =A0 =A0 this->select_chip(mtd, chipnr);
> >> + =A0 =A0 /* check the WP bit */
> >> + =A0 =A0 this->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
> >> + =A0 =A0 if ((this->read_byte(mtd) & 0x80) =3D=3D 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Device is =
write protected!\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if ((ofs & (mtd->writesize - 1)) !=3D 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Start addr=
ess must be"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "beginni=
ng of nand page!\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if (len =3D=3D 0 || (len & (mtd->writesize - 1)) !=3D 0)=
 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Length mus=
t be a multiple of "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "nand pa=
ge size!\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* submit address of first page to unlock */
> >> + =A0 =A0 page =3D (unsigned long)(ofs >> this->page_shift);
> >> + =A0 =A0 this->cmdfunc(mtd, NAND_CMD_UNLOCK1, -1, page & this->pa=
gemask);
> >> +
> >> + =A0 =A0 /* submit ADDRESS of LAST page to unlock */
> >> + =A0 =A0 page +=3D (unsigned long)((ofs + len) >> this->page_shif=
t) ;
> >> + =A0 =A0 this->cmdfunc(mtd, NAND_CMD_UNLOCK2, -1, page & this->pa=
gemask);
> >> +
> >> + =A0 =A0 /* call wait ready function */
> >> + =A0 =A0 status =3D this->waitfunc(mtd, this);
> >> + =A0 =A0 udelay(1000);
> >> + =A0 =A0 /* see if device thinks it succeeded */
> >> + =A0 =A0 if (status & 0x01) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* there was an error */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: error stat=
us =3D0x%08x ", status);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + out:
> >> + =A0 =A0 /* de-select the NAND device */
> >> + =A0 =A0 this->select_chip(mtd, -1);
> >> + =A0 =A0 return ret;
> >> +}
> >
> > Isn't the unlocking generic to the NAND device driver? Or is it som=
ehow board
> > specific?
>=20
> Yes, zoom2 boards come up with whole NAND locked, whereas it is not
> case for SDP boards.

But the procedure should be done under drivers/mtd I believe using some
standard tools.
=20
> >
> >
> >> +static struct mtd_partition ldp_nand_partitions[] =3D {
> >> + =A0 =A0 /* All the partition sizes are listed in terms of NAND b=
lock size */
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loader-=
NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * (64 * =
2048), =A0 =A0 =A0/* 512KB, 0x80000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0=
 =A0 =A0 =A0/* force read-only */
> >> + =A0 =A0 },
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boot-NA=
ND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_=
APPEND, =A0 /* Offset =3D 0x80000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 10 * (64 *=
 2048), =A0 =A0 /* 1.25MB, 0x140000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABLE, =A0=
 =A0 =A0 =A0/* force read-only */
> >> + =A0 =A0 },
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Boot Env-=
NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_=
APPEND, =A0 /* Offset =3D 0x1c0000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 2 * (64 * =
2048), =A0 =A0 =A0/* 256KB, 0x40000 */
> >> + =A0 =A0 },
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kernel-NA=
ND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_=
APPEND, =A0 /* Offset =3D 0x0200000*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 240 * (64 =
* 2048), =A0 =A0/* 30M, 0x1E00000 */
> >> + =A0 =A0 },
> >> +#ifdef CONFIG_MACH_OMAP_ZOOM2
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "system",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_=
APPEND, =A0 /* Offset =3D 0x2000000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 1280 * (64=
 * 2048), =A0 /* 160M, 0xA000000 */
> >> + =A0 =A0 },
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "userdata"=
,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_=
APPEND, =A0 /* Offset =3D 0xC000000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 256 * (64 =
* 2048), =A0 =A0/* 32M, 0x2000000 */
> >> + =A0 =A0 },
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "cache",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_=
APPEND, =A0 /* Offset =3D 0xE000000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 256 * (64 =
* 2048), =A0 =A0/* 32M, 0x2000000 */
> >> + =A0 =A0 },
> >> +#else
> >> + =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File Syst=
em - NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_OFS_=
APPEND, =A0 /* Offset =3D 0x2000000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPART_SI=
Z_FULL, =A0 =A0 /* 96MB, 0x6000000 */
> >> + =A0 =A0 },
> >> +#endif
> >
> > Please remove the ifdefs, you should be able to compile in all mach=
-omap2
> > boards into the same kernel binary. You should set the size dynamic=
ally as
> > needed.
>=20
> We can always provide partitioning information from cmdline
> (mtdparts:). Which will anyway have higher precedence than this. Here
> are trying provide default static partitions. Which IMHO is fine.
>=20
> see this too:
> http://marc.info/?l=3Dlinux-omap&m=3D125178914327011&w=3D2

No way we're adding any more of these ifdef else hacks.

The whole idea of the platform_data is to pass the board specific
configuration to the driver. The driver should be generic.


>=20
> >
> >
> >> +};
> >> +
> >> +/* NAND chip access: 16 bit */
> >> +static struct omap_nand_platform_data ldp_nand_data =3D {
> >> + =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D ldp_nand_partitions,
> >> + =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(ldp_nand_partitions=
),
> >> + =A0 =A0 .nand_setup =A0 =A0 =3D NULL,
> >> + =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disab=
le DMA in OMAP NAND driver */
> >> + =A0 =A0 .dev_ready =A0 =A0 =A0=3D NULL,
> >> + =A0 =A0 .unlock =A0 =A0 =A0 =A0 =3D omap_ldp_nand_unlock,
> >> +};
> >> +
> >> +static struct resource ldp_nand_resource =3D {
> >> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> >> +};
> >> +
> >> +static struct platform_device ldp_nand_device =3D {
> >> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2-nand",
> >> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> >> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> >> + =A0 =A0 .platform_data =A0=3D &ldp_nand_data,
> >> + =A0 =A0 },
> >> + =A0 =A0 .num_resources =A0=3D 1,
> >> + =A0 =A0 .resource =A0 =A0 =A0 =3D &ldp_nand_resource,
> >> +};
> >> +
> >> +/**
> >> + * ldp430_flash_init - Identify devices connected to GPMC and reg=
ister.
> >> + *
> >> + * @return - void.
> >> + */
> >> +void __init zoom_flash_init(void)
> >> +{
> >> + =A0 =A0 u8 nandcs =3D GPMC_CS_NUM + 1;
> >> + =A0 =A0 u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
> >> +
> >> + =A0 =A0 /* pop nand part */
> >> + =A0 =A0 nandcs =3D LDP3430_NAND_CS;
> >> +
> >> + =A0 =A0 ldp_nand_data.cs =3D nandcs;
> >> + =A0 =A0 ldp_nand_data.gpmc_cs_baseaddr =3D (void *)(gpmc_base_ad=
d +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
> >> + =A0 =A0 ldp_nand_data.gpmc_baseaddr =3D (void *) (gpmc_base_add)=
;
> >> +
> >> + =A0 =A0 if (platform_device_register(&ldp_nand_device) < 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to register NAND=
 device\n");
> >> +}
> >
> > This too should use gpmc_cs_request().
>=20
> This is just platform data, needed by nand driver (nand/omap2.c).
> 'gpmc_cs_request' is separately done in mentioned driver. And IMO tha=
t
> is the correct place to do this, as every time (when driver is
> compiled as module) inserting and de-inserting driver, will need this=
=2E

Without gpmc_cs_request the GPMC can be in uninitialized state.
You're basically relying on some hardcoded values from the bootloader,
which can be at whatever version and whatever bootloader. Not good.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
