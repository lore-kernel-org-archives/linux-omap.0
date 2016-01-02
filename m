From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Nokia N900: twl4030-power different data in DTS and board code
Date: Sat, 2 Jan 2016 15:13:32 +0100
Message-ID: <201601021513.32814@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4928047.maPgc7PTdl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machel <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart4928047.maPgc7PTdl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

now I'm looking at differences between legacy board code and DTS file
for Nokia N900 and I see some inconsistency for twl4030-power driver.

In board code are defined more twl4030 power scripts which override
defaults defined in twl4030-power code. See:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/a=
rm/mach-omap2/board-rx51-peripherals.c#n790

Next in DTS file is defined just "compatible" keyword, but no custom
scripts, see:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/a=
rm/boot/dts/omap3-n900.dts#n416

And the last in DTS file is defined line:

compatible =3D "ti,twl4030-power-n900"=20

which is not in twl4030-power driver itself, see:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driver=
s/mfd/twl4030-power.c#n851

So all this stuff looks like some errors when board code was ported to
DTS. Tony, can you look at this at all?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4928047.maPgc7PTdl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaH2wwACgkQi/DJPQPkQ1L2ggCbBhX/BuEzqRK1JBvOURsfEqjq
OuoAn0N4UrJBuO/tXNPVybah79eiiC3o
=dNbE
-----END PGP SIGNATURE-----

--nextPart4928047.maPgc7PTdl--
