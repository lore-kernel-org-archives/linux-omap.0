From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH] ARM: dts: dra7-evm: add parallel NOR flash support
Date: Wed, 23 Jul 2014 16:28:50 +0530
Message-ID: <1406113130-23939-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36536 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaGWK7X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jul 2014 06:59:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Pekon Gupta <pekon@ti.com>

This patch adds support for parallel NOR device (S29GL512S10) present on J6-EVM.
The Flash device is connected to GPMC controller on chip-select[0] and accessed
as memory-mapped device. It has data-witdh=x16, capacity-64MBytes(512Mbits) and
is CFI compatible.
As multiple devices are share GPMC pins on this board, so following board
settings are required to detect NOR device:
     SW5.1 (NAND_BOOTn) = OFF (logic-1)
     SW5.2 (NOR_BOOTn)  = ON  (logic-0) /* Active-low */
     SW5.3 (eMMC_BOOTn) = OFF (logic-1)
     SW5.4 (QSPI_BOOTn) = OFF (logic-1)

Also to maintain NAND Boot functionality, following setting are kept as default
- NAND status="enabled"
- NOR status="disabled"

Signed-off-by: Pekon Gupta <pekon@ti.com>
---

/* Flash read/write access tested after enabling NOR sub-node in DT */
   linux#> flash_erase /dev/mtd9 0 0
   linux#> dd if=/dev/urandom of=/tmp/source.hex  bs=1c count=2048
   linux#> mtd_debug write /dev/mtd9 0x0 2048 /tmp/source.hex
   linux#> mtd_debug read  /dev/mtd9 0x0 2048 /tmp/destination.hex
   linux#> diff /tmp/source.hex  /tmp/destination.hex

 
 arch/arm/boot/dts/dra7-evm.dts | 141 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 4adc280..1ee9727 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -151,6 +151,66 @@
 			0xd0	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_be0n_cle */
 		>;
 	};
+
+	nor_flash_x16: nor_flash_x16 {
+		/* On DRA7 EVM, NOR_BOOTn comes from DIP switch
+		 * So NOR flash requires following switch settings:
+		 * SW5.1 (NAND_BOOTn) = OFF (logic-1)
+		 * SW5.2 (NOR_BOOTn)  = ON  (logic-0) Active-low
+		 * SW5.3 (eMMC_BOOTn) = OFF (logic-1)
+		 * SW5.4 (QSPI_BOOTn) = OFF (logic-1)
+		 */
+		pinctrl-single,pins = <
+			0x00	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0  */
+			0x04	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1  */
+			0x08	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2  */
+			0x0c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3  */
+			0x10	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4  */
+			0x14	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5  */
+			0x18	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6  */
+			0x1c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7  */
+			0x20	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad8  */
+			0x24	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad9  */
+			0x28	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad10 */
+			0x2c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad11 */
+			0x30	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad12 */
+			0x34	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad13 */
+			0x38	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad14 */
+			0x3c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_ad15 */
+			0x40	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a0   */
+			0x44	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a1   */
+			0x48	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a2   */
+			0x4c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a3   */
+			0x50	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a4   */
+			0x54	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a5   */
+			0x58	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a6   */
+			0x5c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a7   */
+			0x60	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a8   */
+			0x64	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a9   */
+			0x68	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a10  */
+			0x6c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a11  */
+			0x70	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a12  */
+			0x74	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a13  */
+			0x78	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a14  */
+			0x7c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a15  */
+			0x80	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a16  */
+			0x84	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a17  */
+			0x88	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a18  */
+			0x8c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a19  */
+			0x90	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a20  */
+			0x94	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a21  */
+			0x98	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a22  */
+			0x9c	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a23  */
+			0xa0	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a24  */
+			0xa4	(PIN_INPUT  | MUX_MODE0)	/* gpmc_a25  */
+			0xd8	(PIN_INPUT  | MUX_MODE0)	/* gpmc_wait0    */
+			0xcc	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_wen      */
+			0xb4	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_csn0     */
+			0xc4	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_advn_ale */
+			0xc8	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_oen_ren	 */
+			0xd0	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_be0n_cle */
+		>;
+	};
 };
 
 &i2c1 {
@@ -417,8 +477,9 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x16>;
-	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
+	ranges = <0 0 0x08000000 0x04000000>;	/* address offset=128MB, range=512Mb=64MB */
 	nand@0,0 {
+		status = "okay";
 		reg = <0 0 4>;		/* device IO registers */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
@@ -494,4 +555,82 @@
 			reg = <0x00a00000 0x0f600000>;
 		};
 	};
+
+	nor@0,0 {
+		status = "disabled";
+		compatible = "cfi-flash";
+		reg = <0 0 0x04000000>;		/* device memory map = 64MB (actual capacity) */
+		/* generic bindings */
+		linux,mtd-name = "Spansion,S29GL512";
+		bank-width = <2>;
+		/* vendor specific bindings */
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <100>;
+		gpmc,cs-wr-off-ns = <100>;
+		gpmc,adv-on-ns = <10>;
+		gpmc,adv-rd-off-ns = <100>;
+		gpmc,adv-wr-off-ns = <100>;
+		gpmc,we-on-ns = <10>;
+		gpmc,we-off-ns = <100>;
+		gpmc,oe-on-ns = <10>;
+		gpmc,oe-off-ns = <100>;
+		gpmc,access-ns = <75>;
+		gpmc,rd-cycle-ns = <100>;
+		gpmc,wr-cycle-ns = <100>;
+		gpmc,page-burst-access-ns = <10>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,bus-turnaround-ns = <10>;
+		gpmc,cycle2cycle-delay-ns = <20>;
+		/* gpmc,clk-activation-ns = <0>; */
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <75>;
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

