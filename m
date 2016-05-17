From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 4/5] ARM: dta: omap3-gta04: Define and use hmc5843 irq pin
Date: Tue, 17 May 2016 21:48:50 +0200
Message-ID: <1463514531-7235-5-git-send-email-marek@goldelico.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Define pinmux and usage if irq pin.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 094e5e1..55b6b88 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -262,6 +262,12 @@
 			OMAP3_CORE1_IOPAD(0x20b8, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio56 */
 		>;
 	};
+
+	hmc5843_pins: pinmux_hmc5843_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2134, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio112 */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -389,6 +395,10 @@
 	hmc5843@1e {
 		compatible = "honeywell,hmc5883l";
 		reg = <0x1e>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hmc5843_pins>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;	/* gpio112 */
 	};
 
 	/* touchscreen */
-- 
2.5.0
