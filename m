From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 22/39] ARM: dts: dra72-evm: Use DRA7XX_CORE_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:00 -0300
Message-ID: <1447390457-1158-23-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/dra72-evm.dts | 200 ++++++++++++++++++++--------------------
 1 file changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index d6104d5f0c01..e5cc5d307f97 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -142,158 +142,158 @@
 &dra7_pmx_core {
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			0x400 (PIN_INPUT | MUX_MODE0) /* i2c1_sda.i2c1_sda */
-			0x404 (PIN_INPUT | MUX_MODE0) /* i2c1_scl.i2c1_scl */
+			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT | MUX_MODE0) /* i2c1_sda.i2c1_sda */
+			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT | MUX_MODE0) /* i2c1_scl.i2c1_scl */
 		>;
 	};
 
 	i2c5_pins: pinmux_i2c5_pins {
 		pinctrl-single,pins = <
-			0x2b4 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
-			0x2b8 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
+			DRA7XX_CORE_IOPAD(0x36b4, PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
+			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
 		>;
 	};
 
 	i2c5_pins: pinmux_i2c5_pins {
 		pinctrl-single,pins = <
-			0x2b4 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
-			0x2b8 (PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
+			DRA7XX_CORE_IOPAD(0x36b4, PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
+			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
 		>;
 	};
 
 	nand_default: nand_default {
 		pinctrl-single,pins = <
-			0x0	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad0 */
-			0x4	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad1 */
-			0x8	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad2 */
-			0xc	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad3 */
-			0x10	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad4 */
-			0x14	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad5 */
-			0x18	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad6 */
-			0x1c	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad7 */
-			0x20	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad8 */
-			0x24	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad9 */
-			0x28	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad10 */
-			0x2c	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad11 */
-			0x30	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad12 */
-			0x34	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad13 */
-			0x38	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad14 */
-			0x3c	(PIN_INPUT  | MUX_MODE0) /* gpmc_ad15 */
-			0xb4	(PIN_OUTPUT | MUX_MODE0) /* gpmc_cs0 */
-			0xc4	(PIN_OUTPUT | MUX_MODE0) /* gpmc_advn_ale */
-			0xcc	(PIN_OUTPUT | MUX_MODE0) /* gpmc_wen */
-			0xc8	(PIN_OUTPUT | MUX_MODE0) /* gpmc_oen_ren */
-			0xd0	(PIN_OUTPUT | MUX_MODE0) /* gpmc_ben0 */
-			0xd8	(PIN_INPUT  | MUX_MODE0) /* gpmc_wait0 */
+			DRA7XX_CORE_IOPAD(0x3400, PIN_INPUT  | MUX_MODE0) /* gpmc_ad0 */
+			DRA7XX_CORE_IOPAD(0x3404, PIN_INPUT  | MUX_MODE0) /* gpmc_ad1 */
+			DRA7XX_CORE_IOPAD(0x3408, PIN_INPUT  | MUX_MODE0) /* gpmc_ad2 */
+			DRA7XX_CORE_IOPAD(0x340c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad3 */
+			DRA7XX_CORE_IOPAD(0x3410, PIN_INPUT  | MUX_MODE0) /* gpmc_ad4 */
+			DRA7XX_CORE_IOPAD(0x3414, PIN_INPUT  | MUX_MODE0) /* gpmc_ad5 */
+			DRA7XX_CORE_IOPAD(0x3418, PIN_INPUT  | MUX_MODE0) /* gpmc_ad6 */
+			DRA7XX_CORE_IOPAD(0x341c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad7 */
+			DRA7XX_CORE_IOPAD(0x3420, PIN_INPUT  | MUX_MODE0) /* gpmc_ad8 */
+			DRA7XX_CORE_IOPAD(0x3424, PIN_INPUT  | MUX_MODE0) /* gpmc_ad9 */
+			DRA7XX_CORE_IOPAD(0x3428, PIN_INPUT  | MUX_MODE0) /* gpmc_ad10 */
+			DRA7XX_CORE_IOPAD(0x342c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad11 */
+			DRA7XX_CORE_IOPAD(0x3430, PIN_INPUT  | MUX_MODE0) /* gpmc_ad12 */
+			DRA7XX_CORE_IOPAD(0x3434, PIN_INPUT  | MUX_MODE0) /* gpmc_ad13 */
+			DRA7XX_CORE_IOPAD(0x3438, PIN_INPUT  | MUX_MODE0) /* gpmc_ad14 */
+			DRA7XX_CORE_IOPAD(0x343c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad15 */
+			DRA7XX_CORE_IOPAD(0x34b4, PIN_OUTPUT | MUX_MODE0) /* gpmc_cs0 */
+			DRA7XX_CORE_IOPAD(0x34c4, PIN_OUTPUT | MUX_MODE0) /* gpmc_advn_ale */
+			DRA7XX_CORE_IOPAD(0x34cc, PIN_OUTPUT | MUX_MODE0) /* gpmc_wen */
+			DRA7XX_CORE_IOPAD(0x34c8, PIN_OUTPUT | MUX_MODE0) /* gpmc_oen_ren */
+			DRA7XX_CORE_IOPAD(0x34d0, PIN_OUTPUT | MUX_MODE0) /* gpmc_ben0 */
+			DRA7XX_CORE_IOPAD(0x34d8, PIN_INPUT  | MUX_MODE0) /* gpmc_wait0 */
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
 
 	tps65917_pins_default: tps65917_pins_default {
 		pinctrl-single,pins = <
-			0x424 (PIN_INPUT_PULLUP | MUX_MODE1) /* wakeup3.sys_nirq1 */
+			DRA7XX_CORE_IOPAD(0x3824, PIN_INPUT_PULLUP | MUX_MODE1) /* wakeup3.sys_nirq1 */
 		>;
 	};
 
 	mmc1_pins_default: mmc1_pins_default {
 		pinctrl-single,pins = <
-			0x36c (PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
-			0x354 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
-			0x358 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
-			0x35c (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
-			0x360 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
-			0x364 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
-			0x368 (PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
 		>;
 	};
 
 	mmc2_pins_default: mmc2_pins_default {
 		pinctrl-single,pins = <
-			0x9c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
-			0xb0 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
-			0xa0 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
-			0xa4 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
-			0xa8 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
-			0xac (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
-			0x8c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
-			0x90 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
-			0x94 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
-			0x98 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
+			DRA7XX_CORE_IOPAD(0x349c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
+			DRA7XX_CORE_IOPAD(0x34b0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
+			DRA7XX_CORE_IOPAD(0x34a0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
+			DRA7XX_CORE_IOPAD(0x34a4, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
+			DRA7XX_CORE_IOPAD(0x34a8, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
+			DRA7XX_CORE_IOPAD(0x34ac, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
+			DRA7XX_CORE_IOPAD(0x348c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
+			DRA7XX_CORE_IOPAD(0x3490, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
+			DRA7XX_CORE_IOPAD(0x3494, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
+			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
 		>;
 	};
 
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
-			0x3d0   (PIN_OUTPUT_PULLUP | MUX_MODE0) /* dcan1_tx */
-			0x418   (PULL_UP | MUX_MODE1)	/* wakeup0.dcan1_rx */
+			DRA7XX_CORE_IOPAD(0x37d0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* dcan1_tx */
+			DRA7XX_CORE_IOPAD(0x3818, PULL_UP | MUX_MODE1)	/* wakeup0.dcan1_rx */
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
 
 	qspi1_pins: pinmux_qspi1_pins {
 		pinctrl-single,pins = <
-			0x74 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_a13.qspi1_rtclk */
-			0x78 (PIN_INPUT | MUX_MODE1)	/* gpmc_a14.qspi1_d3 */
-			0x7c (PIN_INPUT | MUX_MODE1)	/* gpmc_a15.qspi1_d2 */
-			0x80 (PIN_INPUT | MUX_MODE1)	/* gpmc_a16.qspi1_d1 */
-			0x84 (PIN_INPUT | MUX_MODE1)	/* gpmc_a17.qspi1_d0 */
-			0x88 (PIN_OUTPUT | MUX_MODE1)	/* qpmc_a18.qspi1_sclk */
-			0xb8 (PIN_OUTPUT | MUX_MODE1)	/* gpmc_cs2.qspi1_cs0 */
+			DRA7XX_CORE_IOPAD(0x3474, PIN_OUTPUT | MUX_MODE1)	/* gpmc_a13.qspi1_rtclk */
+			DRA7XX_CORE_IOPAD(0x3478, PIN_INPUT | MUX_MODE1)	/* gpmc_a14.qspi1_d3 */
+			DRA7XX_CORE_IOPAD(0x347c, PIN_INPUT | MUX_MODE1)	/* gpmc_a15.qspi1_d2 */
+			DRA7XX_CORE_IOPAD(0x3480, PIN_INPUT | MUX_MODE1)	/* gpmc_a16.qspi1_d1 */
+			DRA7XX_CORE_IOPAD(0x3484, PIN_INPUT | MUX_MODE1)	/* gpmc_a17.qspi1_d0 */
+			DRA7XX_CORE_IOPAD(0x3488, PIN_OUTPUT | MUX_MODE1)	/* qpmc_a18.qspi1_sclk */
+			DRA7XX_CORE_IOPAD(0x34b8, PIN_OUTPUT | MUX_MODE1)	/* gpmc_cs2.qspi1_cs0 */
 		>;
 	};
 
 	hdmi_pins: pinmux_hdmi_pins {
 		pinctrl-single,pins = <
-			0x408 (PIN_INPUT | MUX_MODE1) /* i2c2_sda.hdmi1_ddc_scl */
-			0x40c (PIN_INPUT | MUX_MODE1) /* i2c2_scl.hdmi1_ddc_sda */
+			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1) /* i2c2_sda.hdmi1_ddc_scl */
+			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE1) /* i2c2_scl.hdmi1_ddc_sda */
 		>;
 	};
 
 	tpd12s015_pins: pinmux_tpd12s015_pins {
 		pinctrl-single,pins = <
-			0x3b8 (PIN_INPUT_PULLDOWN | MUX_MODE14) /* gpio7_12 HPD */
+			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_PULLDOWN | MUX_MODE14) /* gpio7_12 HPD */
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
-			0x324 (PIN_INPUT_PULLDOWN | MUX_MODE15)
-			0x328 (PIN_INPUT_PULLDOWN | MUX_MODE15)
-			0x32c (PIN_INPUT_PULLDOWN | MUX_MODE15)
-			0x330 (PIN_INPUT_PULLDOWN | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT_PULLDOWN | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT_PULLDOWN | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x372c, PIN_INPUT_PULLDOWN | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT_PULLDOWN | MUX_MODE15)
 		>;
 	};
 };
@@ -627,18 +627,18 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
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
@@ -646,33 +646,33 @@
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
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
 			/* MDIO */
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
 };
-- 
2.4.3
