From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: dts: da850-evm: Correct the audio codec regulators
Date: Wed, 19 Dec 2018 12:12:58 +0200
Message-ID: <20181219101258.20763-1-peter.ujfalusi@ti.com>
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
tlv320aic3x-codec 0-0018: Too high supply voltage(s) AVDD: 5000000, DVDD: 5000000

With the correct voltages the driver can select correct OCMV value to
reduce pop noise.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f9a5a8212c84..997bede2a48f 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -94,6 +94,28 @@
 		regulator-boot-on;
 	};
 
+	baseboard_3v3: fixedregulator-3v3 {
+		/* TPS73701DCQ */
+		compatible = "regulator-fixed";
+		regulator-name = "baseboard_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vbat>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	baseboard_1v8: fixedregulator-1v8 {
+		/* TPS73701DCQ */
+		compatible = "regulator-fixed";
+		regulator-name = "baseboard_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vbat>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	backlight_lcd: backlight-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "lcd_backlight_pwr";
@@ -210,10 +232,9 @@
 
 		/* Regulators */
 		IOVDD-supply = <&vdcdc2_reg>;
-		/* Derived from VBAT: Baseboard 3.3V / 1.8V */
-		AVDD-supply = <&vbat>;
-		DRVDD-supply = <&vbat>;
-		DVDD-supply = <&vbat>;
+		AVDD-supply = <&baseboard_3v3>;
+		DRVDD-supply = <&baseboard_3v3>;
+		DVDD-supply = <&baseboard_1v8>;
 	};
 	tca6416: gpio@20 {
 		compatible = "ti,tca6416";
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
