From: Sebastian Reichel <sre@debian.org>
Subject: RX51: tsc2005 platform data
Date: Sun, 6 Nov 2011 00:49:42 +0100
Message-ID: <20111105234942.GA5937@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:57162 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212Ab1KEXt7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Nov 2011 19:49:59 -0400
Received: from sre.ring0.de (unknown [93.223.97.193])
	by smtp.ring0.de (Postfix) with ESMTP id 2995081FEB
	for <linux-omap@vger.kernel.org>; Sat,  5 Nov 2011 23:49:44 +0000 (UTC)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Please add tsc2005 to board-rx51-peripherals.c. The code should
have gone through the input queue according to [0], but only
the touchscreen driver is part of the mainline linux kernel
since 2.6.39-rc1.

I attached the patch adding tsc2005 support to the rx51 board
file, updated to apply cleanly against the mainline 3.1 kernel.

[0] http://comments.gmane.org/gmane.linux.ports.arm.omap/34198

-- Sebastian

--ZGiS0Q5IWpPtfppv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="rx51-tsc2005-support.patch"
Content-Transfer-Encoding: quoted-printable

Description: Add tsc2005 touchscreen driver to rx51 peripherals board code
 This patch adds the boardcode for tsc2005 touchscreen support
 to board-rx51-peripherals.c.
Author: Aaro Koskinen <aaro.koskinen@nokia.com>
Reviewed-by: Sebastian Reichel <sre@debian.org>
Origin: http://permalink.gmane.org/gmane.linux.kernel.input/12218
Last-Update: 2011-11-06

--- a/arch/arm/mach-omap2/board-rx51-peripherals.c	2011-11-06 00:39:36.0000=
00000 +0100
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c	2011-11-06 00:39:40.0000=
00000 +0100
@@ -15,6 +15,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 #include <linux/wl12xx.h>
+#include <linux/spi/tsc2005.h>
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 #include <linux/clk.h>
@@ -56,6 +57,9 @@
=20
 #define RX51_USB_TRANSCEIVER_RST_GPIO	67
=20
+#define RX51_TSC2005_RESET_GPIO         104
+#define RX51_TSC2005_IRQ_GPIO           100
+
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
@@ -64,6 +68,7 @@
 };
=20
 static struct wl12xx_platform_data wl1251_pdata;
+static struct tsc2005_platform_data tsc2005_pdata;
=20
 #if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODU=
LE)
 static struct tsl2563_platform_data rx51_tsl2563_platform_data =3D {
@@ -107,10 +112,10 @@
 		.modalias		=3D "tsc2005",
 		.bus_num		=3D 1,
 		.chip_select		=3D 0,
-		/* .irq =3D OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),*/
+		.irq                    =3D OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
 		.max_speed_hz		=3D 6000000,
 		.controller_data	=3D &tsc2005_mcspi_config,
-		/* .platform_data =3D &tsc2005_config,*/
+		.platform_data          =3D &tsc2005_pdata,
 	},
 };
=20
@@ -970,6 +975,42 @@
 	 */
 }
=20
+static struct tsc2005_platform_data tsc2005_pdata =3D {
+       .ts_pressure_max   =3D 2048,
+       .ts_pressure_fudge =3D 2,
+       .ts_x_max          =3D 4096,
+       .ts_x_fudge        =3D 4,
+       .ts_y_max          =3D 4096,
+       .ts_y_fudge        =3D 7,
+       .ts_x_plate_ohm    =3D 280,
+       .esd_timeout_ms    =3D 8000,
+};
+
+static void rx51_tsc2005_set_reset(bool enable)
+{
+       gpio_set_value(RX51_TSC2005_RESET_GPIO, enable);
+}
+
+static void __init rx51_init_tsc2005(void)
+{
+       int r;
+
+       r =3D gpio_request(RX51_TSC2005_IRQ_GPIO, "tsc2005 IRQ");
+       if (r >=3D 0)
+               gpio_direction_input(RX51_TSC2005_IRQ_GPIO);
+       else
+               printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 IRQ");
+
+       r =3D gpio_request(RX51_TSC2005_RESET_GPIO, "tsc2005 reset");
+       if (r >=3D 0) {
+               gpio_direction_output(RX51_TSC2005_RESET_GPIO, 1);
+               tsc2005_pdata.set_reset =3D rx51_tsc2005_set_reset;
+       } else {
+               printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 reset");
+               tsc2005_pdata.esd_timeout_ms =3D 0;
+       }
+}
+
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
@@ -977,6 +1018,7 @@
 	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
+	rx51_init_tsc2005();
 	rx51_init_si4713();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));

--ZGiS0Q5IWpPtfppv--

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOtcuWAAoJENju1/PIO/qaz/0P/0IpDwKBekYXH9Nw7Z7gl+oH
2z1YZhr9AEg/bmHd5oCVp/i28F5CQ56owKS3Uug1UygwygUsfu65iMTCNeQFlaFJ
BTtSPJKC7O4oZmTRF1EluBtPge0k/HMWCRcsbEWe0GWvKsLhp7exXOYHmq5VAOyr
ryjDXaug7hrjyIj2JF8HcThk7bZMRJiap4fjnboCXSdbpW4MTeld1mTVWaT6Qmyz
i1A85DctH4PXr+js6QHSBNbNmcPgg73ycOnzakRusJUdFpS657qYgUgrDiyLY2Ll
cHs6yL3eDeijdnkA/J8pGUNK/rfXVwZKcueW1gMq57lRGMUj+e8SbCCsOQF1YHT7
36acZIjlO1I1+dhodSj+mcAudZIDhubj4JgwvKQaFsLgHsWe0K0e49gV8AL4hQY9
HWSz10Ds0Xzqucrxc3sE0RrVax5XbjDVs+JmhocSKr0VD9/fmj5lx7VbSRFTLFWU
+HPqfxmTg6lnmlR5n6XJhQN11GMY1Kn/HrWmofAIG6HPEeq/oU4yYuQLYRPLo12W
vF+LqKp6EYOW1DvXmL2DR/v/ZEiL8pyxnT0X8hq/FtadMH7iqGDtFaA8VAy+bFc3
IeL5vslb5vkEFGUJdF2PiJcgSvrSs/e5FX3kmr9Z+w9QMKJ5V29nDMrixbQeVoGr
4vit4sP8VspU6tZUeICF
=+ReC
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
