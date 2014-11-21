From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 11/11] arm64: dts: exynos7-espresso: Add regulators for Vbus
 and Vbus-Boost
Date: Fri, 21 Nov 2014 19:05:54 +0530
Message-ID: <1416576954-11997-12-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

Adding fixed voltage regulators for Vbus and Vbus-boost required
by USB 3.0 DRD controller on Exynos7-espresso board.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   43 +++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 5424cc4..2dedd5e 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -30,6 +30,28 @@
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x0 0xC0000000>;
 	};
+
+	usb30_vbus_reg: regulator-usb30 {
+		compatible = "regulator-fixed";
+		regulator-name = "VBUS_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gph1 1 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb30_vbus_en>;
+		enable-active-high;
+	};
+
+	usb3drd_vboost_5v: regulator-usb3drd-vboost {
+		compatible = "regulator-fixed";
+		regulator-name = "VUSB_VBUS_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpf4 1 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3drd_vboost_en>;
+		enable-active-high;
+	};
 };
 
 &fin_pll {
@@ -40,6 +62,22 @@
 	status = "okay";
 };
 
+&pinctrl_bus1 {
+	usb30_vbus_en: usb30-vbus-en {
+		samsung,pins = "gph1-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	usb3drd_vboost_en: usb3drd-vboost-en {
+		samsung,pins = "gpf4-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
+
 &rtc {
 	status = "okay";
 };
@@ -82,3 +120,8 @@
 	bus-width = <4>;
 	disable-wp;
 };
+
+&usbdrd_phy {
+	vbus-supply = <&usb30_vbus_reg>;
+	vbus-boost-supply = <&usb3drd_vboost_5v>;
+};
-- 
1.7.10.4
