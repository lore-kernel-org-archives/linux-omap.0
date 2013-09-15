From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 15/16] arm: dts: add omap5 thermal data
Date: Sun, 15 Sep 2013 18:02:42 -0400
Message-ID: <1379282563-14650-16-git-send-email-eduardo.valentin@ti.com>
References: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch changes the dtsi entry on omap5 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C. The
system will do a thermal shutdown at 125C whenever
any of its sensors sees this level.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index 07be2cd..b2ca0cf 100644
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
@@ -704,13 +710,15 @@
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
+			#sensor-cells =3D <1>;
 		};
 	};
 };
--=20
1.8.2.1.342.gfa7285d
