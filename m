From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v3 2/4] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Sun, 23 Jun 2013 02:33:48 +0530
Message-ID: <1371935030-20773-3-git-send-email-pekon@ti.com>
References: <1371935030-20773-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43665 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab3FVVEv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Jun 2013 17:04:51 -0400
In-Reply-To: <1371935030-20773-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, b-cousson@ti.com
Cc: arnd@arndb.de, avinashphilip@ti.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, jp.francois@cynove.com, "Gupta, Pekon" <pekon@ti.com>

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

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          | 44 ++++++++++++++++------
 arch/arm/mach-omap2/gpmc.c                         | 14 ++++---
 include/linux/platform_data/mtd-nand-omap2.h       | 22 +++++++----
 3 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index 6a983c1..690070e 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -17,20 +17,42 @@ Required properties:
 
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
+	"hamming_code_sw"		1-bit Hamming ECC
+					- ECC calculation in software
+					- Error detection in software
+
+	"hamming_code_hw"		1-bit Hamming ECC
+					- ECC calculation in hardware
+					- Error detection in software
+
+	"hamming_code_hw_romcode"	1-bit Hamming ECC
+					- ECC calculation in hardware
+					- Error detection in software
+					- ECC layout compatible to ROM code
+
+	"bch8_hw_code_detection_sw"	8-bit BCH ECC
+					- ECC calculation in hardware
+					- Error detection in software
+					- depends on CONFIG_MTD_NAND_ECC_BCH
+
+	"bch8_code_hw"             	8-bit BCH ECC
+					- ECC calculation in hardware
+					- Error detection in hardware
+					- depends on CONFIG_MTD_NAND_OMAP_BCH
+					- requires <elm_id> to be specified
+
+
+ - elm_id:			Specifies elm device node. This is required to
+				support some BCH ECC schemes mentioned above.
 
- - elm_id:	Specifies elm device node. This is required to support BCH
- 		error correction using ELM module.
 
 For inline partiton table parsing (optional):
 
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 6c4da12..ae8bb70 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1338,11 +1338,13 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 #ifdef CONFIG_MTD_NAND
 
 static const char * const nand_ecc_opts[] = {
-	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
-	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
-	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-romcode",
-	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
-	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
+	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "hamming_code_sw",
+	[OMAP_ECC_HAMMING_CODE_HW]		= "hamming_code_hw",
+	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hamming_code_hw_romcode",
+	[OMAP_ECC_BCH4_CODE_HW]			= "bch4_code_hw",
+	[OMAP_ECC_BCH4_CODE_HW_DETECTION_SW]	= "bch4_code_hw_detection_sw",
+	[OMAP_ECC_BCH8_CODE_HW]			= "bch8_code_hw",
+	[OMAP_ECC_BCH8_CODE_HW_DETECTION_SW]	= "bch8_code_hw_detection_sw"
 };
 
 static int gpmc_probe_nand_child(struct platform_device *pdev,
@@ -1369,7 +1371,7 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 
 	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s))
 		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
-			if (!strcasecmp(s, nand_ecc_opts[val])) {
+			if (!strcmp(s, nand_ecc_opts[val])) {
 				gpmc_nand_data->ecc_opt = val;
 				break;
 			}
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 6bf9ef4..ce74576 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -23,13 +23,21 @@ enum nand_io {
 };
 
 enum omap_ecc {
-		/* 1-bit ecc: stored at end of spare area */
-	OMAP_ECC_HAMMING_CODE_DEFAULT = 0, /* Default, s/w method */
-	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
-		/* 1-bit ecc: stored at beginning of spare area as romcode */
-	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
-	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
-	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
+	/* 1-bit  ECC calculation by Software, Error detection by Software */
+	OMAP_ECC_HAMMING_CODE_DEFAULT = 0,
+	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_HAMMING_CODE_HW,
+	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
+	/* ECC layout compatible to legacy ROMCODE. */
+	OMAP_ECC_HAMMING_CODE_HW_ROMCODE,
+	/* 4-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH4_CODE_HW,
+	/* 4-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW,
+	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH8_CODE_HW,
+	/* 8-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
 };
 
 struct gpmc_nand_regs {
-- 
1.8.1

