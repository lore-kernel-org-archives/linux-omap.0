From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 12/14] DTS: ARM: OMAP3-N900: Add TLV320AIC3X support
Date: Wed, 23 Oct 2013 00:49:41 +0200
Message-ID: <1382482183-14426-13-git-send-email-sre@debian.org>
References: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382482183-14426-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

This patch adds support for Nokia N900 TLV320AIC3X chips.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5afbd28..98797e5 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -250,6 +250,32 @@
 
 	clock-frequency = <100000>;
 
+	tlv320aic3x: tlv320aic3x@18 {
+		compatible = "ti,tlv320aic3x";
+		reg = <0x18>;
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		ai3x-gpio-func = <
+			0 /* AIC3X_GPIO1_FUNC_DISABLED */
+			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
+		>;
+
+		AVDD-supply = <&vmmc2>;
+		DRVDD-supply = <&vmmc2>;
+		IOVDD-supply = <&vio>;
+		DVDD-supply = <&vio>;
+	};
+
+	tlv320aic3x_aux: tlv320aic3x@19 {
+		compatible = "ti,tlv320aic3x";
+		reg = <0x19>;
+		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+
+		AVDD-supply = <&vmmc2>;
+		DRVDD-supply = <&vmmc2>;
+		IOVDD-supply = <&vio>;
+		DVDD-supply = <&vio>;
+	};
+
 	bq27200: bq27200@55 {
 		compatible = "ti,bq27200";
 		reg = <0x55>;
-- 
1.8.4.rc3
