From: "Luke-Jr" <luke@dashjr.org>
Subject: [PATCH] omap: rx51: Add bq27200 battery platform data
Date: Sun, 15 Aug 2010 01:12:10 -0500
Message-ID: <201008150112.30128.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2172023.hh0B3XKSJT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zinan.dashjr.org ([173.242.112.54]:39367 "EHLO zinan.dashjr.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab0HOGUu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Aug 2010 02:20:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <cbou@mail.ru>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>

--nextPart2172023.hh0B3XKSJT
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
=2D--
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-o=
map2/board-rx51-peripherals.c
index 0348392..4131cc6 100644
=2D-- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -731,6 +731,9 @@ static struct i2c_board_info __initdata rx51_peripheral=
s_i2c_board_info_2[] =3D {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
 	},
+	{
+		I2C_BOARD_INFO("bq27200", 0x55),
+	},
 };
=20
 static int __init rx51_i2c_init(void)
=2D-=20
1.7.1

--nextPart2172023.hh0B3XKSJT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkxnhU0ACgkQZl/BHdU+lYOp6gCfYfjX5s2QCqVUvf5mYaZMm9ll
ImkAn3bXiHhLgvi5VvJ2XHyk5DwLIwbm
=k8PO
-----END PGP SIGNATURE-----

--nextPart2172023.hh0B3XKSJT--
