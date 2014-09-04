From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] ARM: DTS: AM335x: Drop TSC's wire-config parameters
Date: Thu,  4 Sep 2014 16:39:15 +0200
Message-ID: <1409841555-11336-3-git-send-email-bigeasy@linutronix.de>
References: <1409841555-11336-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1409841555-11336-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Jeff Lance <j-lance1@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

=46rom: Jeff Lance <j-lance1@ti.com>

The TSC driver is beeing updated, the parameter is not used anymore. Th=
e
AIN lines can not be muxed. All boards use the same value.
This patch updates the Documentation and dts files.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Jeff Lance <j-lance1@ti.com>
[bigeasy: split, add .dts files to the removal]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt       | 10 --=
--------
 arch/arm/boot/dts/am335x-evm.dts                               |  1 -
 arch/arm/boot/dts/am335x-evmsk.dts                             |  1 -
 arch/arm/boot/dts/am335x-pepper.dts                            |  1 -
 4 files changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc=
-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-a=
dc.txt
index 878549ba814d..eeaf065563c9 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.tx=
t
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.tx=
t
@@ -15,15 +15,6 @@
 				Y and 2 for Z (always). This utilises 12
 				of the 16 software steps available. The
 				remaining 4 can be used by the ADC.
-	ti,wire-config: Different boards could have a different order for
-			connecting wires on touchscreen. We need to provide an
-			8 bit number where in the 1st four bits represent the
-			analog lines and the next 4 bits represent positive/
-			negative terminal on that input line. Notations to
-			represent the input lines and terminals resoectively
-			is as follows:
-			AIN0 =3D 0, AIN1 =3D 1 and so on till AIN7 =3D 7.
-			XP  =3D 0, XN =3D 1, YP =3D 2, YN =3D 3.
 - child "adc"
 	ti,adc-channels: List of analog inputs available for ADC.
 			 AIN0 =3D 0, AIN1 =3D 1 and so on till AIN7 =3D 7.
@@ -35,7 +26,6 @@
 			ti,wires =3D <4>;
 			ti,x-plate-resistance =3D <200>;
 			ti,coordiante-readouts =3D <5>;
-			ti,wire-config =3D <0x00 0x11 0x22 0x33>;
 		};
=20
 		adc {
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335=
x-evm.dts
index e2156a583de7..4c0a5eab5ef2 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -640,7 +640,6 @@
 		ti,wires =3D <4>;
 		ti,x-plate-resistance =3D <200>;
 		ti,coordinate-readouts =3D <5>;
-		ti,wire-config =3D <0x00 0x11 0x22 0x33>;
 	};
=20
 	adc {
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am3=
35x-evmsk.dts
index df5fee6b6b4b..88d83b25089a 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -671,7 +671,6 @@
 		ti,wires =3D <4>;
 		ti,x-plate-resistance =3D <200>;
 		ti,coordinate-readouts =3D <5>;
-		ti,wire-config =3D <0x00 0x11 0x22 0x33>;
 	};
 };
=20
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am=
335x-pepper.dts
index 0d35ab64641c..0939ded7eea5 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -502,7 +502,6 @@
 		ti,wires =3D <4>;
 		ti,x-plate-resistance =3D <200>;
 		ti,coordinate-readouts =3D <5>;
-		ti,wire-config =3D <0x00 0x11 0x22 0x33>;
 	};
=20
 	adc {
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
