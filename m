From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v5 2/4] ARM: dts: am437x-gp-evm: add support for parallel NAND flash
Date: Mon, 12 May 2014 17:19:11 +0530
Message-ID: <1399895353-3663-3-git-send-email-pekon@ti.com>
References: <1399895353-3663-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51540 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515AbaELLti (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 07:49:38 -0400
In-Reply-To: <1399895353-3663-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, bcousson@baylibre.com, Pekon Gupta <pekon@ti.com>

Adds pinmux and DT node for Micron (MT29F4G08AB) x8 NAND device present on
am437x-gp-evm board.
(1) As NAND Flash data lines are muxed with eMMC, Thus at a given time either
    eMMC or NAND can be enabled. Selection between eMMC and NAND is controlled:
    (a) By dynamically driving following GPIO pin from software
        SPI2_CS0(GPIO) == 0 NAND is selected (default)
        SPI2_CS0(GPIO) == 1 eMMC is selected
    (b) By statically using Jumper (J89) on the board

(2) As NAND device connnected to this board has page-size=4K and oob-size=224,
    So ROM code expects boot-loaders to be flashed in BCH16 ECC scheme for
    NAND boot.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 2e0c636..bd7ca86 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -98,6 +98,27 @@
 			0x264 (PIN_INPUT_PULLUP | MUX_MODE7)  /* spi2_d0.gpio3_22 */
 		>;
 	};
+
+	nand_flash_x8: nand_flash_x8 {
+		pinctrl-single,pins = <
+			0x26C(PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* spi2_cs0.gpio/eMMCorNANDsel */
+			0x0  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			0x4  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			0x8  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			0xc  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			0x10 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			0x14 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			0x18 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			0x1c (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			0x74 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
+			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+		>;
+	};
 };
 
 &i2c0 {
@@ -174,3 +195,89 @@
 	dr_mode = "host";
 	status = "okay";
 };
+
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_flash_x8>;
+	ranges = <0 0 0 0x01000000>;	/* CS0: min address-space configurable under GPMC chip-select = 16MB */
+	nand@0,0 {
+		reg = <0 0 0x380>; /* CS0, offset=0, GPMC register-space size=0x380 */
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <40>;
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <25>;
+		gpmc,adv-wr-off-ns = <25>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <20>;
+		gpmc,oe-on-ns = <3>;
+		gpmc,oe-off-ns = <30>;
+		gpmc,access-ns = <30>;
+		gpmc,rd-cycle-ns = <40>;
+		gpmc,wr-cycle-ns = <40>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		/* MTD partition table */
+		/* All SPL-* partitions are sized to minimal length
+		 * which can be independently programmable. For
+		 * NAND flash this is equal to size of erase-block */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "NAND.SPL";
+			reg = <0x00000000 0x00040000>;
+		};
+		partition@1 {
+			label = "NAND.SPL.backup1";
+			reg = <0x00040000 0x00040000>;
+		};
+		partition@2 {
+			label = "NAND.SPL.backup2";
+			reg = <0x00080000 0x00040000>;
+		};
+		partition@3 {
+			label = "NAND.SPL.backup3";
+			reg = <0x000c0000 0x00040000>;
+		};
+		partition@4 {
+			label = "NAND.u-boot-spl-os";
+			reg = <0x00100000 0x00080000>;
+		};
+		partition@5 {
+			label = "NAND.u-boot";
+			reg = <0x00180000 0x00100000>;
+		};
+		partition@6 {
+			label = "NAND.u-boot-env";
+			reg = <0x00280000 0x00040000>;
+		};
+		partition@7 {
+			label = "NAND.u-boot-env.backup1";
+			reg = <0x002c0000 0x00040000>;
+		};
+		partition@8 {
+			label = "NAND.kernel";
+			reg = <0x00300000 0x00700000>;
+		};
+		partition@9 {
+			label = "NAND.file-system";
+			reg = <0x00a00000 0x1f600000>;
+		};
+	};
+};
-- 
1.8.5.1.163.gd7aced9

