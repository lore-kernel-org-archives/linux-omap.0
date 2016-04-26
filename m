From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v7 7/9] ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP
 and EPWM nodes
Date: Tue, 26 Apr 2016 17:36:47 -0500
Message-ID: <1461710209-6563-8-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461710209-6563-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Previous patches switched the ECAP and EPWM to use the new bindings.
These bindings explicitly adds the various required clocks via DT rather
than depending on hwmod.

Therefore, it is safe to remove the hwmod entries since they are no longer
needed.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt   | 3 ---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 3 ---
 arch/arm/boot/dts/am33xx.dtsi                          | 6 ------
 arch/arm/boot/dts/am4372.dtsi                          | 9 ---------
 4 files changed, 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 76cf322..4d4c977 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -11,8 +11,6 @@ Required properties:
 - reg: physical base address and size of the registers map.
 
 Optional properties:
-- ti,hwmods: Name of the hwmod associated to the ECAP:
-  "ecap<x>", <x> being the 0-based instance number from the HW spec
 - clocks: Handle to the ECAP's functional clock.
 - clock-names: Must be set to "fck".
 
@@ -22,7 +20,6 @@ ecap0: ecap@48300100 { /* ECAP on am33xx */
 	compatible = "ti,am3352-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
 	reg = <0x48300100 0x80>;
-	ti,hwmods = "ecap0";
 	clocks = <&l4ls_gclk>;
 	clock-names = "fck";
 };
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 87ef528..c1d6a2a 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -11,8 +11,6 @@ Required properties:
 - reg: physical base address and size of the registers map.
 
 Optional properties:
-- ti,hwmods: Name of the hwmod associated to the EHRPWM:
-  "ehrpwm<x>", <x> being the 0-based instance number from the HW spec
 - clocks: Handle to the PWM's time-base and functional clock.
 - clock-names: Must be set to "tbclk" and "fck".
 
@@ -24,7 +22,6 @@ ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
 	reg = <0x48300200 0x100>;
 	clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
 	clock-names = "tbclk", "fck";
-	ti,hwmods = "ehrpwm0";
 };
 
 ehrpwm0: pwm@48300200 { /* EHRPWM on am4372 */
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
