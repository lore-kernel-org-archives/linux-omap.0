From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 34/39] ARM: dts: omap4-sdp: Use OMAP4_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:12 -0300
Message-ID: <1447390457-1158-35-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap4-sdp.dts | 110 ++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index f0bdc41f8eff..aae513265dc2 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -212,143 +212,143 @@
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			0xd8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
-			0xda (PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
-			0xdc (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_rx.uart2_rx */
-			0xde (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			OMAP4_IOPAD(0x11a, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+			OMAP4_IOPAD(0x11c, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_rx.uart2_rx */
+			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
-			0x102 (PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
-			0x104 (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
-			0x106 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP4_IOPAD(0x140, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+			OMAP4_IOPAD(0x142, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+			OMAP4_IOPAD(0x144, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP4_IOPAD(0x146, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
 	uart4_pins: pinmux_uart4_pins {
 		pinctrl-single,pins = <
-			0x11c (PIN_INPUT | MUX_MODE0)		/* uart4_rx.uart4_rx */
-			0x11e (PIN_OUTPUT | MUX_MODE0)		/* uart4_tx.uart4_tx */
+			OMAP4_IOPAD(0x15c, PIN_INPUT | MUX_MODE0)		/* uart4_rx.uart4_rx */
+			OMAP4_IOPAD(0x15e, PIN_OUTPUT | MUX_MODE0)		/* uart4_tx.uart4_tx */
 		>;
 	};
 
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
-			0xe0 (PIN_OUTPUT | MUX_MODE3)		/* hdq_sio.gpio_127 */
-			0x160 (PIN_INPUT | MUX_MODE0)		/* sys_nirq2.sys_nirq2 */
+			OMAP4_IOPAD(0x120, PIN_OUTPUT | MUX_MODE3)		/* hdq_sio.gpio_127 */
+			OMAP4_IOPAD(0x1a0, PIN_INPUT | MUX_MODE0)		/* sys_nirq2.sys_nirq2 */
 		>;
 	};
 
 	mcpdm_pins: pinmux_mcpdm_pins {
 		pinctrl-single,pins = <
-			0xc6 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
-			0xc8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
-			0xca (PIN_INPUT_PULLUP | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
-			0xcc (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
-			0xce (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
+			OMAP4_IOPAD(0x106, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
+			OMAP4_IOPAD(0x108, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
+			OMAP4_IOPAD(0x10a, PIN_INPUT_PULLUP | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
+			OMAP4_IOPAD(0x10c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
+			OMAP4_IOPAD(0x10e, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
 		>;
 	};
 
 	dmic_pins: pinmux_dmic_pins {
 		pinctrl-single,pins = <
-			0xd0 (PIN_OUTPUT | MUX_MODE0)		/* abe_dmic_clk1.abe_dmic_clk1 */
-			0xd2 (PIN_INPUT | MUX_MODE0)		/* abe_dmic_din1.abe_dmic_din1 */
-			0xd4 (PIN_INPUT | MUX_MODE0)		/* abe_dmic_din2.abe_dmic_din2 */
-			0xd6 (PIN_INPUT | MUX_MODE0)		/* abe_dmic_din3.abe_dmic_din3 */
+			OMAP4_IOPAD(0x110, PIN_OUTPUT | MUX_MODE0)		/* abe_dmic_clk1.abe_dmic_clk1 */
+			OMAP4_IOPAD(0x112, PIN_INPUT | MUX_MODE0)		/* abe_dmic_din1.abe_dmic_din1 */
+			OMAP4_IOPAD(0x114, PIN_INPUT | MUX_MODE0)		/* abe_dmic_din2.abe_dmic_din2 */
+			OMAP4_IOPAD(0x116, PIN_INPUT | MUX_MODE0)		/* abe_dmic_din3.abe_dmic_din3 */
 		>;
 	};
 
 	mcbsp1_pins: pinmux_mcbsp1_pins {
 		pinctrl-single,pins = <
-			0xbe (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_clkx.abe_mcbsp1_clkx */
-			0xc0 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dr.abe_mcbsp1_dr */
-			0xc2 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dx.abe_mcbsp1_dx */
-			0xc4 (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_fsx.abe_mcbsp1_fsx */
+			OMAP4_IOPAD(0x0fe, PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_clkx.abe_mcbsp1_clkx */
+			OMAP4_IOPAD(0x100, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dr.abe_mcbsp1_dr */
+			OMAP4_IOPAD(0x102, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dx.abe_mcbsp1_dx */
+			OMAP4_IOPAD(0x104, PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_fsx.abe_mcbsp1_fsx */
 		>;
 	};
 
 	mcbsp2_pins: pinmux_mcbsp2_pins {
 		pinctrl-single,pins = <
-			0xb6 (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp2_clkx.abe_mcbsp2_clkx */
-			0xb8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp2_dr.abe_mcbsp2_dr */
-			0xba (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp2_dx.abe_mcbsp2_dx */
-			0xbc (PIN_INPUT | MUX_MODE0)		/* abe_mcbsp2_fsx.abe_mcbsp2_fsx */
+			OMAP4_IOPAD(0x0f6, PIN_INPUT | MUX_MODE0)		/* abe_mcbsp2_clkx.abe_mcbsp2_clkx */
+			OMAP4_IOPAD(0x0f8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp2_dr.abe_mcbsp2_dr */
+			OMAP4_IOPAD(0x0fa, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp2_dx.abe_mcbsp2_dx */
+			OMAP4_IOPAD(0x0fc, PIN_INPUT | MUX_MODE0)		/* abe_mcbsp2_fsx.abe_mcbsp2_fsx */
 		>;
 	};
 
 	mcspi1_pins: pinmux_mcspi1_pins {
 		pinctrl-single,pins = <
-			0xf2 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_clk.mcspi1_clk */
-			0xf4 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_somi.mcspi1_somi */
-			0xf6 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_simo.mcspi1_simo */
-			0xf8 (PIN_INPUT | MUX_MODE0)		/*  mcspi1_cs0.mcspi1_cs0 */
+			OMAP4_IOPAD(0x132, PIN_INPUT | MUX_MODE0)		/*  mcspi1_clk.mcspi1_clk */
+			OMAP4_IOPAD(0x134, PIN_INPUT | MUX_MODE0)		/*  mcspi1_somi.mcspi1_somi */
+			OMAP4_IOPAD(0x136, PIN_INPUT | MUX_MODE0)		/*  mcspi1_simo.mcspi1_simo */
+			OMAP4_IOPAD(0x138, PIN_INPUT | MUX_MODE0)		/*  mcspi1_cs0.mcspi1_cs0 */
 		>;
 	};
 
 	dss_hdmi_pins: pinmux_dss_hdmi_pins {
 		pinctrl-single,pins = <
-			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
-			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl */
-			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda */
+			OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl */
+			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda */
 		>;
 	};
 
 	tpd12s015_pins: pinmux_tpd12s015_pins {
 		pinctrl-single,pins = <
-			0x22 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a17.gpio_41 */
-			0x48 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_nbe1.gpio_60 */
-			0x58 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* hdmi_hpd.gpio_63 */
+			OMAP4_IOPAD(0x062, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a17.gpio_41 */
+			OMAP4_IOPAD(0x088, PIN_OUTPUT | MUX_MODE3)		/* gpmc_nbe1.gpio_60 */
+			OMAP4_IOPAD(0x098, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* hdmi_hpd.gpio_63 */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0xe2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
-			0xe4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			0xe6 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
-			0xe8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
+			OMAP4_IOPAD(0x126, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
+			OMAP4_IOPAD(0x128, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
 		>;
 	};
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0xea (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
-			0xec (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
 		>;
 	};
 
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
-			0xee (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
-			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
+			OMAP4_IOPAD(0x12e, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
+			OMAP4_IOPAD(0x130, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
 		>;
 	};
 
 	/* wl12xx GPIO output for WLAN_EN */
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			0x3c (PIN_OUTPUT | MUX_MODE3)		/* gpmc_nwp.gpio_54 */
+			OMAP4_IOPAD(0x07c, PIN_OUTPUT | MUX_MODE3)		/* gpmc_nwp.gpio_54 */
 		>;
 	};
 
 	/* wl12xx GPIO inputs and SDIO pins */
 	wl12xx_pins: pinmux_wl12xx_pins {
 		pinctrl-single,pins = <
-			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
-			0x108 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk.sdmmc5_clk */
-			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
-			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
-			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
-			0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2.sdmmc5_dat2 */
-			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
+			OMAP4_IOPAD(0x07a, PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
+			OMAP4_IOPAD(0x148, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk.sdmmc5_clk */
+			OMAP4_IOPAD(0x14a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
+			OMAP4_IOPAD(0x14c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
+			OMAP4_IOPAD(0x14e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
+			OMAP4_IOPAD(0x150, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2.sdmmc5_dat2 */
+			OMAP4_IOPAD(0x152, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
 		>;
 	};
 };
-- 
2.4.3
