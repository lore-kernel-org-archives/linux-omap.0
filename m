From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/3] BeagleBoard: add support for the twl4030-madc
Date: Thu, 11 Aug 2011 12:44:05 +0300
Message-ID: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
References: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
	<1313033272-16774-4-git-send-email-kyle@kylemanna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45868 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1HKJoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 05:44:05 -0400
Received: by yxj19 with SMTP id 19so1187792yxj.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 02:44:05 -0700 (PDT)
In-Reply-To: <1313033272-16774-4-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyle Manna <kyle@kylemanna.com>
Cc: linux-omap@vger.kernel.org

You need to CC linux-arm-kernel too.

On Thu, Aug 11, 2011 at 6:27 AM, Kyle Manna <kyle@kylemanna.com> wrote:
> Signed-off-by: Kyle Manna <kyle@kylemanna.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-omap3beagle.c | =C2=A0 11 +++++++++++
> =C2=A01 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 3ae16b4..a82d53b 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -362,11 +362,16 @@ static struct regulator_init_data beagle_vsim =3D=
 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D=
 beagle_vsim_supply,
> =C2=A0};
>
> +static struct twl4030_madc_platform_data beagle_madc =3D {
> + =C2=A0 =C2=A0 =C2=A0 .irq_line =C2=A0 =C2=A0 =C2=A0 =3D 1,
> +};
> +
> =C2=A0static struct twl4030_platform_data beagle_twldata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* platform_data for children goes here */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 &beagle_gpio_data,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.vmmc1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &beagle_vmmc1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.vsim =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 &beagle_vsim,
> + =C2=A0 =C2=A0 =C2=A0 .madc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &=
beagle_madc,
> =C2=A0};

Basically all boards with twl4030 might want to have this, maybe add
this to twl-common.c instead to avoid code duplication?



--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
