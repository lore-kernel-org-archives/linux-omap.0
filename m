From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v6 5/7] ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP and EPWM nodes
Date: Fri, 22 Apr 2016 11:40:36 -0500
Message-ID: <1461343238-29274-6-git-send-email-fcooper@ti.com>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1461343238-29274-1-git-send-email-fcooper@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: thierry.reding@gmail.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Previous patches switched the ECAP and EPWM to use the new bindings.
These bindings explicitly adds the various required clocks via DT rather
than depending on hwmod.

Therefore, it is safe to remove the hwmod entries since they are no longer
needed.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt   | 3 ---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 3 ---
 arch/arm/boot/dts/am33xx.dtsi                          | 6 ------
 arch/arm/boot/dts/am4372.dtsi                          | 9 ---------
 4 files changed, 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 5c7a116..39277b6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -10,8 +10,6 @@ Required properties:
 - reg: physical base address and size of the registers map.
 
 Optional properties:
-- ti,hwmods: Name of the hwmod associated to the ECAP:
-  "ecap<x>", <x> being the 0-based instance number from the HW spec
 - clocks: Handle to the ECAP's functional clock.
 - clock-names: Must be set to "fck".
 
@@ -21,7 +19,6 @@ ecap0: ecap@0 { /* ECAP on am33xx */
 	compatible = "ti,am3352-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x48300100 0x80>;
-	ti,hwmods = "ecap0";
 	clocks = <&l4ls_gclk>;
 	clock-names = "fck";
 };
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index a82e249..ac1eae6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -10,8 +10,6 @@ Required properties:
 - reg: physical base address and size of the registers map.
 
 Optional properties:
-- ti,hwmods: Name of the hwmod associated to the EHRPWM:
-  "ehrpwm<x>", <x> being the 0-based instance number from the HW spec
 - clocks: Handle to the PWM's time-base and functional clock.
 - clock-names: Must be set to "tbclk" and "fck".
 
@@ -23,7 +21,6 @@ ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
 	reg = <0x48300200 0x100>;
 	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
 	clock-names = "tbclk", "fck";
-	ti,hwmods = "ehrpwm0";
 };
 
 ehrpwm0: pwm@300000 { /* EHRPWM on da850 */
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 999ba2f..2661acc 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -687,7 +687,6 @@
 				clock-names = "fck";
 				interrupts = <31>;
 				interrupt-names = "ecap0";
-				ti,hwmods = "ecap0";
 				status = "disabled";
 			};
 
@@ -696,7 +695,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
-				ti,hwmods = "ehrpwm0";
 				clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
@@ -723,7 +721,6 @@
 				clock-names = "fck";
 				interrupts = <47>;
 				interrupt-names = "ecap1";
-				ti,hwmods = "ecap1";
 				status = "disabled";
 			};
 
@@ -732,7 +729,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
-				ti,hwmods = "ehrpwm1";
 				clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
@@ -759,7 +755,6 @@
 				clock-names = "fck";
 				interrupts = <61>;
 				interrupt-names = "ecap2";
-				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
 
@@ -768,7 +763,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
-				ti,hwmods = "ehrpwm2";
 				clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index e858460..cfdd4b7 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -677,7 +677,6 @@
 					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
-				ti,hwmods = "ecap0";
 				clocks = <&l4ls_gclk>;
 				clock-names = "fck";
 				status = "disabled";
@@ -689,7 +688,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
-				ti,hwmods = "ehrpwm0";
 				clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
@@ -711,7 +709,6 @@
 					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
-				ti,hwmods = "ecap1";
 				clocks = <&l4ls_gclk>;
 				clock-names = "fck";
 				status = "disabled";
@@ -723,7 +720,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
-				ti,hwmods = "ehrpwm1";
 				clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
@@ -747,7 +743,6 @@
 				reg = <0x48304100 0x80>;
 				clocks = <&l4ls_gclk>;
 				clock-names = "fck";
-				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
 
@@ -757,7 +752,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
-				ti,hwmods = "ehrpwm2";
 				clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
@@ -779,7 +773,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48306200 0x80>;
-				ti,hwmods = "ehrpwm3";
 				clocks = <&ehrpwm3_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
@@ -801,7 +794,6 @@
 					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48308200 0x80>;
-				ti,hwmods = "ehrpwm4";
 				clocks = <&ehrpwm4_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
 				status = "disabled";
@@ -825,7 +817,6 @@
 				reg = <0x4830a200 0x80>;
 				clocks = <&ehrpwm5_tbclk>, <&l4ls_gclk>;
 				clock-names = "tbclk", "fck";
-				ti,hwmods = "ehrpwm5";
 				status = "disabled";
 			};
 		};
-- 
2.7.0

