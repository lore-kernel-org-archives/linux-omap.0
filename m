From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/5] ARM: dts: dra7-evm: Add extcon to USB2 port
Date: Tue, 29 May 2018 12:00:56 +0300
Message-ID: <1527584458-6257-4-git-send-email-rogerq@ti.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Both ports on the dra7-evm and related boards can be used
as dual-role ports. Although we don't enable dual-role mode
for USB2 port let's add the necessary extcon bits to it.

Move the common portion of extcon_usb2 into dra7-evm-common.dtsi

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm-common.dtsi  | 10 ++++++++++
 arch/arm/boot/dts/dra7-evm.dts          |  9 ---------
 arch/arm/boot/dts/dra72-evm-common.dtsi |  1 +
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
index 05a7b1a..425431f 100644
--- a/arch/arm/boot/dts/dra7-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
@@ -20,6 +20,11 @@
 		id-gpio = <&pcf_gpio_21 1 GPIO_ACTIVE_HIGH>;
 	};
 
+	extcon_usb2: extcon_usb2 {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
+	};
+
 	sound0: sound0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DRA7xx-EVM";
@@ -198,8 +203,13 @@
 	extcon = <&extcon_usb1>;
 };
 
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
 &usb2 {
 	dr_mode = "host";
+	extcon = <&extcon_usb2>;
 };
 
 &atl {
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index f1425b0..272ac773 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -54,11 +54,6 @@
 		regulator-max-microvolt = <1800000>;
 	};
 
-	extcon_usb2: extcon_usb2 {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&pcf_gpio_21 2 GPIO_ACTIVE_HIGH>;
-	};
-
 	vtt_fixed: fixedregulator-vtt {
 		compatible = "regulator-fixed";
 		regulator-name = "vtt_fixed";
@@ -338,10 +333,6 @@
 	vdd-supply = <&smps123_reg>;
 };
 
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &elm {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index e85f560..f2c0777 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -399,6 +399,7 @@
 
 &usb2 {
 	dr_mode = "host";
+	extcon = <&extcon_usb2>;
 };
 
 &mmc1 {
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
