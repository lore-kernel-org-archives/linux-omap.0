From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 14:00:49 -0500
Message-ID: <20150617190049.GI18421@saruman.tx.rr.com>
References: <1434565751-14944-1-git-send-email-balbi@ti.com>
 <5581C3E5.6020109@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5581C3E5.6020109-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 09:00:53PM +0200, Alexander Sverdlin wrote:
> Hi!
>=20
> On 17/06/15 20:29, Felipe Balbi wrote:
> > -		if (dev->speed > 400 ||
> > -			       dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
> > -			internal_clk =3D 19200;
>=20
> Let's compare, what it waas before in this case...
>=20
> > -		else if (dev->speed > 100)
> > -			internal_clk =3D 9600;
> > -		else
> > -			internal_clk =3D 4000;
> > +		if (dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK ||
> > +				dev->speed > 400) {
> > +			internal_clk =3D 1920000;
>=20
> Seems that it should be 19200000? Because...

indeed, it's missing one 0. I don't have OMAP3 board to test that out,
that's why I asked Aaro to run the test. v3 coming.

--=20
balbi

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgcPhAAoJEIaOsuA1yqRE5xAP/3cmVa4DKApTpEwfCH5EC96N
PKhBbOr+4e0IJOc/MRSOyJRiGtgeJeEUZKVsQQJFl3F3/AvCTi3UNV9nQGyuzMWj
UFiuquUmS1FvIUF0VbjdvOZLk8HnCClgb7PArT7sWsUQYjSBiJ69ENPcmtS8fWAY
icox8m1CMOHmQCsoP+k/T832C+hYiRqbLFf9i9MC4PRTrwN5lMCvjxBywTTt4tuC
pYSGo7Mt7b74L9ABM03hF32SPBaC4K1SNaSj2kRERTLnoRN8VVXWUFG7QeXstgu9
4wsxm18O2FfXtD/+IMPVk+gpDtO2SGwHOKaFESWPAD+w3xD9mFJq0Zx+wa0ujvW6
tCrv9PQIBMkqFk/sviM7YbjSYZtFH5wl2FKaft/X7lnwnbs5Tpsa+t8NxRcmRAsw
8RI5hU/GPzFCvSVAM1xX+kVq71vzecMip1EOXVmckOkfOTnXL4CEPNz33y1+Gf2T
PF1+JXTH/nNIEQKO4pIvqslQa0sReQ3ZT/3O36I1LO7DjzA05hZaIP197abUBsfC
vKb6pBbZ13/rClGd/NZK/RJWHDIM+oNxLzj6VmqQey8SktGddoyaCgpy+zeOa+Rg
RMKrN8qPHrPFzKr0v0RxwuTDxdhQFjceHzS/13IyLrp9A43wGaykTK4QwjwOKeS/
LFBye10isIlG6agfQyad
=vOfl
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
