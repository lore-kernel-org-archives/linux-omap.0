From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v4 3/6] ARM: dts: dra7: add support for parallel NAND flash
Date: Sat, 10 May 2014 02:16:49 +0530
Message-ID: <1399668412-10818-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757696AbaEIUrd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 16:47:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>, Pekon Gupta <pekon@ti.com>

From: Minal Shah <minalkshah@gmail.com>

DRA7xx platform has in-build GPMC and ELM h/w engines which can be used
for accessing externel NAND flash device. This patch:
- adds generic DT binding in dra7.dtsi for enabling GPMC and ELM h/w engines
- adds DT binding for Micron NAND Flash (MT29F2G16AADWP) present on dra7-evm
*Important*
	On DRA7 EVM, GPMC_WPN and NAND_BOOTn are controlled by DIP switch
	So following board settings are required for NAND device detection:
	SW5.9 (GPMC_WPN) = LOW
	SW5.1 (NAND_BOOTn) = HIGH

Signed-off-by: Minal Shah <minalkshah@gmail.com>
Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 117 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi    |  20 +++++++
 2 files changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5f1f6da..ed4e974 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -108,6 +108,37 @@
 			0xbc (PIN_INPUT_PULLUP | MUX_MODE1)  /* gpmc_cs3.qspi1_cs1 */
 		>;
 	};
+
+	nand_flash_x16: nand_flash_x16 {
+		/* On DRA7 EVM, GPMC_WPN and NAND_BOOTn comes from DIP switch
+		 * So NAND flash requires following switch settings:
+		 * SW5.9 (GPMC_WPN) = LOW
+		 * SW5.1 (NAND_BOOTn) = HIGH */
+		pinctrl-single,pins = <
+			0x0 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0	*/
+			0x4 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1	*/
+			0x8 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2	*/
+			0xc 	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3	*/
+			0x10	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4	*/
+			0x14	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5	*/
+			0x18	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6	*/
+			0x1c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7	*/
+			0x20	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad8	*/
+			0x24	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad9	*/
+			0x28	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad10	*/
+			0x2C	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad11	*/
+			0x30	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad12	*/
+			0x34	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad13	*/
+			0x38	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad14	*/
+			0x3C	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad15	*/
+			0xd8	(PIN_INPUT_PULLUP  | MUX_MODE0)	/* gpmc_wait0	*/
+			0xcc	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_wen	*/
+			0xb4	(PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_csn0	*/
+			0xc4	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_advn_ale */
+			0xc8	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_oen_ren	 */
+			0xd0	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_be0n_cle */
+		>;
+	};
 };
 
 &i2c1 {
@@ -353,3 +384,89 @@
 		};
 	};
 };
+
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_flash_x16>;
+	ranges = <0 0 0 0x1000000>;
+	nand@0,0 {
+		reg = <0 0 0x380>;
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <40>;
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <30>;
+		gpmc,adv-wr-off-ns = <30>;
+		gpmc,we-on-ns = <5>;
+		gpmc,we-off-ns = <25>;
+		gpmc,oe-on-ns = <2>;
+		gpmc,oe-off-ns = <20>;
+		gpmc,access-ns = <20>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,rd-cycle-ns = <40>;
+		gpmc,wr-cycle-ns = <40>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		/* MTD partition table */
+		/* All SPL-* partitions are sized to minimal length
+		 * which can be independently programmable. For
+		 * NAND flash this is equal to size of erase-block */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "NAND.SPL";
+			reg = <0x00000000 0x000020000>;
+		};
+		partition@1 {
+			label = "NAND.SPL.backup1";
+			reg = <0x00020000 0x00020000>;
+		};
+		partition@2 {
+			label = "NAND.SPL.backup2";
+			reg = <0x00040000 0x00020000>;
+		};
+		partition@3 {
+			label = "NAND.SPL.backup3";
+			reg = <0x00060000 0x00020000>;
+		};
+		partition@4 {
+			label = "NAND.u-boot-spl-os";
+			reg = <0x00080000 0x00040000>;
+		};
+		partition@5 {
+			label = "NAND.u-boot";
+			reg = <0x000c0000 0x00100000>;
+		};
+		partition@6 {
+			label = "NAND.u-boot-env";
+			reg = <0x001c0000 0x00020000>;
+		};
+		partition@7 {
+			label = "NAND.u-boot-env";
+			reg = <0x001e0000 0x00020000>;
+		};
+		partition@8 {
+			label = "NAND.kernel";
+			reg = <0x00200000 0x00800000>;
+		};
+		partition@9 {
+			label = "NAND.file-system";
+			reg = <0x00a00000 0x0f600000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 37a0595..6af775a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -776,6 +776,26 @@
 			interrupts = <0 343 0x4>;
 			status = "disabled";
 		};
+
+		elm: elm@48078000 {
+			compatible = "ti,am3352-elm";
+			reg = <0x48078000 0x2000>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "elm";
+			status = "disabled";
+		};
+
+		gpmc: gpmc@50000000 {
+			compatible = "ti,am3352-gpmc";
+			ti,hwmods = "gpmc";
+			reg = <0x50000000 0x2000>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.5.1.163.gd7aced9

