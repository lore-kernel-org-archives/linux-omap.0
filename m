From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 14/15] OMAP: Panda, Beagle, Overo: DVI: Add
 i2c_bus_num
Date: Mon, 12 Sep 2011 13:17:25 +0300
Message-ID: <1315822645.2177.23.camel@deskari>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	 <1315818818-18733-15-git-send-email-tomi.valkeinen@ti.com>
	 <CAFqH_53ttom-c75NihgmMsckp4RQTpskXhYjAEAee2LWsHXW0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:43767 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204Ab1ILKRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 06:17:31 -0400
In-Reply-To: <CAFqH_53ttom-c75NihgmMsckp4RQTpskXhYjAEAee2LWsHXW0g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?ISO-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Mon, 2011-09-12 at 11:58 +0200, Enric Balletb=C3=B2 i Serra wrote:
> 2011/9/12 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> > Add i2c bus number for DVI output. The driver uses this to detect i=
f a
> > panel is connected and to read EDID.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3beagle.c |    1 +
> >  arch/arm/mach-omap2/board-omap4panda.c  |    1 +
> >  arch/arm/mach-omap2/board-overo.c       |    1 +
> >  3 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mac=
h-omap2/board-omap3beagle.c
> > index 26bc860..742ac45 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -206,6 +206,7 @@ static void beagle_disable_dvi(struct omap_dss_=
device *dssdev)
> >  static struct panel_dvi_platform_data dvi_panel =3D {
> >        .platform_enable =3D beagle_enable_dvi,
> >        .platform_disable =3D beagle_disable_dvi,
> > +       .i2c_bus_num =3D 3,
> >  };
> >
> >  static struct omap_dss_device beagle_dvi_device =3D {
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach=
-omap2/board-omap4panda.c
> > index c35384e..a38ed273 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -458,6 +458,7 @@ static void omap4_panda_disable_dvi(struct omap=
_dss_device *dssdev)
> >  static struct panel_dvi_platform_data omap4_dvi_panel =3D {
> >        .platform_enable        =3D omap4_panda_enable_dvi,
> >        .platform_disable       =3D omap4_panda_disable_dvi,
> > +       .i2c_bus_num =3D 3,
> >  };
> >
> >  struct omap_dss_device omap4_panda_dvi_device =3D {
> > diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap=
2/board-overo.c
> > index 06064d5..da94376 100644
> > --- a/arch/arm/mach-omap2/board-overo.c
> > +++ b/arch/arm/mach-omap2/board-overo.c
> > @@ -186,6 +186,7 @@ static void overo_panel_disable_dvi(struct omap=
_dss_device *dssdev)
> >  static struct panel_dvi_platform_data dvi_panel =3D {
> >        .platform_enable        =3D overo_panel_enable_dvi,
> >        .platform_disable       =3D overo_panel_disable_dvi,
> > +       .i2c_bus_num            =3D 3,
> >  };
> >
> >  static struct omap_dss_device overo_dvi_device =3D {
> > --
> > 1.7.4.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
> Please, can also include the same modification for IGEP v2 board
> (arch/arm/mach-omap2/board-igep0020.c) ?

Sure. You have tested that the i2c bus is 3 and it works?

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
