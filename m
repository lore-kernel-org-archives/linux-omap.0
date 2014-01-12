From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 09/12] ARM: dts: cm-t3x30: add USB OTG support
Date: Sun, 12 Jan 2014 15:22:52 +0200
Message-ID: <1389532975-28281-10-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:36399 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbaALNXF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:05 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add USB OTG support for cm-t3x30 CoMs.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index cb43929..d000558 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -32,6 +32,23 @@
 			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
 		>;
 	};
+
+ 	hsusb0_pins: pinmux_hsusb0_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_clk.hsusb0_clk */
+			OMAP3_CORE1_IOPAD(0x21a2, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_stp.hsusb0_stp */
+			OMAP3_CORE1_IOPAD(0x21a4, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_dir.hsusb0_dir */
+			OMAP3_CORE1_IOPAD(0x21a6, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_nxt.hsusb0_nxt */
+			OMAP3_CORE1_IOPAD(0x21a8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data0.hsusb2_data0 */
+			OMAP3_CORE1_IOPAD(0x21aa, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data1.hsusb0_data1 */
+			OMAP3_CORE1_IOPAD(0x21ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data2.hsusb0_data2 */
+			OMAP3_CORE1_IOPAD(0x21ae, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data3 */
+			OMAP3_CORE1_IOPAD(0x21b0, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data4 */
+			OMAP3_CORE1_IOPAD(0x21b2, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data5 */
+			OMAP3_CORE1_IOPAD(0x21b4, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data6 */
+			OMAP3_CORE1_IOPAD(0x21b6, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* hsusb0_data7.hsusb0_data7 */
+		>;
+	};
 };
 
 &gpmc {
@@ -101,3 +118,14 @@
 &hsusb2_phy {
 	reset-gpios = <&twl_gpio 7 GPIO_ACTIVE_LOW>;
 };
+
+&usb_otg_hs {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hsusb0_pins>;
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
+	mode = <3>;
+	power = <50>;
+};
-- 
1.7.5.4

