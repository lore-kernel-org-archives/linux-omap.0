From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 32/39] ARM: dts: omap4-panda-common: Use OMAP4_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:10 -0300
Message-ID: <1447390457-1158-33-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap4-panda-common.dtsi | 164 +++++++++++++++---------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 18d096696fc0..df2e356ec089 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -199,129 +199,129 @@
 
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
-			0xe0 (PIN_OUTPUT | MUX_MODE3)	/* hdq_sio.gpio_127 */
-			0x160 (PIN_INPUT | MUX_MODE0)	/* sys_nirq2.sys_nirq2 */
+			OMAP4_IOPAD(0x120, PIN_OUTPUT | MUX_MODE3)	/* hdq_sio.gpio_127 */
+			OMAP4_IOPAD(0x1a0, PIN_INPUT | MUX_MODE0)	/* sys_nirq2.sys_nirq2 */
 		>;
 	};
 
 	mcpdm_pins: pinmux_mcpdm_pins {
 		pinctrl-single,pins = <
-			0xc6 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
-			0xc8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
-			0xca (PIN_INPUT_PULLUP   | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
-			0xcc (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
-			0xce (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
+			OMAP4_IOPAD(0x106, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_ul_data.abe_pdm_ul_data */
+			OMAP4_IOPAD(0x108, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_dl_data.abe_pdm_dl_data */
+			OMAP4_IOPAD(0x10a, PIN_INPUT_PULLUP   | MUX_MODE0)	/* abe_pdm_frame.abe_pdm_frame */
+			OMAP4_IOPAD(0x10c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_pdm_lb_clk.abe_pdm_lb_clk */
+			OMAP4_IOPAD(0x10e, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_clks.abe_clks */
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
 
 	dss_dpi_pins: pinmux_dss_dpi_pins {
 		pinctrl-single,pins = <
-			0x122 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data23 */
-			0x124 (PIN_OUTPUT | MUX_MODE5) 	/* dispc2_data22 */
-			0x126 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data21 */
-			0x128 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data20 */
-			0x12a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data19 */
-			0x12c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data18 */
-			0x12e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data15 */
-			0x130 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data14 */
-			0x132 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data13 */
-			0x134 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data12 */
-			0x136 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data11 */
-
-			0x174 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data10 */
-			0x176 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data9 */
-			0x178 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data16 */
-			0x17a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data17 */
-			0x17c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_hsync */
-			0x17e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_pclk */
-			0x180 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_vsync */
-			0x182 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_de */
-			0x184 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data8 */
-			0x186 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data7 */
-			0x188 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data6 */
-			0x18a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data5 */
-			0x18c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data4 */
-			0x18e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data3 */
-
-			0x190 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data2 */
-			0x192 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data1 */
-			0x194 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data0 */
+			OMAP4_IOPAD(0x162, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data23 */
+			OMAP4_IOPAD(0x164, PIN_OUTPUT | MUX_MODE5) 	/* dispc2_data22 */
+			OMAP4_IOPAD(0x166, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data21 */
+			OMAP4_IOPAD(0x168, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data20 */
+			OMAP4_IOPAD(0x16a, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data19 */
+			OMAP4_IOPAD(0x16c, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data18 */
+			OMAP4_IOPAD(0x16e, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data15 */
+			OMAP4_IOPAD(0x170, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data14 */
+			OMAP4_IOPAD(0x172, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data13 */
+			OMAP4_IOPAD(0x174, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data12 */
+			OMAP4_IOPAD(0x176, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data11 */
+
+			OMAP4_IOPAD(0x1b4, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data10 */
+			OMAP4_IOPAD(0x1b6, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data9 */
+			OMAP4_IOPAD(0x1b8, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data16 */
+			OMAP4_IOPAD(0x1ba, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data17 */
+			OMAP4_IOPAD(0x1bc, PIN_OUTPUT | MUX_MODE5)	/* dispc2_hsync */
+			OMAP4_IOPAD(0x1be, PIN_OUTPUT | MUX_MODE5)	/* dispc2_pclk */
+			OMAP4_IOPAD(0x1c0, PIN_OUTPUT | MUX_MODE5)	/* dispc2_vsync */
+			OMAP4_IOPAD(0x1c2, PIN_OUTPUT | MUX_MODE5)	/* dispc2_de */
+			OMAP4_IOPAD(0x1c4, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data8 */
+			OMAP4_IOPAD(0x1c6, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data7 */
+			OMAP4_IOPAD(0x1c8, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data6 */
+			OMAP4_IOPAD(0x1ca, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data5 */
+			OMAP4_IOPAD(0x1cc, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data4 */
+			OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data3 */
+
+			OMAP4_IOPAD(0x1d0, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data2 */
+			OMAP4_IOPAD(0x1d2, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data1 */
+			OMAP4_IOPAD(0x1d4, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data0 */
 		>;
 	};
 
 	tfp410_pins: pinmux_tfp410_pins {
 		pinctrl-single,pins = <
-			0x144 (PIN_OUTPUT | MUX_MODE3)	/* gpio_0 */
+			OMAP4_IOPAD(0x184, PIN_OUTPUT | MUX_MODE3)	/* gpio_0 */
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
 
 	hsusbb1_pins: pinmux_hsusbb1_pins {
 		pinctrl-single,pins = <
-			0x82 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_clk.usbb1_ulpiphy_clk */
-			0x84 (PIN_OUTPUT | MUX_MODE4)		/* usbb1_ulpitll_stp.usbb1_ulpiphy_stp */
-			0x86 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dir.usbb1_ulpiphy_dir */
-			0x88 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_nxt.usbb1_ulpiphy_nxt */
-			0x8a (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat0.usbb1_ulpiphy_dat0 */
-			0x8c (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat1.usbb1_ulpiphy_dat1 */
-			0x8e (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat2.usbb1_ulpiphy_dat2 */
-			0x90 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat3.usbb1_ulpiphy_dat3 */
-			0x92 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat4.usbb1_ulpiphy_dat4 */
-			0x94 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat5.usbb1_ulpiphy_dat5 */
-			0x96 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat6.usbb1_ulpiphy_dat6 */
-			0x98 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat7.usbb1_ulpiphy_dat7 */
+			OMAP4_IOPAD(0x0c2, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_clk.usbb1_ulpiphy_clk */
+			OMAP4_IOPAD(0x0c4, PIN_OUTPUT | MUX_MODE4)		/* usbb1_ulpitll_stp.usbb1_ulpiphy_stp */
+			OMAP4_IOPAD(0x0c6, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dir.usbb1_ulpiphy_dir */
+			OMAP4_IOPAD(0x0c8, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_nxt.usbb1_ulpiphy_nxt */
+			OMAP4_IOPAD(0x0ca, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat0.usbb1_ulpiphy_dat0 */
+			OMAP4_IOPAD(0x0cc, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat1.usbb1_ulpiphy_dat1 */
+			OMAP4_IOPAD(0x0ce, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat2.usbb1_ulpiphy_dat2 */
+			OMAP4_IOPAD(0x0d0, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat3.usbb1_ulpiphy_dat3 */
+			OMAP4_IOPAD(0x0d2, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat4.usbb1_ulpiphy_dat4 */
+			OMAP4_IOPAD(0x0d4, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat5.usbb1_ulpiphy_dat5 */
+			OMAP4_IOPAD(0x0d6, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat6.usbb1_ulpiphy_dat6 */
+			OMAP4_IOPAD(0x0d8, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat7.usbb1_ulpiphy_dat7 */
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
 
@@ -331,24 +331,24 @@
 	 */
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			0x26 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 */
-			0x2c (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a22.gpio_46 */
-			0x30 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48 */
-			0x32 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a25.gpio_49 */
+			OMAP4_IOPAD(0x066, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 */
+			OMAP4_IOPAD(0x06c, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a22.gpio_46 */
+			OMAP4_IOPAD(0x070, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48 */
+			OMAP4_IOPAD(0x072, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a25.gpio_49 */
 		>;
 	};
 
 	/* wl12xx GPIO inputs and SDIO pins */
 	wl12xx_pins: pinmux_wl12xx_pins {
 		pinctrl-single,pins = <
-			0x38 (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs2.gpio_52 */
-			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
-			0x108 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk.sdmmc5_clk */
-			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
-			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
-			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
-			0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2.sdmmc5_dat2 */
-			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
+			OMAP4_IOPAD(0x078, PIN_INPUT | MUX_MODE3)		/* gpmc_ncs2.gpio_52 */
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
@@ -356,8 +356,8 @@
 &omap4_pmx_wkup {
 	led_wkgpio_pins: pinmux_leds_wkpins {
 		pinctrl-single,pins = <
-			0x1a (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk7 */
-			0x1c (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
+			OMAP4_IOPAD(0x05a, PIN_OUTPUT | MUX_MODE3)	/* gpio_wk7 */
+			OMAP4_IOPAD(0x05c, PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
 		>;
 	};
 };
-- 
2.4.3
