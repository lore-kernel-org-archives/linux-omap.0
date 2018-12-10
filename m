From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix ranges for am335x epwmss
Date: Mon, 10 Dec 2018 14:10:05 -0800
Message-ID: <20181210221005.24386-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Looks like I missed the ranges for am335x epwmss. Let's set it up the
same way as for am437x and dra7.

Fixes: 87fc89ced3a7 ("ARM: dts: am335x: Move l4 child devices to probe
them with ti-sysc")
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-cm-t335.dts |  2 +-
 arch/arm/boot/dts/am335x-evm.dts     |  2 +-
 arch/arm/boot/dts/am335x-evmsk.dts   |  2 +-
 arch/arm/boot/dts/am335x-shc.dts     |  2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi     | 36 ++++++++++++----------------
 5 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -393,7 +393,7 @@ status = "okay";
 &epwmss0 {
 	status = "okay";
 
-	ecap0: ecap@48300100 {
+	ecap0: ecap@100 {
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ecap0_pins>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -519,7 +519,7 @@
 &epwmss0 {
 	status = "okay";
 
-	ecap0: ecap@48300100 {
+	ecap0: ecap@100 {
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ecap0_pins>;
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -540,7 +540,7 @@
 &epwmss2 {
 	status = "okay";
 
-	ecap2: ecap@48304100 {
+	ecap2: ecap@100 {
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ecap2_pins>;
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -138,7 +138,7 @@
 &epwmss1 {
 	status = "okay";
 
-	ehrpwm1: pwm@48302200 {
+	ehrpwm1: pwm@200 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ehrpwm1_pins>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1899,15 +1899,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				status = "disabled";
-				ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-					  0x48300180 0x48300180 0x80   /* EQEP */
-					  0x48300200 0x48300200 0x80>; /* EHRPWM */
+				ranges = <0 0 0x1000>;
 
-				ecap0: ecap@48300100 {
+				ecap0: ecap@100 {
 					compatible = "ti,am3352-ecap",
 						     "ti,am33xx-ecap";
 					#pwm-cells = <3>;
-					reg = <0x48300100 0x80>;
+					reg = <0x100 0x80>;
 					clocks = <&l4ls_gclk>;
 					clock-names = "fck";
 					interrupts = <31>;
@@ -1915,11 +1913,11 @@
 					status = "disabled";
 				};
 
-				ehrpwm0: pwm@48300200 {
+				ehrpwm0: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
 					#pwm-cells = <3>;
-					reg = <0x48300200 0x80>;
+					reg = <0x200 0x80>;
 					clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
 					clock-names = "tbclk", "fck";
 					status = "disabled";
@@ -1954,15 +1952,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				status = "disabled";
-				ranges = <0x48302100 0x48302100 0x80   /* ECAP */
-					  0x48302180 0x48302180 0x80   /* EQEP */
-					  0x48302200 0x48302200 0x80>; /* EHRPWM */
+				ranges = <0 0 0x1000>;
 
-				ecap1: ecap@48302100 {
+				ecap1: ecap@100 {
 					compatible = "ti,am3352-ecap",
 						     "ti,am33xx-ecap";
 					#pwm-cells = <3>;
-					reg = <0x48302100 0x80>;
+					reg = <0x100 0x80>;
 					clocks = <&l4ls_gclk>;
 					clock-names = "fck";
 					interrupts = <47>;
@@ -1970,11 +1966,11 @@
 					status = "disabled";
 				};
 
-				ehrpwm1: pwm@48302200 {
+				ehrpwm1: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
 					#pwm-cells = <3>;
-					reg = <0x48302200 0x80>;
+					reg = <0x200 0x80>;
 					clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
 					clock-names = "tbclk", "fck";
 					status = "disabled";
@@ -2009,15 +2005,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				status = "disabled";
-				ranges = <0x48304100 0x48304100 0x80   /* ECAP */
-					  0x48304180 0x48304180 0x80   /* EQEP */
-					  0x48304200 0x48304200 0x80>; /* EHRPWM */
+				ranges = <0 0 0x1000>;
 
-				ecap2: ecap@48304100 {
+				ecap2: ecap@100 {
 					compatible = "ti,am3352-ecap",
 						     "ti,am33xx-ecap";
 					#pwm-cells = <3>;
-					reg = <0x48304100 0x80>;
+					reg = <0x100 0x80>;
 					clocks = <&l4ls_gclk>;
 					clock-names = "fck";
 					interrupts = <61>;
@@ -2025,11 +2019,11 @@
 					status = "disabled";
 				};
 
-				ehrpwm2: pwm@48304200 {
+				ehrpwm2: pwm@200 {
 					compatible = "ti,am3352-ehrpwm",
 						     "ti,am33xx-ehrpwm";
 					#pwm-cells = <3>;
-					reg = <0x48304200 0x80>;
+					reg = <0x200 0x80>;
 					clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
 					clock-names = "tbclk", "fck";
 					status = "disabled";
-- 
2.19.2
