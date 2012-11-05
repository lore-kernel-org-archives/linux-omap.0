From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
Date: Mon, 5 Nov 2012 09:13:18 +0100
Message-ID: <20121105081317.GC28886@opensource.wolfsonmicro.com>
References: <1349879449-22657-1-git-send-email-mporter@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
 <CAD=GYpZ9w=D55G9DOiMqZ4BCGGdGszsgG3fumHUGZ12xx+TKjw@mail.gmail.com>
 <1BAFE6F6C881BF42822005164F1491C33EAB973D@DBDE01.ent.ti.com>
 <CAD=GYpYuyfGuEgAWJyE2nkKx4GEsm=eDYAhV966sWVLbEPaqYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=GYpYuyfGuEgAWJyE2nkKx4GEsm=eDYAhV966sWVLbEPaqYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Porter, Matt" <mporter@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 03, 2012 at 02:32:59PM -0500, Joel A Fernandes wrote:

> beaglebone_defconfig: Add dummy regulator to init tlv320aic3x
> https://github.com/joelagnel/linux-kernel/commit/db5672dfe548d82625cf40ed688d05ba7cee5c93

This should never be done in production, you should ensure that the
appropriate supplies are provided by the board file or device tree.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl3UWAAoJELSic+t+oim9rQ4QAJaDz1fahgALubBbZZwIOWZA
a0acT49+VwL6sWjiS9sKReDRAzEpsF/Odn+V8wpZqoCTUtR3cKdCU4dUaU4gr0YN
Wv0200azme+UbibIcK61kMmtZytQ2fulu1ul1MSpntQ6eA5sika762pMbgagZozb
VO4bYHA1uDHytlElVubHmsIunoAuTPRyreSynGmn6XjoKOiWQP4qWIkIXUtKEGXj
WAlWLvemu+K6XOJdPCU2Y30Y0RZ4BMkjc+wtf8Xj+RUKNn6U3lV2n3wYlKzEFESQ
8AwCNTrNpyvpoI5jqYNiOSngBTENfwszpivneqxTBJ6SiDoQmhIPxHOKO2RziYvq
XO7f7edXbebSlXy5Y4SSTJRt8qgR/Y2UkqxrYc+3p3zUouxYYbrHsIY0Ag8b6ohY
MZH9Wo6wN7uKSHCka14gwppUQlL/eN7RY0Ly2rAfedxXqMhGl0wPbGZWHGHKG1g3
88qFoYulNvEP1OUHWAPVLxWu4ykut/YXG8jExrpxUyuxK5mvRJTgzDmiCzGfMVnB
BadoMvZek7XEXPn346lNuydh8isdCtaV3PEjJGIgha3MZuuyLwC6NPCChzjT28W4
qs2rX0pQJjN0i57ClD9otipSdYF71f7oYW5wAnn3BKj+YOLmql5ynaWkHNt7SnLq
9/7In8V4jcLcAl2EC6Pb
=ouct
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
