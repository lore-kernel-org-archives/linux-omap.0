From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v7 1/6] mtd: nand: omap: combine different flavours of 1-bit
 hamming ecc schemes
Date: Sat, 5 Oct 2013 01:19:43 +0530
Message-ID: <1380916188-24206-2-git-send-email-pekon@ti.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1380916188-24206-1-git-send-email-pekon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: devicetree@vger.kernel.org, Pawel.Moll@arm.com, arnd@arndb.de, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, Pekon Gupta <pekon@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

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
---
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 8 ++++----
 arch/arm/mach-omap2/board-flash.c                   | 2 +-
 arch/arm/mach-omap2/gpmc.c                          | 4 +---
 drivers/mtd/nand/omap2.c                            | 9 +++------
 include/linux/platform_data/mtd-nand-omap2.h        | 6 +-----
 5 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index df338cb..25ee232 100644
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
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9f4795a..1c45b72 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1342,9 +1342,7 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 #ifdef CONFIG_MTD_NAND
 
 static const char * const nand_ecc_opts[] = {
-	[OMAP_ECC_HAMMING_CODE_DEFAULT]		= "sw",
-	[OMAP_ECC_HAMMING_CODE_HW]		= "hw",
-	[OMAP_ECC_HAMMING_CODE_HW_ROMCODE]	= "hw-romcode",
+	[OMAP_ECC_HAM1_CODE_HW]			= "ham1",
 	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
 	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
 };
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
index 6bf9ef4..cb5a54a 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -23,11 +23,7 @@ enum nand_io {
 };
 
 enum omap_ecc {
-		/* 1-bit ecc: stored at end of spare area */
-	OMAP_ECC_HAMMING_CODE_DEFAULT = 0, /* Default, s/w method */
-	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
-		/* 1-bit ecc: stored at beginning of spare area as romcode */
-	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
+	OMAP_ECC_HAM1_CODE_HW = 0, /* 1-bit Hamming ecc code */
 	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
 	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
 };
-- 
1.8.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
