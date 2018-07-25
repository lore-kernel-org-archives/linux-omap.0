From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 19/32] ARM: dts: omap3-gta04: add mcbsp (audio subsystem) pinmux
Date: Wed, 25 Jul 2018 08:58:51 +0200
Message-ID: <a9ddc586d5f5b0f1ee8ee2351e792fb73e1ea986.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GTA04 audio system makes use of all four McBSP ports, so set
up proper pinmux.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index a5d1fa1be9c5..935a2a707737 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -356,6 +356,45 @@
 			OMAP3_CORE1_IOPAD(0x2132, PIN_INPUT_PULLDOWN | MUX_MODE4) /* cam_strobe */
 		>;
 	};
+
+	mcbsp1_pins: pinmux_mcbsp1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x218c, PIN_INPUT | MUX_MODE4)	/* mcbsp1_clkr.mcbsp1_clkr - gpio_156 FM interrupt */
+			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE0)	/* mcbsp1_clkr.mcbsp1_fsr */
+			OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dx */
+			OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dr */
+			/* mcbsp_clks is used as PENIRQ */
+			/* OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp_clks */
+			OMAP3_CORE1_IOPAD(0x2196, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp1_fsx */
+			OMAP3_CORE1_IOPAD(0x2198, PIN_INPUT | MUX_MODE0)	/* mcbsp1_clkx.mcbsp1_clkx */
+		>;
+	};
+
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x213c, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx.mcbsp2_fsx */
+			OMAP3_CORE1_IOPAD(0x213e, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx.mcbsp2_clkx */
+			OMAP3_CORE1_IOPAD(0x2140, PIN_INPUT | MUX_MODE0)	/* mcbsp2_dr.mcbsp2_dr */
+			OMAP3_CORE1_IOPAD(0x2142, PIN_OUTPUT | MUX_MODE0)	/* mcbsp2_dr.mcbsp2_dx */
+		>;
+	};
+
+	mcbsp3_pins: pinmux_mcbsp3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x216c, PIN_OUTPUT | MUX_MODE0)	/* mcbsp3_dx.mcbsp3_dx */
+			OMAP3_CORE1_IOPAD(0x216e, PIN_INPUT | MUX_MODE0)	/* mcbsp3_dx.mcbsp3_dr */
+			OMAP3_CORE1_IOPAD(0x2170, PIN_INPUT | MUX_MODE0)	/* mcbsp3_clkx.mcbsp3_clkx */
+			OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE0)	/* mcbsp3_clkx.mcbsp3_fsx */
+		>;
+	};
+
+	mcbsp4_pins: pinmux_mcbsp4_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcbsp4_clkx.mcbsp4_clkx */
+			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcbsp4_clkx.mcbsp4_dr */
+			OMAP3_CORE1_IOPAD(0x218a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcbsp4_dx.mcbsp4_fsx */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
-- 
2.12.2
