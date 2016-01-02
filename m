From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Nokia N900: Adjust MPU OPP values
Date: Sat, 2 Jan 2016 15:31:10 +0100
Message-ID: <201601021531.10424@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2243776.qspmg5Jme8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart2243776.qspmg5Jme8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

MPU OPP table table (omap36xx_vddcore_volt_data) defined in
opp3xxx_data.c does not match Nokia N900 phone. For a long time we have
dirty patch in linux-n900 tree for it, see:

https://github.com/pali/linux-n900/commit/4644c5801d7469e2be01d847c61df3d93=
4dadd8c

Now when doing transition to device tree, is there any way how correct
MPU OOP table for Nokia N900 could be defined in DT file?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2243776.qspmg5Jme8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaH3y4ACgkQi/DJPQPkQ1KrmQCfb0Vq6Zt890YPRBaBZ5VocSx+
+7wAnjiZ4CQO73ErATgsJK9h8ZkdfnjJ
=GIwH
-----END PGP SIGNATURE-----

--nextPart2243776.qspmg5Jme8--
