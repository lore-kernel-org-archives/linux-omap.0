From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init()
 visible to board code
Date: Fri, 27 Apr 2012 11:30:00 +0200
Message-ID: <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
	<CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52165 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab2D0JaA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 05:30:00 -0400
Received: by obbta14 with SMTP id ta14so810587obb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 02:30:00 -0700 (PDT)
In-Reply-To: <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb=C3=B2 i Serra
<eballetbo@gmail.com> wrote:
> 2012/4/4 Javier Martinez Canillas <javier@dowhile0.org>:
>> board_onenand_init() and board_nand_init() initialization functions =
are
>> used to initialize OneNAND and NAND memories respectively. But only
>> board_nand_init() was visible to be used from board code. This patch=
 makes
>> possible to initialize a OneNAND flash memory within platform code.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>> =C2=A0arch/arm/mach-omap2/board-flash.c | =C2=A0 =C2=A04 ++--
>> =C2=A0arch/arm/mach-omap2/board-flash.h | =C2=A0 11 +++++++++++
>> =C2=A02 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2=
/board-flash.c
>> index 0349fd2..70a81f9 100644
>> --- a/arch/arm/mach-omap2/board-flash.c
>> +++ b/arch/arm/mach-omap2/board-flash.c
>> @@ -87,7 +87,7 @@ static struct omap_onenand_platform_data board_one=
nand_data =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dma_channel =C2=A0 =C2=A0=3D -1, =C2=A0 =
/* disable DMA in OMAP OneNAND driver */
>> =C2=A0};
>>
>> -static void
>> +void
>> =C2=A0__init board_onenand_init(struct mtd_partition *onenand_parts,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 nr_parts, u8 cs)
>> =C2=A0{
>> @@ -98,7 +98,7 @@ __init board_onenand_init(struct mtd_partition *on=
enand_parts,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0gpmc_onenand_init(&board_onenand_data);
>> =C2=A0}
>> =C2=A0#else
>> -static void
>> +void
>> =C2=A0__init board_onenand_init(struct mtd_partition *nor_parts, u8 =
nr_parts, u8 cs)
>> =C2=A0{
>> =C2=A0}
>> diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2=
/board-flash.h
>> index d25503a..c44b70d 100644
>> --- a/arch/arm/mach-omap2/board-flash.h
>> +++ b/arch/arm/mach-omap2/board-flash.h
>> @@ -47,3 +47,14 @@ static inline void board_nand_init(struct mtd_par=
tition *nand_parts,
>> =C2=A0{
>> =C2=A0}
>> =C2=A0#endif
>> +
>> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defined(CONFIG_MT=
D_ONENAND_OMAP2_MODULE)
>> +extern void board_onenand_init(struct mtd_partition *nand_parts,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 n=
r_parts, u8 cs);
>> +#else
>> +static inline void board_onenand_init(struct mtd_partition *nand_pa=
rts,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 n=
r_parts, u8 cs)
>> +{
>> +}
>> +#endif
>> --
>> 1.7.7.6
>>
>
> Seems good to me.
>
> Tony, as this is a fix ,may be included ?
>
> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>
> Cheers,
> =C2=A0 =C2=A0Enric

Hi Tony, Russel:

This patch is a requirement for patch:

[RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flash
storage memory

which is really important since newer IGEPv2 boards have changed their
flash memory from OneNAND to NAND.

This patch-set is necessary to make the board work, otherwise it
doesn't even boot.

Could we please include these patches?

Thanks a lot and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
