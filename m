From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: dts: am335x-evmsk: Correct the regulators for the audio codec
Date: Fri, 15 Mar 2019 12:59:17 +0200
Message-ID: <20190315105917.8718-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, Stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Correctly map the regulators used by tlv320aic3106.
Both 1.8V and 3.3V for the codec is derived from VBAT via fixed regulators.

Cc: <Stable@vger.kernel.org> # v4.14+
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- Add stable tag for backporting to v4.14+

Regards,
Peter

 arch/arm/boot/dts/am335x-evmsk.dts | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index b128998097ce..2c2d8b5b8cf5 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -73,6 +73,24 @@
 		enable-active-high;
 	};
 
+	/* TPS79518 */
+	v1_8d_reg: fixedregulator-v1_8d {
+		compatible = "regulator-fixed";
+		regulator-name = "v1_8d";
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	/* TPS78633 */
+	v3_3d_reg: fixedregulator-v3_3d {
+		compatible = "regulator-fixed";
+		regulator-name = "v3_3d";
+		vin-supply = <&vbat>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_leds_s0>;
@@ -501,10 +519,10 @@
 		status = "okay";
 
 		/* Regulators */
-		AVDD-supply = <&vaux2_reg>;
-		IOVDD-supply = <&vaux2_reg>;
-		DRVDD-supply = <&vaux2_reg>;
-		DVDD-supply = <&vbat>;
+		AVDD-supply = <&v3_3d_reg>;
+		IOVDD-supply = <&v3_3d_reg>;
+		DRVDD-supply = <&v3_3d_reg>;
+		DVDD-supply = <&v1_8d_reg>;
 	};
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
