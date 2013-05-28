From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH v4,3/3] ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm
Date: Tue, 28 May 2013 17:11:25 +0530
Message-ID: <1369741285-1967-4-git-send-email-pekon@ti.com>
References: <1369741285-1967-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38367 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878Ab3E1Ll5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 May 2013 07:41:57 -0400
In-Reply-To: <1369741285-1967-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Philip Avinash <avinashphilip@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, hvaibhav@ti.com, "Gupta, Pekon" <pekon@ti.com>

From: Philip Avinash <avinashphilip@ti.com>

NAND flash connected in am335x-evm on GPMC controller. This patch adds
device tree node in am3355-evm with GPMC contoller timing for NAND flash
interface, NAND partition table, ECC scheme, elm handle id.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 105 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 0423298..7d2be9c 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -44,6 +44,26 @@
 				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
 			>;
 		};
+
+		nandflash_pins_s0: nandflash_pins_s0 {
+			pinctrl-single,pins = <
+				0x0 0x30	/* gpmc_ad0.gpmc_ad0, INPUT | PULLUP | MODE0 */
+				0x4 0x30	/* gpmc_ad1.gpmc_ad1, INPUT | PULLUP | MODE0 */
+				0x8 0x30	/* gpmc_ad2.gpmc_ad2, INPUT | PULLUP | MODE0 */
+				0xc 0x30	/* gpmc_ad3.gpmc_ad3, INPUT | PULLUP | MODE0 */
+				0x10 0x30	/* gpmc_ad4.gpmc_ad4, INPUT | PULLUP | MODE0 */
+				0x14 0x30	/* gpmc_ad5.gpmc_ad5, INPUT | PULLUP | MODE0 */
+				0x18 0x30	/* gpmc_ad6.gpmc_ad6, INPUT | PULLUP | MODE0 */
+				0x1c 0x30	/* gpmc_ad7.gpmc_ad7, INPUT | PULLUP | MODE0 */
+				0x70 0x30	/* gpmc_wait0.gpmc_wait0, INPUT | PULLUP | MODE0 */
+				0x74 0x37	/* gpmc_wpn.gpio0_30, INPUT | PULLUP | MODE7 */
+				0x7c 0x8	/* gpmc_csn0.gpmc_csn0,  PULL DISA */
+				0x90 0x8	/* gpmc_advn_ale.gpmc_advn_ale, PULL DISA */
+				0x94 0x8	/* gpmc_oen_ren.gpmc_oen_ren, PULL DISA */
+				0x98 0x8	/* gpmc_wen.gpmc_wen, PULL DISA */
+				0x9c 0x8	/* gpmc_be0n_cle.gpmc_be0n_cle, PULL DISA */
+			>;
+		};
 	};
 
 	ocp {
@@ -102,6 +122,91 @@
 				reg = <0x48>;
 			};
 		};
+
+		elm: elm@48080000 {
+			status = "okay";
+		};
+
+		gpmc: gpmc@50000000 {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&nandflash_pins_s0>;
+			ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+			nand@0,0 {
+				reg = <0 0 0>; /* CS0, offset 0 */
+				nand-bus-width = <8>;
+				ti,nand-ecc-opt = "bch8";
+				gpmc,device-nand = "true";
+				gpmc,device-width = <1>;
+				gpmc,sync-clk-ps = <0>;
+				gpmc,cs-on-ns = <0>;
+				gpmc,cs-rd-off-ns = <44>;
+				gpmc,cs-wr-off-ns = <44>;
+				gpmc,adv-on-ns = <6>;
+				gpmc,adv-rd-off-ns = <34>;
+				gpmc,adv-wr-off-ns = <44>;
+				gpmc,we-on-ns = <0>;
+				gpmc,we-off-ns = <40>;
+				gpmc,oe-on-ns = <0>;
+				gpmc,oe-off-ns = <54>;
+				gpmc,access-ns = <64>;
+				gpmc,rd-cycle-ns = <82>;
+				gpmc,wr-cycle-ns = <82>;
+				gpmc,wait-on-read = "true";
+				gpmc,wait-on-write = "true";
+				gpmc,bus-turnaround-ns = <0>;
+				gpmc,cycle2cycle-delay-ns = <0>;
+				gpmc,clk-activation-ns = <0>;
+				gpmc,wait-monitoring-ns = <0>;
+				gpmc,wr-access-ns = <40>;
+				gpmc,wr-data-mux-bus-ns = <0>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				elm_id = <&elm>;
+
+				/* MTD partition table */
+				partition@0 {
+					label = "SPL1";
+					reg = <0x00000000 0x000020000>;
+				};
+
+				partition@1 {
+					label = "SPL2";
+					reg = <0x00020000 0x00020000>;
+				};
+
+				partition@2 {
+					label = "SPL3";
+					reg = <0x00040000 0x00020000>;
+				};
+
+				partition@3 {
+					label = "SPL4";
+					reg = <0x00060000 0x00020000>;
+				};
+
+				partition@4 {
+					label = "U-boot";
+					reg = <0x00080000 0x001e0000>;
+				};
+
+				partition@5 {
+					label = "environment";
+					reg = <0x00260000 0x00020000>;
+				};
+
+				partition@6 {
+					label = "Kernel";
+					reg = <0x00280000 0x00500000>;
+				};
+
+				partition@7 {
+					label = "File-System";
+					reg = <0x00780000 0x0F880000>;
+				};
+			};
+		};
 	};
 
 	vbat: fixedregulator@0 {
-- 
1.8.1

