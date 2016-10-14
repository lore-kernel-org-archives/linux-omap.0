From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/9] ARM: dra72-evm: Fix modelling of regulators
Date: Fri, 14 Oct 2016 18:30:26 +0530
Message-ID: <20161014130033.14172-3-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161014130033.14172-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add proper description of input voltage regulators and update the voltage
rail map for all the regulators.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 48 +++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 3c02612..8537b6a 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -18,11 +18,47 @@
 		display0 = &hdmi0;
 	};
 
+	evm_12v0: fixedregulator-evm12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	evm_5v0: fixedregulator-evm5v0 {
+		/* Output 1 of TPS43351QDAPRQ1 */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: fixedregulator-vsys3v3 {
+		/* Output 2 of TPS43351QDAPRQ1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	evm_3v3_sw: fixedregulator-evm_3v3 {
+		/* TPS22965DSG */
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
 	};
 
 	aic_dvdd: fixedregulator-aic_dvdd {
@@ -39,6 +75,7 @@
 		regulator-name = "evm_3v3_sd";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_3v3_sw>;
 		enable-active-high;
 		gpio = <&pcf_gpio_21 5 GPIO_ACTIVE_HIGH>;
 	};
@@ -190,6 +227,17 @@
 		tps65917_pmic {
 			compatible = "ti,tps65917-pmic";
 
+			smps1-in-supply = <&vsys_3v3>;
+			smps2-in-supply = <&vsys_3v3>;
+			smps3-in-supply = <&vsys_3v3>;
+			smps4-in-supply = <&vsys_3v3>;
+			smps5-in-supply = <&vsys_3v3>;
+			ldo1-in-supply = <&vsys_3v3>;
+			ldo2-in-supply = <&vsys_3v3>;
+			ldo3-in-supply = <&vsys_3v3>;
+			ldo4-in-supply = <&evm_5v0>;
+			ldo5-in-supply = <&vsys_3v3>;
+
 			tps65917_regulators: regulators {
 				smps1_reg: smps1 {
 					/* VDD_MPU */
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
