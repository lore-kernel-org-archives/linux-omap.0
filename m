From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/1] ARM: dts: am437x gp-evm: add sd card dt nodes
Date: Fri, 27 Dec 2013 21:59:53 +0530
Message-ID: <1388161793-24230-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58967 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab3L0QaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Dec 2013 11:30:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Balaji T K <balajitk@ti.com>

enable sd card slot on am437x-gp-evm

Signed-off-by: Balaji T K <balajitk@ti.com>
---
Depends on [1] Sourav Poddar's series which add am437x-gp-evm.dts

[1]
http://www.spinics.net/lists/linux-omap/msg101723.html

 arch/arm/boot/dts/am437x-gp-evm.dts |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 4eb72b8..df8798e 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -19,6 +19,14 @@
 	model = "TI AM437x GP EVM";
 	compatible = "ti,am437x-gp-evm","ti,am4372","ti,am43";
 
+	vmmcsd_fixed: fixedregulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
@@ -62,6 +70,12 @@
 		>;
 	};
 
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+		>;
+	};
+
 	ecap0_pins: backlight_pins {
 		pinctrl-single,pins = <
 			0x164 MUX_MODE0       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
@@ -91,6 +105,10 @@
 	pinctrl-0 = <&ecap0_pins>;
 };
 
+&gpio0 {
+	status = "okay";
+};
+
 &gpio3 {
 	status = "okay";
 };
@@ -98,3 +116,12 @@
 &gpio4 {
 	status = "okay";
 };
+
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+};
-- 
1.7.5.4

