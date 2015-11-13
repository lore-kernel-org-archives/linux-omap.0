From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 21/39] ARM: dts: dra7-evm: Use DRA7XX_CORE_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:59 -0300
Message-ID: <1447390457-1158-22-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/dra7-evm.dts | 254 ++++++++++++++++++++---------------------
 1 file changed, 127 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 864f60020124..53b3a4b97086 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -154,100 +154,100 @@
 
 	vtt_pin: pinmux_vtt_pin {
 		pinctrl-single,pins = <
-			0x3b4 (PIN_OUTPUT | MUX_MODE14) /* spi1_cs1.gpio7_11 */
+			DRA7XX_CORE_IOPAD(0x37b4, PIN_OUTPUT | MUX_MODE14) /* spi1_cs1.gpio7_11 */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0x400 (PIN_INPUT | MUX_MODE0) /* i2c1_sda */
-			0x404 (PIN_INPUT | MUX_MODE0) /* i2c1_scl */
+			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT | MUX_MODE0) /* i2c1_sda */
+			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT | MUX_MODE0) /* i2c1_scl */
 		>;
 	};
 
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
-			0x408 (PIN_INPUT | MUX_MODE0) /* i2c2_sda */
-			0x40c (PIN_INPUT | MUX_MODE0) /* i2c2_scl */
+			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE0) /* i2c2_sda */
+			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE0) /* i2c2_scl */
 		>;
 	};
 
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
-			0x288 (PIN_INPUT | MUX_MODE9) /* gpio6_14.i2c3_sda */
-			0x28c (PIN_INPUT | MUX_MODE9) /* gpio6_15.i2c3_scl */
+			DRA7XX_CORE_IOPAD(0x3688, PIN_INPUT | MUX_MODE9) /* gpio6_14.i2c3_sda */
+			DRA7XX_CORE_IOPAD(0x368c, PIN_INPUT | MUX_MODE9) /* gpio6_15.i2c3_scl */
 		>;
 	};
 
 	mcspi1_pins: pinmux_mcspi1_pins {
 		pinctrl-single,pins = <
-			0x3a4 (PIN_INPUT | MUX_MODE0) /* spi1_sclk */
-			0x3a8 (PIN_INPUT | MUX_MODE0) /* spi1_d1 */
-			0x3ac (PIN_INPUT | MUX_MODE0) /* spi1_d0 */
-			0x3b0 (PIN_INPUT_SLEW | MUX_MODE0) /* spi1_cs0 */
-			0x3b8 (PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs2.hdmi1_hpd */
-			0x3bc (PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs3.hdmi1_cec */
+			DRA7XX_CORE_IOPAD(0x37a4, PIN_INPUT | MUX_MODE0) /* spi1_sclk */
+			DRA7XX_CORE_IOPAD(0x37a8, PIN_INPUT | MUX_MODE0) /* spi1_d1 */
+			DRA7XX_CORE_IOPAD(0x37ac, PIN_INPUT | MUX_MODE0) /* spi1_d0 */
+			DRA7XX_CORE_IOPAD(0x37b0, PIN_INPUT_SLEW | MUX_MODE0) /* spi1_cs0 */
+			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs2.hdmi1_hpd */
+			DRA7XX_CORE_IOPAD(0x37bc, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs3.hdmi1_cec */
 		>;
 	};
 
 	mcspi2_pins: pinmux_mcspi2_pins {
 		pinctrl-single,pins = <
-			0x3c0 (PIN_INPUT | MUX_MODE0) /* spi2_sclk */
-			0x3c4 (PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
-			0x3c8 (PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
-			0x3cc (PIN_INPUT_SLEW | MUX_MODE0) /* spi2_cs0 */
+			DRA7XX_CORE_IOPAD(0x37c0, PIN_INPUT | MUX_MODE0) /* spi2_sclk */
+			DRA7XX_CORE_IOPAD(0x37c4, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
+			DRA7XX_CORE_IOPAD(0x37c8, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
+			DRA7XX_CORE_IOPAD(0x37cc, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_cs0 */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			0x3e0 (PIN_INPUT_SLEW | MUX_MODE0) /* uart1_rxd */
-			0x3e4 (PIN_INPUT_SLEW | MUX_MODE0) /* uart1_txd */
-			0x3e8 (PIN_INPUT | MUX_MODE3) /* uart1_ctsn */
-			0x3ec (PIN_INPUT | MUX_MODE3) /* uart1_rtsn */
+			DRA7XX_CORE_IOPAD(0x37e0, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_rxd */
+			DRA7XX_CORE_IOPAD(0x37e4, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_txd */
+			DRA7XX_CORE_IOPAD(0x37e8, PIN_INPUT | MUX_MODE3) /* uart1_ctsn */
+			DRA7XX_CORE_IOPAD(0x37ec, PIN_INPUT | MUX_MODE3) /* uart1_rtsn */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			0x3f0 (PIN_INPUT | MUX_MODE0) /* uart2_rxd */
-			0x3f4 (PIN_INPUT | MUX_MODE0) /* uart2_txd */
-			0x3f8 (PIN_INPUT | MUX_MODE0) /* uart2_ctsn */
-			0x3fc (PIN_INPUT | MUX_MODE0) /* uart2_rtsn */
+			DRA7XX_CORE_IOPAD(0x37f0, PIN_INPUT | MUX_MODE0) /* uart2_rxd */
+			DRA7XX_CORE_IOPAD(0x37f4, PIN_INPUT | MUX_MODE0) /* uart2_txd */
+			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT | MUX_MODE0) /* uart2_ctsn */
+			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT | MUX_MODE0) /* uart2_rtsn */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			0x248 (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd */
-			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
+			DRA7XX_CORE_IOPAD(0x3648, PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd */
+			DRA7XX_CORE_IOPAD(0x364c, PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
 		>;
 	};
 
 	qspi1_pins: pinmux_qspi1_pins {
 		pinctrl-single,pins = <
-			0x4c (PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
-			0x50 (PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_cs3 */
-			0x74 (PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1_rtclk */
-			0x78 (PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1_d3 */
-			0x7c (PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1_d2 */
-			0x80 (PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_d1 */
-			0x84 (PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1_d0 */
-			0x88 (PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1_sclk */
-			0xb8 (PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs2.qspi1_cs0 */
-			0xbc (PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
+			DRA7XX_CORE_IOPAD(0x344c, PIN_INPUT | MUX_MODE1)  /* gpmc_a3.qspi1_cs2 */
+			DRA7XX_CORE_IOPAD(0x3450, PIN_INPUT | MUX_MODE1)  /* gpmc_a4.qspi1_cs3 */
+			DRA7XX_CORE_IOPAD(0x3474, PIN_INPUT | MUX_MODE1)  /* gpmc_a13.qspi1_rtclk */
+			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)  /* gpmc_a14.qspi1_d3 */
+			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)  /* gpmc_a15.qspi1_d2 */
+			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1) /* gpmc_a16.qspi1_d1 */
+			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)  /* gpmc_a17.qspi1_d0 */
+			DRA7XX_CORE_IOPAD(0x3488, PIN_INPUT | MUX_MODE1)  /* qpmc_a18.qspi1_sclk */
+			DRA7XX_CORE_IOPAD(0x34b8, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs2.qspi1_cs0 */
+			DRA7XX_CORE_IOPAD(0x34bc, PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
 		>;
 	};
 
 	usb1_pins: pinmux_usb1_pins {
                 pinctrl-single,pins = <
-			0x280 (PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
+			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
                 >;
         };
 
 	usb2_pins: pinmux_usb2_pins {
                 pinctrl-single,pins = <
-			0x284 (PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
+			DRA7XX_CORE_IOPAD(0x3684, PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
                 >;
         };
 
@@ -257,60 +257,60 @@
 		 * SW5.9 (GPMC_WPN) = LOW
 		 * SW5.1 (NAND_BOOTn) = HIGH */
 		pinctrl-single,pins = <
-			0x0 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0	*/
-			0x4 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1	*/
-			0x8 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2	*/
-			0xc 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3	*/
-			0x10	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4	*/
-			0x14	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5	*/
-			0x18	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6	*/
-			0x1c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7	*/
-			0x20	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad8	*/
-			0x24	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad9	*/
-			0x28	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad10	*/
-			0x2c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad11	*/
-			0x30	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad12	*/
-			0x34	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad13	*/
-			0x38	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad14	*/
-			0x3c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad15	*/
-			0xd8	(PIN_INPUT_PULLUP  | MUX_MODE0)	/* gpmc_wait0	*/
-			0xcc	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_wen	*/
-			0xb4	(PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0	*/
-			0xc4	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_advn_ale */
-			0xc8	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_oen_ren	 */
-			0xd0	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_be0n_cle */
+			DRA7XX_CORE_IOPAD(0x3400, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0	*/
+			DRA7XX_CORE_IOPAD(0x3404, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1	*/
+			DRA7XX_CORE_IOPAD(0x3408, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2	*/
+			DRA7XX_CORE_IOPAD(0x340c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3	*/
+			DRA7XX_CORE_IOPAD(0x3410, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4	*/
+			DRA7XX_CORE_IOPAD(0x3414, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5	*/
+			DRA7XX_CORE_IOPAD(0x3418, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6	*/
+			DRA7XX_CORE_IOPAD(0x341c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7	*/
+			DRA7XX_CORE_IOPAD(0x3420, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad8	*/
+			DRA7XX_CORE_IOPAD(0x3424, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad9	*/
+			DRA7XX_CORE_IOPAD(0x3428, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad10	*/
+			DRA7XX_CORE_IOPAD(0x342c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad11	*/
+			DRA7XX_CORE_IOPAD(0x3430, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad12	*/
+			DRA7XX_CORE_IOPAD(0x3434, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad13	*/
+			DRA7XX_CORE_IOPAD(0x3438, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad14	*/
+			DRA7XX_CORE_IOPAD(0x343c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad15	*/
+			DRA7XX_CORE_IOPAD(0x34d8, PIN_INPUT_PULLUP  | MUX_MODE0)	/* gpmc_wait0	*/
+			DRA7XX_CORE_IOPAD(0x34cc, PIN_OUTPUT | MUX_MODE0)	/* gpmc_wen	*/
+			DRA7XX_CORE_IOPAD(0x34b4, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0	*/
+			DRA7XX_CORE_IOPAD(0x34c4, PIN_OUTPUT | MUX_MODE0)	/* gpmc_advn_ale */
+			DRA7XX_CORE_IOPAD(0x34c8, PIN_OUTPUT | MUX_MODE0)	/* gpmc_oen_ren	 */
+			DRA7XX_CORE_IOPAD(0x34d0, PIN_OUTPUT | MUX_MODE0)	/* gpmc_be0n_cle */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x250 (PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txc.rgmii0_txc */
-			0x254 (PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txctl.rgmii0_txctl */
-			0x258 (PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td3.rgmii0_txd3 */
-			0x25c (PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd2.rgmii0_txd2 */
-			0x260 (PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd1.rgmii0_txd1 */
-			0x264 (PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd0.rgmii0_txd0 */
-			0x268 (PIN_INPUT | MUX_MODE0)	/* rgmii0_rxc.rgmii0_rxc */
-			0x26c (PIN_INPUT | MUX_MODE0)	/* rgmii0_rxctl.rgmii0_rxctl */
-			0x270 (PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd3.rgmii0_rxd3 */
-			0x274 (PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd2.rgmii0_rxd2 */
-			0x278 (PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd1.rgmii0_rxd1 */
-			0x27c (PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd0.rgmii0_rxd0 */
+			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txc.rgmii0_txc */
+			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txctl.rgmii0_txctl */
+			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td3.rgmii0_txd3 */
+			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd2.rgmii0_txd2 */
+			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd1.rgmii0_txd1 */
+			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd0.rgmii0_txd0 */
+			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxc.rgmii0_rxc */
+			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxctl.rgmii0_rxctl */
+			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd3.rgmii0_rxd3 */
+			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd2.rgmii0_rxd2 */
+			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd1.rgmii0_rxd1 */
+			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd0.rgmii0_rxd0 */
 
 			/* Slave 2 */
-			0x198 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d12.rgmii1_txc */
-			0x19c (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d13.rgmii1_tctl */
-			0x1a0 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d14.rgmii1_td3 */
-			0x1a4 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d15.rgmii1_td2 */
-			0x1a8 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d16.rgmii1_td1 */
-			0x1ac (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d17.rgmii1_td0 */
-			0x1b0 (PIN_INPUT | MUX_MODE3)	/* vin2a_d18.rgmii1_rclk */
-			0x1b4 (PIN_INPUT | MUX_MODE3)	/* vin2a_d19.rgmii1_rctl */
-			0x1b8 (PIN_INPUT | MUX_MODE3)	/* vin2a_d20.rgmii1_rd3 */
-			0x1bc (PIN_INPUT | MUX_MODE3)	/* vin2a_d21.rgmii1_rd2 */
-			0x1c0 (PIN_INPUT | MUX_MODE3)	/* vin2a_d22.rgmii1_rd1 */
-			0x1c4 (PIN_INPUT | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
+			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d12.rgmii1_txc */
+			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d13.rgmii1_tctl */
+			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d14.rgmii1_td3 */
+			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d15.rgmii1_td2 */
+			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d16.rgmii1_td1 */
+			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d17.rgmii1_td0 */
+			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE3)	/* vin2a_d18.rgmii1_rclk */
+			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE3)	/* vin2a_d19.rgmii1_rctl */
+			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE3)	/* vin2a_d20.rgmii1_rd3 */
+			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE3)	/* vin2a_d21.rgmii1_rd2 */
+			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE3)	/* vin2a_d22.rgmii1_rd1 */
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
 		>;
 
 	};
@@ -318,85 +318,85 @@
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			0x250 (MUX_MODE15)
-			0x254 (MUX_MODE15)
-			0x258 (MUX_MODE15)
-			0x25c (MUX_MODE15)
-			0x260 (MUX_MODE15)
-			0x264 (MUX_MODE15)
-			0x268 (MUX_MODE15)
-			0x26c (MUX_MODE15)
-			0x270 (MUX_MODE15)
-			0x274 (MUX_MODE15)
-			0x278 (MUX_MODE15)
-			0x27c (MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3650, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3654, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3658, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x365c, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3660, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3664, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3668, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x366c, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3670, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3674, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3678, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x367c, MUX_MODE15)
 
 			/* Slave 2 */
-			0x198 (MUX_MODE15)
-			0x19c (MUX_MODE15)
-			0x1a0 (MUX_MODE15)
-			0x1a4 (MUX_MODE15)
-			0x1a8 (MUX_MODE15)
-			0x1ac (MUX_MODE15)
-			0x1b0 (MUX_MODE15)
-			0x1b4 (MUX_MODE15)
-			0x1b8 (MUX_MODE15)
-			0x1bc (MUX_MODE15)
-			0x1c0 (MUX_MODE15)
-			0x1c4 (MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3598, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x359c, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a0, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a4, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35a8, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35ac, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b0, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b4, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35b8, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35bc, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c0, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x35c4, MUX_MODE15)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
-			0x23c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_d.mdio_d */
-			0x240 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_clk.mdio_clk */
+			DRA7XX_CORE_IOPAD(0x363c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_d.mdio_d */
+			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
-			0x23c (MUX_MODE15)
-			0x240 (MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x363c, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3640, MUX_MODE15)
 		>;
 	};
 
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
-			0x3d0   (PIN_OUTPUT_PULLUP | MUX_MODE0) /* dcan1_tx */
-			0x418   (PULL_UP | MUX_MODE1) /* wakeup0.dcan1_rx */
+			DRA7XX_CORE_IOPAD(0x37d0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* dcan1_tx */
+			DRA7XX_CORE_IOPAD(0x3818, PULL_UP | MUX_MODE1) /* wakeup0.dcan1_rx */
 		>;
 	};
 
 	dcan1_pins_sleep: dcan1_pins_sleep {
 		pinctrl-single,pins = <
-			0x3d0   (MUX_MODE15 | PULL_UP)	/* dcan1_tx.off */
-			0x418   (MUX_MODE15 | PULL_UP)	/* wakeup0.off */
+			DRA7XX_CORE_IOPAD(0x37d0, MUX_MODE15 | PULL_UP)	/* dcan1_tx.off */
+			DRA7XX_CORE_IOPAD(0x3818, MUX_MODE15 | PULL_UP)	/* wakeup0.off */
 		>;
 	};
 
 	atl_pins: pinmux_atl_pins {
 		pinctrl-single,pins = <
-			0x298 (PIN_OUTPUT | MUX_MODE5)	/* xref_clk1.atl_clk1 */
-			0x29c (PIN_OUTPUT | MUX_MODE5)	/* xref_clk2.atl_clk2 */
+			DRA7XX_CORE_IOPAD(0x3698, PIN_OUTPUT | MUX_MODE5)	/* xref_clk1.atl_clk1 */
+			DRA7XX_CORE_IOPAD(0x369c, PIN_OUTPUT | MUX_MODE5)	/* xref_clk2.atl_clk2 */
 		>;
 	};
 
 	mcasp3_pins: pinmux_mcasp3_pins {
 		pinctrl-single,pins = <
-			0x324 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_aclkx */
-			0x328 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_fsx */
-			0x32c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr0 */
-			0x330 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr1 */
+			DRA7XX_CORE_IOPAD(0x3724, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_aclkx */
+			DRA7XX_CORE_IOPAD(0x3728, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_fsx */
+			DRA7XX_CORE_IOPAD(0x372c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr0 */
+			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr1 */
 		>;
 	};
 
 	mcasp3_sleep_pins: pinmux_mcasp3_sleep_pins {
 		pinctrl-single,pins = <
-			0x324 (MUX_MODE15)
-			0x328 (MUX_MODE15)
-			0x32c (MUX_MODE15)
-			0x330 (MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3724, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3728, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x372c, MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3730, MUX_MODE15)
 		>;
 	};
 };
-- 
2.4.3
