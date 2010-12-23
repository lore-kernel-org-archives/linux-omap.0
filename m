From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Thu, 23 Dec 2010 14:38:57 -0700
Message-ID: <AANLkTi=L+ZfwVy+O=oAXx8EHGisCdW1Pg4U+dQa4ZzEN@mail.gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com> <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34928 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0LWVjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 16:39:18 -0500
Received: by iyi12 with SMTP id 12so5344298iyi.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 13:39:18 -0800 (PST)
In-Reply-To: <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.miao@marvell.com>, Michael Hennerich <michael.hennerich@analog.com>, spi-devel-general <spi-devel-general@lists.sourceforge.net>

On Tue, Dec 21, 2010 at 10:56 AM, Ben Gamari <bgamari.foss@gmail.com> w=
rote:
> This mechanism is in large part stolen from the s3c64xx-spi module. T=
o
> use this functionality, one simply must define a set_level function t=
o
> set the CS state and a omap2_mcspi_csinfo struct for each chip select=
 in
> the board file.
>
> Each spi_board_info.controller_data should then be set
> to point to the appropriate csinfo struct. This will cause the driver=
 to
> call the csinfo->set_level function instead of toggling the McSPI chi=
p
> select lines.
>
> Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>

I'd rather see the spi driver modified to use the gpio api directly.
The drivers are already tending in that direction and it doesn't
require machine specific set_level functions to be defined.

g.

> ---
> =A0arch/arm/plat-omap/include/plat/mcspi.h | =A0 14 ++++++++++++++
> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 14 +++=
++++++-----
> =A02 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-=
omap/include/plat/mcspi.h
> index 1254e49..ab84b8d 100644
> --- a/arch/arm/plat-omap/include/plat/mcspi.h
> +++ b/arch/arm/plat-omap/include/plat/mcspi.h
> @@ -1,6 +1,20 @@
> =A0#ifndef _OMAP2_MCSPI_H
> =A0#define _OMAP2_MCSPI_H
>
> +/**
> + * struct omap2_mcspi_csinfo - Chip Select description
> + * @line: Custom 'identity' of the CS line
> + * @set_level: Function to set the state of a given CS line
> + *
> + * This is to allow use of GPIO lines as CS lines. Allocate and init=
ialize one
> + * in the machine init code and make spi_board_info.controller_data =
point to
> + * it.
> + */
> +struct omap2_mcspi_csinfo {
> + =A0 =A0 =A0 =A0unsigned line;
> + =A0 =A0 =A0 =A0void (*set_level)(unsigned line_id, int lvl);
> +};
> +
> =A0struct omap2_mcspi_platform_config {
> =A0 =A0 =A0 =A0unsigned short =A0num_cs;
> =A0};
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 2a651e6..92ccbd6 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -35,6 +35,7 @@
> =A0#include <linux/slab.h>
>
> =A0#include <linux/spi/spi.h>
> +#include <linux/gpio.h>
>
> =A0#include <plat/dma.h>
> =A0#include <plat/clock.h>
> @@ -235,11 +236,14 @@ static void omap2_mcspi_set_enable(const struct=
 spi_device *spi, int enable)
>
> =A0static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_ac=
tive)
> =A0{
> - =A0 =A0 =A0 u32 l;
> -
> - =A0 =A0 =A0 l =3D mcspi_cached_chconf0(spi);
> - =A0 =A0 =A0 MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
> - =A0 =A0 =A0 mcspi_write_chconf0(spi, l);
> + =A0 =A0 =A0 if (spi->controller_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap2_mcspi_csinfo *csinfo =3D s=
pi->controller_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*csinfo->set_level)(csinfo->line, cs_a=
ctive);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 l =3D mcspi_cached_chconf0(spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE=
, cs_active);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_chconf0(spi, l);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static void omap2_mcspi_set_master_mode(struct spi_master *master)
> --
> 1.7.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
