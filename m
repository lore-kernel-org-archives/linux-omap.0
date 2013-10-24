From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v11 02/10] mtd: nand: omap: combine different flavours of 1-bit hamming ecc schemes
Date: Thu, 24 Oct 2013 18:20:18 +0530
Message-ID: <1382619026-4182-3-git-send-email-pekon@ti.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55731 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753Ab3JXMvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 08:51:37 -0400
In-Reply-To: <1382619026-4182-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

OMAP NAND driver currently supports multiple flavours of 1-bit Hamming
ecc-scheme, like:
- OMAP_ECC_HAMMING_CODE_DEFAULT
	1-bit hamming ecc code using software library
- OMAP_ECC_HAMMING_CODE_HW
	1-bit hamming ecc-code using GPMC h/w engine
- OMAP_ECC_HAMMING_CODE_HW_ROMCODE
	1-bit hamming ecc-code using GPMC h/w engin with ecc-layout compatible
	to ROM code.

This patch combines above multiple ecc-schemes into single implementation:
- OMAP_ECC_HAM1_CODE_HW
	1-bit hamming ecc-code using GPMC h/w engine with ROM-code compatible
	ecc-layout.

Signed-off-by: Pekon Gupta <pekon@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 8 ++++----
 arch/arm/mach-omap2/board-flash.c                   | 2 +-
 drivers/mtd/nand/omap2.c                            | 9 +++------
 include/linux/platform_data/mtd-nand-omap2.h        | 7 +------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index bfe07e1..5e1f31b 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -22,10 +22,10 @@ Optional properties:
 				width of 8 is assumed.
 
  - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
-
-		"sw"		Software method (default)
-		"hw"		Hardware method
-		"hw-romcode"	gpmc hamming mode method & romcode layout
+		"sw"		<deprecated> use "ham1" instead
+		"hw"		<deprecated> use "ham1" instead
+		"hw-romcode"	<deprecated> use "ham1" instead
+		"ham1"		1-bit Hamming ecc code
 		"bch4"		4-bit BCH ecc code
 		"bch8"		8-bit BCH ecc code
 
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index fc20a61..ac82512 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -142,7 +142,7 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs,
 	board_nand_data.nr_parts	= nr_parts;
 	board_nand_data.devsize		= nand_type;
 
-	board_nand_data.ecc_opt = OMAP_ECC_HAMMING_CODE_DEFAULT;
+	board_nand_data.ecc_opt = OMAP_ECC_BCH8_CODE_HW;
 	gpmc_nand_init(&board_nand_data, gpmc_t);
 }
 #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 4ecf0e5..8d521aa 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1993,10 +1993,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* select the ecc type */
-	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_DEFAULT)
-		info->nand.ecc.mode = NAND_ECC_SOFT;
-	else if ((pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW) ||
-		(pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW_ROMCODE)) {
+	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
 		info->nand.ecc.bytes            = 3;
 		info->nand.ecc.size             = 512;
 		info->nand.ecc.strength         = 1;
@@ -2025,7 +2022,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* rom code layout */
-	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW_ROMCODE) {
+	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
 
 		if (info->nand.options & NAND_BUSWIDTH_16)
 			offset = 2;
@@ -2033,7 +2030,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 			offset = 1;
 			info->nand.badblock_pattern = &bb_descrip_flashbased;
 		}
-		omap_oobinfo.eccbytes = 3 * (info->mtd.oobsize/16);
+		omap_oobinfo.eccbytes = 3 * (info->mtd.writesize / 512);
 		for (i = 0; i < omap_oobinfo.eccbytes; i++)
 			omap_oobinfo.eccpos[i] = i+offset;
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index e4128f1..4da5bfa 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -23,13 +23,8 @@ enum nand_io {
 };
 
 enum omap_ecc {
-		/* 1-bit ecc: stored at end of spare area */
-	OMAP_ECC_HAMMING_CODE_DEFAULT = 0, /* Default, s/w method */
-	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
-		/* 1-bit ecc: stored at beginning of spare area as romcode */
-	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
 	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
-	OMAP_ECC_HAM1_CODE_HW,
+	OMAP_ECC_HAM1_CODE_HW = 0,
 	/* 4-bit  ECC calculation by GPMC, Error detection by Software */
 	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW,
 	/* 4-bit  ECC calculation by GPMC, Error detection by ELM */
-- 
1.8.1

