From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 10/39] ARM: dts: am335x-lxm: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:48 -0300
Message-ID: <1447390457-1158-11-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-lxm.dts | 120 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 5c5667a3624d..d97b0efa43f3 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -46,109 +46,109 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
-			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
-			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
-			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
-			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
-			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
 		>;
 	};
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_int */
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_crs_dv */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rxer */
-			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_txen */
-			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_td1 */
-			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_td0 */
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rd1 */
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rd0 */
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk */
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_int */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_crs_dv */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rxer */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_td1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* rmii1_td0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii1_rd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_refclk */
 
 			/* Slave 2 */
-			0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_txen */
-			0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td1 */
-			0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td0 */
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd1 */
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd0 */
-			0x70 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_crs_dv */
-			0x74 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rxer */
-			0x78 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_int */
-			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii2_refclk */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_txen */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td1 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td0 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd0 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_crs_dv */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rxer */
+			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_int */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii2_refclk */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_int */
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_crs_dv */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rxer */
-			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_txen */
-			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_td1 */
-			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_td0 */
-			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rd1 */
-			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rd0 */
-			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_refclk */
+			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_int */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_crs_dv */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rxer */
+			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_td1 */
+			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_td0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_rd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii1_refclk */
 
 			/* Slave 2 reset value*/
-			0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_txen */
-			0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_td1 */
-			0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_td0 */
-			0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rd1 */
-			0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rd0 */
-			0x70 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_crs_dv */
-			0x74 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rxer */
-			0x78 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_int */
-			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_refclk */
+			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_txen */
+			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_td1 */
+			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_td0 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rd1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rd0 */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_crs_dv */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_rxer */
+			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_int */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* rmii2_refclk */
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
-			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
-			0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			0x0c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			0x10 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			0x14 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			0x18 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			0x1c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			0x170 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 };
-- 
2.4.3
