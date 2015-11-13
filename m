From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 37/39] ARM: dts: omap5-board-common: Use OMAP5_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:15 -0300
Message-ID: <1447390457-1158-38-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macros to define the register as an offset from
the padconf physical address instead of the offset from padconf base.
This makes the DTS easier to read since matches the addresses listed
in the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap5-board-common.dtsi | 94 +++++++++++++++----------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 5cf76a1c5c75..888412c63f97 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -139,60 +139,60 @@
 
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
-			0x17e (PIN_OUTPUT | MUX_MODE6)	/* mcspi1_somi.gpio5_141 */
+			OMAP5_IOPAD(0x1be, PIN_OUTPUT | MUX_MODE6)	/* mcspi1_somi.gpio5_141 */
 		>;
 	};
 
 	mcpdm_pins: pinmux_mcpdm_pins {
 		pinctrl-single,pins = <
-			0x142 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
-			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_ul_data.abemcpdm_ul_data */
-			0x15e (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_dl_data.abemcpdm_dl_data */
-			0x160 (PIN_INPUT_PULLUP | MUX_MODE0)	/* abemcpdm_frame.abemcpdm_frame */
-			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_lb_clk.abemcpdm_lb_clk */
+			OMAP5_IOPAD(0x182, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
+			OMAP5_IOPAD(0x19c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_ul_data.abemcpdm_ul_data */
+			OMAP5_IOPAD(0x19e, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_dl_data.abemcpdm_dl_data */
+			OMAP5_IOPAD(0x1a0, PIN_INPUT_PULLUP | MUX_MODE0)	/* abemcpdm_frame.abemcpdm_frame */
+			OMAP5_IOPAD(0x1a2, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcpdm_lb_clk.abemcpdm_lb_clk */
 		>;
 	};
 
 	mcbsp1_pins: pinmux_mcbsp1_pins {
 		pinctrl-single,pins = <
-			0x14c (PIN_INPUT | MUX_MODE1)		/* abedmic_clk2.abemcbsp1_fsx */
-			0x14e (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* abedmic_clk3.abemcbsp1_dx */
-			0x150 (PIN_INPUT | MUX_MODE1)		/* abeslimbus1_clock.abemcbsp1_clkx */
-			0x152 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* abeslimbus1_data.abemcbsp1_dr */
+			OMAP5_IOPAD(0x18c, PIN_INPUT | MUX_MODE1)		/* abedmic_clk2.abemcbsp1_fsx */
+			OMAP5_IOPAD(0x18e, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* abedmic_clk3.abemcbsp1_dx */
+			OMAP5_IOPAD(0x190, PIN_INPUT | MUX_MODE1)		/* abeslimbus1_clock.abemcbsp1_clkx */
+			OMAP5_IOPAD(0x192, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* abeslimbus1_data.abemcbsp1_dr */
 		>;
 	};
 
 	mcbsp2_pins: pinmux_mcbsp2_pins {
 		pinctrl-single,pins = <
-			0x154 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dr.abemcbsp2_dr */
-			0x156 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dx.abemcbsp2_dx */
-			0x158 (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_fsx.abemcbsp2_fsx */
-			0x15a (PIN_INPUT | MUX_MODE0)		/* abemcbsp2_clkx.abemcbsp2_clkx */
+			OMAP5_IOPAD(0x194, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dr.abemcbsp2_dr */
+			OMAP5_IOPAD(0x196, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abemcbsp2_dx.abemcbsp2_dx */
+			OMAP5_IOPAD(0x198, PIN_INPUT | MUX_MODE0)		/* abemcbsp2_fsx.abemcbsp2_fsx */
+			OMAP5_IOPAD(0x19a, PIN_INPUT | MUX_MODE0)		/* abemcbsp2_clkx.abemcbsp2_clkx */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0x1b2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
-			0x1b4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+			OMAP5_IOPAD(0x1f2, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			OMAP5_IOPAD(0x1f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
 		>;
 	};
 
 	mcspi2_pins: pinmux_mcspi2_pins {
 		pinctrl-single,pins = <
-			0xbc (PIN_INPUT | MUX_MODE0)		/*  mcspi2_clk */
-			0xbe (PIN_INPUT | MUX_MODE0)		/*  mcspi2_simo */
-			0xc0 (PIN_INPUT_PULLUP | MUX_MODE0)	/*  mcspi2_somi */
-			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs0 */
+			OMAP5_IOPAD(0x0fc, PIN_INPUT | MUX_MODE0)		/*  mcspi2_clk */
+			OMAP5_IOPAD(0x0fe, PIN_INPUT | MUX_MODE0)		/*  mcspi2_simo */
+			OMAP5_IOPAD(0x100, PIN_INPUT_PULLUP | MUX_MODE0)	/*  mcspi2_somi */
+			OMAP5_IOPAD(0x102, PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs0 */
 		>;
 	};
 
 	mcspi3_pins: pinmux_mcspi3_pins {
 		pinctrl-single,pins = <
-			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi3_somi */
-			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi3_cs0 */
-			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi3_simo */
-			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi3_clk */
+			OMAP5_IOPAD(0x0b8, PIN_INPUT | MUX_MODE1)		/*  mcspi3_somi */
+			OMAP5_IOPAD(0x0ba, PIN_INPUT | MUX_MODE1)		/*  mcspi3_cs0 */
+			OMAP5_IOPAD(0x0bc, PIN_INPUT | MUX_MODE1)		/*  mcspi3_simo */
+			OMAP5_IOPAD(0x0be, PIN_INPUT | MUX_MODE1)		/*  mcspi3_clk */
 		>;
 	};
 
@@ -215,59 +215,59 @@
 
 	usbhost_pins: pinmux_usbhost_pins {
 		pinctrl-single,pins = <
-			0x84 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe */
-			0x86 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_data */
+			OMAP5_IOPAD(0x0c4, PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe */
+			OMAP5_IOPAD(0x0c6, PIN_INPUT | MUX_MODE0) /* usbb2_hsic_data */
 
-			0x19e (PIN_INPUT | MUX_MODE0) /* usbb3_hsic_strobe */
-			0x1a0 (PIN_INPUT | MUX_MODE0) /* usbb3_hsic_data */
+			OMAP5_IOPAD(0x1de, PIN_INPUT | MUX_MODE0) /* usbb3_hsic_strobe */
+			OMAP5_IOPAD(0x1e0, PIN_INPUT | MUX_MODE0) /* usbb3_hsic_data */
 
-			0x70 (PIN_OUTPUT | MUX_MODE6) /* gpio3_80 HUB_NRESET */
-			0x6e (PIN_OUTPUT | MUX_MODE6) /* gpio3_79 ETH_NRESET */
+			OMAP5_IOPAD(0x0b0, PIN_OUTPUT | MUX_MODE6) /* gpio3_80 HUB_NRESET */
+			OMAP5_IOPAD(0x0ae, PIN_OUTPUT | MUX_MODE6) /* gpio3_79 ETH_NRESET */
 		>;
 	};
 
 	led_gpio_pins: pinmux_led_gpio_pins {
 		pinctrl-single,pins = <
-			0x196 (PIN_OUTPUT | MUX_MODE6) /* uart3_cts_rctx.gpio5_153 */
+			OMAP5_IOPAD(0x1d6, PIN_OUTPUT | MUX_MODE6) /* uart3_cts_rctx.gpio5_153 */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			0x60 (PIN_OUTPUT | MUX_MODE0) /* uart1_tx.uart1_cts */
-			0x62 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart1_tx.uart1_cts */
-			0x64 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart1_rx.uart1_rts */
-			0x66 (PIN_OUTPUT | MUX_MODE0) /* uart1_rx.uart1_rts */
+			OMAP5_IOPAD(0x0a0, PIN_OUTPUT | MUX_MODE0) /* uart1_tx.uart1_cts */
+			OMAP5_IOPAD(0x0a2, PIN_INPUT_PULLUP | MUX_MODE0) /* uart1_tx.uart1_cts */
+			OMAP5_IOPAD(0x0a4, PIN_INPUT_PULLUP | MUX_MODE0) /* uart1_rx.uart1_rts */
+			OMAP5_IOPAD(0x0a6, PIN_OUTPUT | MUX_MODE0) /* uart1_rx.uart1_rts */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x19a (PIN_OUTPUT | MUX_MODE0) /* uart3_rts_irsd.uart3_tx_irtx */
-			0x19c (PIN_INPUT_PULLUP | MUX_MODE0) /* uart3_rx_irrx.uart3_usbb3_hsic */
+			OMAP5_IOPAD(0x1da, PIN_OUTPUT | MUX_MODE0) /* uart3_rts_irsd.uart3_tx_irtx */
+			OMAP5_IOPAD(0x1dc, PIN_INPUT_PULLUP | MUX_MODE0) /* uart3_rx_irrx.uart3_usbb3_hsic */
 		>;
 	};
 
 	uart5_pins: pinmux_uart5_pins {
 		pinctrl-single,pins = <
-			0x170 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart5_rx.uart5_rx */
-			0x172 (PIN_OUTPUT | MUX_MODE0) /* uart5_tx.uart5_tx */
-			0x174 (PIN_INPUT_PULLUP | MUX_MODE0) /* uart5_cts.uart5_rts */
-			0x176 (PIN_OUTPUT | MUX_MODE0) /* uart5_cts.uart5_rts */
+			OMAP5_IOPAD(0x1b0, PIN_INPUT_PULLUP | MUX_MODE0) /* uart5_rx.uart5_rx */
+			OMAP5_IOPAD(0x1b2, PIN_OUTPUT | MUX_MODE0) /* uart5_tx.uart5_tx */
+			OMAP5_IOPAD(0x1b4, PIN_INPUT_PULLUP | MUX_MODE0) /* uart5_cts.uart5_rts */
+			OMAP5_IOPAD(0x1b6, PIN_OUTPUT | MUX_MODE0) /* uart5_cts.uart5_rts */
 		>;
 	};
 
 	dss_hdmi_pins: pinmux_dss_hdmi_pins {
 		pinctrl-single,pins = <
-			0x0fc (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
-			0x100 (PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
-			0x102 (PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
+			OMAP5_IOPAD(0x13c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			OMAP5_IOPAD(0x140, PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
+			OMAP5_IOPAD(0x142, PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
 		>;
 	};
 
 	tpd12s015_pins: pinmux_tpd12s015_pins {
 		pinctrl-single,pins = <
-			0x0fe (PIN_INPUT_PULLDOWN | MUX_MODE6)	/* hdmi_hpd.gpio7_193 */
+			OMAP5_IOPAD(0x13e, PIN_INPUT_PULLDOWN | MUX_MODE6)	/* hdmi_hpd.gpio7_193 */
 		>;
 	};
 };
@@ -280,13 +280,13 @@
 
 	usbhost_wkup_pins: pinmux_usbhost_wkup_pins {
 		pinctrl-single,pins = <
-			0x1A (PIN_OUTPUT | MUX_MODE0) /* fref_clk1_out, USB hub clk */
+			OMAP5_IOPAD(0x05a, PIN_OUTPUT | MUX_MODE0) /* fref_clk1_out, USB hub clk */
 		>;
 	};
 
 	wlcore_irq_pin: pinmux_wlcore_irq_pin {
 		pinctrl-single,pins = <
-			OMAP5_IOPAD(0x040, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
+			OMAP5_IOPAD(0x40, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE6)	/* llia_wakereqin.gpio1_wk14 */
 		>;
 	};
 };
-- 
2.4.3
