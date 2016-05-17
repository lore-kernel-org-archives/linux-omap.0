From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 3/5] ARM: dta: omap3-gta04: Define and use itg3200  irq pin
Date: Tue, 17 May 2016 21:48:49 +0200
Message-ID: <1463514531-7235-4-git-send-email-marek@goldelico.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Define pinmux and usage if irq pin + fix irq edge.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e0520cf..094e5e1 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -256,6 +256,12 @@
 			OMAP3_CORE1_IOPAD(0x213a, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio115 */
 		>;
 	};
+
+	itg3200_pins: pinmux_itg3200_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20b8, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio56 */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -336,8 +342,10 @@
 	itg3200@68 {
 		compatible = "invensense,itg3200";
 		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&itg3200_pins>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <24 0>; /* GPIO_56 */
+		interrupts = <24 IRQ_TYPE_EDGE_FALLING>; /* GPIO_56 */
 	};
 
 	/* leds */
-- 
2.5.0
