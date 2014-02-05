From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 2/5] ARM: dts: am335x-evm: NAND: update MTD partition table
Date: Wed, 5 Feb 2014 18:58:31 +0530
Message-ID: <1391606914-9947-3-git-send-email-pekon@ti.com>
References: <1391606914-9947-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33057 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaBEN2n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Feb 2014 08:28:43 -0500
In-Reply-To: <1391606914-9947-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

This patch has following updates, specific to MTD/NAND DT
 - update MTD NAND partition table to keep compatibility between
   different boards and mainline u-boot.
 - prefix 'NAND.' in names of NAND device MTD partitions to differentiate them
   from other MTD device partitions (like NOR and QSPI)
               Partition_Name            Partition_Size
    /dev/mtd0  NAND.SPL                  1 block-size*
    /dev/mtd1  NAND.SPL.backup1          1 block-size*
    /dev/mtd2  NAND.SPL.backup2          1 block-size*
    /dev/mtd3  NAND.SPL.backup3          1 block-size*
    /dev/mtd5  NAND.u-boot-spl-os        2 block-size* [for falcon boot]
    /dev/mtd4  NAND.u-boot               1 MB
    /dev/mtd6  NAND.u-boot-env           1 block-size*
    /dev/mtd7  NAND.u-boot-env.backup1   1 block-size*
    /dev/mtd8  NAND.kernel               till 0xA00000
    /dev/mtd9  NAND.file-system          till end of device

* am335x-evm uses NAND device with block-size=128KiB

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 48 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7e6c64e..17c3cc0 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -460,50 +460,52 @@
 		gpmc,wait-monitoring-ns = <0>;
 		gpmc,wr-access-ns = <40>;
 		gpmc,wr-data-mux-bus-ns = <0>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
 		elm_id = <&elm>;
-
 		/* MTD partition table */
+		/* All SPL-* partitions are sized to minimal length
+		 * which can be independently programmable. For
+		 * NAND flash this is equal to size of erase-block */
+		#address-cells = <1>;
+		#size-cells = <1>;
 		partition@0 {
-			label = "SPL1";
+			label = "NAND.SPL";
 			reg = <0x00000000 0x000020000>;
 		};
-
 		partition@1 {
-			label = "SPL2";
+			label = "NAND.SPL.backup1";
 			reg = <0x00020000 0x00020000>;
 		};
-
 		partition@2 {
-			label = "SPL3";
+			label = "NAND.SPL.backup2";
 			reg = <0x00040000 0x00020000>;
 		};
-
 		partition@3 {
-			label = "SPL4";
+			label = "NAND.SPL.backup3";
 			reg = <0x00060000 0x00020000>;
 		};
-
 		partition@4 {
-			label = "U-boot";
-			reg = <0x00080000 0x001e0000>;
+			label = "NAND.u-boot-spl";
+			reg = <0x00080000 0x00040000>;
 		};
-
 		partition@5 {
-			label = "environment";
-			reg = <0x00260000 0x00020000>;
+			label = "NAND.u-boot";
+			reg = <0x000C0000 0x00100000>;
 		};
-
 		partition@6 {
-			label = "Kernel";
-			reg = <0x00280000 0x00500000>;
+			label = "NAND.u-boot-env";
+			reg = <0x001C0000 0x00020000>;
 		};
-
 		partition@7 {
-			label = "File-System";
-			reg = <0x00780000 0x0F880000>;
+			label = "NAND.u-boot-env.backup1";
+			reg = <0x001E0000 0x00020000>;
+		};
+		partition@8 {
+			label = "NAND.kernel";
+			reg = <0x00200000 0x00800000>;
+		};
+		partition@9 {
+			label = "NAND.file-system";
+			reg = <0x00A00000 0x0F600000>;
 		};
 	};
 };
-- 
1.8.5.1.163.gd7aced9

