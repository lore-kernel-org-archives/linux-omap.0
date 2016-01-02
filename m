From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Nokia N900: Proper C-states
Date: Sat, 2 Jan 2016 15:26:28 +0100
Message-ID: <201601021526.28687@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3513510.DYnl31L9LT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Jean Pihet <j-pihet@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart3513510.DYnl31L9LT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

due to this Daniel Lezcano commit (ARM: OMAP3: cpuidle - remove rx51
cpuidle parameters table)

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D231900afba52d6faddfb480cde4132d4edc089bc

we need patch cpuidle34xx.c code to fix commit for Nokia N900. See:

https://github.com/pali/linux-n900/commit/e147fd4b678f1f3d7a5235287910960bd=
41e04dc

As Nokia N900 code is converting from legacy board code to DST, I would
like to know how to patch correctly omap3_idle_driver in DTS with
correct values measured for Nokia N900. Thanks!

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3513510.DYnl31L9LT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaH3hQACgkQi/DJPQPkQ1IcXwCfZrwQVEid/9bA/SCgF8WfVBLL
h68An0q8RwkNur0Gv855wN3AYqxpmY8v
=gMK+
-----END PGP SIGNATURE-----

--nextPart3513510.DYnl31L9LT--
