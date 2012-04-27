From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH] arm: igep0020: Specify the VPLL2 regulator unconditionally
Date: Fri, 27 Apr 2012 11:26:35 +0200
Message-ID: <CAFqH_53s3Vf5822yy8YU-dOq3P_miBD1uG1d+5NqefF=3__zGQ@mail.gmail.com>
References: <1335185338-22006-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41761 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757343Ab2D0J0g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 05:26:36 -0400
Received: by iadi9 with SMTP id i9so776905iad.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 02:26:35 -0700 (PDT)
In-Reply-To: <1335185338-22006-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>, Tony Lindgren <tony@atomide.com>

2012/4/23 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> The supply is connected to the DSS DO-D5 pins and is thus needed for
> both serial and parallel display interfaces on the igep0030 as well a=
s
> the igep0020.
>
> If the igep0030 module isn't connected to a display, no DSI or DPI
> display will be specified in board code, and the DSS driver won't ena=
ble
> to VPLL2 regulator anyway.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 10 +++++-----
> =C2=A01 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-oma=
p2/board-igep0020.c
> index a59ace0..242cdff 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -539,7 +539,10 @@ static void __init igep_i2c_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
>
> - =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_config(&igep_twldata, TWL_COMMO=
N_PDATA_USB, 0);
> + =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_config(&igep_twldata, TWL_COMMO=
N_PDATA_USB,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TWL_COMMON_REGULATOR_VPLL2);
> + =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2->constraints.apply_uV =3D t=
rue;
> + =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2->constraints.name =3D "VDVI=
";
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (machine_is_igep0020()) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> @@ -553,10 +556,7 @@ static void __init igep_i2c_init(void)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0igep_twldata.k=
eypad =C2=A0 =C2=A0 =3D &igep2_keypad_pdata;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get common =
pmic data */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_con=
fig(&igep_twldata, TWL_COMMON_PDATA_AUDIO,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TWL_COMMON_REG=
ULATOR_VPLL2);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2=
->constraints.apply_uV =3D true;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_twldata.vpll2=
->constraints.name =3D "VDVI";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3_pmic_get_con=
fig(&igep_twldata, TWL_COMMON_PDATA_AUDIO, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_pmic_init("twl4030", &igep_twldata);
> --
> Regards,
>
> Laurent Pinchart
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

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
