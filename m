From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 12/39] ARM: dts: am335x-pepper: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:50 -0300
Message-ID: <1447390457-1158-13-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-pepper.dts | 200 ++++++++++++++++++------------------
 1 file changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 7106114c7464..f9d7239ebdaf 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -93,14 +93,14 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0 {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 	i2c1_pins: pinmux_i2c1 {
 		pinctrl-single,pins = <
-			0x10C (PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_crs,i2c1_sda */
-			0x110 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_rxerr,i2c1_scl */
+			AM33XX_IOPAD(0x90C, PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_crs,i2c1_sda */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_rxerr,i2c1_scl */
 		>;
 	};
 };
@@ -130,7 +130,7 @@
 &am33xx_pinmux {
 	accel_pins: pinmux_accel {
 		pinctrl-single,pins = <
-			0x98 (PIN_INPUT | MUX_MODE7)   /* gpmc_wen.gpio2_4 */
+			AM33XX_IOPAD(0x898, PIN_INPUT | MUX_MODE7)   /* gpmc_wen.gpio2_4 */
 		>;
 	};
 };
@@ -177,12 +177,12 @@
 &am33xx_pinmux {
 	audio_pins: pinmux_audio {
 		pinctrl-single,pins = <
-			0x1AC (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
-			0x194 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
-			0x190 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
-			0x198 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
-			0x1A8 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr1.mcasp0_axr1 */
-			0x40 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
+			AM33XX_IOPAD(0x9a8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr1.mcasp0_axr1 */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
 		>;
 	};
 };
@@ -228,36 +228,36 @@
 &am33xx_pinmux {
 	lcd_pins: pinmux_lcd {
 		pinctrl-single,pins = <
-			0xa0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			0xa4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			0xa8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			0xac (PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			0xb0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			0xb4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			0xb8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			0xbc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			0xc0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			0xc4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			0xc8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			0xcc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			0xd0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			0xd4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			0xd8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			0xdc (PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
-			0x20 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
-			0x24 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
-			0x28 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
-			0x2c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
-			0x30 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
-			0x34 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
-			0x38 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
-			0x3c (PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
-			0xe0 (PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			0xe4 (PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			0xe8 (PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			0xec (PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
+			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
+			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
+			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
+			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
+			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
+			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
 			/* Display Enable */
-			0x6c (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
+			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 		>;
 	};
 };
@@ -291,29 +291,29 @@
 &am33xx_pinmux {
 	ethernet_pins: pinmux_ethernet {
 		pinctrl-single,pins = <
-			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			0x118 (PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			0x12c (PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			0x130 (PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			0x134 (PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd3.rgmii1_rxd3 */
-			0x138 (PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd2.rgmii1_rxd2 */
-			0x13c (PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
-			0x140 (PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd3.rgmii1_rxd3 */
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd2.rgmii1_rxd2 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
 			/* ethernet interrupt */
-			0x144 (PIN_INPUT_PULLUP | MUX_MODE7)	/* rmii2_refclk.gpio0_29 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLUP | MUX_MODE7)	/* rmii2_refclk.gpio0_29 */
 			/* ethernet PHY nReset */
-			0x108 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* mii1_col.gpio3_0 */
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* mii1_col.gpio3_0 */
 		>;
 	};
 
 	mdio_pins: pinmux_mdio {
 		pinctrl-single,pins = <
-			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 };
@@ -363,45 +363,45 @@
 &am33xx_pinmux {
 	sd_pins: pinmux_sd_card {
 		pinctrl-single,pins = <
-			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			0x160 (PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
 		>;
 	};
 	emmc_pins: pinmux_emmc {
 		pinctrl-single,pins = <
-			0x80 (PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
-			0x84 (PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
-			0x00 (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
-			0x04 (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
-			0x08 (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
-			0x0c (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
-			0x10 (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
-			0x14 (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
-			0x18 (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
-			0x1c (PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
 			/* EMMC nReset */
-			0x74 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
+			AM33XX_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
 		>;
 	};
 	wireless_pins: pinmux_wireless {
 		pinctrl-single,pins = <
-			0x44 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0 */
-			0x48 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1 */
-			0x4c (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2 */
-			0x78 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3 */
-			0x88 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
-			0x8c (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc1_clk */
+			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0 */
+			AM33XX_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1 */
+			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2 */
+			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3 */
+			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
+			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc1_clk */
 			/* WLAN nReset */
-			0x60 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
+			AM33XX_IOPAD(0x860, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 			/* WLAN nPower down */
-			0x70 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
+			AM33XX_IOPAD(0x870, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
 			/* 32kHz Clock */
-			0x1b4 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 };
@@ -497,10 +497,10 @@
 &am33xx_pinmux {
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			0x150 (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			0x15C (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
-			0x154 (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			0x158 (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
 		>;
 	};
 };
@@ -538,16 +538,16 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 	uart1_pins: pinmux_uart1 {
 		pinctrl-single,pins = <
-			0x178 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_ctsn.uart1_ctsn */
-			0x17C (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
-			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			0x184 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
 		>;
 	};
 };
@@ -590,9 +590,9 @@
 	usb_pins: pinmux_usb {
 		pinctrl-single,pins = <
 			/* USB0 Over-Current (active low) */
-			0x64 (PIN_INPUT | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
+			AM33XX_IOPAD(0x864, PIN_INPUT | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
 			/* USB1 Over-Current (active low) */
-			0x68 (PIN_INPUT | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
 		>;
 	};
 };
@@ -648,16 +648,16 @@
 &am33xx_pinmux {
 	user_leds_pins: pinmux_user_leds {
 		pinctrl-single,pins = <
-			0x50 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_a4.gpio1_20 */
-			0x54 (PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a4.gpio1_20 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
 		>;
 	};
 
 	user_buttons_pins: pinmux_user_buttons {
 		pinctrl-single,pins = <
-			0x58 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			0x5C (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a7.gpio1_21 */
-			0x164 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio0_7 */
+			AM33XX_IOPAD(0x858, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(0x85C, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a7.gpio1_21 */
+			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio0_7 */
 		>;
 	};
 };
-- 
2.4.3
