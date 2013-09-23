From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2] RX-51: Add missing max_current to rx51_lp5523_led_config
Date: Mon, 23 Sep 2013 14:50:12 +0200
Message-ID: <201309231450.12171@pali>
References: <1379541145-25934-1-git-send-email-pali.rohar@gmail.com> <20130919212922.GA27501@atomide.com> <201309200020.58671@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1569287.tiabN1Odsz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201309200020.58671@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, joerg@openmoko.org
List-Id: linux-omap@vger.kernel.org

--nextPart1569287.tiabN1Odsz
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

here is new version (v2) of patch which adding max_current values to rx51 b=
oard data.
According to joerg safe value for max_current is 100 (10 mA).


RX-51: Add missing max_current to rx51_lp5523_led_config

=46ile drivers/leds/leds-lp55xx-common.c refuse to change led_current sysfs
attribute if value is higher than max_current specified in board file. By d=
efault
global C variables are zero, so changing always failed. This patch adding m=
issing
max_current and setting it to max safe value 100 (10 mA).

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
=2D--
 arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-o=
map2/board-rx51-peripherals.c
index c3270c0..f6fe388 100644
=2D-- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -167,38 +167,47 @@ static struct lp55xx_led_config rx51_lp5523_led_confi=
g[] =3D {
 		.name		=3D "lp5523:kb1",
 		.chan_nr	=3D 0,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:kb2",
 		.chan_nr	=3D 1,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:kb3",
 		.chan_nr	=3D 2,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:kb4",
 		.chan_nr	=3D 3,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:b",
 		.chan_nr	=3D 4,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:g",
 		.chan_nr	=3D 5,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:r",
 		.chan_nr	=3D 6,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:kb5",
 		.chan_nr	=3D 7,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}, {
 		.name		=3D "lp5523:kb6",
 		.chan_nr	=3D 8,
 		.led_current	=3D 50,
+		.max_current	=3D 100,
 	}
 };
=20
=2D-=20
1.7.10.4

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1569287.tiabN1Odsz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlJAOQQACgkQi/DJPQPkQ1Ie7ACfaRKdlGuIvdFe9Cj7joFRwrou
5TMAoLFwzG/LTg/GAuzOQr5khsY3Wlpc
=x1tL
-----END PGP SIGNATURE-----

--nextPart1569287.tiabN1Odsz--
