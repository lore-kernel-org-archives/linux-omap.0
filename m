From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 19/39] ARM: dts: am43x-epos-evm: Use AM4372_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:57 -0300
Message-ID: <1447390457-1158-20-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am43x-epos-evm.dts | 246 +++++++++++++++++------------------
 1 file changed, 123 insertions(+), 123 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 47954ed990f8..746fd2b17958 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -144,228 +144,228 @@
 		cpsw_default: cpsw_default {
 			pinctrl-single,pins = <
 				/* Slave 1 */
-				0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs */
-				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
-				0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
-				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxdv.rmii1_rxdv */
-				0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
-				0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
-				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
-				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
-				0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
+				AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs */
+				AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+				AM4372_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
+				AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxdv.rmii1_rxdv */
+				AM4372_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+				AM4372_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+				AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+				AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+				AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk.rmii1_refclk */
 			>;
 		};
 
 		cpsw_sleep: cpsw_sleep {
 			pinctrl-single,pins = <
 				/* Slave 1 reset value */
-				0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
 			>;
 		};
 
 		davinci_mdio_default: davinci_mdio_default {
 			pinctrl-single,pins = <
 				/* MDIO */
-				0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-				0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+				AM4372_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+				AM4372_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
 			>;
 		};
 
 		davinci_mdio_sleep: davinci_mdio_sleep {
 			pinctrl-single,pins = <
 				/* MDIO reset value */
-				0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 			>;
 		};
 
 		i2c0_pins: pinmux_i2c0_pins {
 			pinctrl-single,pins = <
-				0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-				0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+				AM4372_IOPAD(0x988, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+				AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
 
 		nand_flash_x8: nand_flash_x8 {
 			pinctrl-single,pins = <
-				0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.SELQSPIorNAND/GPIO */
-				0x0  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-				0x4  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-				0x8  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-				0xc  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-				0x10 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-				0x14 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-				0x18 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-				0x1c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-				0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-				0x74 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
-				0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
-				0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-				0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-				0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-				0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+				AM4372_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.SELQSPIorNAND/GPIO */
+				AM4372_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+				AM4372_IOPAD(0x804, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+				AM4372_IOPAD(0x808, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+				AM4372_IOPAD(0x80c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+				AM4372_IOPAD(0x810, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+				AM4372_IOPAD(0x814, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+				AM4372_IOPAD(0x818, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+				AM4372_IOPAD(0x81c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+				AM4372_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+				AM4372_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
+				AM4372_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+				AM4372_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+				AM4372_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+				AM4372_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+				AM4372_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 			>;
 		};
 
 		ecap0_pins: backlight_pins {
 			pinctrl-single,pins = <
-				0x164 MUX_MODE0         /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+				AM4372_IOPAD(0x964, MUX_MODE0)         /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 			>;
 		};
 
 		i2c2_pins: pinmux_i2c2_pins {
 			pinctrl-single,pins = <
-				0x1c0 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_sda.i2c2_sda */
-				0x1c4 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_scl.i2c2_scl */
+				AM4372_IOPAD(0x9c0, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_sda.i2c2_sda */
+				AM4372_IOPAD(0x9c4, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE8)    /* i2c2_scl.i2c2_scl */
 			>;
 		};
 
 		spi0_pins: pinmux_spi0_pins {
 			pinctrl-single,pins = <
-				0x150 (PIN_INPUT | MUX_MODE0)           /* spi0_clk.spi0_clk */
-				0x154 (PIN_OUTPUT | MUX_MODE0)           /* spi0_d0.spi0_d0 */
-				0x158 (PIN_INPUT | MUX_MODE0)           /* spi0_d1.spi0_d1 */
-				0x15c (PIN_OUTPUT | MUX_MODE0)          /* spi0_cs0.spi0_cs0 */
+				AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0)           /* spi0_clk.spi0_clk */
+				AM4372_IOPAD(0x954, PIN_OUTPUT | MUX_MODE0)           /* spi0_d0.spi0_d0 */
+				AM4372_IOPAD(0x958, PIN_INPUT | MUX_MODE0)           /* spi0_d1.spi0_d1 */
+				AM4372_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE0)          /* spi0_cs0.spi0_cs0 */
 			>;
 		};
 
 		spi1_pins: pinmux_spi1_pins {
 			pinctrl-single,pins = <
-				0x190 (PIN_INPUT | MUX_MODE3)           /* mcasp0_aclkx.spi1_clk */
-				0x194 (PIN_OUTPUT | MUX_MODE3)           /* mcasp0_fsx.spi1_d0 */
-				0x198 (PIN_INPUT | MUX_MODE3)           /* mcasp0_axr0.spi1_d1 */
-				0x19c (PIN_OUTPUT | MUX_MODE3)          /* mcasp0_ahclkr.spi1_cs0 */
+				AM4372_IOPAD(0x990, PIN_INPUT | MUX_MODE3)           /* mcasp0_aclkx.spi1_clk */
+				AM4372_IOPAD(0x994, PIN_OUTPUT | MUX_MODE3)           /* mcasp0_fsx.spi1_d0 */
+				AM4372_IOPAD(0x998, PIN_INPUT | MUX_MODE3)           /* mcasp0_axr0.spi1_d1 */
+				AM4372_IOPAD(0x99c, PIN_OUTPUT | MUX_MODE3)          /* mcasp0_ahclkr.spi1_cs0 */
 			>;
 		};
 
 		mmc1_pins: pinmux_mmc1_pins {
 			pinctrl-single,pins = <
-				0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+				AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 			>;
 		};
 
 		qspi1_default: qspi1_default {
 			pinctrl-single,pins = <
-				0x7c (PIN_INPUT_PULLUP | MUX_MODE3)
-				0x88 (PIN_INPUT_PULLUP | MUX_MODE2)
-				0x90 (PIN_INPUT_PULLUP | MUX_MODE3)
-				0x94 (PIN_INPUT_PULLUP | MUX_MODE3)
-				0x98 (PIN_INPUT_PULLUP | MUX_MODE3)
-				0x9c (PIN_INPUT_PULLUP | MUX_MODE3)
+				AM4372_IOPAD(0x87c, PIN_INPUT_PULLUP | MUX_MODE3)
+				AM4372_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE2)
+				AM4372_IOPAD(0x890, PIN_INPUT_PULLUP | MUX_MODE3)
+				AM4372_IOPAD(0x894, PIN_INPUT_PULLUP | MUX_MODE3)
+				AM4372_IOPAD(0x898, PIN_INPUT_PULLUP | MUX_MODE3)
+				AM4372_IOPAD(0x89c, PIN_INPUT_PULLUP | MUX_MODE3)
 			>;
 		};
 
 		pixcir_ts_pins: pixcir_ts_pins {
 			pinctrl-single,pins = <
-				0x44 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a1.gpio1_17 */
+				AM4372_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a1.gpio1_17 */
 			>;
 		};
 
 		hdq_pins: pinmux_hdq_pins {
 			pinctrl-single,pins = <
-				0x234 (PIN_INPUT_PULLUP | MUX_MODE1)    /* cam1_wen.hdq_gpio */
+				AM4372_IOPAD(0xa34, PIN_INPUT_PULLUP | MUX_MODE1)    /* cam1_wen.hdq_gpio */
 			>;
 		};
 
 		dss_pins: dss_pins {
 			pinctrl-single,pins = <
-				0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
-				0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-				0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-				0x02C (PIN_OUTPUT_PULLUP | MUX_MODE1)
-				0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-				0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-				0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-				0x03C (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
-				0x0A0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
-				0x0A4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0A8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0AC (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0B0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0B4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0B8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0BC (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0C0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0C4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0C8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0CC (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0D0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0D4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0D8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-				0x0DC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
-				0x0E0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
-				0x0E4 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
-				0x0E8 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
-				0x0EC (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+				AM4372_IOPAD(0x820, PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+				AM4372_IOPAD(0x824, PIN_OUTPUT_PULLUP | MUX_MODE1)
+				AM4372_IOPAD(0x828, PIN_OUTPUT_PULLUP | MUX_MODE1)
+				AM4372_IOPAD(0x82c, PIN_OUTPUT_PULLUP | MUX_MODE1)
+				AM4372_IOPAD(0x830, PIN_OUTPUT_PULLUP | MUX_MODE1)
+				AM4372_IOPAD(0x834, PIN_OUTPUT_PULLUP | MUX_MODE1)
+				AM4372_IOPAD(0x838, PIN_OUTPUT_PULLUP | MUX_MODE1)
+				AM4372_IOPAD(0x83c, PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
+				AM4372_IOPAD(0x8a0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+				AM4372_IOPAD(0x8a4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8a8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8ac, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8b0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8b4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8B8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8bc, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8c0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8c4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8c8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8cc, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8d0, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8d4, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8d8, PIN_OUTPUT_PULLUP | MUX_MODE0)
+				AM4372_IOPAD(0x8dc, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+				AM4372_IOPAD(0x8e0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+				AM4372_IOPAD(0x8e4, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+				AM4372_IOPAD(0x8e8, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+				AM4372_IOPAD(0x8ec, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
 			>;
 		};
 
 		display_mux_pins: display_mux_pins {
 			pinctrl-single,pins = <
 				/* GPMC CLK -> GPIO 2_1 to select LCD / HDMI */
-				0x08C (PIN_OUTPUT_PULLUP | MUX_MODE7)
+				AM4372_IOPAD(0x88C, PIN_OUTPUT_PULLUP | MUX_MODE7)
 			>;
 		};
 
 		vpfe1_pins_default: vpfe1_pins_default {
 			pinctrl-single,pins = <
-				0x1cc (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data9 mode 0 */
-				0x1d0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data8 mode 0 */
-				0x1d4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_hd mode 0 */
-				0x1d8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_vd mode 0 */
-				0x1dc (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_pclk mode 0 */
-				0x1e8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data0 mode 0 */
-				0x1ec (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data1 mode 0 */
-				0x1f0 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data2 mode 0 */
-				0x1f4 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data3 mode 0 */
-				0x1f8 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data4 mode 0 */
-				0x1fc (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data5 mode 0 */
-				0x200 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data6 mode 0 */
-				0x204 (PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data7 mode 0 */
+				AM4372_IOPAD(0x9cc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data9 mode 0 */
+				AM4372_IOPAD(0x9d0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data8 mode 0 */
+				AM4372_IOPAD(0x9d4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_hd mode 0 */
+				AM4372_IOPAD(0x9d8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_vd mode 0 */
+				AM4372_IOPAD(0x9dc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_pclk mode 0 */
+				AM4372_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data0 mode 0 */
+				AM4372_IOPAD(0x9ec, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data1 mode 0 */
+				AM4372_IOPAD(0x9f0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data2 mode 0 */
+				AM4372_IOPAD(0x9f4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data3 mode 0 */
+				AM4372_IOPAD(0x9f8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data4 mode 0 */
+				AM4372_IOPAD(0x9fc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data5 mode 0 */
+				AM4372_IOPAD(0xa00, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data6 mode 0 */
+				AM4372_IOPAD(0xa04, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data7 mode 0 */
 			>;
 		};
 
 		vpfe1_pins_sleep: vpfe1_pins_sleep {
 			pinctrl-single,pins = <
-				0x1cc (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1d0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1d4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1d8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1dc (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1e8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1ec (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1f0 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1f4 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1f8 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x1fc (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x200 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
-				0x204 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9cc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9d0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9d4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9d8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9dc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9e8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9ec, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9f0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9f4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9f8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0x9fc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0xa00, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
+				AM4372_IOPAD(0xa04, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
 			>;
 		};
 
 		mcasp1_pins: mcasp1_pins {
 			pinctrl-single,pins = <
-				0x1a0 (PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_ACLKR/MCASP1_ACLKX */
-				0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_FSR/MCASP1_FSX */
-				0x1a8 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)/* MCASP0_AXR1/MCASP1_AXR0 */
-				0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_AHCLKX/MCASP1_AXR1 */
+				AM4372_IOPAD(0x9a0, PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_ACLKR/MCASP1_ACLKX */
+				AM4372_IOPAD(0x9a4, PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_FSR/MCASP1_FSX */
+				AM4372_IOPAD(0x9a8, PIN_OUTPUT_PULLDOWN | MUX_MODE3)/* MCASP0_AXR1/MCASP1_AXR0 */
+				AM4372_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_AHCLKX/MCASP1_AXR1 */
 			>;
 		};
 
 		mcasp1_sleep_pins: mcasp1_sleep_pins {
 			pinctrl-single,pins = <
-				0x1a0 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-				0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x9a0, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x9a4, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x9a8, PIN_INPUT_PULLDOWN | MUX_MODE7)
+				AM4372_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE7)
 			>;
 		};
 };
-- 
2.4.3
