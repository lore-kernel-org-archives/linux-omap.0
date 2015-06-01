From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Mon, 1 Jun 2015 11:49:19 +0200
Message-ID: <20150601094919.GG17267@lukather>
References: <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529200306.GB17267@lukather>
 <20150530101430.GA505@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150530101430.GA505@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2015 at 12:14:30PM +0200, Pavel Machek wrote:
> Well... the driver was not broken... before you did "cleanup" that did
> two functional changes. And yes, the dts should be fixed, but that
> does not make your "cleanup" good.

Whether it's good or not is arguable, and it really boils down to what
we consider the default value when properties are missing.

If it's 0, then my code does the right thing. If it's undefined, well,
I'd expect undefined behaviour to change without any notice.

Feel free to suggest any better solution.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbCqfAAoJEBx+YmzsjxAggJgP/Rs8oOemmBG8R4sLCdNO0MVZ
iCK/UvzJJAgpB1Ri94vd21ffI7KQvDCJehnXaapceH/5H/nPLmJJInfG4TCON2DX
nDZpjIPgwF+WuodJhC/Fxh3YxPfVvHcBYaZYJebSQX8mGtu2VFDuZee8akqRaGeZ
H2uYfkRdZZsLa4EyQhkXLBOUr38xccA13uKRv1Vfh6OwLKp7UODcCsu3y/uXQuSc
HjsoAdTpRSfAs9M5YkaSu2DBhU2AdqSkCXDEwRaZl1kvMcKJhKBQMYOS3/gZOsNp
EqWQs9CsJ5I8aNO4mDBGhgsjww2+Fv6a0HyuurrzOjBJaAy2+w5qK+sf5Hpca2Rg
927SpPLivXnVA2THE0ffRTW1Rdk6hPMR46WBCn8uJmoOw9A43Efl1MBmx84kXYVK
HtHVnx5+SRE0YceEdp9LTnJLLL3FN4inETszgQlp+nhgMEhDzREXCpG7oW7FQicv
RRLAvo8+ykdc8R3ucwxB2bLE13gsEiwpRIzmJQCzKyohPfahuSp/ETRnBT/YklXu
L/T++9vD2Bq8J3ajxTcrGGjFDGVJpOA7gK72eaYLyKzLmGSRi4l09CBOgrucMhry
bH9bZQjMiEA+fYVLUbrwK7xQxgW5EKxb+887DBj2+gZW8uL7aGxpDDBDqa0m/bD0
VdWZckTAfFJtP1GR/g/c
=1qqq
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
