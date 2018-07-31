From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 18/32] ARM: dts: omap3-gta04: add camera pinmux
Date: Tue, 31 Jul 2018 09:11:21 +0200
Message-ID: <6406849125350a3a921fb2620158d6d891d466da.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

ISP needs camera pinmux (which is referenced by the camera node).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 3d3876782a00..89e16e1897f7 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -330,6 +330,32 @@
 			OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio160 */
 		>;
 	};
+
+	camera_pins: pinmux_camera_pins {
+		pinctrl-single,pins = <
+			/* set up parallel camera interface */
+			OMAP3_CORE1_IOPAD(0x210c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_hs */
+			OMAP3_CORE1_IOPAD(0x210e, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_vs */
+			OMAP3_CORE1_IOPAD(0x2110, PIN_OUTPUT | MUX_MODE0) /* cam_xclka */
+			OMAP3_CORE1_IOPAD(0x2112, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_pclk */
+			OMAP3_CORE1_IOPAD(0x2114, PIN_OUTPUT | MUX_MODE4) /* cam_fld = gpio_98 */
+			OMAP3_CORE1_IOPAD(0x2116, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d0 */
+			OMAP3_CORE1_IOPAD(0x2118, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d1 */
+			OMAP3_CORE1_IOPAD(0x211a, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d2 */
+			OMAP3_CORE1_IOPAD(0x211c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d3 */
+			OMAP3_CORE1_IOPAD(0x211e, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d4 */
+			OMAP3_CORE1_IOPAD(0x2120, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d5 */
+			OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d6 */
+			OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d7 */
+			OMAP3_CORE1_IOPAD(0x2126, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d8 */
+			OMAP3_CORE1_IOPAD(0x2128, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d9 */
+			OMAP3_CORE1_IOPAD(0x212a, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d10 */
+			OMAP3_CORE1_IOPAD(0x212c, PIN_INPUT_PULLDOWN | MUX_MODE0) /* cam_d10 */
+			OMAP3_CORE1_IOPAD(0x212e, PIN_OUTPUT | MUX_MODE0) /* cam_xclkb */
+			OMAP3_CORE1_IOPAD(0x2130, PIN_OUTPUT | MUX_MODE4) /* cam_wen = gpio_167 */
+			OMAP3_CORE1_IOPAD(0x2132, PIN_INPUT_PULLDOWN | MUX_MODE4) /* cam_strobe */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
-- 
2.12.2
