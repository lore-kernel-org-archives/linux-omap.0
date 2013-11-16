From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
Date: Sat, 16 Nov 2013 16:02:35 +0000
Message-ID: <20131116160234.GB5104@earth.universe>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
 <20131116141853.GF10317@atomide.com>
 <5287908C.3040602@collabora.co.uk>
 <20131116154507.GL10317@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:36856 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3KPQDI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Nov 2013 11:03:08 -0500
Content-Disposition: inline
In-Reply-To: <20131116154507.GL10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 07:45:07AM -0800, Tony Lindgren wrote:
> Well let's see what Tomi prefers.
>=20
> > > &vaux1 {
> > > 	/* Needed for ads7846 */
> > > 	regulator-name =3D "vcc";
> > > };
> > >=20
> > > &vpll2 {
> > > 	/* Needed for DSS */
> > > 	regulator-name =3D "vdds_dsi";
> > > };
>=20
> In the long we'll use regulator phandles anyways in the DSS related
> nodes, so from that point of view fixing dpi.c makes sense.

The hack, as being sent by Javier, will result in the wrong
regulator being used on the Nokia N900, which is using vaux1.
It must depend on the machine.

At the same time the N900 device tree file uses V28 as
regulator-name for vaux1 (which is the same one as legacy boot
used). Nothing depends on this, but I don't think it's a
good idea to use this property. Apparently it does not work
if multiple drivers need the same regulator under different
names.

-- Sebastian

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSh5caAAoJENju1/PIO/qaKm0P/RqcEYQOX5DE4YjE8lm+1Pm/
nGKGutmQwEhe9zo/CE2DwHTFK8zcGq5USTzn3xt+7RFvSrf4NGLW309Wp0KIhLzM
ZvVlzVD2Aj++6h2xZc8SbwzmbjW/ZqAXEbSadKBXaABApewsT6gPsVnT2S64siTh
oK6BGonLMYAjZZypA8YV0hVxRF3BZayjDIT0rNeNXP8SHgeMs9svQlGIIRcxj1lU
2VGrEWOK2wtVcjTSosJsovVbvrL+rpr6mQunGtY0rrxr89AIKwV4IZjZRg3hXeXW
r2uds/TBjBbJ0DKH+s041vurjAoBvtqzGXofXEfxgbNI4hj+2mE1K7+KNRzNckS8
ZFf4dny/nsXtiW6Tftt54hR3QNBSH6eAE4Ipk4car6CQYXnurmkTKUIQ/uOXIw0u
gig033/+G+Tb582UMvGSFQYbgfJS7CefZyfQmYWfpUn+WVx8DtYi/xR8RS1jQGmW
Ux+/rAvzOhchOAhoCr77uoxNGsdDfPzsAQtrdpbizOiIE/fOkNRPvInHeENw/xID
cKH+CrSC+Crxfpi2WXss8q29nwmTis18QqGmiijEpItHy9U0wOUIt4bzE1IzHfHI
o82RItVpU1FK2yh7k7ngwucy4gDjBWdPTJWzSlLqcyogJ+Tj3jGi/CtA+U/ZDWuh
i/XbMR2N/WaV2c8TOhDc
=7cSW
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
