From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bq27000: directory/files exists even when hardware is not
 available
Date: Fri, 20 Apr 2018 10:17:42 +0200
Message-ID: <20180420081741.GA8856@amd>
References: <20180420074036.GA16257@amd>
 <20180420074826.c7cy4z3tq7c56ccs@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420074826.c7cy4z3tq7c56ccs@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, afd@ti.com, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-04-20 09:48:26, Pali Roh=E1r wrote:
> On Friday 20 April 2018 09:40:36 Pavel Machek wrote:
> > Hi!
> >=20
> > On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
> > even when hardware is not present (as on Droid 4).
> >=20
> > Any ideas?
> > 									Pavel
>=20
> Somebody must have registered bq device into power_supply subsystem.
> Maybe DT note is present?

No, I don't think so:

pavel@duo:/data/l/linux-n900$ grep bq27 arch/arm/boot/dts/*
Binary file arch/arm/boot/dts/omap3-n900.dtb matches
arch/arm/boot/dts/omap3-n900.dts:	     bq27200: bq27200@55 {
arch/arm/boot/dts/omap3-n900.dts:	     	      compatible =3D
"ti,bq27200";
arch/arm/boot/dts/omap3-n900.dts~:	bq27200: bq27200@55 {
arch/arm/boot/dts/omap3-n900.dts~:		 compatible =3D
"ti,bq27200";
arch/arm/boot/dts/omap3-n900.dts.orig:	bq27200: bq27200@55 {
arch/arm/boot/dts/omap3-n900.dts.orig:		 compatible =3D
"ti,bq27200";
Binary file arch/arm/boot/dts/omap3-n950.dtb matches
arch/arm/boot/dts/omap3-n950-n9.dtsi:	     bq27521: bq27521@55 {
arch/arm/boot/dts/omap3-n950-n9.dtsi:	     	      compatible =3D
"ti,bq27521";
arch/arm/boot/dts/omap3-n950-n9.dtsi~:	bq27521: bq27521@55 {
arch/arm/boot/dts/omap3-n950-n9.dtsi~:		 compatible =3D
"ti,bq27521";
arch/arm/boot/dts/omap3-n950-n9.dtsi.orig:	bq27521: bq27521@55 {
arch/arm/boot/dts/omap3-n950-n9.dtsi.orig:		 compatible =3D
"ti,bq27521";
Binary file arch/arm/boot/dts/omap3-n9.dtb matches
arch/arm/boot/dts/omap3-pandora-common.dtsi:	bq27500@55 {
arch/arm/boot/dts/omap3-pandora-common.dtsi:		   compatible
=3D "ti,bq27500";
arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts:
bq27541@55 {
arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts:
compatible =3D "ti,bq27541";
arch/arm/boot/dts/rk3288-veyron-minnie.dts:	battery: bq27500@55 {
arch/arm/boot/dts/rk3288-veyron-minnie.dts:		 compatible =3D
"ti,bq27500";
pavel@duo:/data/l/linux-n900$


Is it possible that one wire subsystem registers bq27000 even without
device tree node?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrZoiUACgkQMOfwapXb+vIhfgCdEdGUCx3rCHiOys9eN/H8j92w
PxQAoJltMDkjlHJR8wJc0yY7a8yZEwAs
=HVBB
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
