From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 22:03:06 +0200
Message-ID: <20150529200306.GB17267@lukather>
References: <201505241444.41039@pali>
 <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150529194955.GV2026@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 02:49:55PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> > Fix dts to match what the Linux kernel expects. This works around
> > touchscreen problems in 4.1 linux on Nokia n900.
> >    =20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc200=
5.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > index 4b641c7..09089a6 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > @@ -32,8 +32,8 @@ Example:
> >  		touchscreen-fuzz-x =3D <4>;
> >  		touchscreen-fuzz-y =3D <7>;
> >  		touchscreen-fuzz-pressure =3D <2>;
> > -		touchscreen-max-x =3D <4096>;
> > -		touchscreen-max-y =3D <4096>;
> > +		touchscreen-size-x =3D <4096>;
> > +		touchscreen-size-y =3D <4096>;
>=20
> IMHO, the older binding needs to be supported as well. It's fine to
> update the DTS for the new binding, but even Documentation says
> touchscreen-max-[xy] and if the driver changed that, the driver should
> be fixed too. Besides, it seems like this has been in tree since v3.16:
>=20
> $ git describe a38cfebb56898633687ab337fd53710e63a0aedd
> v3.15-rc5-72-ga38cfebb5689
>=20
> So, because this has been wrongly documented for so long, we should
> support both bindings. Sure, deprecate touchscreen-max-[xy], but they
> must still be supported, IMO.

This property has never been anything but a typo in a documentation of
a single driver.

Feel free to fix that in that driver, but I don't see why the core
code should handle that isolated typo.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaMX6AAoJEBx+YmzsjxAg+3sP/iaPwC263qzorBnuMptdDQZJ
R4c67RNEV8KNvQsIeje0maYRWcSX4fTQWyYiCOZf1MoQk1s4lko9+WqsInlDDUun
d7gqjkAn3WrBbPANQ3uwRfUuxCAgaLPz2eX2K1G/BlGx8+7kaosGr0ji+fmS5MpG
qUOFsJfJc28OGz0ps/xNIS9QN8i2mteTnLFYkH2GCkANloAED1DTjgc02lr7OJaP
i1XkB5ioJcpOa+dYbXkExcwOOrKVjD9zMV4+CYdVPKXdyjzC/R5JTG8xTk9twJoW
WaCXIjBuAaOs1+5JuvjoOcPAgm5TktbMOhp9QQ/P7rdU++ySI6piLmSKe3sgj5Kl
viauHsLsvF/DTuza6z2gKjaa0pAfFf/H2HcsPZu/pqtu0uJMAND15xva5J+UGIQS
xi5c6171oizF9Q2oYE4QgCN5QL+FMJIpsoyHvlq3JspRh22n9TaSge29VhKePRgk
k8+dYEUINGOW5Onuxl+LKKy2/fxFLSw9svl2jzpsoXqlon5bpn+Q0id2fmu4QhHs
IOApJVwZavP+FcJ31fIPfH9IMqTjHMLUbC14hYGAWaH3Fgg/B9bUOOEbtg4Iyc03
fywWwb85+nWfF9G+g3TejlzwwtT0LwwthakT//CXNqCIORFjtJhVBgMJSVD5W8r4
ukY3pdI4U8/gTgfCymZZ
=M5oq
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
