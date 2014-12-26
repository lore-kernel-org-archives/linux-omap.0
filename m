From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] arm: boot: dts: am437x-idk: add gpio-based power key
Date: Fri, 26 Dec 2014 14:53:13 -0600
Message-ID: <1419627193-20838-1-git-send-email-balbi@ti.com>
References: <1419626116-12833-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaLZUx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 15:53:59 -0500
In-Reply-To: <1419626116-12833-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

AM437x IDK board has a User Switch which we can
program to whatever we want. Because this board
doesn't have a PMIC which can give us power button
presses, let's use this user switch as a gpio-keys
power button.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes since v1:
	- Add explicit pinctrl data.
	  (note that ball reset state is already MUX_MODE7, and even
	   though it was already working before, as can be seen from
	   v1's boot logs, it's best that we cope with possibly broken
	   bootloaders)

depends on [1]. Boot logs at [2]. Note that this can rather easily
be folded into the original patch if so desired.

[1] http://marc.info/?l=linux-omap&m=141928747902983&w=2
[2] http://hastebin.com/qezicehunu

 arch/arm/boot/dts/am437x-idk-evm.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index b52dd0a..f9a17e2 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -96,9 +96,29 @@
 		regulator-boot-on;
 		vin-supply = <&v1_5dreg>;
 	};
+
+	gpio_keys: gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pins_default>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0 {
+			label = "power-button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &am43xx_pinmux {
+	gpio_keys_pins_default: gpio_keys_pins_default {
+		pinctrl-single,pins = <
+			0x1b8 (PIN_INPUT | MUX_MODE7)	/* cam0_field.gpio4_2 */
+		>;
+	};
+
 	i2c0_pins_default: i2c0_pins_default {
 		pinctrl-single,pins = <
 			0x188 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_sda.i2c0_sda */
@@ -282,6 +302,10 @@
 	status = "okay";
 };
 
+&gpio4 {
+	status = "okay";
+};
+
 &gpio5 {
 	status = "okay";
 };
-- 
2.2.0

