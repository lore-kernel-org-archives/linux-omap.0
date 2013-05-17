From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 2/4 v2] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Fri, 17 May 2013 17:20:16 +0530
Message-ID: <1368791418-14330-3-git-send-email-pekon@ti.com>
References: <1368791418-14330-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58640 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab3EQLvW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 07:51:22 -0400
In-Reply-To: <1368791418-14330-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: "Gupta, Pekon" <pekon@ti.com>, avinashphilip@ti.com, arnd@arndb.de, tony@atomide.com, balbi@ti.com, jp.francois@cynove.com

From: "Gupta, Pekon" <pekon@ti.com>

ECC scheme on NAND devices can be implemented in multiple ways.Some using
Software algorithm, while others using in-build Hardware engines.
omap2-nand driver currently supports following flavours of ECC schemes,
selectable via DTB.

+---------------------------------------+---------------+---------------+
| ECC scheme				|ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAMMING_CODE_DEFAULT		|S/W		|S/W		|
|OMAP_ECC_HAMMING_CODE_HW		|H/W (GPMC)	|S/W		|
|OMAP_ECC_HAMMING_CODE_HW_ROMCODE	|H/W (GPMC)	|S/W		|
+---------------------------------------+---------------+---------------+
|(requires CONFIG_MTD_NAND_ECC_BCH)	|		|		|
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W		|
+---------------------------------------+---------------+---------------+
|(requires CONFIG_MTD_NAND_OMAP_BCH)	|		|		|
|OMAP_ECC_BCH8_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
+---------------------------------------+---------------+---------------+

Selection of some ECC schemes also require enabling following Kconfig options.
This was done to optimize footprint of omap2-nand driver.
-Kconfig:CONFIG_MTD_NAND_ECC_BCH	enables S/W based BCH ECC algorithm
-Kconfig:CONFIG_MTD_NAND_OMAP_BCH	enables H/W based BCH ECC algorithm

Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          | 37 +++++++++++++++-------
 arch/arm/boot/dts/am335x-evm.dts                   |  2 +-
 arch/arm/mach-omap2/gpmc.c                         | 12 ++++---
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index e7f8d7e..de180be 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -17,20 +17,35 @@ Required properties:
 
 Optional properties:
 
- - nand-bus-width: 		Set this numeric value to 16 if the hardware
-				is wired that way. If not specified, a bus
-				width of 8 is assumed.
+ - nand-bus-width: 		Determines data-width of the connected device
+				x16 = "16"
+				x8  = "8" (default)
 
- - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
 
-		"sw"		Software method (default)
-		"hw"		Hardware method
-		"hw-romcode"	gpmc hamming mode method & romcode layout
-		"bch4"		4-bit BCH ecc code
-		"bch8"		8-bit BCH ecc code
+ - ti,nand-ecc-opt:		Determines the ECC scheme used by driver.
+				It can be any of the following strings:
+
+	"hamming_sw"          	1-bit Hamming ECC using software
+
+	"hamming_hw"          	1-bit Hamming ECC using hardware
+
+	"hamming_hw_romcode"  	1-bit Hamming ECC using hardware
+				- ECC layout compatible to ROM code
+
+	"bch8_hw_detection_sw" 	8-bit BCH with ECC calculation in hardware
+				and error detection in software
+				- requires Kconfig CONFIG_MTD_NAND_ECC_BCH
+
+	"bch8_hw"             	8-bit BCH with ECC calculation in hardware
+				and error detection in hardware
+				- requires <elm_id> to be specified
+				- requires Kconfig CONFIG_MTD_NAND_OMAP_BCH
+
+
+
+ - elm_id:			Specifies elm device node. This is required to
+				support some BCH ECC schemes mentioned above.
 
- - elm_id:	Specifies elm device node. This is required to support BCH
- 		error correction using ELM module.
 
 For inline partiton table parsing (optional):
 
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 0b8f161..60e8f59 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -135,7 +135,7 @@
 			nand@0,0 {
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
-				ti,nand-ecc-opt = "bch8";
+				ti,nand-ecc-opt = "bch8_hw";
 
 				gpmc,sync-clk = <0>;
 				gpmc,cs-on = <0>;
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 410e1ba..03b8027 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1205,11 +1205,13 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 #ifdef CONFIG_MTD_NAND
 
 static const char * const nand_ecc_opts[] = {
-	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
-	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
-	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-romcode",
-	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
-	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
+	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "hamming_sw",
+	[OMAP_ECC_HAMMING_CODE_HW]		= "hamming_hw",
+	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hamming_hw_romcode",
+	[OMAP_ECC_BCH4_CODE_HW]			= "bch4_hw",
+	[OMAP_ECC_BCH4_CODE_HW_DETECTION_SW]	= "bch4_hw_detection_sw",
+	[OMAP_ECC_BCH8_CODE_HW]			= "bch8_hw",
+	[OMAP_ECC_BCH8_CODE_HW_DETECTION_SW]	= "bch8_hw_detection_sw"
 };
 
 static int gpmc_probe_nand_child(struct platform_device *pdev,
-- 
1.8.1

