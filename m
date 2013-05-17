From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 4/4 v2] ARM: OMAP2+: updated ECC scheme attributes for omap2-nand DT
Date: Fri, 17 May 2013 17:20:18 +0530
Message-ID: <1368791418-14330-5-git-send-email-pekon@ti.com>
References: <1368791418-14330-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab3EQLvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 07:51:20 -0400
In-Reply-To: <1368791418-14330-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: "Gupta, Pekon" <pekon@ti.com>, avinashphilip@ti.com, arnd@arndb.de, tony@atomide.com, balbi@ti.com, jp.francois@cynove.com

From: "Gupta, Pekon" <pekon@ti.com>

Updates ECC scheme selection string same to same as used in omap2-driver code.
This makes the DT configurations easy to understand and map to actual code.

Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          | 47 ++++++++++++++--------
 arch/arm/boot/dts/am335x-evm.dts                   |  2 +-
 arch/arm/mach-omap2/gpmc.c                         | 19 +++++----
 3 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index de180be..c7a4add 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -25,22 +25,37 @@ Optional properties:
  - ti,nand-ecc-opt:		Determines the ECC scheme used by driver.
 				It can be any of the following strings:
 
-	"hamming_sw"          	1-bit Hamming ECC using software
-
-	"hamming_hw"          	1-bit Hamming ECC using hardware
-
-	"hamming_hw_romcode"  	1-bit Hamming ECC using hardware
-				- ECC layout compatible to ROM code
-
-	"bch8_hw_detection_sw" 	8-bit BCH with ECC calculation in hardware
-				and error detection in software
-				- requires Kconfig CONFIG_MTD_NAND_ECC_BCH
-
-	"bch8_hw"             	8-bit BCH with ECC calculation in hardware
-				and error detection in hardware
-				- requires <elm_id> to be specified
-				- requires Kconfig CONFIG_MTD_NAND_OMAP_BCH
-
+				"OMAP_ECC_HAMMING_CODE_SW"
+					1-bit Hamming ECC using software.
+
+				"OMAP_ECC_HAMMING_CODE_HW"
+					1-bit Hamming ECC using hardware.
+
+				"OMAP_ECC_HAMMING_CODE_HW_ROMCODE"
+					1-bit Hamming ECC using hardware with
+					ECC layout compatible to ROM code.
+
+				"OMAP_ECC_BCH4_CODE_HW_DETECTION_SW"
+					4-bit BCH with ECC calculation in
+					hardware & error detection in software.
+					- requires CONFIG_MTD_NAND_ECC_BCH
+
+				"OMAP_ECC_BCH4_CODE_HW"
+					4-bit BCH with ECC calculation in
+					hardware & error detection in hardware.
+					- requires CONFIG_MTD_NAND_OMAP_BCH
+					- requires <elm_id> to be specified
+
+				"OMAP_ECC_BCH8_CODE_HW_DETECTION_SW"
+					8-bit BCH with ECC calculation in
+					hardware & error detection in software.
+					- requires CONFIG_MTD_NAND_ECC_BCH
+
+				"OMAP_ECC_BCH8_CODE_HW"
+					8-bit BCH with ECC calculation in
+					hardware & error detection in hardware.
+					- requires CONFIG_MTD_NAND_OMAP_BCH
+					- requires <elm_id> to be specified
 
 
  - elm_id:			Specifies elm device node. This is required to
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 60e8f59..1107761 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -135,7 +135,7 @@
 			nand@0,0 {
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
-				ti,nand-ecc-opt = "bch8_hw";
+				ti,nand-ecc-opt = "OMAP_ECC_BCH8_CODE_HW";
 
 				gpmc,sync-clk = <0>;
 				gpmc,cs-on = <0>;
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 03b8027..e3146c3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1205,13 +1205,16 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 #ifdef CONFIG_MTD_NAND
 
 static const char * const nand_ecc_opts[] = {
-	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "hamming_sw",
-	[OMAP_ECC_HAMMING_CODE_HW]		= "hamming_hw",
-	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hamming_hw_romcode",
-	[OMAP_ECC_BCH4_CODE_HW]			= "bch4_hw",
-	[OMAP_ECC_BCH4_CODE_HW_DETECTION_SW]	= "bch4_hw_detection_sw",
-	[OMAP_ECC_BCH8_CODE_HW]			= "bch8_hw",
-	[OMAP_ECC_BCH8_CODE_HW_DETECTION_SW]	= "bch8_hw_detection_sw"
+	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "OMAP_ECC_HAMMING_CODE_SW",
+	[OMAP_ECC_HAMMING_CODE_HW]		= "OMAP_ECC_HAMMING_CODE_HW",
+	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	=
+					"OMAP_ECC_HAMMING_CODE_HW_ROMCODE",
+	[OMAP_ECC_BCH4_CODE_HW_DETECTION_SW]	=
+					"OMAP_ECC_BCH4_CODE_HW_DETECTION_SW",
+	[OMAP_ECC_BCH4_CODE_HW]			= "OMAP_ECC_BCH4_CODE_HW",
+	[OMAP_ECC_BCH8_CODE_HW_DETECTION_SW]	=
+					"OMAP_ECC_BCH8_CODE_HW_DETECTION_SW",
+	[OMAP_ECC_BCH8_CODE_HW]			= "OMAP_ECC_BCH8_CODE_HW"
 };
 
 static int gpmc_probe_nand_child(struct platform_device *pdev,
@@ -1238,7 +1241,7 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 
 	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s))
 		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
-			if (!strcasecmp(s, nand_ecc_opts[val])) {
+			if (!strcmp(s, nand_ecc_opts[val])) {
 				gpmc_nand_data->ecc_opt = val;
 				break;
 			}
-- 
1.8.1

