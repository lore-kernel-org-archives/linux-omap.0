From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] arm/dts: AM33XX: Convert all hex numbers to lower-case
Date: Mon, 27 Aug 2012 18:01:53 +0530
Message-ID: <1346070714-6122-2-git-send-email-hvaibhav@ti.com>
References: <1346070714-6122-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346070714-6122-1-git-send-email-hvaibhav-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

To make it consistent, convert all hex number presentation
to lower-case from all am33xx specific nodes.

Signed-off-by: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts |    2 +-
 arch/arm/boot/dts/am335x-evm.dts  |    2 +-
 arch/arm/boot/dts/am33xx.dtsi     |   20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a7906cb..c64f7fa 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -19,7 +19,7 @@
 	};
 
 	ocp {
-		uart1: serial@44E09000 {
+		uart1: serial@44e09000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 5dd8a6b..8963f20 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -19,7 +19,7 @@
 	};
 
 	ocp {
-		uart1: serial@44E09000 {
+		uart1: serial@44e09000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index dde76f7..be43511 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -71,7 +71,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		gpio2: gpio@4804C000 {
+		gpio2: gpio@4804c000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio2";
 			gpio-controller;
@@ -80,7 +80,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		gpio3: gpio@481AC000 {
+		gpio3: gpio@481ac000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio3";
 			gpio-controller;
@@ -89,7 +89,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		gpio4: gpio@481AE000 {
+		gpio4: gpio@481ae000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio4";
 			gpio-controller;
@@ -98,7 +98,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		uart1: serial@44E09000 {
+		uart1: serial@44e09000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
@@ -119,28 +119,28 @@
 			status = "disabled";
 		};
 
-		uart4: serial@481A6000 {
+		uart4: serial@481a6000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
 
-		uart5: serial@481A8000 {
+		uart5: serial@481a8000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
 
-		uart6: serial@481AA000 {
+		uart6: serial@481aa000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
 
-		i2c1: i2c@44E0B000 {
+		i2c1: i2c@44e0b000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -148,7 +148,7 @@
 			status = "disabled";
 		};
 
-		i2c2: i2c@4802A000 {
+		i2c2: i2c@4802a000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -156,7 +156,7 @@
 			status = "disabled";
 		};
 
-		i2c3: i2c@4819C000 {
+		i2c3: i2c@4819c000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.0.4
