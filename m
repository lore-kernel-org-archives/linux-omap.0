From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv4 17/18] arm: dts: add omap5 thermal data
Date: Thu, 26 Sep 2013 23:13:24 -0400
Message-ID: <1380251605-3804-18-git-send-email-eduardo.valentin@ti.com>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380251605-3804-1-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch changes the dtsi entry on omap5 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C. The
system will do a thermal shutdown at 125C whenever
any of its sensors sees this level.

Cc: "Beno=C3=AEt Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index 7cdea1b..187cb71 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -33,7 +33,7 @@
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
=20
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a15";
 			reg =3D <0x0>;
@@ -45,6 +45,12 @@
 		};
 	};
=20
+	thermal-zones {
+		#include "omap4-cpu-thermal.dtsi"
+		#include "omap5-gpu-thermal.dtsi"
+		#include "omap5-core-thermal.dtsi"
+	};
+
 	timer {
 		compatible =3D "arm,armv7-timer";
 		/* PPI secure/nonsecure IRQ */
@@ -705,13 +711,15 @@
 			};
 		};
=20
-		bandgap@4a0021e0 {
+		bandgap: bandgap@4a0021e0 {
 			reg =3D <0x4a0021e0 0xc
 			       0x4a00232c 0xc
 			       0x4a002380 0x2c
 			       0x4a0023C0 0x3c>;
 			interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			compatible =3D "ti,omap5430-bandgap";
+
+			#thermal-sensor-cells =3D <1>;
 		};
 	};
 };
--=20
1.8.2.1.342.gfa7285d

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
