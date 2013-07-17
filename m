From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 7/9] arm: dts: add omap4430 thermal data
Date: Wed, 17 Jul 2013 11:02:50 -0400
Message-ID: <1374073374-30946-15-git-send-email-eduardo.valentin@ti.com>
References: <1374073374-30946-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50438 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932297Ab3GQPGd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 11:06:33 -0400
In-Reply-To: <1374073374-30946-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: wni@nvidia.com, l.stach@pengutronix.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch changes the dtsi entry on omap4430 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap44=
3x.dtsi
index 4a4dcc3..27f0e0f 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
=20
+#include <dt-bindings/thermal/thermal.h>
 #include "omap4.dtsi"
=20
 / {
@@ -27,8 +28,34 @@
 	};
=20
 	bandgap {
-		reg =3D <0x4a002260 0x4
-		       0x4a00232C 0x4>;
+		reg =3D <0x4a002260 0x4 0x4a00232C 0x4>;
 		compatible =3D "ti,omap4430-bandgap";
+		thermal_zone {
+			type =3D "CPU";
+			mask =3D <0x03>; /* trips writability */
+			passive_delay =3D <250>; /* milliseconds */
+			polling_delay =3D <1000>; /* milliseconds */
+			governor =3D "step_wise";
+			trips {
+				alert@100000{
+					temperature =3D <100000>; /* milliCelsius */
+					hysteresis =3D <2000>; /* milliCelsius */
+					type =3D <THERMAL_TRIP_PASSIVE>;
+				};
+				crit@125000{
+					temperature =3D <125000>; /* milliCelsius */
+					hysteresis =3D <2000>; /* milliCelsius */
+					type =3D <THERMAL_TRIP_CRITICAL>;
+				};
+			};
+			bind_params {
+				action@0{
+					cooling_device =3D "thermal-cpufreq";
+					weight =3D <100>; /* percentage */
+					mask =3D <0x01>;
+					/* no limits, using defaults */
+				};
+			};
+		};
 	};
 };
--=20
1.8.2.1.342.gfa7285d

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
