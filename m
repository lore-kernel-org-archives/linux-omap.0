From: Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: dra72-evm: Rename 3.3V regulator tag
Date: Tue, 24 May 2016 15:00:40 -0500
Message-ID: <1464120040-28776-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Rename the tag of the 3.3 V regulator used in the DRA72 EVM in
order to have a consistent tag name with the DRA7 EVM.  This
is useful when the regulator needs to be referenced in common
dtsi files (i.e. for common companion boards like JAMR3 [1]).

[1] http://www.ti.com.cn/cn/lit/ug/sprui52/sprui52.pdf

Signed-off-by: Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 093538e..9d3cf50 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -18,7 +18,7 @@
 		display0 = &hdmi0;
 	};
 
-	evm_3v3: fixedregulator-evm_3v3 {
+	evm_3v3_sw: fixedregulator-evm_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -29,7 +29,7 @@
 		/* TPS77018DBVT */
 		compatible = "regulator-fixed";
 		regulator-name = "aic_dvdd";
-		vin-supply = <&evm_3v3>;
+		vin-supply = <&evm_3v3_sw>;
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
@@ -414,9 +414,9 @@
 		status = "okay";
 
 		/* Regulators */
-		AVDD-supply = <&evm_3v3>;
-		IOVDD-supply = <&evm_3v3>;
-		DRVDD-supply = <&evm_3v3>;
+		AVDD-supply = <&evm_3v3_sw>;
+		IOVDD-supply = <&evm_3v3_sw>;
+		DRVDD-supply = <&evm_3v3_sw>;
 		DVDD-supply = <&aic_dvdd>;
 	};
 };
@@ -597,7 +597,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
 
-	vmmc-supply = <&evm_3v3>;
+	vmmc-supply = <&evm_3v3_sw>;
 	bus-width = <8>;
 	ti,non-removable;
 	max-frequency = <192000000>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
