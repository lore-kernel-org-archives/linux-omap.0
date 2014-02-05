From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 5/5] ARM: dts: am43xx: add support for parallel NAND flash
Date: Wed, 5 Feb 2014 18:58:34 +0530
Message-ID: <1391606914-9947-6-git-send-email-pekon@ti.com>
References: <1391606914-9947-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56524 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaBEN3E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Feb 2014 08:29:04 -0500
In-Reply-To: <1391606914-9947-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

This patch:
 - enables GPMC h/w and ELM h/w engine for AM43xx devices (am4372.dtsi)
 - adds pinmux and DT node for Micron 4K-paged x8 NAND device (MT29F4G08AB)
   present on following boards:

   am43x-epos-evm:
	On this board, NAND Flash control lines are muxed with QSPI, Thus only
        one of the two can be used at a time. Selection is controlled by:
        (a) dynamically driving following GPIO pin from software
            GPMC_A0(GPIO) == 0 NAND is selected (default)
            GPMC_A0(GPIO) == 1 eMMC is selected

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi        |  24 ++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 107 +++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c6bd4d9..489a4ab 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -689,6 +689,30 @@
 			       <&edma 11>;
 			dma-names = "tx", "rx";
 		};
+
+		elm: elm@48080000 {
+			compatible = "ti,am3352-elm";
+			reg = <0x48080000 0x2000>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "elm";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
+			status = "disabled";
+		};
+
+		gpmc: gpmc@50000000 {
+			compatible = "ti,am3352-gpmc";
+			ti,hwmods = "gpmc";
+			clocks = <&l3s_gclk>;
+			clock-names = "fck";
+			reg = <0x50000000 0x2000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			gpmc,num-cs = <7>;
+			gpmc,num-waitpins = <2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index fbf9c4c..15aa708 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -79,6 +79,27 @@
 				0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 			>;
 		};
+
+		nand_flash_x8: nand_flash_x8 {
+			pinctrl-single,pins = <
+				0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a0.SELQSPIorNAND/GPIO */
+				0x0  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+				0x4  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+				0x8  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+				0xc  (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+				0x10 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+				0x14 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+				0x18 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+				0x1c (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+				0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+				0x74 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
+				0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+				0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+				0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+				0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+				0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -184,3 +205,89 @@
 &gpio3 {
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
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <40>; /* tCEA + tCHZ + 1 */
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-on-ns = <0>;  /* cs-on-ns */
+		gpmc,adv-rd-off-ns = <25>; /* min( tALH + tALS + 1) */
+		gpmc,adv-wr-off-ns = <25>; /* min( tALH + tALS + 1) */
+		gpmc,we-on-ns = <0>;   /* cs-on-ns */
+		gpmc,we-off-ns = <20>; /* we-on-time + tWP + 2 */
+		gpmc,oe-on-ns = <3>;  /* cs-on-ns + tRR + 2 */
+		gpmc,oe-off-ns = <30>; /* oe-on-ns + tRP + 2 */
+		gpmc,access-ns = <30>; /* tCEA + 4*/
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
+			reg = <0x000C0000 0x00040000>;
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
+			reg = <0x002C0000 0x00040000>;
+		};
+		partition@8 {
+			label = "NAND.kernel";
+			reg = <0x00300000 0x00700000>;
+		};
+		partition@9 {
+			label = "NAND.file-system";
+			reg = <0x00800000 0x1F600000>;
+		};
+	};
+};
-- 
1.8.5.1.163.gd7aced9

