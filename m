From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/25] OMAPDSS: clean up the omapdss platform data mess
Date: Fri, 04 May 2012 11:32:00 +0300
Message-ID: <1336120320.2701.1.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <1336053481-25433-9-git-send-email-tomi.valkeinen@ti.com>
	 <4FA369D2.1070809@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-l6ME3ihRUx6ePHtS6TEI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:38992 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752655Ab2EDIcK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 04:32:10 -0400
Received: by lagv3 with SMTP id v3so2237881lag.41
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 01:32:07 -0700 (PDT)
In-Reply-To: <4FA369D2.1070809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-l6ME3ihRUx6ePHtS6TEI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 11:02 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Thursday 03 May 2012 07:27 PM, Tomi Valkeinen wrote:
> > The omapdss pdata handling is a mess. This is more evident when trying
> > to use device tree for DSS, as we don't have platform data anymore in
> > that case. This patch cleans the pdata handling by:
> >
> > - Remove struct omap_display_platform_data. It was used just as a
> >    wrapper for struct omap_dss_board_info.
> > - Pass the platform data only to omapdss device. The drivers for omap
> >    dss hwmods do not need the platform data. This should also work bett=
er
> >    for DT, as we can create omapdss device programmatically in generic =
omap
> >    boot code, and thus we can pass the pdata to it.
> > - Create dss functions for get_ctx_loss_count and dsi_enable/disable_pa=
ds
> >    that the dss hwmod drivers can call.
> >
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> > ---
> >   arch/arm/mach-omap2/display.c   |   39 +++++++++++++++++++-----------=
---------
> >   drivers/video/omap2/dss/core.c  |   35 ++++++++++++++++++++++++++++++=
+++++
> >   drivers/video/omap2/dss/dispc.c |   21 ++-------------------
> >   drivers/video/omap2/dss/dsi.c   |   17 +++--------------
> >   drivers/video/omap2/dss/dss.h   |    3 +++
> >   drivers/video/omap2/dss/hdmi.c  |    2 --
> >   include/video/omapdss.h         |    5 -----
> >   7 files changed, 62 insertions(+), 60 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/displa=
y.c
> > index 60cded4..07232fd 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -191,10 +191,24 @@ int __init omap_display_init(struct omap_dss_boar=
d_info *board_data)
> >   	struct omap_hwmod *oh;
> >   	struct platform_device *pdev;
> >   	int i, oh_count;
> > -	struct omap_display_platform_data pdata;
> >   	const struct omap_dss_hwmod_data *curr_dss_hwmod;
> >
> > -	memset(&pdata, 0, sizeof(pdata));
> > +	/* create omapdss device */
> > +
> > +	board_data->dsi_enable_pads =3D omap_dsi_enable_pads;
> > +	board_data->dsi_disable_pads =3D omap_dsi_disable_pads;
> > +	board_data->get_context_loss_count =3D omap_pm_get_dev_context_loss_c=
ount;
> > +	board_data->set_min_bus_tput =3D omap_dss_set_min_bus_tput;
> > +
> > +	omap_display_device.dev.platform_data =3D board_data;
> > +
> > +	r =3D platform_device_register(&omap_display_device);
> > +	if (r<  0) {
> > +		pr_err("Unable to register omapdss device\n");
> > +		return r;
> > +	}
>=20
> After this patch, the "omapdss" platform device is registered before the=
=20
> other dss platform devices. This would change the sequence of probes of=
=20
> these devices. Was this intentional?

Hmm. The sequence shouldn't change. The order in which the devices are
registered doesn't matter if there are no drivers registered yet. When
the drivers are registered, and there's a device for it, the probe will
be done. So in this case the order of the driver registration will
dictate the order of probes.

 Tomi


--=-l6ME3ihRUx6ePHtS6TEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo5QAAAoJEPo9qoy8lh71hI8QAIYr3u9kw/nY9fazoNkRY3P7
FiXNDZI86S5XrSgpE3iywurbiMnl1fSdzaFu/Ipu71Ve7pHSOdNVpaC+eDISIK9c
ucVooCVkEREH/rRbvXpQB755aGJ0AKVEKTBCNP6aka/OaBn2eQWMdd+cK7Lomeeu
c9WVr05c1MjkAfJn8VUjP+klKqUSh5I7LyUgvjzKZRUTQURr1hhvvhAVcYU+jiXO
14vsZaVaJl2VCOXP9IQwRMAV9Je1/ykDjhU6LwX0hZJ0UizuXaLEuxJnIbFExNNX
FyMWGH/4Vvsc3gDOzwY9MSIWDMD3/CSjFa0nwP0rJcLKgM99Vk2HT+Kxq7wa88Fg
orOfTzkK3+SoK2nWT+IvpMdhzVdn3j4tv/JaTer9kkaMKHtx9n0gT5oAmzgSwNqm
XGUPxg2sOb8U/BU64Asgcyqmthb54SgAFFEZpLuF43dsdMg/OE1k7O2qy1OUnmeP
OR77kyfsmLRh0BEK9BiQsOijQzaTj5tNPe7UvW0Zjgdb8fEkjAx3j6Htm88GM+DK
G28dE+1jfBaaxuPot9qfQh6ygNBwKsaaPltGlKMShMDtYYb2ldJfZdY0sLGhK/Ce
wSVBFje/gRQf+D1COHAc7wDzp7gnfTR4y4bEclQweB7mXRbTrqNjaYK2PGe7R5PY
uffwMIGyYzGEGoCP8Puy
=7GB4
-----END PGP SIGNATURE-----

--=-l6ME3ihRUx6ePHtS6TEI--

