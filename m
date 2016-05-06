From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2] ARM: dts: am57xx-idk-common: Fix input supply names
Date: Fri, 6 May 2016 08:37:57 -0500
Message-ID: <1462541877-20032-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Palmas Regulator is an exception and does not follow the standard
"vin-supply" common definitions for all regulators, as a result of this,
the input supplies are not reported to regulator framework, with the
obvious result of not being appropriately mapped. Fix the same.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
Changes since V1:
	- fix up fat fingered deletion of regulator name of ldortc
V1: https://patchwork.kernel.org/patch/9028201/
Based on: next-20160506

bootlog: http://pastebin.ubuntu.com/16258763/

 arch/arm/boot/dts/am57xx-idk-common.dtsi | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index b01a5948cdd0..0e63b9dff6e7 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -60,10 +60,26 @@
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
+
+			smps12-in-supply = <&vmain>;
+			smps3-in-supply = <&vmain>;
+			smps45-in-supply = <&vmain>;
+			smps6-in-supply = <&vmain>;
+			smps7-in-supply = <&vmain>;
+			smps8-in-supply = <&vmain>;
+			smps9-in-supply = <&vmain>;
+			ldo1-in-supply = <&vmain>;
+			ldo2-in-supply = <&vmain>;
+			ldo3-in-supply = <&vmain>;
+			ldo4-in-supply = <&vmain>;
+			ldo9-in-supply = <&vmain>;
+			ldoln-in-supply = <&vmain>;
+			ldousb-in-supply = <&vmain>;
+			ldortc-in-supply = <&vmain>;
+
 			regulators {
 				smps12_reg: smps12 {
 					/* VDD_MPU */
-					vin-supply = <&vmain>;
 					regulator-name = "smps12";
 					regulator-min-microvolt = <850000>;
 					regulator-max-microvolt = <1250000>;
@@ -73,7 +89,6 @@
 
 				smps3_reg: smps3 {
 					/* VDD_DDR EMIF1 EMIF2 */
-					vin-supply = <&vmain>;
 					regulator-name = "smps3";
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
@@ -84,7 +99,6 @@
 				smps45_reg: smps45 {
 					/* VDD_DSPEVE on AM572 */
 					/* VDD_IVA + VDD_DSP on AM571 */
-					vin-supply = <&vmain>;
 					regulator-name = "smps45";
 					regulator-min-microvolt = <850000>;
 					regulator-max-microvolt = <1250000>;
@@ -94,7 +108,6 @@
 
 				smps6_reg: smps6 {
 					/* VDD_GPU */
-					vin-supply = <&vmain>;
 					regulator-name = "smps6";
 					regulator-min-microvolt = <850000>;
 					regulator-max-microvolt = <1250000>;
@@ -104,7 +117,6 @@
 
 				smps7_reg: smps7 {
 					/* VDD_CORE */
-					vin-supply = <&vmain>;
 					regulator-name = "smps7";
 					regulator-min-microvolt = <850000>;
 					regulator-max-microvolt = <1150000>;
@@ -115,13 +127,11 @@
 				smps8_reg: smps8 {
 					/* 5728 - VDD_IVAHD */
 					/* 5718 - N.C. test point */
-					vin-supply = <&vmain>;
 					regulator-name = "smps8";
 				};
 
 				smps9_reg: smps9 {
 					/* VDD_3_3D */
-					vin-supply = <&vmain>;
 					regulator-name = "smps9";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -132,7 +142,6 @@
 				ldo1_reg: ldo1 {
 					/* VDDSHV8 - VSDMMC  */
 					/* NOTE: on rev 1.3a, data supply */
-					vin-supply = <&vmain>;
 					regulator-name = "ldo1";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
@@ -142,7 +151,6 @@
 
 				ldo2_reg: ldo2 {
 					/* VDDSH18V */
-					vin-supply = <&vmain>;
 					regulator-name = "ldo2";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -152,7 +160,6 @@
 
 				ldo3_reg: ldo3 {
 					/* R1.3a 572x V1_8PHY_LDO3: USB, SATA */
-					vin-supply = <&vmain>;
 					regulator-name = "ldo3";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -162,7 +169,6 @@
 
 				ldo4_reg: ldo4 {
 					/* R1.3a 572x V1_8PHY_LDO4: PCIE, HDMI*/
-					vin-supply = <&vmain>;
 					regulator-name = "ldo4";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -174,7 +180,6 @@
 
 				ldo9_reg: ldo9 {
 					/* VDD_RTC  */
-					vin-supply = <&vmain>;
 					regulator-name = "ldo9";
 					regulator-min-microvolt = <840000>;
 					regulator-max-microvolt = <1160000>;
@@ -184,7 +189,6 @@
 
 				ldoln_reg: ldoln {
 					/* VDDA_1V8_PLL */
-					vin-supply = <&vmain>;
 					regulator-name = "ldoln";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -194,7 +198,6 @@
 
 				ldousb_reg: ldousb {
 					/* VDDA_3V_USB: VDDA_USBHS33 */
-					vin-supply = <&vmain>;
 					regulator-name = "ldousb";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -204,7 +207,6 @@
 
 				ldortc_reg: ldortc {
 					/* VDDA_RTC  */
-					vin-supply = <&vmain>;
 					regulator-name = "ldortc";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
-- 
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
