From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Missing OMAP PM layer
Date: Sun, 24 Jan 2016 21:23:58 +0100
Message-ID: <201601242123.58871@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2173341.o1vKbr5NbP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart2173341.o1vKbr5NbP
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

make menuconfig allows me to choose "OMAP PM layer selection" and the=20
only one option is CONFIG_OMAP_PM_NOOP "No-op/debug PM layer".

What does it mean? Power manager is noop?

I see that it has only two corresponding files in mainline kernel:
arch/arm/mach-omap2/omap-pm.h
arch/arm/mach-omap2/omap-pm-noop.c

Nokia's kernels (for N900 and N950) had also:
arch/arm/mach-omap2/omap-pm-srf.c

Can somebody explain it what happened with omap power management?

Looks like that omap-pm.h provides some API, but the only implementation=20
is noop which do nothing.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2173341.o1vKbr5NbP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlalMt4ACgkQi/DJPQPkQ1K5dgCgiu3I9243xJZjNndBWWuwkLZ3
RTEAnipcARkxjR/2nYQfZiHIdJkETgOD
=FyXr
-----END PGP SIGNATURE-----

--nextPart2173341.o1vKbr5NbP--
