From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] i2c: omap: improve duty cycle on SCL
Date: Fri, 10 Jul 2015 12:27:15 -0500
Message-ID: <20150710172714.GC20408@saruman.tx.rr.com>
References: <1434569475-17378-1-git-send-email-balbi@ti.com>
 <55827CD7.7030207@nokia.com>
 <20150618172558.GC27790@saruman.tx.rr.com>
 <20150709194241.GF4744@katana>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150709194241.GF4744@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2015 at 09:42:41PM +0200, Wolfram Sang wrote:
> On Thu, Jun 18, 2015 at 12:25:58PM -0500, Felipe Balbi wrote:
> > On Thu, Jun 18, 2015 at 10:09:59AM +0200, Alexander Sverdlin wrote:
> > > Hello Felipe,
> > >=20
> > > On 17/06/15 21:31, ext Felipe Balbi wrote:
> > > > With this patch we try to be as close to 50%
> > > > duty cycle as possible. The reason for this
> > > > is that some devices present an erratic behavior
> > > > with certain duty cycles.
> > > >=20
> > > > One such example is TPS65218 PMIC which fails
> > > > to change voltages when running @ 400kHz and
> > > > duty cycle is lower than 34%.
> > > >=20
> > > > The idea of the patch is simple:
> > > >=20
> > > > calculate desired scl_period from requested scl
> > > > and use 50% for tLow and 50% for tHigh.
> > > >=20
> > > > tLow is calculated with a DIV_ROUND_UP() to make
> > > > sure it's slightly higher than tHigh and to make
> > > > sure that we end up within I2C specifications.
> > >=20
> > > if you refuse to change the calculations to achieve maximum possible
> > > bus rate (as I've shown you with SCLL=3D9 and SCLH=3D9), maybe you wa=
nt to
> > > change the description? Because you are doing something else than is
> > > written here. You are only in spec because you are not doing 50% duty
> > > cycle. And you didn't mention here that you lower the bus speed below
> > > 400kHz to achieve this.
> >=20
> > and there's a comment where the calculation goes which states "as close
> > to 50% as possible but we make sure tLow is higher than tHigh so we're
> > still within spec".
>=20
> So, is that ready to go in for-next?

should be.

--=20
balbi

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVoAByAAoJEIaOsuA1yqRET58P/3g4Hw3omBrp93jVQ591yVYR
ge4/ejL4RXTnnw0YUt5xxEZQTWz9YgCu9WQgFJsQ1oL6aWRssX9g7RN/nljFjX+Q
TF+BSVlcR5nkdUVdVeIFwrG4lp+rKFJtI+h3siwS476Rxw7VI9gNDvFqkijBZTKE
8uA94bFItP+AmYTuxZCrSswyHRTgPVg12ksSHQuXrOEQJL3Cx0RQ+o/H8snNMq7z
uTZ3D4YK9md42SpmeJ8rSTQ0FsRzZ9j3JoslqytvG/obtryIQfw+jjeO5Er/TxWd
//Yrq6QBm+l+ffFHE88xCcnOXI/4UylzOzMV3W8dkjsLxzLDYjJfDKC+gQBTPAJ4
Oy9+fxv1HpCV+jqaFOEk4Iig5Lcf7OZ6bCb7sOtnONv8U+2L1co6dO6TyZtT7Eed
S30aBhyM/cuJcTEd7GgTrNl8dCX60Kq+GZrSqSrukHhmqo6Bvm+1+dhBoExD35Ir
ieqNkNaq1M+zRZ84BBscMzfYh4tP8xjymAC2nch81BTgSl0pmlywWBMmb2MHajk5
zgKPNtc+Z22zmjaCy9wl8FtLt4cLD1T3unn7rf0sI8Sbli58dofhaeWFruCdtWuz
XbHMV7yuk3fcLFIf2u2lZCgaNRczILuZU9wMpCl8E13EoOKLXuYnqZ15pqtuEN/o
VynxfvuYLOqbg0IcV72V
=ew0E
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
