From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init()
 visible to board code
Date: Wed, 25 Apr 2012 09:59:33 +0200
Message-ID: <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34013 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2DYH7d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 03:59:33 -0400
Received: by iadi9 with SMTP id i9so2155461iad.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 00:59:33 -0700 (PDT)
In-Reply-To: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

2012/4/4 Javier Martinez Canillas <javier@dowhile0.org>:
> board_onenand_init() and board_nand_init() initialization functions a=
re
> used to initialize OneNAND and NAND memories respectively. But only
> board_nand_init() was visible to be used from board code. This patch =
makes
> possible to initialize a OneNAND flash memory within platform code.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
> =C2=A0arch/arm/mach-omap2/board-flash.c | =C2=A0 =C2=A04 ++--
> =C2=A0arch/arm/mach-omap2/board-flash.h | =C2=A0 11 +++++++++++
> =C2=A02 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/=
board-flash.c
> index 0349fd2..70a81f9 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -87,7 +87,7 @@ static struct omap_onenand_platform_data board_onen=
and_data =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dma_channel =C2=A0 =C2=A0=3D -1, =C2=A0 /=
* disable DMA in OMAP OneNAND driver */
> =C2=A0};
>
> -static void
> +void
> =C2=A0__init board_onenand_init(struct mtd_partition *onenand_parts,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 nr_parts, u8 cs)
> =C2=A0{
> @@ -98,7 +98,7 @@ __init board_onenand_init(struct mtd_partition *one=
nand_parts,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gpmc_onenand_init(&board_onenand_data);
> =C2=A0}
> =C2=A0#else
> -static void
> +void
> =C2=A0__init board_onenand_init(struct mtd_partition *nor_parts, u8 n=
r_parts, u8 cs)
> =C2=A0{
> =C2=A0}
> diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/=
board-flash.h
> index d25503a..c44b70d 100644
> --- a/arch/arm/mach-omap2/board-flash.h
> +++ b/arch/arm/mach-omap2/board-flash.h
> @@ -47,3 +47,14 @@ static inline void board_nand_init(struct mtd_part=
ition *nand_parts,
> =C2=A0{
> =C2=A0}
> =C2=A0#endif
> +
> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defined(CONFIG_MTD=
_ONENAND_OMAP2_MODULE)
> +extern void board_onenand_init(struct mtd_partition *nand_parts,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 nr_p=
arts, u8 cs);
> +#else
> +static inline void board_onenand_init(struct mtd_partition *nand_par=
ts,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 nr_p=
arts, u8 cs)
> +{
> +}
> +#endif
> --
> 1.7.7.6
>

Seems good to me.

Tony, as this is a fix ,may be included ?

Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Cheers,
    Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
