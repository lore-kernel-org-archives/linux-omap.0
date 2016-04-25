From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: dra7xx: Fix compatible string for PCF8575 chip
Date: Mon, 25 Apr 2016 15:53:54 +0300
Message-ID: <1461588834-20908-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The boards use a TI variant of the PCF8575 so specify that
in the compatible string.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7-evm.dts          | 6 +++---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d272cf1..4fb0ff4 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -556,7 +556,7 @@
 	};
 
 	pcf_lcd: gpio@20 {
-		compatible = "nxp,pcf8575";
+		compatible = "ti,pcf8575", "nxp,pcf8575";
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
@@ -567,7 +567,7 @@
 	};
 
 	pcf_gpio_21: gpio@21 {
-		compatible = "nxp,pcf8575";
+		compatible = "ti,pcf8575", "nxp,pcf8575";
 		reg = <0x21>;
 		lines-initial-states = <0x1408>;
 		gpio-controller;
@@ -601,7 +601,7 @@
 	clock-frequency = <400000>;
 
 	pcf_hdmi: gpio@26 {
-		compatible = "nxp,pcf8575";
+		compatible = "ti,pcf8575", "nxp,pcf8575";
 		reg = <0x26>;
 		gpio-controller;
 		#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 2c88050..90a827d 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -408,7 +408,7 @@
 	};
 
 	pcf_gpio_21: gpio@21 {
-		compatible = "nxp,pcf8575";
+		compatible = "ti,pcf8575", "nxp,pcf8575";
 		reg = <0x21>;
 		lines-initial-states = <0x1408>;
 		gpio-controller;
@@ -440,7 +440,7 @@
 	clock-frequency = <400000>;
 
 	pcf_hdmi: pcf8575@26 {
-		compatible = "nxp,pcf8575";
+		compatible = "ti,pcf8575", "nxp,pcf8575";
 		reg = <0x26>;
 		gpio-controller;
 		#gpio-cells = <2>;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
