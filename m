From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc5
Date: Mon, 28 Jan 2013 18:51:59 +0200
Message-ID: <20130128165159.GZ28698@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
 <20130128113818.GD28698@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA946E4@DBDE01.ent.ti.com>
 <20130128121635.GI28698@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA94745@DBDE01.ent.ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAF78AE@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kf9dPzkPP9+q7vtQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39895 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991Ab3A1QwV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Jan 2013 11:52:21 -0500
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAF78AE@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--Kf9dPzkPP9+q7vtQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 28, 2013 at 03:40:09PM +0100, AnilKumar, Chimata wrote:
> On Mon, Jan 28, 2013 at 17:48:49, Mohammed, Afzal wrote:
> > Hi Felipe,
> >=20
> > On Mon, Jan 28, 2013 at 17:46:35, Balbi, Felipe wrote:
> >=20
> > > didn't help :-s
> >=20
> > Hands up :(
>=20
> Hi Felipe,
>=20
> Could you please try with any of these options?
>=20
> 1. Change/add mem=3D512M (should be same value as u-boot printed RAM size=
) in your
> bootargs?
>=20
> Or
>=20
> 2. set fdt_high 0xffffffff (at u-boot prompt).

that helped, thank you :-)

--=20
balbi

--Kf9dPzkPP9+q7vtQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBqyvAAoJEIaOsuA1yqRExdcP/048DO90CEu7SbqTSP8Et0VR
i2VtykI3cHJ1sBrsDdHzrKW5D/hss0PPY+mcb9i0lS1qVTpFReevakR/KCO3LL53
FqeMU8ONSk15ppk4ZK7reeoS4A1mKow3ISVFr+45PXvaKoDq26N6D9yh7lZrWP4l
MXH0tCqAoUE0gDYXrwkDQDlF7wHYUP9S1DxykAwJFZm4M2uDMsmQdK+qRaSB4ajf
dpbYqB1bApKNMEQVOMfyDLchv1pWrcTvVVYHdVFgMH5sgJiUCyhNh2gmwyWzL9Np
oKqfp+5oiaWC+l/LE1MA1o7m066WpdgrlPD+nvwXZDVz15NQLCwWgbqvdR0oPlww
JKzp4MFztIIjJ8gtihFk7tKAknnV1raqBIQNdbP0pMFfza0he8Hz9MfCXwg485R8
MQDFnqwaLuP/lpi/zYekkNqN5DJIPDqxB86msssy76S7ffdoc9G8KqfFvGhfOFw5
jI5EIjpzGA2SJB9wcIACm7JDkxsWaXQ0EDqr7oOBniBgYGEVI2iE+lHTF1V52HGq
MEKwlivAqT4CZY88NLHDuyLBOO/TVw9cPVnPXH77XKm57F8b4hR5gysI6kkFgojK
pXEE+esSF9KVUiSaQe/7AExNrrXetEeYnuBSPzpUtZvhWwvfqAf8L9OuUtT1XLOT
D4QWrhr7XOaitTir9359
=Qpog
-----END PGP SIGNATURE-----

--Kf9dPzkPP9+q7vtQ--
