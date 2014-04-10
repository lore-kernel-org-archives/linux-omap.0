From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/11] ARM: dts: Enable N900 keybaord sleep leds by default
Date: Thu, 10 Apr 2014 16:47:15 -0700
Message-ID: <1397173639-29587-8-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49089 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758550AbaDJXrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 19:47:31 -0400
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Paul Walmsley <paul@pwsan.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>

On N900 there are nice LEDs that show the state of the
sys_clkreq and sys_off_mode pins.

These LEDs go low when the system enters deeper idle
states. The left LED shows the state of the sys_clkreq
pin, and goes off during retention idle. The right LED
shows the state of sys_off_mode pin and both go off
during off idle.

As N900 is a battery operated device, these LEDs should
be off most of the time. So let's enable them by default
so we can make sure the system is mostly idle.

This allows the maintainers to also immediately test
patches for PM regressions by looking at the LEDs,
which certainly makes my life easier.

The LED can naturally be disabled during runtime with:

# echo none > /sys/class/leds/debug::sleep/trigger

Note that we don't currently have support for omap3
errata 1.158 that remuxes GPIO pins to INPUT_PULLUP |
MUX_MODE7 for the duration of idle. This means that the
GPIO pins set high will go down during off idle. In this
case it does not matter as the sys_off_mode goes down
too, but there's still a slim chance of false off idle
LED signals. If in doubt, false LED signals can be
verified by the sys_off_mode or vdd_core values.

Also note that to allow the UARTs to autoidle, the
following needs to be run on N900 to enable off idle:

#!/bin/sh
uarts=3D$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
	echo 3000 > $uart/autosuspend_delay_ms
done

uarts=3D$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
	echo enabled > $uart/wakeup
	echo auto > $uart/control
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

=46or retention idle, change the above to set 0 to
enable_off_mode.

Also note that without the twl4030 PM scripts the actual
voltage scaling won't happen for off idle so we only get
voltage scaling over I2C4 for retention idle. I'll do
some device tree patches for those also a bit later on.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index 0bf40c9..0d34201 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -21,6 +21,17 @@
 		};
 	};
=20
+        leds {
+                compatible =3D "gpio-leds";
+                heartbeat {
+                        label =3D "debug::sleep";
+                        gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpi=
o162 */
+                        linux,default-trigger =3D "default-on";
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&debug_leds>;
+                };
+        };
+
 	memory {
 		device_type =3D "memory";
 		reg =3D <0x80000000 0x10000000>; /* 256 MB */
@@ -114,6 +125,12 @@
 		>;
 	};
=20
+	debug_leds: pinmux_debug_led_pins {
+		pinctrl-single,pins =3D <
+			OMAP3_CORE1_IOPAD(0x2198, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_clkx.gp=
io_162 */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins =3D <
 			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
--=20
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
