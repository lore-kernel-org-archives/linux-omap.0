From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 16/23] usb: host: ehci: add
	platform_data
Date: Wed, 25 Feb 2009 00:39:38 +0200
Message-ID: <20090224223937.GC4879@gandalf>
References: <1235415335-17408-9-git-send-email-me@felipebalbi.com> <1235415335-17408-10-git-send-email-me@felipebalbi.com> <1235415335-17408-11-git-send-email-me@felipebalbi.com> <1235415335-17408-12-git-send-email-me@felipebalbi.com> <1235415335-17408-13-git-send-email-me@felipebalbi.com> <1235415335-17408-14-git-send-email-me@felipebalbi.com> <1235415335-17408-15-git-send-email-me@felipebalbi.com> <1235415335-17408-16-git-send-email-me@felipebalbi.com> <1235415335-17408-17-git-send-email-me@felipebalbi.com> <6ed0b2680902241435j6c11e093t66722c098a9c4ed@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58157 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275AbZBXWjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:39:53 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680902241435j6c11e093t66722c098a9c4ed@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>

On Wed, Feb 25, 2009 at 12:35:05AM +0200, Grazvydas Ignotas wrote:
> On Mon, Feb 23, 2009 at 8:55 PM, Felipe Balbi <me@felipebalbi.com> wr=
ote:
> > Adding a platform_data to the driver allow us
> > to remove some of the ifdeferry in the code.
> >
>=20
> <snip>
>=20
> > diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/ma=
ch-omap2/board-omap3pandora.c
> > index b8a78c0..08215c0 100644
> > --- a/arch/arm/mach-omap2/board-omap3pandora.c
> > +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> > @@ -297,7 +297,7 @@ static void __init omap3pandora_init(void)
> > =A0 =A0 =A0 =A0spi_register_board_info(omap3pandora_spi_board_info,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap3pand=
ora_spi_board_info));
> > =A0 =A0 =A0 =A0usb_musb_init();
> > - =A0 =A0 =A0 usb_ehci_init();
> > + =A0 =A0 =A0 usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57,=
 61);
>=20
> Perhaps it would be better to have .chargepump and .phy_reset set to
> false by default, as pandora doesn't need that chargepump thing (I
> guess some other boards too), and phy reset GPIO is wrong not only fo=
r
> pandora I think. Board maintainers can then send patches as needed.
> There also should be a way to specify only one reset GPIO, most board=
s
> have only one EHCI port I think. Note that .phy_reset is required for
> EHCI to work on pandora (in case you have thoughts of removing that
> code later).

I made it true by default because those where always true in PHY mode a=
s
of current driver. The correct way to do it, would be to move both to
board-file since those workarounds are board-specific.

We need a list of the boards that need the workarounds and a list of
those which don't need so we can move the workarounds to the
board-files.

>=20
> > diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/u=
sb-ehci.c
> > index 23fe857..30e1ad6 100644
> > --- a/arch/arm/mach-omap2/usb-ehci.c
> > +++ b/arch/arm/mach-omap2/usb-ehci.c
> > @@ -145,8 +145,20 @@ static void setup_ehci_io_mux(void)
> > =A0 =A0 =A0 =A0return;
> > =A0}
> >
> > -void __init usb_ehci_init(void)
> > +void __init usb_ehci_init(enum ehci_hcd_omap_mode phy_mode,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int chargepump, int phy_reset, int re=
set_gpio_port1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int reset_gpio_port2)
> > =A0{
> > + =A0 =A0 =A0 struct ehci_hcd_omap_platform_data pdata =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .phy_mode =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D phy_mode,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .chargepump =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 chargepump,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .phy_reset =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D phy_reset,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reset_gpio_port1 =A0 =A0 =A0 =3D res=
et_gpio_port1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reset_gpio_port2 =A0 =A0 =A0 =3D res=
et_gpio_port2,
> > + =A0 =A0 =A0 };
> > +
> > + =A0 =A0 =A0 ehci_device.dev.platform_data =3D &pdata;
> > +
>=20
> hmm, doesn't pdata end up on stack here? platform_device_register()
> doesn't seem to make a copy of that structure.

hmm... should make that __initconst and use
platform_device_add_data();

Will fix, thanks a lot

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
