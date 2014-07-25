From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v2 2/3] ARM: dts: am335x-bone: add support for beaglebone NOR cape
Date: Fri, 25 Jul 2014 16:04:03 +0530
Message-ID: <1406284444-16733-3-git-send-email-pekon@ti.com>
References: <1406284444-16733-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39047 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759996AbaGYKel (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jul 2014 06:34:41 -0400
In-Reply-To: <1406284444-16733-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Pekon Gupta <pekon@ti.com>

This patch adds support of NOR cape[1] for both Beaglebone (white) and
Beaglebone(Black) boards. NOR Flash on this cape is connected to GPMC
chip-select[0] and accesses as external memory-mapped device.
This cape has 128Mbits(16MBytes), x16, CFI compatible NOR Flash device.

As GPMC chip-select[0] can be shared by multiple capes, so NAND cape pin-mux
is kept by default.

[1] http://boardzoo.com/index.php/beaglebone/bone-128mb-16-bit-nor.html
    http://boardzoo.com/index.php/beaglebone/bone-mem-exp.html
Note: These capes have been tested on Beaglebone-Black so these capes work
      perfectly on BBB, as against the information provided on above links.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-bone-memory-cape.dts | 118 +++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-memory-cape.dts b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
index 08efed3..0283549 100644
--- a/arch/arm/boot/dts/am335x-bone-memory-cape.dts
+++ b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
@@ -38,11 +38,48 @@
 			0x9c (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
+
+	bbcape_nor_flash_pins: bbcape_nor_flash_pins {
+		pinctrl-single,pins = <
+			0x00 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad0.gpmc_ad0 */
+			0x04 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad1.gpmc_ad1 */
+			0x08 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad2.gpmc_ad2 */
+			0x0c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad3.gpmc_ad3 */
+			0x10 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad4.gpmc_ad4 */
+			0x14 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad5.gpmc_ad5 */
+			0x18 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad6.gpmc_ad6 */
+			0x1c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad7.gpmc_ad7 */
+			0x20 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad8.gpmc_ad8 */
+			0x24 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad9.gpmc_ad9 */
+			0x28 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad10.gpmc_ad10 */
+			0x2c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad11.gpmc_ad11 */
+			0x30 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad12.gpmc_ad12 */
+			0x34 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad13.gpmc_ad13 */
+			0x38 (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad14.gpmc_ad14 */
+			0x3c (MUX_MODE0 | PIN_INPUT)	/* gpmc_ad15.gpmc_ad15 */
+			0x40 (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a0.gpmc_a0 */
+			0x44 (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a1.gpmc_a1 */
+			0x48 (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a2.gpmc_a2 */
+			0x4c (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a3.gpmc_a3 */
+			0x50 (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a4.gpmc_a4 */
+			0x54 (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a5.gpmc_a5 */
+			0x58 (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a6.gpmc_a6 */
+			0x5c (MUX_MODE0 | PIN_OUTPUT)	/* gpmc_a7.gpmc_a7 */
+			0x70 (MUX_MODE0 | PIN_INPUT_PULLUP )	/* gpmc_wait0.gpmc_wait0 */
+		/*	0x74 (MUX_MODE0 | PIN_OUTPUT_PULLUP) */	/* gpmc_wpn (not connected) */
+			0x7c (MUX_MODE0 | PIN_OUTPUT_PULLUP)	/* gpmc_csn0.gpmc_csn0  */
+			0x90 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_advn_ale.gpmc_advn_ale */
+			0x94 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_oen_ren.gpmc_oen_ren */
+			0x98 (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_wen.gpmc_wen */
+			0x9c (MUX_MODE0 | PIN_OUTPUT)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+		>;
+	};
 };
 
 
 &gpmc {
-	ranges = <0 0 0 0x01000000>;	/* address range = 16MB (minimum GPMC partition) */
+	ranges = <0 0 0x08000000 0x01000000>;	/* address offset=128MB, range=128Mb=16MB */
+	/* For NOR support below pin-mux should be changed to bbcape_nor_flash_pins */
 	pinctrl-names = "default";
 	pinctrl-0 = <&bbcape_nand_flash_pins>;
 	nand@0,0 {
@@ -124,4 +161,83 @@
 			reg = <0x00a00000 0x3f600000>;
 		};
 	};
+
+	nor@0,0 {
+		status = "disabled";
+		compatible = "cfi-flash";
+		reg = <0 0 0x01000000>;		/* device memory map = actual device size = 16MB */
+		/* generic bindings */
+		linux,mtd-name = "Micron,M29W128G";
+		bank-width = <2>;
+		/* vendor specific bindings */
+		gpmc,device-width = <2>;
+		gpmc,mux-add-data = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <120>;
+		gpmc,cs-wr-off-ns = <120>;
+		gpmc,adv-on-ns = <10>;
+		gpmc,adv-rd-off-ns = <40>;
+		gpmc,adv-wr-off-ns = <40>;
+		gpmc,we-on-ns = <50>;
+		gpmc,we-off-ns = <120>;
+		gpmc,oe-on-ns = <50>;
+		gpmc,oe-off-ns = <120>;
+		gpmc,access-ns = <100>;
+		gpmc,rd-cycle-ns = <120>;
+		gpmc,wr-cycle-ns = <120>;
+		gpmc,page-burst-access-ns = <0>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,num-waitpins = <4>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <20>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <80>;
+		gpmc,wr-data-mux-bus-ns = <100>;
+		/* MTD partition table */
+		/* All SPL-* partitions are sized to minimal length
+		 * which can be independently programmable */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0x00000000 {
+			label = "NOR.SPL";
+			reg = <0x00000000 0x00040000>;
+		};
+		partition@0x00040000 {
+			label = "NOR.SPL.backup1";
+			reg = <0x00040000 0x00040000>;
+		};
+		partition@0x00080000 {
+			label = "NOR.SPL.backup2";
+			reg = <0x00080000 0x00040000>;
+		};
+		partition@0x000c0000 {
+			label = "NOR.SPL.backup3";
+			reg = <0x000c0000 0x00040000>;
+		};
+		partition@0x00100000 {
+			label = "NOR.u-boot-spl-os";
+			reg = <0x00100000 0x00080000>;
+		};
+		partition@0x00180000 {
+			label = "NOR.u-boot";
+			reg = <0x00180000 0x00100000>;
+		};
+		partition@0x00280000 {
+			label = "NOR.u-boot-env";
+			reg = <0x00280000 0x00040000>;
+		};
+		partition@0x002c0000 {
+			label = "NOR.u-boot-env.backup1";
+			reg = <0x002c0000 0x00040000>;
+		};
+		partition@0x00300000 {
+			label = "NOR.kernel";
+			reg = <0x00300000 0x00700000>;
+		};
+		partition@0x00a00000 {
+			label = "NOR.file-system";
+			reg = <0x00a00000 0x00600000>;
+		};
+	};
 };
-- 
1.8.5.1.163.gd7aced9

