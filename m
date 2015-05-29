From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 22:17:45 +0200
Message-ID: <20150529201745.GC17267@lukather>
References: <201505241444.41039@pali>
 <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45940 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751139AbbE2UUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 16:20:04 -0400
Content-Disposition: inline
In-Reply-To: <20150529195629.GA9811@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 09:56:29PM +0200, Pavel Machek wrote:
> On Fri 2015-05-29 14:49:55, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> > > Fix dts to match what the Linux kernel expects. This works around
> > > touchscreen problems in 4.1 linux on Nokia n900.
> > >    =20
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2=
005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > > index 4b641c7..09089a6 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > > @@ -32,8 +32,8 @@ Example:
> > >  		touchscreen-fuzz-x =3D <4>;
> > >  		touchscreen-fuzz-y =3D <7>;
> > >  		touchscreen-fuzz-pressure =3D <2>;
> > > -		touchscreen-max-x =3D <4096>;
> > > -		touchscreen-max-y =3D <4096>;
> > > +		touchscreen-size-x =3D <4096>;
> > > +		touchscreen-size-y =3D <4096>;
> >=20
> > IMHO, the older binding needs to be supported as well. It's fine to
> > update the DTS for the new binding, but even Documentation says
> > touchscreen-max-[xy] and if the driver changed that, the driver should
> > be fixed too. Besides, it seems like this has been in tree since
> > v3.16:
>=20
> Agreed. In parent email, I have list of two commits that should be
> reverted.

So, if we sums things up. You introduce in some documentation example
some property, that you never document, that you still use in one
single DT, you don't even use that property in your driver, and now
that you realise you meant something else, you want the code that
actually parse the *right* property and does the right thing, that all
other DT agree (and depend on) to be reverted?

This is a joke, right?

If not, I can show you a handful of DTs that will be equally broken if
you revert the commits. Who wins?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaMlpAAoJEBx+YmzsjxAgXesP/iFZ0bKXl7JENfjimdLikx+n
4dprmO0cmubg0U8n4/+lMHQTSHMiQH5fZtNBZeLY275SIZzZKyUNVoIboLevNGM8
cTstxPUA//OM7yf/qub0Vn8XKRwCvzx2uwaGSvlLWGZeK9IrWw9ojX5TBpsP01Ms
HpZGIDQvFZSBFas3Yb4qZwtnbkLyCoNQjN6XNJS5LbhjHHf/maPoHhBJ44QNr9ed
RaiU06CYzZCayg+DCEQooKPuxYUzplaChiXfdya5RgVd8LyB6yRkPGwFSwrz4vuB
2VfYOk97OkQodfB5Culb9rGgtlkQYIbuPNUihlpCrD18r0aBoVSANYeAXOiNt8cs
92Z81ADYgoLsy47c+Cn2p6NBFyenNFbo8XlxWd99FP/nxW2wE59Ar0j2FtDyFzCU
hnJX6XIrIYFY8xsVacIQ5AAri8tIYmgkwAkS131z0v4yMvCwU75obpJ9bUBPDxf3
JeNSuxHR5Hv4dDJpaiGFF/AJrkOU1bFPVoOtYF8DS6Fc+MMnt9E5BV//zhQdNRUL
bqP/AW/3d87Fa3BtHauk3vQ9P7qQm5LesrRcd3TKqfDgS9Kfo/2nN+TxR2gzPemt
2cftp4RVn1Fciu4BwxIBJC6RQRhz+OQD1M0mEEdo6oXKxf5CsLF5tS0HWOqD9Lk0
BqGn2LsA3FGJfYiBr5Jp
=mCHv
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
