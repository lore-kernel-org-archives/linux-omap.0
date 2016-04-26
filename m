From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v7 5/9] ARM: dts: am437x/am33xx/da850: Add new ECAP and EPWM bindings
Date: Tue, 26 Apr 2016 17:36:45 -0500
Message-ID: <1461710209-6563-6-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
provide the various required clocks.

For AM437 and AM335x, add the required clocks explicitly to DT. The
hwmod entries for ECAP and EPWM will be removed and this will prevent
anything from breaking.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 .../devicetree/bindings/pwm/pwm-tiecap.txt         | 18 +++++---
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       | 18 +++++---
 arch/arm/boot/dts/am33xx.dtsi                      | 30 +++++++++---
 arch/arm/boot/dts/am4372.dtsi                      | 54 ++++++++++++++++++----
 arch/arm/boot/dts/da850.dtsi                       | 15 ++++--
 5 files changed, 103 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 1b7eec5..76cf322 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -2,9 +2,9 @@ TI SOC ECAP based APWM controller
 
 Required properties:
 - compatible: Must be "ti,<soc>-ecap".
-  for am33xx  - compatible = "ti,am33xx-ecap";
-  for am4372  - compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
-  for da850   - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+  for am33xx - compatible = "ti,am3352-ecap", "ti,am33xx-ecap";
+  for am4372 - compatible = "ti,am4372-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
+  for da850  - compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
@@ -13,25 +13,31 @@ Required properties:
 Optional properties:
 - ti,hwmods: Name of the hwmod associated to the ECAP:
   "ecap<x>", <x> being the 0-based instance number from the HW spec
+- clocks: Handle to the ECAP's functional clock.
+- clock-names: Must be set to "fck".
 
 Example:
 
 ecap0: ecap@48300100 { /* ECAP on am33xx */
-	compatible = "ti,am33xx-ecap";
+	compatible = "ti,am3352-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x48300100 0x80>;
 	ti,hwmods = "ecap0";
+	clocks = <&l4ls_gclk>;
+	clock-names = "fck";
 };
 
 ecap0: ecap@48300100 { /* ECAP on am4372 */
-	compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
+	compatible = "ti,am4372-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x48300100 0x80>;
 	ti,hwmods = "ecap0";
+	clocks = <&l4ls_gclk>;
+	clock-names = "fck";
 };
 
 ecap0: ecap@1f06000 { /* ECAP on da850 */
-	compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+	compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x306000 0x80>;
 };
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index cbc538b..87ef528 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -2,9 +2,9 @@ TI SOC EHRPWM based PWM controller
 
 Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
-  for am33xx  - compatible = "ti,am33xx-ehrpwm";
-  for am4372  - compatible = "ti,am4372-ehrpwm", "ti,am33xx-ehrpwm";
-  for da850   - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+  for am33xx  - compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
+  for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
+  for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
@@ -13,25 +13,31 @@ Required properties:
 Optional properties:
 - ti,hwmods: Name of the hwmod associated to the EHRPWM:
   "ehrpwm<x>", <x> being the 0-based instance number from the HW spec
+- clocks: Handle to the PWM's time-base and functional clock.
+- clock-names: Must be set to "tbclk" and "fck".
 
 Example:
 
 ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
-	compatible = "ti,am33xx-ehrpwm";
+	compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x48300200 0x100>;
+	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+	clock-names = "tbclk", "fck";
 	ti,hwmods = "ehrpwm0";
 };
 
 ehrpwm0: pwm@48300200 { /* EHRPWM on am4372 */
-	compatible = "ti,am4372-ehrpwm", "ti,am33xx-ehrpwm";
+	compatible = "ti,am4372-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x48300200 0x80>;
+	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+	clock-names = "tbclk", "fck";
 	ti,hwmods = "ehrpwm0";
 };
 
 ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
-	compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+	compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
 	#pwm-cells = <3>;
 	reg = <0x300000 0x2000>;
 };
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 52be48b..999ba2f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -679,9 +679,12 @@
 				  0x48300200 0x48300200 0x80>; /* EHRPWM */
 
 			ecap0: ecap@48300100 {
-				compatible = "ti,am33xx-ecap";
+				compatible = "ti,am3352-ecap",
+					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
+				clocks = <&l4ls_gclk>;
+				clock-names = "fck";
 				interrupts = <31>;
 				interrupt-names = "ecap0";
 				ti,hwmods = "ecap0";
@@ -689,10 +692,13 @@
 			};
 
 			ehrpwm0: pwm@48300200 {
-				compatible = "ti,am33xx-ehrpwm";
+				compatible = "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
 				ti,hwmods = "ehrpwm0";
+				clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
@@ -709,9 +715,12 @@
 				  0x48302200 0x48302200 0x80>; /* EHRPWM */
 
 			ecap1: ecap@48302100 {
-				compatible = "ti,am33xx-ecap";
+				compatible = "ti,am3352-ecap",
+					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
+				clocks = <&l4ls_gclk>;
+				clock-names = "fck";
 				interrupts = <47>;
 				interrupt-names = "ecap1";
 				ti,hwmods = "ecap1";
@@ -719,10 +728,13 @@
 			};
 
 			ehrpwm1: pwm@48302200 {
-				compatible = "ti,am33xx-ehrpwm";
+				compatible = "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
 				ti,hwmods = "ehrpwm1";
+				clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
@@ -739,9 +751,12 @@
 				  0x48304200 0x48304200 0x80>; /* EHRPWM */
 
 			ecap2: ecap@48304100 {
-				compatible = "ti,am33xx-ecap";
+				compatible = "ti,am3352-ecap",
+					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
+				clocks = <&l4ls_gclk>;
+				clock-names = "fck";
 				interrupts = <61>;
 				interrupt-names = "ecap2";
 				ti,hwmods = "ecap2";
@@ -749,10 +764,13 @@
 			};
 
 			ehrpwm2: pwm@48304200 {
-				compatible = "ti,am33xx-ehrpwm";
+				compatible = "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
 				ti,hwmods = "ehrpwm2";
+				clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 12fcde4..e858460 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -672,18 +672,26 @@
 			status = "disabled";
 
 			ecap0: ecap@48300100 {
-				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
+				compatible = "ti,am4372-ecap",
+					     "ti,am3352-ecap",
+					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
 				ti,hwmods = "ecap0";
+				clocks = <&l4ls_gclk>;
+				clock-names = "fck";
 				status = "disabled";
 			};
 
 			ehrpwm0: pwm@48300200 {
-				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				compatible = "ti,am4372-ehrpwm",
+					     "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
 				ti,hwmods = "ehrpwm0";
+				clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
@@ -698,18 +706,26 @@
 			status = "disabled";
 
 			ecap1: ecap@48302100 {
-				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
+				compatible = "ti,am4372-ecap",
+					     "ti,am3352-ecap",
+					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
 				ti,hwmods = "ecap1";
+				clocks = <&l4ls_gclk>;
+				clock-names = "fck";
 				status = "disabled";
 			};
 
 			ehrpwm1: pwm@48302200 {
-				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				compatible = "ti,am4372-ehrpwm",
+					     "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
 				ti,hwmods = "ehrpwm1";
+				clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
@@ -724,18 +740,26 @@
 			status = "disabled";
 
 			ecap2: ecap@48304100 {
-				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
+				compatible = "ti,am4372-ecap",
+					     "ti,am3352-ecap",
+					     "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
+				clocks = <&l4ls_gclk>;
+				clock-names = "fck";
 				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
 
 			ehrpwm2: pwm@48304200 {
-				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				compatible = "ti,am4372-ehrpwm",
+					     "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
 				ti,hwmods = "ehrpwm2";
+				clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
@@ -750,10 +774,14 @@
 			status = "disabled";
 
 			ehrpwm3: pwm@48306200 {
-				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				compatible = "ti,am4372-ehrpwm",
+					     "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48306200 0x80>;
 				ti,hwmods = "ehrpwm3";
+				clocks = <&ehrpwm3_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
@@ -768,10 +796,14 @@
 			status = "disabled";
 
 			ehrpwm4: pwm@48308200 {
-				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				compatible = "ti,am4372-ehrpwm",
+					     "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x48308200 0x80>;
 				ti,hwmods = "ehrpwm4";
+				clocks = <&ehrpwm4_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				status = "disabled";
 			};
 		};
@@ -786,9 +818,13 @@
 			status = "disabled";
 
 			ehrpwm5: pwm@4830a200 {
-				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
+				compatible = "ti,am4372-ehrpwm",
+					     "ti,am3352-ehrpwm",
+					     "ti,am33xx-ehrpwm";
 				#pwm-cells = <3>;
 				reg = <0x4830a200 0x80>;
+				clocks = <&ehrpwm5_tbclk>, <&l4ls_gclk>;
+				clock-names = "tbclk", "fck";
 				ti,hwmods = "ehrpwm5";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c3910e2..28a1064 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -248,31 +248,36 @@
 			status = "disabled";
 		};
 		ehrpwm0: pwm@01f00000 {
-			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
+				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
 			status = "disabled";
 		};
 		ehrpwm1: pwm@01f02000 {
-			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
+				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
 			status = "disabled";
 		};
 		ecap0: ecap@01f06000 {
-			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			compatible = "ti,da850-ecap", "ti,am3352-ecap",
+				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x306000 0x80>;
 			status = "disabled";
 		};
 		ecap1: ecap@01f07000 {
-			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			compatible = "ti,da850-ecap", "ti,am3352-ecap",
+				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x307000 0x80>;
 			status = "disabled";
 		};
 		ecap2: ecap@01f08000 {
-			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			compatible = "ti,da850-ecap", "ti,am3352-ecap",
+				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x308000 0x80>;
 			status = "disabled";
-- 
2.7.0
