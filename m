From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCHv2 14/15] OMAP: Panda, Beagle, Overo: DVI: Add i2c_bus_num
Date: Mon, 12 Sep 2011 11:58:21 +0200
Message-ID: <CAFqH_53ttom-c75NihgmMsckp4RQTpskXhYjAEAee2LWsHXW0g@mail.gmail.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	<1315818818-18733-15-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:55477 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab1ILJ6W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 05:58:22 -0400
In-Reply-To: <1315818818-18733-15-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

2011/9/12 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> Add i2c bus number for DVI output. The driver uses this to detect if =
a
> panel is connected and to read EDID.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-omap3beagle.c | =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-omap2/board-omap4panda.c =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-omap2/board-overo.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A01 +
> =C2=A03 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 26bc860..742ac45 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -206,6 +206,7 @@ static void beagle_disable_dvi(struct omap_dss_de=
vice *dssdev)
> =C2=A0static struct panel_dvi_platform_data dvi_panel =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_enable =3D beagle_enable_dvi,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_disable =3D beagle_disable_dvi,
> + =C2=A0 =C2=A0 =C2=A0 .i2c_bus_num =3D 3,
> =C2=A0};
>
> =C2=A0static struct omap_dss_device beagle_dvi_device =3D {
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index c35384e..a38ed273 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -458,6 +458,7 @@ static void omap4_panda_disable_dvi(struct omap_d=
ss_device *dssdev)
> =C2=A0static struct panel_dvi_platform_data omap4_dvi_panel =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_enable =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D omap4_panda_enable_dvi,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_disable =C2=A0 =C2=A0 =C2=A0 =3D=
 omap4_panda_disable_dvi,
> + =C2=A0 =C2=A0 =C2=A0 .i2c_bus_num =3D 3,
> =C2=A0};
>
> =C2=A0struct omap_dss_device omap4_panda_dvi_device =3D {
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/=
board-overo.c
> index 06064d5..da94376 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -186,6 +186,7 @@ static void overo_panel_disable_dvi(struct omap_d=
ss_device *dssdev)
> =C2=A0static struct panel_dvi_platform_data dvi_panel =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_enable =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D overo_panel_enable_dvi,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_disable =C2=A0 =C2=A0 =C2=A0 =3D=
 overo_panel_disable_dvi,
> + =C2=A0 =C2=A0 =C2=A0 .i2c_bus_num =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D 3,
> =C2=A0};
>
> =C2=A0static struct omap_dss_device overo_dvi_device =3D {
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Please, can also include the same modification for IGEP v2 board
(arch/arm/mach-omap2/board-igep0020.c) ?

Best regards,
   Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
