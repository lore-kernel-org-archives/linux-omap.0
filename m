From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv5 19/20] arm: dts: make OMAP4460 bandgap node to belong to OCP
Date: Tue, 12 Nov 2013 15:46:21 -0400
Message-ID: <1384285582-16933-20-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Small fix on representation. Bandgap node belongs to OCP.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap44=
60.dtsi
index dc22719..def8183 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -39,14 +39,16 @@
 		#include "omap4-cpu-thermal.dtsi"
 	};
=20
-	bandgap: bandgap {
-		reg =3D <0x4a002260 0x4
-		       0x4a00232C 0x4
-		       0x4a002378 0x18>;
-		compatible =3D "ti,omap4460-bandgap";
-		interrupts =3D <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
-		gpios =3D <&gpio3 22 0>; /* tshut */
+	ocp {
+		bandgap: bandgap {
+			reg =3D <0x4a002260 0x4
+			       0x4a00232C 0x4
+			       0x4a002378 0x18>;
+			compatible =3D "ti,omap4460-bandgap";
+			interrupts =3D <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
+			gpios =3D <&gpio3 22 0>; /* tshut */
=20
-		#thermal-sensor-cells =3D <0>;
+			#thermal-sensor-cells =3D <0>;
+		};
 	};
 };
--=20
1.8.2.1.342.gfa7285d
