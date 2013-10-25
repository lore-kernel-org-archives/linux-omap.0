From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 1/5] ARM: am335x-bone: Add support for 16-bit NAND cape
Date: Fri, 25 Oct 2013 07:17:53 -0300
Message-ID: <1382696277-9063-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54084 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752548Ab3JYKSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 06:18:09 -0400
In-Reply-To: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, Felipe Balbi <balbi@ti.com>, marek.belisko@gmail.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

From: Pekon Gupta <pekon@ti.com>

Add GPMC timing configurations and NAND partitions for the Beaglebone
"NAND cape". Further information and datasheets of this cape can be found at:
- http://beagleboardtoys.info/index.php?title=BeagleBone_Memory_Expansion
- http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module

Signed-off-by: Pekon Gupta <pekon@ti.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
This patch is not really intended for inclusion. I'm just adding it
to the series for reference and in case anyone wants to test.

In particular, this patch includes two different GPMC configurations:
one at am335x-bone-common.dtsi, and another one at am335x-boneblack.dts,
overriding the first one. The former is Pekon's, while the latter is mine,
to support the flash device on my setup.

 arch/arm/boot/dts/am335x-bone-common.dtsi | 28 ++++++++++++
 arch/arm/boot/dts/am335x-bone.dts         | 75 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-boneblack.dts    | 69 ++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 2f66ded..73dcc58 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -107,6 +107,34 @@
 				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
 			>;
 		};
+
+		nandflash_pins_s0: nandflash_pins_s0 {
+			pinctrl-single,pins = <
+				0x0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+				0x4 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+				0x8 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+				0xc (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+				0x10 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+				0x14 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+				0x18 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+				0x1c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+				0x20 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad8.gpmc_ad8 */
+				0x24 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad9.gpmc_ad9 */
+				0x28 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad10.gpmc_ad10 */
+				0x2c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad11.gpmc_ad11 */
+				0x30 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad12.gpmc_ad12 */
+				0x34 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad13.gpmc_ad13 */
+				0x38 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad14.gpmc_ad14 */
+				0x3c (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad15.gpmc_ad15 */
+				0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+				0x74 (PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+				0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+				0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+				0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+				0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+				0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			>;
+		};
 	};
 
 	ocp {
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 7993c48..d9172c7 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -9,3 +9,78 @@
 
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
+
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins_s0>;
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <740>;
+		gpmc,cs-wr-off-ns = <740>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <740>;
+		gpmc,adv-wr-off-ns = <740>;
+		gpmc,we-on-ns = <90>;
+		gpmc,we-off-ns = <600>;
+		gpmc,oe-on-ns = <150>;
+		gpmc,oe-off-ns = <650>;
+		gpmc,access-ns = <560>;
+		gpmc,rd-cycle-ns = <740>;
+		gpmc,wr-cycle-ns = <740>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ti,elm-id = <&elm>;
+		/* MTD partition table */
+		partition@0 {
+			label = "SPL1";
+			reg = <0x00000000 0x000020000>;
+		};
+		partition@1 {
+			label = "SPL2";
+			reg = <0x00020000 0x00020000>;
+		};
+		partition@2 {
+			label = "SPL3";
+			reg = <0x00040000 0x00020000>;
+		};
+		partition@3 {
+			label = "SPL4";
+			reg = <0x00060000 0x00020000>;
+		};
+		partition@4 {
+			label = "U-boot";
+			reg = <0x00080000 0x001e0000>;
+		};
+		partition@5 {
+			label = "environment";
+			reg = <0x00260000 0x00020000>;
+		};
+		partition@6 {
+			label = "Kernel";
+			reg = <0x00280000 0x00500000>;
+		};
+		partition@7 {
+			label = "File-System";
+			reg = <0x00780000 0x0F880000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 197cadf..e30f58a 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -15,3 +15,72 @@
 	regulator-max-microvolt = <1800000>;
 	regulator-always-on;
 };
+
+&elm {
+	status = "okay";
+};
+
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins_s0>;
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	nand@0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ti,elm-id = <&elm>;
+		/* MTD partition table */
+		partition@0 {
+			label = "SPL1";
+			reg = <0x00000000 0x000020000>;
+		};
+		partition@1 {
+			label = "SPL2";
+			reg = <0x00020000 0x00020000>;
+		};
+		partition@2 {
+			label = "SPL3";
+			reg = <0x00040000 0x00020000>;
+		};
+		partition@3 {
+			label = "SPL4";
+			reg = <0x00060000 0x00020000>;
+		};
+		partition@4 {
+			label = "U-boot";
+			reg = <0x00080000 0x001e0000>;
+		};
+		partition@5 {
+			label = "environment";
+			reg = <0x00260000 0x00020000>;
+		};
+		partition@6 {
+			label = "Kernel";
+			reg = <0x00280000 0x00500000>;
+		};
+		partition@7 {
+			label = "File-System";
+			reg = <0x00780000 0x0F880000>;
+		};
+	};
+};
-- 
1.8.1.5

