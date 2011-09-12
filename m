From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCHv2 14/15] OMAP: Panda, Beagle, Overo: DVI: Add i2c_bus_num
Date: Mon, 12 Sep 2011 13:13:57 +0200
Message-ID: <CAFqH_53id=7S5B0yWFgp=O7zBH92C6jKQhTsVZzvs9yAjrzLLg@mail.gmail.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	<1315818818-18733-15-git-send-email-tomi.valkeinen@ti.com>
	<CAFqH_53ttom-c75NihgmMsckp4RQTpskXhYjAEAee2LWsHXW0g@mail.gmail.com>
	<1315822645.2177.23.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55962 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab1ILLN7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 07:13:59 -0400
In-Reply-To: <1315822645.2177.23.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

2011/9/12 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On Mon, 2011-09-12 at 11:58 +0200, Enric Balletb=C3=B2 i Serra wrote:
>> 2011/9/12 Tomi Valkeinen <tomi.valkeinen@ti.com>:
>> > Add i2c bus number for DVI output. The driver uses this to detect =
if a
>> > panel is connected and to read EDID.
>> >
>> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> > ---
>> > =C2=A0arch/arm/mach-omap2/board-omap3beagle.c | =C2=A0 =C2=A01 +
>> > =C2=A0arch/arm/mach-omap2/board-omap4panda.c =C2=A0| =C2=A0 =C2=A0=
1 +
>> > =C2=A0arch/arm/mach-omap2/board-overo.c =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A01 +
>> > =C2=A03 files changed, 3 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/ma=
ch-omap2/board-omap3beagle.c
>> > index 26bc860..742ac45 100644
>> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> > @@ -206,6 +206,7 @@ static void beagle_disable_dvi(struct omap_dss=
_device *dssdev)
>> > =C2=A0static struct panel_dvi_platform_data dvi_panel =3D {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_enable =3D beagle_enable_dvi,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_disable =3D beagle_disable_dv=
i,
>> > + =C2=A0 =C2=A0 =C2=A0 .i2c_bus_num =3D 3,
>> > =C2=A0};
>> >
>> > =C2=A0static struct omap_dss_device beagle_dvi_device =3D {
>> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mac=
h-omap2/board-omap4panda.c
>> > index c35384e..a38ed273 100644
>> > --- a/arch/arm/mach-omap2/board-omap4panda.c
>> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> > @@ -458,6 +458,7 @@ static void omap4_panda_disable_dvi(struct oma=
p_dss_device *dssdev)
>> > =C2=A0static struct panel_dvi_platform_data omap4_dvi_panel =3D {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_enable =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D omap4_panda_enable_dvi,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_disable =C2=A0 =C2=A0 =C2=A0 =
=3D omap4_panda_disable_dvi,
>> > + =C2=A0 =C2=A0 =C2=A0 .i2c_bus_num =3D 3,
>> > =C2=A0};
>> >
>> > =C2=A0struct omap_dss_device omap4_panda_dvi_device =3D {
>> > diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-oma=
p2/board-overo.c
>> > index 06064d5..da94376 100644
>> > --- a/arch/arm/mach-omap2/board-overo.c
>> > +++ b/arch/arm/mach-omap2/board-overo.c
>> > @@ -186,6 +186,7 @@ static void overo_panel_disable_dvi(struct oma=
p_dss_device *dssdev)
>> > =C2=A0static struct panel_dvi_platform_data dvi_panel =3D {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_enable =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D overo_panel_enable_dvi,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_disable =C2=A0 =C2=A0 =C2=A0 =
=3D overo_panel_disable_dvi,
>> > + =C2=A0 =C2=A0 =C2=A0 .i2c_bus_num =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 3,
>> > =C2=A0};
>> >
>> > =C2=A0static struct omap_dss_device overo_dvi_device =3D {
>> > --
>> > 1.7.4.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>> >
>>
>> Please, can also include the same modification for IGEP v2 board
>> (arch/arm/mach-omap2/board-igep0020.c) ?
>
> Sure. You have tested that the i2c bus is 3 and it works?

Yes, the i2c bus is 3 on IGEP v2 board and I'm just testing and seem is=
 working.

>
> =C2=A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
