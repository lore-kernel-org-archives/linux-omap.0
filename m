From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: dts: da850-lcdk: Correct the audio codec regulators
Date: Wed, 19 Dec 2018 12:13:05 +0200
Message-ID: <20181219101305.20832-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux@armlinux.org.uk, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Add the board level fixed regulators for 3.3V and 1.8V which is used to
power - among other things - the tlv320aic3106 codec.

Apart from removing the following warning during boot:
tlv320aic3x-codec 0-0018: Invalid supply voltage(s) AVDD: -22, DVDD: -22

With the correct voltages the driver can select correct OCMV value to
reduce pop noise.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 0177e3ed20fe..c196e37606c4 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -39,6 +39,36 @@
 		};
 	};
 
+	vcc_5vd: fixedregulator-vcc_5vd {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5vd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+
+	vcc_3v3d: fixedregulator-vcc_3v3d {
+		/* TPS650250 - VDCDC1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3d";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5vd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_1v8d: fixedregulator-vcc_1v8d {
+		/* TPS650250 - VDCDC2 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8d";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_5vd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
@@ -221,6 +251,12 @@
 		compatible = "ti,tlv320aic3106";
 		reg = <0x18>;
 		status = "okay";
+
+		/* Regulators */
+		IOVDD-supply = <&vcc_3v3d>;
+		AVDD-supply = <&vcc_3v3d>;
+		DRVDD-supply = <&vcc_3v3d>;
+		DVDD-supply = <&vcc_1v8d>;
 	};
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
