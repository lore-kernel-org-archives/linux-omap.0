From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 5/5] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Thu, 25 Feb 2016 16:36:36 -0600
Message-ID: <1456439796-28546-6-git-send-email-fcooper@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, tony@atomide.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

Add PWMSS device tree nodes for DRA7 SoC family and add documentation
for dt bindings.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
Version 3 changes:
None

 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  8 +++
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 17 +++++-
 arch/arm/boot/dts/dra7.dtsi                        | 64 ++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 9c100b2..25d91ae 100644
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
@@ -27,3 +28,10 @@ ehrpwm0: ehrpwm@0 { /* EHRPWM on da850 */
 	#pwm-cells = <3>;
 	reg = <0x300000 0x2000>;
 };
+
+ehrpwm0: ehrpwm@0 { /* EHRPWM on dra7xx */
+	compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
+	#pwm-cells = <3>;
+	reg = <0x48440200 0x80>;
+	ti,hwmods = "ehrpwm0";
+};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
index f7eae77..9270ce6 100644
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
@@ -29,3 +31,16 @@ pwmss0: pwmss@48300000 {
 
 	/* child nodes go here */
 };
+
+epwmss0: epwmss@4843e000 { /* On DRA7xx */
+	compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+	reg = <0x4843e000 0x30>;
+	ti,hwmods = "epwmss0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x4843e100  0x4843e100 0x80	/* ECAP */
+		  0x4843e180  0x4843e180 0x80	/* EQEP */
+		  0x4843e200  0x4843e200 0x80>; /* EHRPWM */
+
+	/* child nodes go here */
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c4d9175..9143db0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1597,6 +1597,70 @@
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
+			ranges = <0x4843e100  0x4843e100 0x80  /* ECAP */
+				  0x4843e180  0x4843e180 0x80  /* EQEP */
+				  0x4843e200  0x4843e200 0x80>;/* EHRPWM */
+
+			ehrpwm0: ehrpwm@4843e200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x4843e200 0x80>;
+				ti,hwmods = "ehrpwm0";
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
+			ranges = <0x48440100  0x48440100  0x80   /* ECAP */
+				  0x48440180  0x48440180  0x80   /* EQEP */
+				  0x48440200  0x48440200  0x80>; /* EHRPWM */
+
+			ehrpwm1: ehrpwm@48440200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48440200 0x80>;
+				ti,hwmods = "ehrpwm1";
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
+
+			ranges = <0x48442100  0x48442100  0x80   /* ECAP */
+				  0x48442180  0x48442180  0x80   /* EQEP */
+				  0x48442200  0x48442200  0x80>; /* EHRPWM */
+
+			ehrpwm2: ehrpwm@48442200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48442200 0x80>;
+				ti,hwmods = "ehrpwm2";
+				status = "disabled";
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
-- 
2.7.0
