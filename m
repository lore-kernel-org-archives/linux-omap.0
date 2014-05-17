From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 1/2] ARM: dts: Convert DuoVero Parlor to use IOPAD macro
Date: Sat, 17 May 2014 14:06:59 +0200
Message-ID: <1400328420-28384-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:47409 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbaEQMHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 May 2014 08:07:51 -0400
Received: by mail-lb0-f179.google.com with SMTP id c11so2680852lbj.24
        for <linux-omap@vger.kernel.org>; Sat, 17 May 2014 05:07:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, florian.vaussard@epfl.ch

Conversion done by following awk script.
/0x[0-9a-f]{1,3} \(PIN/ {
	offset = sprintf("OMAP4_IOPAD(0x%03x, ", strtonum($1) + 64)
	sub(/0x[0-9a-f]{1,3} \(/, offset, $0)
	print $0
	next
}
{ print $0 }

Cc: florian.vaussard@epfl.ch
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

Hi,

Checked md5sum before and after patch and the resulting dtb is the same. So
this should be safe.

 arch/arm/boot/dts/omap4-duovero-parlor.dts | 18 +++----
 arch/arm/boot/dts/omap4-duovero.dtsi       | 84 +++++++++++++++---------------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 96f51d870812..cd53a64d8f2e 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -46,35 +46,35 @@
 
 	led_pins: pinmux_led_pins {
 		pinctrl-single,pins = <
-			0xd6 (PIN_OUTPUT | MUX_MODE3)		/* abe_dmic_din3.gpio_122 */
+			OMAP4_IOPAD(0x116, PIN_OUTPUT | MUX_MODE3)		/* abe_dmic_din3.gpio_122 */
 		>;
 	};
 
 	button_pins: pinmux_button_pins {
 		pinctrl-single,pins = <
-			0xd4 (PIN_INPUT_PULLUP | MUX_MODE3)	/* abe_dmic_din2.gpio_121 */
+			OMAP4_IOPAD(0x114, PIN_INPUT_PULLUP | MUX_MODE3)	/* abe_dmic_din2.gpio_121 */
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
 
 	smsc_pins: pinmux_smsc_pins {
 		pinctrl-single,pins = <
-			0x28 (PIN_INPUT | MUX_MODE3)		/* gpmc_a20.gpio_44: IRQ */
-			0x2a (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a21.gpio_45: nReset */
-			0x30 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
+			OMAP4_IOPAD(0x068, PIN_INPUT | MUX_MODE3)		/* gpmc_a20.gpio_44: IRQ */
+			OMAP4_IOPAD(0x06a, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a21.gpio_45: nReset */
+			OMAP4_IOPAD(0x070, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
index a514791154eb..cc68a3b58648 100644
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -74,93 +74,93 @@
 
 	twl6040_pins: pinmux_twl6040_pins {
 		pinctrl-single,pins = <
-			0x126 (PIN_OUTPUT | MUX_MODE3)		/* usbb2_ulpitll_nxt.gpio_160 */
-			0x160 (PIN_INPUT | MUX_MODE0)		/* sys_nirq2.sys_nirq2 */
+			OMAP4_IOPAD(0x166, PIN_OUTPUT | MUX_MODE3)		/* usbb2_ulpitll_nxt.gpio_160 */
+			OMAP4_IOPAD(0x1a0, PIN_INPUT | MUX_MODE0)		/* sys_nirq2.sys_nirq2 */
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
 
 	hsusb1phy_pins: pinmux_hsusb1phy_pins {
 		pinctrl-single,pins = <
-			0x4c (PIN_OUTPUT | MUX_MODE3)		/* gpmc_wait1.gpio_62 */
+			OMAP4_IOPAD(0x08c, PIN_OUTPUT | MUX_MODE3)		/* gpmc_wait1.gpio_62 */
 		>;
 	};
 
 	w2cbw0015_pins: pinmux_w2cbw0015_pins {
 		pinctrl-single,pins = <
-			0x26 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 */
-			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
+			OMAP4_IOPAD(0x066, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 */
+			OMAP4_IOPAD(0x07a, PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
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
 
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
-			0xee (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
-			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
+			OMAP4_IOPAD(0x12e, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
+			OMAP4_IOPAD(0x130, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0xa2 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
-			0xa4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc1_cmd */
-			0xa6 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc1_dat0 */
-			0xa8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
-			0xaa (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
-			0xac (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
+			OMAP4_IOPAD(0x0e2, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
+			OMAP4_IOPAD(0x0e4, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc1_cmd */
+			OMAP4_IOPAD(0x0e6, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc1_dat0 */
+			OMAP4_IOPAD(0x0e8, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
+			OMAP4_IOPAD(0x0ea, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
+			OMAP4_IOPAD(0x0ec, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
 		>;
 	};
 
 	mmc5_pins: pinmux_mmc5_pins {
 		pinctrl-single,pins = <
-			0x108 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk */
-			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc5_cmd */
-			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc5_dat0 */
-			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1 */
-			0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2 */
-			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3 */
+			OMAP4_IOPAD(0x148, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk */
+			OMAP4_IOPAD(0x14a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc5_cmd */
+			OMAP4_IOPAD(0x14c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmcc5_dat0 */
+			OMAP4_IOPAD(0x14e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1 */
+			OMAP4_IOPAD(0x150, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2 */
+			OMAP4_IOPAD(0x152, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3 */
 		>;
 	};
 };
-- 
1.8.0

