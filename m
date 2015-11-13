From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 27/39] ARM: dts: omap3-n900: Use OMAP3_CORE1_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:05 -0300
Message-ID: <1447390457-1158-28-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macro to define the register absolute physical
address instead of the offset from the padconf base address. This
makes the DTS easier to read since matches the addresses listed in
the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-n900.dts | 106 +++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5f5e0f3d5b64..f8a20f32e26c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -149,15 +149,15 @@
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			0x14a (PIN_INPUT | MUX_MODE0)		/* uart2_rx */
-			0x148 (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx */
-			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx */
 		>;
 	};
 
@@ -198,22 +198,22 @@
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0x18a (PIN_INPUT | MUX_MODE0)		/* i2c1_scl */
-			0x18c (PIN_INPUT | MUX_MODE0)		/* i2c1_sda */
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)		/* i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)		/* i2c1_sda */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			0x18e (PIN_INPUT | MUX_MODE0)		/* i2c2_scl */
-			0x190 (PIN_INPUT | MUX_MODE0)		/* i2c2_sda */
+			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT | MUX_MODE0)		/* i2c2_scl */
+			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT | MUX_MODE0)		/* i2c2_sda */
 		>;
 	};
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0x192 (PIN_INPUT | MUX_MODE0)		/* i2c3_scl */
-			0x194 (PIN_INPUT | MUX_MODE0)		/* i2c3_sda */
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)		/* i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)		/* i2c3_sda */
 		>;
 	};
 
@@ -225,85 +225,85 @@
 
 	mcspi4_pins: pinmux_mcspi4_pins {
 		pinctrl-single,pins = <
-			0x15c (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_clk */
-			0x162 (PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_somi */
-			0x160 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_simo */
-			0x166 (PIN_OUTPUT | MUX_MODE1) /* mcspi4_cs0 */
+			OMAP3_CORE1_IOPAD(0x218c, PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_clk */
+			OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_somi */
+			OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE1) /* mcspi4_simo */
+			OMAP3_CORE1_IOPAD(0x2196, PIN_OUTPUT | MUX_MODE1) /* mcspi4_cs0 */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
-			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd */
-			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0 */
-			0x11a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
-			0x11c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
-			0x11e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
+			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk */
-			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd */
-			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc2_dat0 */
-			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1 */
-			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2 */
-			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3 */
-			0x134 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat4 */
-			0x136 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat5 */
-			0x138 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat6 */
-			0x13a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat7 */
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat4 */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat5 */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat6 */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat7 */
 		>;
 	};
 
 	acx565akm_pins: pinmux_acx565akm_pins {
 		pinctrl-single,pins = <
-			0x0d4 (PIN_OUTPUT | MUX_MODE4)		/* RX51_LCD_RESET_GPIO */
+			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE4)		/* RX51_LCD_RESET_GPIO */
 		>;
 	};
 
 	dss_sdi_pins: pinmux_dss_sdi_pins {
 		pinctrl-single,pins = <
-			0x0c0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
-			0x0c2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
-			0x0c4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
-			0x0c6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
 
-			0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
-			0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
+			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
 		>;
 	};
 
 	wl1251_pins: pinmux_wl1251 {
 		pinctrl-single,pins = <
-			0x0ce (PIN_OUTPUT | MUX_MODE4)		/* gpio 87 => wl1251 enable */
-			0x05a (PIN_INPUT | MUX_MODE4)		/* gpio 42 => wl1251 irq */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE4)		/* gpio 87 => wl1251 enable */
+			OMAP3_CORE1_IOPAD(0x208a, PIN_INPUT | MUX_MODE4)		/* gpio 42 => wl1251 irq */
 		>;
 	};
 
 	ssi_pins: pinmux_ssi {
 		pinctrl-single,pins = <
-			0x150 (PIN_INPUT_PULLUP | MUX_MODE1)	/* ssi1_rdy_tx */
-			0x14e (PIN_OUTPUT | MUX_MODE1)		/* ssi1_flag_tx */
-			0x152 (PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* ssi1_wake_tx (cawake) */
-			0x14c (PIN_OUTPUT | MUX_MODE1)		/* ssi1_dat_tx */
-			0x154 (PIN_INPUT | MUX_MODE1)		/* ssi1_dat_rx */
-			0x156 (PIN_INPUT | MUX_MODE1)		/* ssi1_flag_rx */
-			0x158 (PIN_OUTPUT | MUX_MODE1)		/* ssi1_rdy_rx */
-			0x15a (PIN_OUTPUT | MUX_MODE1)		/* ssi1_wake */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE1)	/* ssi1_rdy_tx */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE1)		/* ssi1_flag_tx */
+			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* ssi1_wake_tx (cawake) */
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE1)		/* ssi1_dat_tx */
+			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT | MUX_MODE1)		/* ssi1_dat_rx */
+			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE1)		/* ssi1_flag_rx */
+			OMAP3_CORE1_IOPAD(0x2188, PIN_OUTPUT | MUX_MODE1)		/* ssi1_rdy_rx */
+			OMAP3_CORE1_IOPAD(0x218a, PIN_OUTPUT | MUX_MODE1)		/* ssi1_wake */
 		>;
 	};
 
 	modem_pins: pinmux_modem {
 		pinctrl-single,pins = <
-			0x0ac (PIN_OUTPUT | MUX_MODE4)		/* gpio 70 => cmt_apeslpx */
-			0x0b0 (PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* gpio 72 => ape_rst_rq */
-			0x0b2 (PIN_OUTPUT | MUX_MODE4)		/* gpio 73 => cmt_rst_rq */
-			0x0b4 (PIN_OUTPUT | MUX_MODE4)		/* gpio 74 => cmt_en */
-			0x0b6 (PIN_OUTPUT | MUX_MODE4)		/* gpio 75 => cmt_rst */
-			0x15e (PIN_OUTPUT | MUX_MODE4)		/* gpio 157 => cmt_bsi */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE4)		/* gpio 70 => cmt_apeslpx */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* gpio 72 => ape_rst_rq */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE4)		/* gpio 73 => cmt_rst_rq */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE4)		/* gpio 74 => cmt_en */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE4)		/* gpio 75 => cmt_rst */
+			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)		/* gpio 157 => cmt_bsi */
 		>;
 	};
 };
-- 
2.4.3
