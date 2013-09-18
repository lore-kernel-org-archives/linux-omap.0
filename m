From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20RX-51=3A=20Add=20missing=20max=5Fcurrent=20to=20rx51=5Flp5523=5Fled=5Fconfig?=
Date: Wed, 18 Sep 2013 23:52:25 +0200
Message-ID: <1379541145-25934-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Without max_current data in board file lp5523 driver does not change cu=
rrent.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index 9326890..d0f857c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -180,38 +180,47 @@ static struct lp55xx_led_config rx51_lp5523_led_c=
onfig[] =3D {
 		.name		=3D "lp5523:kb1",
 		.chan_nr	=3D 0,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:kb2",
 		.chan_nr	=3D 1,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:kb3",
 		.chan_nr	=3D 2,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:kb4",
 		.chan_nr	=3D 3,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:b",
 		.chan_nr	=3D 4,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:g",
 		.chan_nr	=3D 5,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:r",
 		.chan_nr	=3D 6,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:kb5",
 		.chan_nr	=3D 7,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}, {
 		.name		=3D "lp5523:kb6",
 		.chan_nr	=3D 8,
 		.led_current	=3D 50,
+		.max_current	=3D 255,
 	}
 };
=20
--=20
1.7.10.4
