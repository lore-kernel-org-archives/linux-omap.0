From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 07/12] ARM: dts: cm-t3x30: add HS USB Host support
Date: Sun, 12 Jan 2014 15:22:50 +0200
Message-ID: <1389532975-28281-8-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59084 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbaALNXF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:05 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add HS USB Host support along with USB PHYs and power supply regulators

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   38 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |    8 +++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index abda493..c671a22 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -19,6 +19,36 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	/* HS USB Port 1 Power */
+	hsusb1_power: hsusb1_power_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb1_vbus";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <70000>;
+	};
+
+	/* HS USB Port 2 Power */
+	hsusb2_power: hsusb2_power_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "hsusb2_vbus";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <70000>;
+	};
+
+	/* HS USB Host PHY on PORT 1 */
+	hsusb1_phy: hsusb1_phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&hsusb1_power>;
+	};
+
+	/* HS USB Host PHY on PORT 2 */
+	hsusb2_phy: hsusb2_phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&hsusb2_power>;
+	};
 };
 
 &omap3_pmx_core {
@@ -70,3 +100,11 @@
 &i2c3 {
 	clock-frequency = <400000>;
 };
+&usbhshost {
+	port1-mode = "ehci-phy";
+	port2-mode = "ehci-phy";
+};
+
+&usbhsehci {
+	phys = <&hsusb1_phy &hsusb2_phy>;
+};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index a56d082..cb43929 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -93,3 +93,11 @@
 	/* pullups: BIT(0) */
 	ti,pullups = <0x000001>;
 };
+
+&hsusb1_phy {
+	reset-gpios = <&twl_gpio 6 GPIO_ACTIVE_LOW>;
+};
+
+&hsusb2_phy {
+	reset-gpios = <&twl_gpio 7 GPIO_ACTIVE_LOW>;
+};
-- 
1.7.5.4

