From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Mon, 1 Jun 2015 11:55:56 +0200
Message-ID: <20150601095556.GH17267@lukather>
References: <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150529203456.GC22083@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 10:34:56PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > > single DT, you don't even use that property in your driver, and now
> > > > that you realise you meant something else, you want the code that
> > >=20
> > > not Pali, Sebastian.
> > >=20
> > > > actually parse the *right* property and does the right thing, that =
all
> > > > other DT agree (and depend on) to be reverted?
> > >=20
> > > We shouldn't revert, that I agree. But both properties should be pars=
ed.
> >=20
> > No. If the property is wrong, and nobody parsed it, I do not see any re=
ason to
> > start now.
>=20
> Agreed.
>=20
> But that's not what I'm asking. See a changelog of
> 3eea8b5d68c801fec788b411582b803463834752 and compare it with what it
> actually does.
>=20
> It is buggy. If fuzz is specified but maximum is not, it overwites
> maximum with zero.

If maximum is not set, you'll have other issues anyway. But it really
boils down on what the default behaviour should be.

> Plus it introduces new failure "if (!test_bit(axis, dev->absbit))".

It's not a new failure, it's testing against stupid code.

If an axis is setup in the DT but not registered in the driver,
something is wrong, most probably the DT.

> Plus it fails to distinguish between "value not specified in the dt"
> and "zero is specified in the dt".

Again, default behaviour.

> The 3eea8b5d68c801fec788b411582b803463834752 is just bad.

You were very welcome to review this patch at the time and/or suggest
a fix that pleases everyone.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbCwsAAoJEBx+YmzsjxAgbzkQALU0io/SKT9QgEeX/kVOgP2m
mXIJANFnXlanwu1DTxeBDHL0HITwf3ksdG3xt+Q3g6PKLYGv6/IX+65oIGrgPLKz
oDqyTIxgjtqICTO0FYBcVSOPuKvjWMNt0tNFrRqNhhPWL4NMPNlsgOEk9stDDaE0
finoR3L4S98vuT5Gi6GJO8m//kJ3//CKnEUzcrP9csZy/YmfhqtiBPN07O9Z3Jgj
3z8QNPRiI4Jy/e5I/sBzNisA3BdZD/h3TlxttPaWKlM4ByCLF80nOnPCW1pHIhyj
gEx69BjM1BsmAfICaMiu5+nDnO0MY+1K3k/mPJG7urYikpJ2zVX4jIEqHMwpslS9
7rtMSewDCUVmwfzOynyD7zAK0uPh9rYRhJ+qGGq5HTyBf6SqIpOfSCobn2Sw1bsh
4/uUWymjlHxZRMIf4GCDZTyVOVmoZdst2Xe3kFfhL3hSN7cGq3a94ZoTuOgcoO41
kqtp2wDT0bg+LwLbY6yBFy2vQEFEQ5584SvOEdqS5ByuAn4kpqJ7O9eYHCcpKren
iRaO2MBFrelxYZmA7LnfQN44L/cUt4AhipdLuyWs74o+xXXaUrcWjeZl12OypoRo
kBXH9PZRqSlozaQL+hMblZ06EqregvatzHnnReMXbJ+0/MNs91ZqAqavDz7owaT3
9RctXROzmMbG4cT8aXrx
=ygBg
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
