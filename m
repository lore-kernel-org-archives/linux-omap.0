From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2 v3] OMAP-McSPI: Update platform McSPI files
Date: Fri, 13 Aug 2010 16:25:24 -0600
Message-ID: <AANLkTikGagiRWqnsGazt20U8dXjx-gkeY6rd6610mcT=@mail.gmail.com>
References: <65423.192.168.10.88.1281707926.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44386 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab0HMWZp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 18:25:45 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so243497iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 15:25:45 -0700 (PDT)
In-Reply-To: <65423.192.168.10.88.1281707926.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, dbrownell@users.sourceforge.net, Hemanth V <hemanthv@ti.com>

Hi Hermanth,

A few comments below.  I imagine to avoid ordering issues, both of
these patches should be merged through the spi tree?

On Fri, Aug 13, 2010 at 7:58 AM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
>
> From: Hemanth V <hemanthv@ti.com>
>
> This patch updates platform files for fifo, slave support.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Hemanth V <hemanthv@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A0arch/arm/plat-omap/include/plat/mcspi.h | =A0 29 +++++++++++++++++=
+++++++++++-
> =A02 files changed, 33 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index 2dbb265..fa99da1 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -251,6 +251,7 @@ static inline void omap_init_sti(void) {}
>
> =A0static struct omap2_mcspi_platform_config omap2_mcspi1_config =3D =
{
> =A0 =A0 =A0 =A0.num_cs =A0 =A0 =A0 =A0 =3D 4,
> + =A0 =A0 =A0 .force_cs_mode =A0=3D 1,
> =A0};
>
> =A0static struct resource omap2_mcspi1_resources[] =3D {
> @@ -273,6 +274,10 @@ static struct platform_device omap2_mcspi1 =3D {
>
> =A0static struct omap2_mcspi_platform_config omap2_mcspi2_config =3D =
{
> =A0 =A0 =A0 =A0.num_cs =A0 =A0 =A0 =A0 =3D 2,
> + =A0 =A0 =A0 .mode =A0 =A0 =A0 =A0 =A0 =3D OMAP2_MCSPI_MASTER,
> + =A0 =A0 =A0 .dma_mode =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .force_cs_mode =A0=3D 0,
> + =A0 =A0 =A0 .fifo_depth =A0 =A0 =3D 0,
> =A0};
>
> =A0static struct resource omap2_mcspi2_resources[] =3D {
> diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-=
omap/include/plat/mcspi.h
> index 1254e49..23b928b 100644
> --- a/arch/arm/plat-omap/include/plat/mcspi.h
> +++ b/arch/arm/plat-omap/include/plat/mcspi.h
> @@ -1,8 +1,35 @@
> =A0#ifndef _OMAP2_MCSPI_H
> =A0#define _OMAP2_MCSPI_H
>
> +#define OMAP2_MCSPI_MASTER =A0 =A0 =A0 =A0 =A0 =A0 0
> +#define OMAP2_MCSPI_SLAVE =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +
> +/**
> + * struct omap2_mcspi_platform_config - McSPI controller configurati=
on
> + * @num_cs: Number of chip selects or channels supported
> + * @mode: SPI is master or slave

There is currently no infrastructure for supporting SPI slave mode in
drivers/spi.  How is this intended to be implemented?

> + * @dma_mode: Use only DMA for data transfers
> + * @force_cs_mode: Use force chip select mode or auto chip select mo=
de
> + * @fifo_depth: FIFO depth in bytes, max value 64
> + *
> + * @dma_mode when set to 1 uses only dma for data transfers
> + * else the default behaviour is to use PIO mode for transfer
> + * size of 8 bytes or less. This mode is useful when mcspi
> + * is configured as slave
> + *
> + * @force_cs_mode when set to 1 allows continuous transfer of multip=
le
> + * spi words without toggling the chip select line.

The SPI subsystem already supports exactly this.  The spi bus driver
must support sending a single spi message with multiple words and
transfers without toggling the CS line.  If it doesn't, then the
driver is buggy.

> + *
> + * @fifo_depth when set to non zero values enables FIFO. fifo_depth
> + * should be set as a multiple of buffer size used for read/write.
> + */
> +
> =A0struct omap2_mcspi_platform_config {
> - =A0 =A0 =A0 unsigned short =A0num_cs;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0num_cs;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0mode;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0dma_mode;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0force_cs_mode;
> + =A0 =A0 =A0 unsigned short fifo_depth;
> =A0};
>
> =A0struct omap2_mcspi_device_config {
> --
> 1.6.3.3
>
>
>
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
