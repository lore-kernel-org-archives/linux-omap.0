From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing
 MODULE_ALIAS()
Date: Wed, 15 Oct 2014 09:38:49 -0500
Message-ID: <20141015143849.GC10888@saruman>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-2-git-send-email-balbi@ti.com>
 <543E6683.5040103@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44096 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbaJOOjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 10:39:21 -0400
Content-Disposition: inline
In-Reply-To: <543E6683.5040103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 03:20:19PM +0300, Tomi Valkeinen wrote:
> On 14/10/14 21:28, Felipe Balbi wrote:
> > without MODULE_ALIAS(), omapfb won't get loaded
> > automatically.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/v=
ideo/fbdev/omap2/omapfb/omapfb-main.c
> > index 9cbf1ce..b4b9244 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > @@ -2651,6 +2651,7 @@ module_param_named(mirror, def_mirror, bool, 0);
> > =20
> >  module_platform_driver(omapfb_driver);
> > =20
> > +MODULE_ALIAS("platform:omapfb");
> >  MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
> >  MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
> >  MODULE_LICENSE("GPL v2");
> >=20
>=20
> Thanks, I've queued this.
>=20
> Unfortunately it's somewhat based on luck if the automatic loading works
> correctly. We can't add more displays after omapfb has been probed, so
> all the panel and encoder drivers have to be loaded before omapfb.
>=20
> We have two workarounds there, which help the situation a bit. First is
> that if omapfb finds no displays, it returns EPROBE_DEFER. The second is
> that if there are displays, but no main display (display0), then omapfb
> returns EPROBE_DEFER.
>=20
> So even with these workarounds it is possible that drivers for secondary
> displays are loaded after omapfb, causing them to be ignored.

then there is another case to fix, right ? :-)

--=20
balbi

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPob5AAoJEIaOsuA1yqRESrgP/1XvsANYLf7WhOaxFd7ABhSB
GDoICmVuZuF04xX+TNrfxt831g5/SuPECf+j694sD+dVr+ghZVRrrIidPgwSxDHP
eSiRCvOYB4SqN2BEP4ADoBOv03LEN3VgFJ/kyNYQWxbc04MaP8uDeEzFTxn5WDxn
N+VYAf1TRlAI7l21oKL1gvLESfnnkEBXfRq5k8de6YtQoriR3PHl+ecqLpYWowAw
GPOCqvopzZ9lJIN3rOkZuDmxAeegj3yX1Tnv50kumT1OgSsuGOojOk6RrWGxW2pq
EbFy32MeSg4AmcWo11jfdaY0hJKYQzXcHByMV1e1XIRkPMY9e95kEl8NlipaLbbz
ByxQHvzujCSOInQNsPzye9bO5GldlL/wvKZ1C9Rp2z3dnEOHmz6BcBB/abwyXCI3
UwNpIT2IwcE9QPasOAZFcNUDMzPwfDFNMITqFaTNK/Qr5fYE2OOilcfwwVmLX4Kv
qofo4dgZaSFo+YjvLi7iO/G/anvL4JPjnbQqh78lGQaavrfTVt0YF2VAoKfxevNJ
AYgAmXrQ6LPXAAXEVI9ewp3Ez+Ves5po+pljgUxNVUqXtkCMMFefTO2euwt0UlEB
6P2hvrOc35j1FcJnuqpihRtlWAhD0wYFXnZwrfPU2XabLjk3pKLqxmfAX6g05uLU
+fQNw9zLsRJ1tNC54w8K
=ASvG
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
