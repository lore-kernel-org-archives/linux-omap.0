From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mtd: make onenand/generic.c more generic
Date: Wed, 5 Aug 2009 13:24:28 +0900
Message-ID: <9c9fda240908042124y4f783dfehd575601c0a09550e@mail.gmail.com>
References: <20090804092046.16025.83910.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20090804092046.16025.83910.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, tony@atomide.com, lethal@linux-sh.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Hi

Good idea add the onenand_platform_data, but dont' agree the renaming
the onenand-flash.
Other boards are use it even though it's not released it

Others are good.

Thank you,
Kyungmin Park

On Tue, Aug 4, 2009 at 6:20 PM, Magnus Damm<magnus.damm@gmail.com> wrot=
e:
> From: Magnus Damm <damm@igel.co.jp>
>
> This patch removes the ARM dependency from the generic "onenand"
> platform device driver. This change makes the driver useful for
> other architectures as well. Needed for the SuperH kfr2r09 board.
>
> Apart from the obvious Kconfig bits, the most important change
> is the move away from ARM specific includes and platform data.
> Together with this change the only in-tree board code gets an
> update, and the driver name is also changed gracefully break
> potential out of tree drivers.
>
> The driver is also updated to allow NULL as platform data together
> with a few changes to make use of resource_size() and dev_name().
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
>
> =A0Tested on the sh7724 kfr2r09 board with a separate platform data p=
atch.
>
> =A0arch/arm/mach-omap2/board-apollon.c | =A0 =A04 ++--
> =A0drivers/mtd/onenand/Kconfig =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/mtd/onenand/generic.c =A0 =A0 =A0 | =A0 24 ++++++++++++++-=
---------
> =A0include/linux/mtd/onenand.h =A0 =A0 =A0 =A0 | =A0 =A08 ++++++++
> =A04 files changed, 24 insertions(+), 13 deletions(-)
>
> --- 0001/arch/arm/mach-omap2/board-apollon.c
> +++ work/arch/arm/mach-omap2/board-apollon.c =A0 =A02009-08-04 17:01:=
18.000000000 +0900
> @@ -87,7 +87,7 @@ static struct mtd_partition apollon_part
> =A0 =A0 =A0 =A0},
> =A0};
>
> -static struct flash_platform_data apollon_flash_data =3D {
> +static struct onenand_platform_data apollon_flash_data =3D {
> =A0 =A0 =A0 =A0.parts =A0 =A0 =A0 =A0 =A0=3D apollon_partitions,
> =A0 =A0 =A0 =A0.nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(apollon_partition=
s),
> =A0};
> @@ -99,7 +99,7 @@ static struct resource apollon_flash_res
> =A0};
>
> =A0static struct platform_device apollon_onenand_device =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "onenand",
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "onenand-flash",
> =A0 =A0 =A0 =A0.id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> =A0 =A0 =A0 =A0.dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &apollon_flash_d=
ata,
> --- 0001/drivers/mtd/onenand/Kconfig
> +++ work/drivers/mtd/onenand/Kconfig =A0 =A02009-08-04 17:01:18.00000=
0000 +0900
> @@ -23,7 +23,6 @@ config MTD_ONENAND_VERIFY_WRITE
>
> =A0config MTD_ONENAND_GENERIC
> =A0 =A0 =A0 =A0tristate "OneNAND Flash device via platform device dri=
ver"
> - =A0 =A0 =A0 depends on ARM
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Support for OneNAND flash via platform device driv=
er.
>
> --- 0001/drivers/mtd/onenand/generic.c
> +++ work/drivers/mtd/onenand/generic.c =A02009-08-04 17:12:00.0000000=
00 +0900
> @@ -19,12 +19,16 @@
> =A0#include <linux/mtd/mtd.h>
> =A0#include <linux/mtd/onenand.h>
> =A0#include <linux/mtd/partitions.h>
> -
> =A0#include <asm/io.h>
> -#include <asm/mach/flash.h>
> -
> -#define DRIVER_NAME =A0 =A0"onenand"
>
> +/*
> + * Note: Driver name and platform data format have been updated!
> + *
> + * This version of the driver is named "onenand-flash" and takes str=
uct
> + * onenand_platform_data as platform data. The old ARM-specific vers=
ion
> + * with the name "onenand" used to take struct flash_platform_data.
> + */
> +#define DRIVER_NAME =A0 =A0"onenand-flash"
>
> =A0#ifdef CONFIG_MTD_PARTITIONS
> =A0static const char *part_probes[] =3D { "cmdlinepart", NULL, =A0};
> @@ -39,16 +43,16 @@ struct onenand_info {
> =A0static int __devinit generic_onenand_probe(struct platform_device =
*pdev)
> =A0{
> =A0 =A0 =A0 =A0struct onenand_info *info;
> - =A0 =A0 =A0 struct flash_platform_data *pdata =3D pdev->dev.platfor=
m_data;
> + =A0 =A0 =A0 struct onenand_platform_data *pdata =3D pdev->dev.platf=
orm_data;
> =A0 =A0 =A0 =A0struct resource *res =3D pdev->resource;
> - =A0 =A0 =A0 unsigned long size =3D res->end - res->start + 1;
> + =A0 =A0 =A0 unsigned long size =3D resource_size(res);
> =A0 =A0 =A0 =A0int err;
>
> =A0 =A0 =A0 =A0info =3D kzalloc(sizeof(struct onenand_info), GFP_KERN=
EL);
> =A0 =A0 =A0 =A0if (!info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 if (!request_mem_region(res->start, size, pdev->dev.dri=
ver->name)) {
> + =A0 =A0 =A0 if (!request_mem_region(res->start, size, dev_name(&pde=
v->dev))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EBUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_free_info;
> =A0 =A0 =A0 =A0}
> @@ -59,7 +63,7 @@ static int __devinit generic_onenand_pro
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_release_mem_region;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 info->onenand.mmcontrol =3D pdata->mmcontrol;
> + =A0 =A0 =A0 info->onenand.mmcontrol =3D pdata ? pdata->mmcontrol : =
0;
> =A0 =A0 =A0 =A0info->onenand.irq =3D platform_get_irq(pdev, 0);
>
> =A0 =A0 =A0 =A0info->mtd.name =3D dev_name(&pdev->dev);
> @@ -75,7 +79,7 @@ static int __devinit generic_onenand_pro
> =A0 =A0 =A0 =A0err =3D parse_mtd_partitions(&info->mtd, part_probes, =
&info->parts, 0);
> =A0 =A0 =A0 =A0if (err > 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_mtd_partitions(&info->mtd, info->p=
arts, err);
> - =A0 =A0 =A0 else if (err <=3D 0 && pdata->parts)
> + =A0 =A0 =A0 else if (err <=3D 0 && pdata && pdata->parts)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_mtd_partitions(&info->mtd, pdata->=
parts, pdata->nr_parts);
> =A0 =A0 =A0 =A0else
> =A0#endif
> @@ -99,7 +103,7 @@ static int __devexit generic_onenand_rem
> =A0{
> =A0 =A0 =A0 =A0struct onenand_info *info =3D platform_get_drvdata(pde=
v);
> =A0 =A0 =A0 =A0struct resource *res =3D pdev->resource;
> - =A0 =A0 =A0 unsigned long size =3D res->end - res->start + 1;
> + =A0 =A0 =A0 unsigned long size =3D resource_size(res);
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, NULL);
>
> --- 0001/include/linux/mtd/onenand.h
> +++ work/include/linux/mtd/onenand.h =A0 =A02009-08-04 17:01:18.00000=
0000 +0900
> @@ -214,4 +214,12 @@ unsigned onenand_block(struct onenand_ch
> =A0loff_t onenand_addr(struct onenand_chip *this, int block);
> =A0int flexonenand_region(struct mtd_info *mtd, loff_t addr);
>
> +struct mtd_partition;
> +
> +struct onenand_platform_data {
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*mmcontrol)(struct mtd_inf=
o *mtd, int sync_read);
> + =A0 =A0 =A0 struct mtd_partition *parts;
> + =A0 =A0 =A0 unsigned int =A0 =A0nr_parts;
> +};
> +
> =A0#endif /* __LINUX_MTD_ONENAND_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
