From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: rx51-battery.ko incompatiblity: board code vs DT
Date: Mon, 6 Jul 2015 21:44:22 +0200
Message-ID: <201507062144.22911@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7385215.0aLSxAUm59";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart7385215.0aLSxAUm59
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

now I found out that rx51-battery.ko driver register sysnode=20
/sys/class/power_supply/rx51-battery/ when booting with legacy board=20
code. But when booting DT kernel it register sysnode with different name=20
/sys/class/power_supply/n900-battery/

Sysfs node for DT kernel comes from Nokia N900 DTS file:=20
arch/arm/boot/dts/omap3-n900.dts

I would propose change which change DTS to "rx51-battery" to have it=20
compatible with naming which is for legacy board code. It is just=20
because to have compatibility and same naming scheme and also to make=20
existing programs to work without needing patching them.

What do you think?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7385215.0aLSxAUm59
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWa2pYACgkQi/DJPQPkQ1JE4wCeJgTWjfngLXzaRxamuE42g7Su
hsUAniJgX8gqAHviMOJvMc2c5MRJopM6
=ZDf4
-----END PGP SIGNATURE-----

--nextPart7385215.0aLSxAUm59--
