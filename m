From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: DRA7-evm: Add missing regulators
Date: Thu, 3 Mar 2016 08:49:48 +0530
Message-ID: <1456975188-9746-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Few regulators information were missing from DT. Add those
missing regulators.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-evm.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d9b8723..dc4df55 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -33,6 +33,7 @@
 	evm_3v3_sw: fixedregulator-evm_3v3_sw {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3_sw";
+		vin-supply = <&sysen1>;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -64,6 +65,7 @@
 		regulator-always-on;
 		regulator-boot-on;
 		enable-active-high;
+		vin-supply = <&sysen2>;
 		gpio = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -523,6 +525,31 @@
 					regulator-max-microvolt = <3300000>;
 					regulator-boot-on;
 				};
+
+				/* REGEN1 is unused */
+
+				regen2: regen2 {
+					/* Needed for PMIC internal resources */
+					regulator-name = "regen2";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				/* REGEN3 is unused */
+
+				sysen1: sysen1 {
+					/* PMIC_REGEN_3V3 */
+					regulator-name = "sysen1";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				sysen2: sysen2 {
+					/* PMIC_REGEN_DDR */
+					regulator-name = "sysen2";
+					regulator-boot-on;
+					regulator-always-on;
+				};
 			};
 		};
 	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
