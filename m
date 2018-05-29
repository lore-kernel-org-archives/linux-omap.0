From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/5] ARM: dts: am57xx-idk: Enable dual role for USB2 port
Date: Tue, 29 May 2018 12:00:55 +0300
Message-ID: <1527584458-6257-3-git-send-email-rogerq@ti.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, "[4.16+]" <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Dual-role support was added in v4.12. We should be using
it for USB2 port on the am57xx-idk.

Cc: <stable@vger.kernel.org>        [4.16+]
Reported-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts         | 4 ----
 arch/arm/boot/dts/am572x-idk-common.dtsi | 4 ----
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 7 ++++++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index a255514..86301ae 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -65,10 +65,6 @@
 	};
 };
 
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &extcon_usb2 {
 	id-gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
 	vbus-gpio = <&gpio7 22 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/am572x-idk-common.dtsi b/arch/arm/boot/dts/am572x-idk-common.dtsi
index c6d858b..784639d 100644
--- a/arch/arm/boot/dts/am572x-idk-common.dtsi
+++ b/arch/arm/boot/dts/am572x-idk-common.dtsi
@@ -57,10 +57,6 @@
 	};
 };
 
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &extcon_usb2 {
 	id-gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 	vbus-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43cdf52..697cd1a 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -406,8 +406,13 @@
 	dr_mode = "host";
 };
 
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
 &usb2 {
-	dr_mode = "peripheral";
+	extcon = <&extcon_usb2>;
+	dr_mode = "otg";
 };
 
 &mmc1 {
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
