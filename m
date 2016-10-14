From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/9] ARM: dts: dra72-evm: Remove pinmux configurations for
 erratum i869
Date: Fri, 14 Oct 2016 18:30:25 +0530
Message-ID: <20161014130033.14172-2-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161014130033.14172-1-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
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
sequence). With the exception of DCAN and MMC, all other pin mux
configurations are removed from the dts.

[1] http://www.ti.com/lit/er/sprz436a/sprz436a.pdf
[2] http://www.ti.com/lit/ug/spruhz7c/spruhz7c.pdf

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 192 --------------------------------
 1 file changed, 192 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index c94d8d64..3c02612 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -69,9 +69,6 @@
 	tpd12s015: encoder {
 		compatible = "ti,tpd12s015";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&tpd12s015_pins>;
-
 		gpios = <&pcf_hdmi 4 GPIO_ACTIVE_HIGH>,	/* P4, CT CP HPD */
 			<&pcf_hdmi 5 GPIO_ACTIVE_HIGH>,	/* P5, LS OE */
 			<&gpio7 12 GPIO_ACTIVE_HIGH>;	/* gpio7_12/sp1_cs2, HPD */
@@ -134,72 +131,6 @@
 };
 
 &dra7_pmx_core {
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT | MUX_MODE0) /* i2c1_sda.i2c1_sda */
-			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT | MUX_MODE0) /* i2c1_scl.i2c1_scl */
-		>;
-	};
-
-	i2c5_pins: pinmux_i2c5_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x36b4, PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
-			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
-		>;
-	};
-
-	i2c5_pins: pinmux_i2c5_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x36b4, PIN_INPUT | MUX_MODE10) /* mcasp1_axr0.i2c5_sda */
-			DRA7XX_CORE_IOPAD(0x36b8, PIN_INPUT | MUX_MODE10) /* mcasp1_axr1.i2c5_scl */
-		>;
-	};
-
-	nand_default: nand_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3400, PIN_INPUT  | MUX_MODE0) /* gpmc_ad0 */
-			DRA7XX_CORE_IOPAD(0x3404, PIN_INPUT  | MUX_MODE0) /* gpmc_ad1 */
-			DRA7XX_CORE_IOPAD(0x3408, PIN_INPUT  | MUX_MODE0) /* gpmc_ad2 */
-			DRA7XX_CORE_IOPAD(0x340c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad3 */
-			DRA7XX_CORE_IOPAD(0x3410, PIN_INPUT  | MUX_MODE0) /* gpmc_ad4 */
-			DRA7XX_CORE_IOPAD(0x3414, PIN_INPUT  | MUX_MODE0) /* gpmc_ad5 */
-			DRA7XX_CORE_IOPAD(0x3418, PIN_INPUT  | MUX_MODE0) /* gpmc_ad6 */
-			DRA7XX_CORE_IOPAD(0x341c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad7 */
-			DRA7XX_CORE_IOPAD(0x3420, PIN_INPUT  | MUX_MODE0) /* gpmc_ad8 */
-			DRA7XX_CORE_IOPAD(0x3424, PIN_INPUT  | MUX_MODE0) /* gpmc_ad9 */
-			DRA7XX_CORE_IOPAD(0x3428, PIN_INPUT  | MUX_MODE0) /* gpmc_ad10 */
-			DRA7XX_CORE_IOPAD(0x342c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad11 */
-			DRA7XX_CORE_IOPAD(0x3430, PIN_INPUT  | MUX_MODE0) /* gpmc_ad12 */
-			DRA7XX_CORE_IOPAD(0x3434, PIN_INPUT  | MUX_MODE0) /* gpmc_ad13 */
-			DRA7XX_CORE_IOPAD(0x3438, PIN_INPUT  | MUX_MODE0) /* gpmc_ad14 */
-			DRA7XX_CORE_IOPAD(0x343c, PIN_INPUT  | MUX_MODE0) /* gpmc_ad15 */
-			DRA7XX_CORE_IOPAD(0x34b4, PIN_OUTPUT | MUX_MODE0) /* gpmc_cs0 */
-			DRA7XX_CORE_IOPAD(0x34c4, PIN_OUTPUT | MUX_MODE0) /* gpmc_advn_ale */
-			DRA7XX_CORE_IOPAD(0x34cc, PIN_OUTPUT | MUX_MODE0) /* gpmc_wen */
-			DRA7XX_CORE_IOPAD(0x34c8, PIN_OUTPUT | MUX_MODE0) /* gpmc_oen_ren */
-			DRA7XX_CORE_IOPAD(0x34d0, PIN_OUTPUT | MUX_MODE0) /* gpmc_ben0 */
-			DRA7XX_CORE_IOPAD(0x34d8, PIN_INPUT  | MUX_MODE0) /* gpmc_wait0 */
-		>;
-	};
-
-	usb1_pins: pinmux_usb1_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
-		>;
-	};
-
-	usb2_pins: pinmux_usb2_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3684, PIN_INPUT_SLEW | MUX_MODE0) /* usb2_drvvbus */
-		>;
-	};
-
-	tps65917_pins_default: tps65917_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3824, PIN_INPUT_PULLUP | MUX_MODE1) /* wakeup3.sys_nirq1 */
-		>;
-	};
-
 	mmc1_pins_default: mmc1_pins_default {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
@@ -240,59 +171,16 @@
 			DRA7XX_CORE_IOPAD(0x3818, MUX_MODE15 | PULL_UP)	/* wakeup0.off */
 		>;
 	};
-
-	hdmi_pins: pinmux_hdmi_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x3808, PIN_INPUT | MUX_MODE1) /* i2c2_sda.hdmi1_ddc_scl */
-			DRA7XX_CORE_IOPAD(0x380c, PIN_INPUT | MUX_MODE1) /* i2c2_scl.hdmi1_ddc_sda */
-		>;
-	};
-
-	tpd12s015_pins: pinmux_tpd12s015_pins {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x37b8, PIN_INPUT_PULLDOWN | MUX_MODE14) /* gpio7_12 HPD */
-		>;
-	};
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
-			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT_PULLDOWN | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT_PULLDOWN | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x372c, PIN_INPUT_PULLDOWN | MUX_MODE15)
-			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT_PULLDOWN | MUX_MODE15)
-		>;
-	};
 };
 
 &i2c1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 
 	tps65917: tps65917@58 {
 		compatible = "ti,tps65917";
 		reg = <0x58>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&tps65917_pins_default>;
-
 		interrupts = <GIC_SPI 2 IRQ_TYPE_NONE>;  /* IRQ_SYS_1N */
 		interrupt-controller;
 		#interrupt-cells = <2>;
@@ -423,8 +311,6 @@
 
 &i2c5 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c5_pins>;
 	clock-frequency = <400000>;
 
 	pcf_hdmi: pcf8575@26 {
@@ -462,8 +348,6 @@
 
 &gpmc {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_default>;
 	ranges = <0 0 0x08000000 0x01000000>;	/* minimum GPMC partition = 16MB */
 	nand@0,0 {
 		/* To use NAND, DIP switch SW5 must be set like so:
@@ -566,14 +450,10 @@
 
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
 
 &mmc1 {
@@ -603,71 +483,8 @@
 	max-frequency = <192000000>;
 };
 
-&dra7_pmx_core {
-	cpsw_default: cpsw_default {
-		pinctrl-single,pins = <
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
-			/* MDIO */
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
-};
-
 &mac {
 	status = "okay";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cpsw_default>;
-	pinctrl-1 = <&cpsw_sleep>;
-};
-
-&davinci_mdio {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&davinci_mdio_default>;
-	pinctrl-1 = <&davinci_mdio_sleep>;
 };
 
 &dcan1 {
@@ -748,9 +565,6 @@
 &hdmi {
 	status = "ok";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdmi_pins>;
-
 	port {
 		hdmi_out: endpoint {
 			remote-endpoint = <&tpd12s015_in>;
@@ -759,9 +573,6 @@
 };
 
 &atl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&atl_pins>;
-
 	assigned-clocks = <&abe_dpll_sys_clk_mux>,
 			  <&atl_gfclk_mux>,
 			  <&dpll_abe_ck>,
@@ -780,9 +591,6 @@
 
 &mcasp3 {
 	#sound-dai-cells = <0>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&mcasp3_pins>;
-	pinctrl-1 = <&mcasp3_sleep_pins>;
 
 	assigned-clocks = <&mcasp3_ahclkx_mux>;
 	assigned-clock-parents = <&atl_clkin2_ck>;
-- 
2.9.3
