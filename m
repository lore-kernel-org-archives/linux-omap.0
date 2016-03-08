From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v5 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Mon,  7 Mar 2016 19:23:44 -0600
Message-ID: <1457400224-24797-7-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457400224-24797-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

Add PWMSS device tree nodes for DRA7 SoC family and add documentation
for dt bindings.

Signed-off-by: Vignesh R <vigneshr@ti.com>
[fcooper@ti.com: Add eCAP and use updated bindings for PWMSS and ePWM]
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 5 changes:
Add DT node for eCAP and update eCAP binding documentation

Version 4 changes:
Updated link to the latest documentation

 .../devicetree/bindings/pwm/pwm-tiecap.txt         |  9 +++
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 +++
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
 arch/arm/boot/dts/dra7.dtsi                        | 84 ++++++++++++++++++++++
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 72a8f26..fb9ea89 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Must be "ti,<soc>-ecap".
   for am33xx - compatible = "ti,am33xx-ecap";
   for da850  - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+  for dra7xx - compatible = "ti,dra7xx-ecap", "ti,am33xx-ecap";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
@@ -26,3 +27,11 @@ ecap0: ecap@0 { /* ECAP on da850 */
 	#pwm-cells = <3>;
 	reg = <0x306000 0x80>;
 };
+
+ecap0: ecap@4843e100 {
+	compatible = "ti,dra7xx-ecap",
+		     "ti,am33xx-ecap";
+	#pwm-cells = <3>;
+	reg = <0x4843e100 0x80>;
+};
+
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 345d3f6..5965b9d 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
   for am33xx - compatible = "ti,am33xx-ehrpwm";
   for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+  for dra7xx - compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
@@ -28,3 +29,11 @@ ehrpwm0: pwm@01f00000 { /* EHRPWM on da850 */
 	#pwm-cells = <3>;
 	reg = <0x300000 0x2000>;
 };
+
+ehrpwm0: pwm@4843e200 { /* EHRPWM on dra7xx */
+	compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
+	#pwm-cells = <3>;
+	reg = <0x48440200 0x80>;
+	clocks = <&ehrpwm0_tbclk>;
+	clock-names = "tbclk";
+};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
index 672fa71..f137d0b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
@@ -1,7 +1,9 @@
 TI SOC based PWM Subsystem
 
 Required properties:
-- compatible: Must be "ti,am33xx-pwmss";
+- compatible: Must be "ti,<soc>-pwmss".
+  for am33xx - compatible = "ti,am33xx-pwmss"
+  for dra7xx - compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss"
 - reg: physical base address and size of the registers map.
 - address-cells: Specify the number of u32 entries needed in child nodes.
 		  Should set to 1.
@@ -25,3 +27,14 @@ pwmss0: pwmss@48300000 {
 
 	/* child nodes go here */
 };
+
+epwmss0: epwmss@4843e000 { /* On DRA7xx */
+	compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+	reg = <0x4843e000 0x30>;
+	ti,hwmods = "epwmss0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	/* child nodes go here */
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c4d9175..db62f55 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1597,6 +1597,90 @@
 				clock-names = "fck", "sys_clk";
 			};
 		};
+
+		epwmss0: epwmss@4843e000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x4843e000 0x30>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm0: pwm@4843e200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x4843e200 0x80>;
+				clocks = <&ehrpwm0_tbclk>;
+				clock-names = "tbclk";
+				status = "disabled";
+			};
+
+			ecap0: ecap@4843e100 {
+				compatible = "ti,dra7xx-ecap",
+					     "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x4843e100 0x80>;
+				status = "disabled";
+			};
+		};
+
+		epwmss1: epwmss@48440000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48440000 0x30>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm1: pwm@48440200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48440200 0x80>;
+				clocks = <&ehrpwm1_tbclk>;
+				clock-names = "tbclk";
+				status = "disabled";
+			};
+
+			ecap1: ecap@48440100 {
+				compatible = "ti,dra7xx-ecap",
+					     "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48440100 0x80>;
+				status = "disabled";
+			};
+		};
+
+		epwmss2: epwmss@48442000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48442000 0x30>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm2: pwm@48442200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48442200 0x80>;
+				clocks = <&ehrpwm2_tbclk>;
+				clock-names = "tbclk";
+				status = "disabled";
+			};
+
+			ecap2: ecap@48442100 {
+				compatible = "ti,dra7xx-ecap",
+					     "ti,am33xx-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48442100 0x80>;
+				status = "disabled";
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
-- 
2.7.0
