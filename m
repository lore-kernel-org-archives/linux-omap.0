From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Nokia N900: Broken lirc ir-rx51 driver
Date: Sat, 2 Jan 2016 15:45:35 +0100
Message-ID: <201601021545.35201@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart80659432.qHGkfLRrg1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart80659432.qHGkfLRrg1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

due to this commit (ARM: OMAP2+: Disable code that currently does not
work with multiplaform)

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/driv=
ers/media/rc/Kconfig?id=3Da62a6e98c370ccca37d353a5f763b532411a4c14

lirc driver for Nokia N900 (ir-rx51) cannot be enabled via make
menuconfig. It is because Nokia N900 support cannot be compiled without
ARCH_MULTIPLATFORM, but Nokia N900 lirc driver (IR_RX51) cannot be
compiled when ARCH_MULTIPLATFORM is enabled.

Because ir-rx51 driver is just for Nokia N900 it is nonsense to have
such condition because nobody can use ir-rx51 driver... It is even not
possible to enable compilation for it...

Here is simple patch which enable compilation for Nokia N900 and fix
compile errors:

diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index b6e1311..f70d4c7 100644
=2D-- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -335,7 +335,7 @@ config IR_TTUSBIR
=20
 config IR_RX51
 	tristate "Nokia N900 IR transmitter diode"
=2D	depends on OMAP_DM_TIMER && ARCH_OMAP2PLUS && LIRC && !ARCH_MULTIPLATFO=
RM
+	depends on OMAP_DM_TIMER && ARCH_OMAP2PLUS && LIRC
 	---help---
 	   Say Y or M here if you want to enable support for the IR
 	   transmitter diode built in the Nokia N900 (RX51) device.
diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index b1e19a2..be29bd0 100644
=2D-- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -25,9 +25,9 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/clk.h>
=20
=2D#include <plat/dmtimer.h>
=2D#include <plat/clock.h>
+#include "../../../arch/arm/plat-omap/include/plat/dmtimer.h"
=20
 #include <media/lirc.h>
 #include <media/lirc_dev.h>
@@ -208,7 +208,7 @@ static int lirc_rx51_init_port(struct lirc_rx51 *lirc_r=
x51)
 	}
=20
 	clk_fclk =3D omap_dm_timer_get_fclk(lirc_rx51->pwm_timer);
=2D	lirc_rx51->fclk_khz =3D clk_fclk->rate / 1000;
+	lirc_rx51->fclk_khz =3D clk_get_rate(clk_fclk) / 1000;
=20
 	return 0;
=20

So Tony, you are author of that commit (a62a6e98c3) which broke ir-rx51
module for Nokia N900. Do you know how to fix this driver for upstream
kernel? It would be great to have driver working and not to have it in
this dead state...

Also platform data for this driver are only in legacy board code.
Support in DTS is missing, so driver (after fixing above problem) cannot
be used on DT booted kernel.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart80659432.qHGkfLRrg1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaH4o8ACgkQi/DJPQPkQ1IQjgCgwhx6Sbk1dKqnOunXJvs/dIya
o1QAn0Py0gidkBlbEfFlvSKPcyB5rkbQ
=9J+E
-----END PGP SIGNATURE-----

--nextPart80659432.qHGkfLRrg1--
