From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 11/39] ARM: dts: am335x-nano: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:49 -0300
Message-ID: <1447390457-1158-12-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-nano.dts | 140 +++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 5ed4ca6eaf55..f313999c503e 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -41,121 +41,121 @@
 
 	misc_pins: misc_pins {
 		pinctrl-single,pins = <
-			0x15c (PIN_OUTPUT | MUX_MODE7)	/* spi0_cs0.gpio0_5 */
+			AM33XX_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE7)	/* spi0_cs0.gpio0_5 */
 		>;
 	};
 
 	gpmc_pins: gpmc_pins {
 		pinctrl-single,pins = <
-			0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			0x20 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad8.gpmc_ad8 */
-			0x24 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad9.gpmc_ad9 */
-			0x28 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad10.gpmc_ad10 */
-			0x2c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad11.gpmc_ad11 */
-			0x30 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad12.gpmc_ad12 */
-			0x34 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad13.gpmc_ad13 */
-			0x38 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad14.gpmc_ad14 */
-			0x3c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad15.gpmc_ad15 */
-
-			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
-			0x80 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn1.gpmc_csn1 */
-			0x84 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn2.gpmc_csn2 */
-			0x88 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn3.gpmc_csn3 */
-
-			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ben0_cle.gpmc_ben0_cle */
-
-			0xa4 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data1.gpmc_a1 */
-			0xa8 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data2.gpmc_a2 */
-			0xac (PIN_OUTPUT | MUX_MODE1)		/* lcd_data3.gpmc_a3 */
-			0xb0 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data4.gpmc_a4 */
-			0xb4 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data5.gpmc_a5 */
-			0xb8 (PIN_OUTPUT | MUX_MODE1)		/* lcd_data6.gpmc_a6 */
-			0xbc (PIN_OUTPUT | MUX_MODE1)		/* lcd_data7.gpmc_a7 */
-
-			0xe0 (PIN_OUTPUT | MUX_MODE1)		/* lcd_vsync.gpmc_a8 */
-			0xe4 (PIN_OUTPUT | MUX_MODE1)		/* lcd_hsync.gpmc_a9 */
-			0xe8 (PIN_OUTPUT | MUX_MODE1)		/* lcd_pclk.gpmc_a10 */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad8.gpmc_ad8 */
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad9.gpmc_ad9 */
+			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad10.gpmc_ad10 */
+			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad11.gpmc_ad11 */
+			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad12.gpmc_ad12 */
+			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad13.gpmc_ad13 */
+			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad14.gpmc_ad14 */
+			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad15.gpmc_ad15 */
+
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0 */
+			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn1.gpmc_csn1 */
+			AM33XX_IOPAD(0x884, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn2.gpmc_csn2 */
+			AM33XX_IOPAD(0x888, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn3.gpmc_csn3 */
+
+			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_ben0_cle.gpmc_ben0_cle */
+
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE1)		/* lcd_data1.gpmc_a1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE1)		/* lcd_data2.gpmc_a2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE1)		/* lcd_data3.gpmc_a3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE1)		/* lcd_data4.gpmc_a4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE1)		/* lcd_data5.gpmc_a5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE1)		/* lcd_data6.gpmc_a6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE1)		/* lcd_data7.gpmc_a7 */
+
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE1)		/* lcd_vsync.gpmc_a8 */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE1)		/* lcd_hsync.gpmc_a9 */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE1)		/* lcd_pclk.gpmc_a10 */
 		>;
 	};
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	uart0_pins: uart0_pins {
 		pinctrl-single,pins = <
-			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			0x174 (PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT | MUX_MODE0)		/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	uart1_pins: uart1_pins {
 		pinctrl-single,pins = <
-			0x178 (PIN_OUTPUT | MUX_MODE7)		/* uart1_ctsn.uart1_ctsn */
-			0x17c (PIN_OUTPUT | MUX_MODE7)		/* uart1_rtsn.uart1_rtsn */
-			0x180 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			0x184 (PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE7)		/* uart1_ctsn.uart1_ctsn */
+			AM33XX_IOPAD(0x97c, PIN_OUTPUT | MUX_MODE7)		/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
 		>;
 	};
 
 	uart2_pins: uart2_pins {
 		pinctrl-single,pins = <
-			0xc0 (PIN_INPUT_PULLUP | MUX_MODE7)	/* lcd_data8.gpio2[14] */
-			0xc4 (PIN_OUTPUT | MUX_MODE7)		/* lcd_data9.gpio2[15] */
-			0x150 (PIN_INPUT | MUX_MODE1)		/* spi0_sclk.uart2_rxd */
-			0x154 (PIN_OUTPUT | MUX_MODE1)		/* spi0_d0.uart2_txd */
+			AM33XX_IOPAD(0x8c0, PIN_INPUT_PULLUP | MUX_MODE7)	/* lcd_data8.gpio2[14] */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE7)		/* lcd_data9.gpio2[15] */
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)		/* spi0_sclk.uart2_rxd */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)		/* spi0_d0.uart2_txd */
 		>;
 	};
 
 	uart3_pins: uart3_pins {
 		pinctrl-single,pins = <
-			0xc8 (PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data10.uart3_ctsn */
-			0xcc (PIN_OUTPUT | MUX_MODE6)		/* lcd_data11.uart3_rtsn */
-			0x160 (PIN_INPUT | MUX_MODE1)		/* spi0_cs1.uart3_rxd */
-			0x164 (PIN_OUTPUT | MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
+			AM33XX_IOPAD(0x8c8, PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data10.uart3_ctsn */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE6)		/* lcd_data11.uart3_rtsn */
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE1)		/* spi0_cs1.uart3_rxd */
+			AM33XX_IOPAD(0x964, PIN_OUTPUT | MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
 		>;
 	};
 
 	uart4_pins: uart4_pins {
 		pinctrl-single,pins = <
-			0xd0 (PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data12.uart4_ctsn */
-			0xd4 (PIN_OUTPUT | MUX_MODE6)		/* lcd_data13.uart4_rtsn */
-			0x168 (PIN_INPUT | MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
-			0x16c (PIN_OUTPUT | MUX_MODE1)		/* uart0_rtsn.uart4_txd */
+			AM33XX_IOPAD(0x8d0, PIN_INPUT_PULLUP | MUX_MODE6)	/* lcd_data12.uart4_ctsn */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE6)		/* lcd_data13.uart4_rtsn */
+			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
+			AM33XX_IOPAD(0x96c, PIN_OUTPUT | MUX_MODE1)		/* uart0_rtsn.uart4_txd */
 		>;
 	};
 
 	uart5_pins: uart5_pins {
 		pinctrl-single,pins = <
-			0xd8 (PIN_INPUT | MUX_MODE4)		/* lcd_data14.uart5_rxd */
-			0x144 (PIN_OUTPUT | MUX_MODE3)		/* rmiii1_refclk.uart5_txd */
+			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE4)		/* lcd_data14.uart5_rxd */
+			AM33XX_IOPAD(0x944, PIN_OUTPUT | MUX_MODE3)		/* rmiii1_refclk.uart5_txd */
 		>;
 	};
 
 	mmc1_pins: mmc1_pins {
 		pinctrl-single,pins = <
-			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			0x1e8 (PIN_INPUT_PULLUP | MUX_MODE7)	/* emu1.gpio3[8] */
-			0x1a0 (PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkr.gpio3[18] */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE7)	/* emu1.gpio3[8] */
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkr.gpio3[18] */
 		>;
 	};
 };
-- 
2.4.3
