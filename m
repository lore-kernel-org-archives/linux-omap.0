From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 15:21:23 -0500
Message-ID: <20150529202123.GY2026@saruman.tx.rr.com>
References: <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0B3PZ1+h5f4cFxHi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42098 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbbE2UYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 16:24:24 -0400
Content-Disposition: inline
In-Reply-To: <20150529201745.GC17267@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

--0B3PZ1+h5f4cFxHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 10:17:45PM +0200, Maxime Ripard wrote:
> On Fri, May 29, 2015 at 09:56:29PM +0200, Pavel Machek wrote:
> > On Fri 2015-05-29 14:49:55, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> > > > Fix dts to match what the Linux kernel expects. This works around
> > > > touchscreen problems in 4.1 linux on Nokia n900.
> > > >    =20
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/ts=
c2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > > > index 4b641c7..09089a6 100644
> > > > --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.t=
xt
> > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.t=
xt
> > > > @@ -32,8 +32,8 @@ Example:
> > > >  		touchscreen-fuzz-x =3D <4>;
> > > >  		touchscreen-fuzz-y =3D <7>;
> > > >  		touchscreen-fuzz-pressure =3D <2>;
> > > > -		touchscreen-max-x =3D <4096>;
> > > > -		touchscreen-max-y =3D <4096>;
> > > > +		touchscreen-size-x =3D <4096>;
> > > > +		touchscreen-size-y =3D <4096>;
> > >=20
> > > IMHO, the older binding needs to be supported as well. It's fine to
> > > update the DTS for the new binding, but even Documentation says
> > > touchscreen-max-[xy] and if the driver changed that, the driver should
> > > be fixed too. Besides, it seems like this has been in tree since
> > > v3.16:
> >=20
> > Agreed. In parent email, I have list of two commits that should be
> > reverted.
>=20
> So, if we sums things up. You introduce in some documentation example
> some property, that you never document, that you still use in one

it was Documented in DT bindings document for this particular driver.
What are you talking about ?

> single DT, you don't even use that property in your driver, and now
> that you realise you meant something else, you want the code that

not Pali, Sebastian.

> actually parse the *right* property and does the right thing, that all
> other DT agree (and depend on) to be reverted?

We shouldn't revert, that I agree. But both properties should be parsed.

--=20
balbi

--0B3PZ1+h5f4cFxHi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaMpDAAoJEIaOsuA1yqREzukP/31Lle9ra34boE455zUFgLCn
7vQQc2SM9LOtiN2YRizY5IpjBRYSZuuClm7tAQY9cBFb7/w2BHB+8Mk7ceNXr2yu
zx1qrV1l7fVoa7N9HKQA81Qg7HdynBR7pYlVNzJ9KBKv2KLthR1MtNXY+CwgwjHI
w0QkvjB0EQMVXUl0OVqyLLQYK+qGbEgBzEJ2wiHgX89lA1lenISG2YNFHgyMQlcs
Zj8LoOyIPNNgbnKgQoJUXKZa4bDgE7LZqXINeiFEgS80Yr3sqfU+hUVLMyIKoLip
pZ7jLdDqT7KBUouep+YjAuqAYl2EmtIRzhYI6irJwwJOFAMOeGKiEkhrw+vlEHnI
Kx8e+hA31oFXf/MaQYYbTuGO/XC+Di2JnNAg573uYn29Rnohqd8/rEJlQPKHx2X+
7xasNJwiaTLduggSlKVUmlU5tCcfHt/WyvD3d4BkcdmJwvWW6Iouxn5JvbvdBjyF
l0+oIeNo620o86kvRRYKKaRP9PgRqdE9zSpk0/2ewjvUYb8srhih8Z/2fpR+4ckF
Wk0jnL4BQzYO1V0MXZiBHSPDLncmC4dUs6XfNqiFIBvfoOnZV5n4BVxRB4Mo423R
NBcxFEz3OfS0lK8DR1jyJ2Q+wr2D+Oh3nATv4Wlop86ova2OPaA7dzeVC+HWCjRC
DIsI3eMqAWz2FYcTWrqK
=5Wbl
-----END PGP SIGNATURE-----

--0B3PZ1+h5f4cFxHi--
