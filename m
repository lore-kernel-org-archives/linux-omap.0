From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/2] ARM: dts: dra7-evm: Remove pinmux configurations for
 erratum i869
Date: Tue, 29 Nov 2016 14:54:47 +0530
Message-ID: <b80e3cbc8a377abdb40ab11de78ce0b3fb67596f.1480411308.git.nsekhar@ti.com>
References: <cover.1480411308.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1480411308.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Pinmuxing for DRA7x/AM57x family of processors need to be done in IO
isolation as part of initial bootloader executed from SRAM. This is
done as part of iodelay configuration sequence and is required due
to the limitations introduced by erratum ID: i869[1] (IO Glitches
can occur when changing IO settings) and elaborated in the Technical
Reference Manual[2] 18.4.6.1.7 Isolation Requirements.

Only peripheral that is permitted for dynamic pin mux configuration
is MMC and DCAN. MMC is permitted to change to accommodate the
requirements for varied speeds (which require IO-delay support in
kernel as well). DCAN is a result of i893[1] (DCAN initialization
sequence).

DCAN pinmux is retained in this patch. MMC pinmux is missing from
the dra7-evm.dts file and the board is relying on configuration done
by bootloader. A subsequent patch will add MMC pinmux configuration.

A side-effect of this patch is that NAND support is removed. NAND
pins clash with VOUT3 on DRA7-EVM. U-Boot selects VOUT3 over NAND
as per TI EVM application needs.

[1] http://www.ti.com/lit/pdf/sprz429
[2] http://www.ti.com/lit/pdf/sprui30

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 260 -----------------------------------------
 1 file changed, 260 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 132f2be10889..a1efd4efed6d 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -151,204 +151,6 @@
 };
 
 &dra7_pmx_core {
-	pinctrl-names = "default";
-	pinctrl-0 = <&vtt_pin>;
-
-	vtt_pin: pinmux_vtt_pin {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37b4, PIN_OUTPUT | MUX_MODE14) /* spi1_cs1.gpio7_11 */
-		>;
-	};
-
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT | MUX_MODE0) /* i2c1_sda */
-			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT | MUX_MODE0) /* i2c1_scl */
-		>;
-	};
-
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE0) /* i2c2_sda */
-			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE0) /* i2c2_scl */
-		>;
-	};
-
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3688, PIN_INPUT | MUX_MODE9) /* gpio6_14.i2c3_sda */
-			DRA7XX_CORE_IOPAD(0x368c, PIN_INPUT | MUX_MODE9) /* gpio6_15.i2c3_scl */
-		>;
-	};
-
-	mcspi1_pins: pinmux_mcspi1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37a4, PIN_INPUT | MUX_MODE0) /* spi1_sclk */
-			DRA7XX_CORE_IOPAD(0x37a8, PIN_INPUT | MUX_MODE0) /* spi1_d1 */
-			DRA7XX_CORE_IOPAD(0x37ac, PIN_INPUT | MUX_MODE0) /* spi1_d0 */
-			DRA7XX_CORE_IOPAD(0x37b0, PIN_INPUT_SLEW | MUX_MODE0) /* spi1_cs0 */
-			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs2.hdmi1_hpd */
-			DRA7XX_CORE_IOPAD(0x37bc, PIN_INPUT_SLEW | MUX_MODE6) /* spi1_cs3.hdmi1_cec */
-		>;
-	};
-
-	mcspi2_pins: pinmux_mcspi2_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37c0, PIN_INPUT | MUX_MODE0) /* spi2_sclk */
-			DRA7XX_CORE_IOPAD(0x37c4, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
-			DRA7XX_CORE_IOPAD(0x37c8, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_d1 */
-			DRA7XX_CORE_IOPAD(0x37cc, PIN_INPUT_SLEW | MUX_MODE0) /* spi2_cs0 */
-		>;
-	};
-
-	uart1_pins: pinmux_uart1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37e0, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_rxd */
-			DRA7XX_CORE_IOPAD(0x37e4, PIN_INPUT_SLEW | MUX_MODE0) /* uart1_txd */
-			DRA7XX_CORE_IOPAD(0x37e8, PIN_INPUT | MUX_MODE3) /* uart1_ctsn */
-			DRA7XX_CORE_IOPAD(0x37ec, PIN_INPUT | MUX_MODE3) /* uart1_rtsn */
-		>;
-	};
-
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37f0, PIN_INPUT | MUX_MODE0) /* uart2_rxd */
-			DRA7XX_CORE_IOPAD(0x37f4, PIN_INPUT | MUX_MODE0) /* uart2_txd */
-			DRA7XX_CORE_IOPAD(0x37f8, PIN_INPUT | MUX_MODE0) /* uart2_ctsn */
-			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT | MUX_MODE0) /* uart2_rtsn */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3648, PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd */
-			DRA7XX_CORE_IOPAD(0x364c, PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd */
-		>;
-	};
-
-	usb1_pins: pinmux_usb1_pins {
-                pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
-                >;
-        };
-
-	usb2_pins: pinmux_usb2_pins {
-                pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3684, PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
-                >;
-        };
-
-	nand_flash_x16: nand_flash_x16 {
-		/* On DRA7 EVM, GPMC_WPN and NAND_BOOTn comes from DIP switch
-		 * So NAND flash requires following switch settings:
-		 * SW5.1 (NAND_BOOTn) = ON (LOW)
-		 * SW5.9 (GPMC_WPN) = OFF (HIGH)
-		 */
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3400, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0	*/
-			DRA7XX_CORE_IOPAD(0x3404, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1	*/
-			DRA7XX_CORE_IOPAD(0x3408, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2	*/
-			DRA7XX_CORE_IOPAD(0x340c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3	*/
-			DRA7XX_CORE_IOPAD(0x3410, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4	*/
-			DRA7XX_CORE_IOPAD(0x3414, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5	*/
-			DRA7XX_CORE_IOPAD(0x3418, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6	*/
-			DRA7XX_CORE_IOPAD(0x341c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7	*/
-			DRA7XX_CORE_IOPAD(0x3420, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad8	*/
-			DRA7XX_CORE_IOPAD(0x3424, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad9	*/
-			DRA7XX_CORE_IOPAD(0x3428, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad10	*/
-			DRA7XX_CORE_IOPAD(0x342c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad11	*/
-			DRA7XX_CORE_IOPAD(0x3430, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad12	*/
-			DRA7XX_CORE_IOPAD(0x3434, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad13	*/
-			DRA7XX_CORE_IOPAD(0x3438, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad14	*/
-			DRA7XX_CORE_IOPAD(0x343c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad15	*/
-			DRA7XX_CORE_IOPAD(0x34d8, PIN_INPUT_PULLUP  | MUX_MODE0)	/* gpmc_wait0	*/
-			DRA7XX_CORE_IOPAD(0x34cc, PIN_OUTPUT | MUX_MODE0)	/* gpmc_wen	*/
-			DRA7XX_CORE_IOPAD(0x34b4, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0	*/
-			DRA7XX_CORE_IOPAD(0x34c4, PIN_OUTPUT | MUX_MODE0)	/* gpmc_advn_ale */
-			DRA7XX_CORE_IOPAD(0x34c8, PIN_OUTPUT | MUX_MODE0)	/* gpmc_oen_ren	 */
-			DRA7XX_CORE_IOPAD(0x34d0, PIN_OUTPUT | MUX_MODE0)	/* gpmc_be0n_cle */
-		>;
-	};
-
-	cpsw_default: cpsw_default {
-		pinctrl-single,pins = <
-			/* Slave 1 */
-			DRA7XX_CORE_IOPAD(0x3650, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txc.rgmii0_txc */
-			DRA7XX_CORE_IOPAD(0x3654, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txctl.rgmii0_txctl */
-			DRA7XX_CORE_IOPAD(0x3658, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_td3.rgmii0_txd3 */
-			DRA7XX_CORE_IOPAD(0x365c, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd2.rgmii0_txd2 */
-			DRA7XX_CORE_IOPAD(0x3660, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd1.rgmii0_txd1 */
-			DRA7XX_CORE_IOPAD(0x3664, PIN_OUTPUT | MUX_MODE0)	/* rgmii0_txd0.rgmii0_txd0 */
-			DRA7XX_CORE_IOPAD(0x3668, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxc.rgmii0_rxc */
-			DRA7XX_CORE_IOPAD(0x366c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxctl.rgmii0_rxctl */
-			DRA7XX_CORE_IOPAD(0x3670, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd3.rgmii0_rxd3 */
-			DRA7XX_CORE_IOPAD(0x3674, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd2.rgmii0_rxd2 */
-			DRA7XX_CORE_IOPAD(0x3678, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd1.rgmii0_rxd1 */
-			DRA7XX_CORE_IOPAD(0x367c, PIN_INPUT | MUX_MODE0)	/* rgmii0_rxd0.rgmii0_rxd0 */
-
-			/* Slave 2 */
-			DRA7XX_CORE_IOPAD(0x3598, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d12.rgmii1_txc */
-			DRA7XX_CORE_IOPAD(0x359c, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d13.rgmii1_tctl */
-			DRA7XX_CORE_IOPAD(0x35a0, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d14.rgmii1_td3 */
-			DRA7XX_CORE_IOPAD(0x35a4, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d15.rgmii1_td2 */
-			DRA7XX_CORE_IOPAD(0x35a8, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d16.rgmii1_td1 */
-			DRA7XX_CORE_IOPAD(0x35ac, PIN_OUTPUT | MUX_MODE3)	/* vin2a_d17.rgmii1_td0 */
-			DRA7XX_CORE_IOPAD(0x35b0, PIN_INPUT | MUX_MODE3)	/* vin2a_d18.rgmii1_rclk */
-			DRA7XX_CORE_IOPAD(0x35b4, PIN_INPUT | MUX_MODE3)	/* vin2a_d19.rgmii1_rctl */
-			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT | MUX_MODE3)	/* vin2a_d20.rgmii1_rd3 */
-			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT | MUX_MODE3)	/* vin2a_d21.rgmii1_rd2 */
-			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT | MUX_MODE3)	/* vin2a_d22.rgmii1_rd1 */
-			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
-		>;
-
-	};
-
-	cpsw_sleep: cpsw_sleep {
-		pinctrl-single,pins = <
-			/* Slave 1 */
-			DRA7XX_CORE_IOPAD(0x3650, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3654, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3658, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x365c, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3660, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3664, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3668, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x366c, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3670, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3674, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3678, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x367c, MUX_MODE15)
-
-			/* Slave 2 */
-			DRA7XX_CORE_IOPAD(0x3598, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x359c, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35a0, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35a4, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35a8, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35ac, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35b0, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35b4, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35b8, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35bc, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35c0, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x35c4, MUX_MODE15)
-		>;
-	};
-
-	davinci_mdio_default: davinci_mdio_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x363c, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_d.mdio_d */
-			DRA7XX_CORE_IOPAD(0x3640, PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_clk.mdio_clk */
-		>;
-	};
-
-	davinci_mdio_sleep: davinci_mdio_sleep {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x363c, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3640, MUX_MODE15)
-		>;
-	};
-
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x37d0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* dcan1_tx */
@@ -362,37 +164,10 @@
 			DRA7XX_CORE_IOPAD(0x3818, MUX_MODE15 | PULL_UP)	/* wakeup0.off */
 		>;
 	};
-
-	atl_pins: pinmux_atl_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3698, PIN_OUTPUT | MUX_MODE5)	/* xref_clk1.atl_clk1 */
-			DRA7XX_CORE_IOPAD(0x369c, PIN_OUTPUT | MUX_MODE5)	/* xref_clk2.atl_clk2 */
-		>;
-	};
-
-	mcasp3_pins: pinmux_mcasp3_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3724, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_aclkx */
-			DRA7XX_CORE_IOPAD(0x3728, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_fsx */
-			DRA7XX_CORE_IOPAD(0x372c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr0 */
-			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr1 */
-		>;
-	};
-
-	mcasp3_sleep_pins: pinmux_mcasp3_sleep_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3724, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3728, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x372c, MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3730, MUX_MODE15)
-		>;
-	};
 };
 
 &i2c1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 
 	tps659038: tps659038@58 {
@@ -581,8 +356,6 @@
 
 &i2c2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	clock-frequency = <400000>;
 
 	pcf_hdmi: gpio@26 {
@@ -602,41 +375,29 @@
 
 &i2c3 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
 	clock-frequency = <400000>;
 };
 
 &mcspi1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcspi1_pins>;
 };
 
 &mcspi2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcspi2_pins>;
 };
 
 &uart1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins>;
 	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
 			      <&dra7_pmx_core 0x3e0>;
 };
 
 &uart2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
 };
 
 &mmc1 {
@@ -732,14 +493,10 @@
 
 &usb1 {
 	dr_mode = "peripheral";
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_pins>;
 };
 
 &usb2 {
 	dr_mode = "host";
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb2_pins>;
 };
 
 &elm {
@@ -748,8 +505,6 @@
 
 &gpmc {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_flash_x16>;
 	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
@@ -845,9 +600,6 @@
 
 &mac {
 	status = "okay";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cpsw_default>;
-	pinctrl-1 = <&cpsw_sleep>;
 	dual_emac;
 };
 
@@ -863,12 +615,6 @@
 	dual_emac_res_vlan = <2>;
 };
 
-&davinci_mdio {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&davinci_mdio_default>;
-	pinctrl-1 = <&davinci_mdio_sleep>;
-};
-
 &dcan1 {
 	status = "ok";
 	pinctrl-names = "default", "sleep", "active";
@@ -878,9 +624,6 @@
 };
 
 &atl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&atl_pins>;
-
 	assigned-clocks = <&abe_dpll_sys_clk_mux>,
 			  <&atl_gfclk_mux>,
 			  <&dpll_abe_ck>,
@@ -899,9 +642,6 @@
 
 &mcasp3 {
 	#sound-dai-cells = <0>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&mcasp3_pins>;
-	pinctrl-1 = <&mcasp3_sleep_pins>;
 
 	assigned-clocks = <&mcasp3_ahclkx_mux>;
 	assigned-clock-parents = <&atl_clkin2_ck>;
-- 
2.9.0
