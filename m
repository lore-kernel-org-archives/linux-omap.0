From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v7 9/9] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Tue, 26 Apr 2016 17:36:49 -0500
Message-ID: <1461710209-6563-10-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

Add PWMSS device tree nodes for DRA7 SoC family and add documentation
for dt bindings.

Signed-off-by: Vignesh R <vigneshr@ti.com>
[fcooper@ti.com: Add eCAP and use updated bindings for PWMSS and ePWM]
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pwm/pwm-tiecap.txt         |  9 +++
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 +++
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 12 +++
 arch/arm/boot/dts/dra7.dtsi                        | 90 ++++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 4d4c977..759de05 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -5,6 +5,7 @@ Required properties:
   for am33xx - compatible = "ti,am3352-ecap", "ti,am33xx-ecap";
   for am4372 - compatible = "ti,am4372-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
   for da850  - compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
+  for dra746 - compatible = "ti,dra746-ecap", "ti,am3352-ecap";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
@@ -38,3 +39,11 @@ ecap0: ecap@1f06000 { /* ECAP on da850 */
 	#pwm-cells = <3>;
 	reg = <0x306000 0x80>;
 };
+
+ecap0: ecap@4843e100 {
+	compatible = "ti,dra746-ecap", "ti,am3352-ecap";
+	#pwm-cells = <3>;
+	reg = <0x4843e100 0x80>;
+	clocks = <&l4_root_clk_div>;
+	clock-names = "fck";
+};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index c1d6a2a..135132a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -5,6 +5,7 @@ Required properties:
   for am33xx  - compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
   for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
   for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
+  for dra746 - compatible = "ti,dra746-ehrpwm", "ti-am3352-ehrpwm";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
@@ -38,3 +39,11 @@ ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
 	#pwm-cells = <3>;
 	reg = <0x300000 0x2000>;
 };
+
+ehrpwm0: pwm@4843e200 { /* EHRPWM on dra746 */
+	compatible = "ti,dra746-ehrpwm", "ti,am3352-ehrpwm";
+	#pwm-cells = <3>;
+	reg = <0x48440200 0x80>;
+	clocks = <&ehrpwm0_tbclk>, <&l4_root_clk_div>;
+	clock-names = "tbclk", "fck";
+};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
index fd8e87c..1a5d7b7 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Must be "ti,<soc>-pwmss".
   for am33xx  - compatible = "ti,am33xx-pwmss";
   for am4372  - compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+  for dra746 - compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss"
 
 - reg: physical base address and size of the registers map.
 - address-cells: Specify the number of u32 entries needed in child nodes.
@@ -46,3 +47,14 @@ epwmss0: epwmss@48300000 { /* PWMSS for am4372 */
 
 	/* child nodes go here */
 };
+
+epwmss0: epwmss@4843e000 { /* PWMSS for DRA7xx */
+	compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss";
+	reg = <0x4843e000 0x30>;
+	ti,hwmods = "epwmss0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	/* child nodes go here */
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e007401..5a21e46 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1743,6 +1743,96 @@
 				clock-names = "fck", "sys_clk";
 			};
 		};
+
+		epwmss0: epwmss@4843e000 {
+			compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss";
+			reg = <0x4843e000 0x30>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm0: pwm@4843e200 {
+				compatible = "ti,dra746-ehrpwm",
+					     "ti,am3352-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x4843e200 0x80>;
+				clocks = <&ehrpwm0_tbclk>, <&l4_root_clk_div>;
+				clock-names = "tbclk", "fck";
+				status = "disabled";
+			};
+
+			ecap0: ecap@4843e100 {
+				compatible = "ti,dra746-ecap",
+					     "ti,am3352-ecap";
+				#pwm-cells = <3>;
+				reg = <0x4843e100 0x80>;
+				clocks = <&l4_root_clk_div>;
+				clock-names = "fck";
+				status = "disabled";
+			};
+		};
+
+		epwmss1: epwmss@48440000 {
+			compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48440000 0x30>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm1: pwm@48440200 {
+				compatible = "ti,dra746-ehrpwm",
+					     "ti,am3352-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48440200 0x80>;
+				clocks = <&ehrpwm1_tbclk>, <&l4_root_clk_div>;
+				clock-names = "tbclk", "fck";
+				status = "disabled";
+			};
+
+			ecap1: ecap@48440100 {
+				compatible = "ti,dra746-ecap",
+					     "ti,am3352-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48440100 0x80>;
+				clocks = <&l4_root_clk_div>;
+				clock-names = "fck";
+				status = "disabled";
+			};
+		};
+
+		epwmss2: epwmss@48442000 {
+			compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48442000 0x30>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm2: pwm@48442200 {
+				compatible = "ti,dra746-ehrpwm",
+					     "ti,am3352-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48442200 0x80>;
+				clocks = <&ehrpwm2_tbclk>, <&l4_root_clk_div>;
+				clock-names = "tbclk", "fck";
+				status = "disabled";
+			};
+
+			ecap2: ecap@48442100 {
+				compatible = "ti,dra746-ecap",
+					     "ti,am3352-ecap";
+				#pwm-cells = <3>;
+				reg = <0x48442100 0x80>;
+				clocks = <&l4_root_clk_div>;
+				clock-names = "fck";
+				status = "disabled";
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
-- 
2.7.0
