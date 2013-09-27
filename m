From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv4 12/18] arm: dts: add omap4460 thermal data
Date: Thu, 26 Sep 2013 23:13:19 -0400
Message-ID: <1380251605-3804-13-git-send-email-eduardo.valentin@ti.com>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch changes the dtsi entry on omap4460 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

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
 arch/arm/boot/dts/omap4460.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap44=
60.dtsi
index c2f0f39..4d93aba 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -12,7 +12,7 @@
 / {
 	cpus {
 		/* OMAP446x 'standard device' variants OPP50 to OPPTurbo */
-		cpu@0 {
+		cpu0: cpu@0 {
 			operating-points =3D <
 				/* kHz    uV */
 				350000  1025000
@@ -30,12 +30,18 @@
 		ti,hwmods =3D "debugss";
 	};
=20
-	bandgap {
+	thermal-zones{
+		#include "omap4-cpu-thermal.dtsi"
+	};
+
+	bandgap: bandgap {
 		reg =3D <0x4a002260 0x4
 		       0x4a00232C 0x4
 		       0x4a002378 0x18>;
 		compatible =3D "ti,omap4460-bandgap";
 		interrupts =3D <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
 		gpios =3D <&gpio3 22 0>; /* tshut */
+
+		#thermal-sensor-cells =3D <0>;
 	};
 };
--=20
1.8.2.1.342.gfa7285d
