From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] musb: musb: dsps: determine the number of instances
 at runtime
Date: Tue, 18 Jun 2013 11:54:09 +0300
Message-ID: <20130618085409.GO5461@arwen.pp.htv.fi>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
 <1371482014-5244-3-git-send-email-bigeasy@linutronix.de>
 <20130618083108.GH5461@arwen.pp.htv.fi>
 <51C01DCB.3030501@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xexMVKTdXPhpRiVT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51411 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab3FRIzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 04:55:36 -0400
Content-Disposition: inline
In-Reply-To: <51C01DCB.3030501@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

--xexMVKTdXPhpRiVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2013 at 10:43:55AM +0200, Sebastian Andrzej Siewior wrote:
> >> --- a/drivers/usb/musb/musb_dsps.c +++
> >> b/drivers/usb/musb/musb_dsps.c @@ -110,8 +110,6 @@ struct
> >> dsps_musb_wrapper { @@ -646,6 +645,23 @@ static int
> >> dsps_probe(struct platform_device *pdev) }=20
> >> platform_set_drvdata(pdev, glue);
> >>=20
> >> +	i =3D 1; +	do { +		iomem =3D platform_get_resource(pdev,
> >> IORESOURCE_MEM, i);
> >=20
> > IIRC this index starts at zero, no ? Meaning that this should be:
> >=20
> > i =3D 0 do { iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, i);=
=20
> > if (!iomem) break;
> >=20
> > i++; } while (true);
> >=20
> > glue->instances =3D i + 1;
>=20
> No. 3x ioadress i.e. 0, 1, 2 means two instances because we have 0 as
> the glue io address and two musb port (1 and 2).

heh, true.

> > Also, why are you getting the resource and doing nothing with it ?
> > Is it just to figure out the amount of instances ? Isn't there a DT
> > helper to
>=20
> exactly, just to count.
>=20
> > count how many child nodes a certain node has ?
> This isn't exactly a child node, is it? There is of_get_child_count()
> but this isn't a child, it is one property.

is it because we haven't added DTS support for musb core ? Eventually we
can/should add and convert this to of_get_child_count() then. For now,
we can go ahead with your approach.

We have such a large amount of function pointers to sort out anyway :-(

--=20
balbi

--xexMVKTdXPhpRiVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwCAxAAoJEIaOsuA1yqREk04P/3vZCXqvUeVtTvXKYZR+5imd
Plsl//iwNf2SaafsediAr22J87I1DXhHkDLG2zILOT64ZMPmmKMdMJ1ClKklURbJ
1u+UkdhAZTtOjZGilJy5zdypbUjlv2HHEN0Hagrz4Yp9QrTScw/qwb4qw7WO/WEV
xqtPkTmIuEAgobfdADcwre/C/S73CVa3WcVC+3pU31xeE5Cotq2PgEox9frlNPQV
NS5oaRZLC76W4Wvi7rSpb94Y26Kni4KKnhueDpTwNR2GfrJ1zTFVOCjZu+7PhGsJ
ZKk4CZ5bVRtSOSmeDRZQCT9ExY3Dru5oOeC5Kf8Cnq+hNkHeF2RYsLjKypbeZ8Te
qSK6cxRpgxDsXNMbwl/kLvGYSvToq8gC20WCiprvG7bUwrQtIVnteFgxSgPs1AuL
rQ1wZreUaO32tM8xssRJ2WHz3wuBsPBLiDInWeck3pCiimjKGQcxJZ8nChmz46jZ
Bg0QNv/2mDeGvaSSl3pBy9uSKQOO1gIEE3LSNuXhW60e3Mu+S6Tx7H4/VTaEyrQE
jrVMauK/6K7NWYkrhWRG5WQX1oR/yQr8lbBgbZ63YAXfXbkLeaZVgtEjmaKKshn2
8DpLErDyp7hwCE5DhNeCUk6o7tBoa2ltPRzE0uJSCWGLnsz9DW5sGz+v4NJToY/A
WV5It0rj/wmEzEcthwvl
=Ocjb
-----END PGP SIGNATURE-----

--xexMVKTdXPhpRiVT--
