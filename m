From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 01/10] ARM: dts: omap3/am4372: add missing unit name to ocp node
Date: Mon,  1 Aug 2016 12:46:55 -0400
Message-ID: <1470070024-30281-2-git-send-email-javier@osg.samsung.com>
References: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for many boards:

"Node /ocp has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am3517.dtsi   | 2 +-
 arch/arm/boot/dts/am4372.dtsi   | 2 +-
 arch/arm/boot/dts/omap3.dtsi    | 2 +-
 arch/arm/boot/dts/omap34xx.dtsi | 2 +-
 arch/arm/boot/dts/omap36xx.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 5e3f5e86ffcf..0db19d39d24c 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -15,7 +15,7 @@
 		serial3 = &uart4;
 	};
 
-	ocp {
+	ocp@68000000 {
 		am35x_otg_hs: am35x_otg_hs@5c040000 {
 			compatible = "ti,omap3-musb";
 			ti,hwmods = "am35x_otg_hs";
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fadae5396e1..d8689878d67b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -132,7 +132,7 @@
 		cache-level = <2>;
 	};
 
-	ocp {
+	ocp@44000000 {
 		compatible = "ti,am4372-l3-noc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 4c3c471d2a83..16cf2fdfec75 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -78,7 +78,7 @@
 	 * the moment, just use a fake OCP bus entry to represent the whole bus
 	 * hierarchy.
 	 */
-	ocp {
+	ocp@68000000 {
 		compatible = "ti,omap3-l3-smx", "simple-bus";
 		reg = <0x68000000 0x10000>;
 		interrupts = <9 10>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index e44656258225..e41c52d3b113 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -28,7 +28,7 @@
 		};
 	};
 
-	ocp {
+	ocp@68000000 {
 		omap3_pmx_core2: pinmux@480025d8 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
 			reg = <0x480025d8 0x24>;
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 8b7979153008..718fa88407cd 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -30,7 +30,7 @@
 		};
 	};
 
-	ocp {
+	ocp@68000000 {
 		uart4: serial@49042000 {
 			compatible = "ti,omap3-uart";
 			reg = <0x49042000 0x400>;
-- 
2.5.5
