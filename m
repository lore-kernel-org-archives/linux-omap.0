From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 2/2] mtd: nand: omap: fix ecclayout to be in sync with
 u-boot NAND driver
Date: Fri, 13 Dec 2013 14:42:58 +0530
Message-ID: <1386925978-23705-3-git-send-email-pekon@ti.com>
References: <1386925978-23705-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1386925978-23705-1-git-send-email-pekon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>, Artem Bityutskiy <dedekind1@gmail.com>, Scott Wood <scottwood@freescale.com>, Tom Rini <trini@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Stefan Roese <sr@denx.de>, Michael Trimarchi <michael@amarulasolutions.com>, r-woodruff2@ti.com, avinashphilipk@gmail.com, jp.francois@cynove.com, Pekon Gupta <pekon@ti.com>, r.meier@siemens.com, balbi@ti.com, u-boot@lists.denx.de, Enric Balletbo Serra <eballetbo@iseebcn.com>, linux-mtd@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap <linux-omap@vger.kernel.org>, ivan.djelic@parrot.com, Nikita Kiryanov <nikita@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

This patch mainly fixes ecc-layout for following ecc-schemes, to bring them
in sync with u-boot omap_gpmc NAND driver:
 - BCH4_SW: OMAP_ECC_BCH4_CODE_HW_DETECTION_SW
      This ecc-scheme is mainly used on AM35xx and other legacy platforms.

 - BCH8_SW: OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
      This ecc-scheme is mainly used on OMAP3x and other legacy platforms.

Apart from above, this patch also touches other ecc-schemes as the fix
required refactoring common code, into ecc-scheme specific code.
Hence, end-to-end NAND boot sequence was tested on AM335x-EVM to avoid
any further regression on legacy or current platforms.

    (BCH8_HW)      (HAM1_HW)         (HAM1_HW)         (HAM1_HW)  (UBIFS)
ROM ---------> SPL ---------> U-Boot ---------> Kernel ---------> File-System

    (BCH8_HW)      (BCH8_SW)         (BCH8_SW)         (BCH8_SW)  (UBIFS)
ROM ---------> SPL ---------> U-Boot ---------> Kernel ---------> File-System

    (BCH8_HW)      (BCH8_HW)         (BCH8_HW)         (BCH8_HW)  (UBIFS)
ROM ---------> SPL ---------> U-Boot ---------> Kernel ---------> File-System

*Configurations used to build u-boot and kernel for end-to-end NAND boot*
+------------+--------------------------------------------+------------------+
| ecc-scheme |  u-boot/SPL configs                        | kernel DTS       |
+------------+--------------------------------------------+------------------+
|            |                                            |                  |
| HAM1_HW    | #define CONFIG_NAND_OMAP_ECCSCHEME     \   |ti,nand-ecc-opts= |
|            |         OMAP_ECC_HAM1_CODE_HW              |    "ham1"        |
| (1-bit     | #define CONFIG_SYS_NAND_ECCBYTES       3   |                  |
| Hamming    | #define CONFIG_SYS_NAND_ECCPOS \           |                  |
| using h/w) |      { 1, 2, 3, 4, 5, 6, 7, 8, 9, \        |                  |
|            |        10, 11, 12 }                        |                  |
|            | (for NAND page-size=2048)                  |                  |
|            |                                            |                  |
+------------+--------------------------------------------+------------------+
|            |                                            |                  |
| BCH8_SW    | #define CONFIG_NAND_OMAP_ECCSCHEME    \    |ti,nand-ecc-opts= |
|            |         OMAP_ECC_BCH8_CODE_HW_DETECTION_SW |    "bch8"        |
|(8-bit BCH  | #define CONFIG_SYS_NAND_ECCBYTES       13  |(without ELM node)|
| using s/w  | #define CONFIG_BCH                         |                  |
|library for | #undef CONFIG_SPL_NAND_AM33XX_BCH          |                  |
|for ECC     | #define CONFIG_SPL_NAND_SIMPLE             |                  |
| error      | #define CONFIG_SYS_NAND_ECCPOS \           |                  |
|correction) |     {2,  3,  4,  5,  6,  7,  8,  9, 10, \  |                  |
|            |     11, 12, 13, 14, \                      |                  |
|            |     16, 17, 18, 19, 20, 21, 22, 23, 24, \  |                  |
|            |     25, 26, 27, 28, \                      |                  |
|            |     30, 31, 32, 33, 34, 35, 36, 37, 38, \  |                  |
|            |     39, 40, 41, 42, \                      |                  |
|            |     44, 45, 46, 47, 48, 49, 50, 51, 52, \  |                  |
|            |     53, 54, 55, 56, }                      |                  |
|            | (for NAND page-size=2048)                  |                  |
|            | #define CONFIG_SYS_NAND_ECCSIZE       512  |                  |
|            |                                            |                  |
+------------+--------------------------------------------+------------------+
|            |                                            |                  |
| BCH8_HW    | #define CONFIG_NAND_OMAP_ECCSCHEME    \    |ti,nand-ecc-opts= |
|            |         OMAP_ECC_BCH8_CODE_HW              |    "bch8"        |
|(8-bit BCH  | #define CONFIG_SYS_NAND_ECCBYTES       14  |                  |
| using ELM  | #define CONFIG_SPL_NAND_AM33XX_BCH         |(with ELM node)   |
| h/w engine | #define CONFIG_SYS_NAND_ECCPOS  \          |ti,elm-id=<&elm>  |
|for ECC     |       {2,  3,  4,  5,  6,  7,  8,  9, \    |                  |
| error      |       10, 11, 12, 13, 14, 15, 16, 17, \    |                  |
|correction) |       18, 19, 20, 21, 22, 23, 24, 25, \    |                  |
|            |       26, 27, 28, 29, 30, 31, 32, 33, \    |                  |
|            |       34, 35, 36, 37, 38, 39, 40, 41, \    |                  |
|            |       42, 43, 44, 45, 46, 47, 48, 49, \    |                  |
|            |       50, 51, 52, 53, 54, 55, 56, 57, }    |                  |
|            | (for NAND page-size=2048)                  |                  |
|            | #define CONFIG_SYS_NAND_ECCSIZE       512  |                  |
|            |                                            |                  |
+------------+--------------------------------------------+------------------+

Test1: flash ubi image from u-boot and boot the kernel
   U-boot> mw 0x82000000 0xff <u-boot.img size aligned to NAND block boundary>
   U-boot> fatload mmc 0 0x82000000 u-boot.img
   U-boot> nand erase <u-boot_offset> <u-boot.img size>
   U-boot> nand write 0x82000000  <u-boot_offset> <u-boot.img size>
   U-boot> setenv bootargs 'console=ttyO0,115200n8 noinitrd mem=256M \
                root=ubi0 rw rootfstype=ubifs ubi.mtd=<mtdpart-of-rootfs>,\
                <page-size> ip=off init=/init'
   U-boot> bootm <kernel_offset>

Test2: update u-boot.img from kernel and re-boot
   Kernel> flash_erase /dev/<mtdpart-of-u-boot>  0 0
   Kernel> nandwrite -s 0  /dev/<mtdpart-of-u-boot>   u-boot.img
   Kernel> reboot

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index bbdb5e8..e7836bf 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1633,6 +1633,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	int				i;
 	dma_cap_mask_t			mask;
 	unsigned			sig;
+	unsigned			oob_index;
 	struct resource			*res;
 	struct mtd_part_parser_data	ppdata = {};
 
@@ -1832,9 +1833,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 							(mtd->writesize /
 							nand_chip->ecc.size);
 		if (nand_chip->options & NAND_BUSWIDTH_16)
-			ecclayout->eccpos[0]	= BADBLOCK_MARKER_LENGTH;
+			oob_index		= BADBLOCK_MARKER_LENGTH;
 		else
-			ecclayout->eccpos[0]	= 1;
+			oob_index		= 1;
+		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
+			ecclayout->eccpos[i]	= oob_index;
 		break;
 
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
@@ -1851,7 +1854,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
 							nand_chip->ecc.size);
-		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		oob_index			= BADBLOCK_MARKER_LENGTH;
+		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
+			if ((i % nand_chip->ecc.bytes) || (i == 0))
+				ecclayout->eccpos[i] = oob_index;
+			else
+				ecclayout->eccpos[i] = ++oob_index;
+		}
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd,
 							nand_chip->ecc.size,
@@ -1885,7 +1894,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
 							nand_chip->ecc.size);
-		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		oob_index			= BADBLOCK_MARKER_LENGTH;
+		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
+			ecclayout->eccpos[i]	= oob_index;
 		/* This ECC scheme requires ELM H/W block */
 		if (is_elm_present(info, pdata->elm_of_node, BCH4_ECC) < 0) {
 			pr_err("nand: error: could not initialize ELM\n");
@@ -1913,7 +1924,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
 							nand_chip->ecc.size);
-		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		oob_index			= BADBLOCK_MARKER_LENGTH;
+		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
+			if ((i % nand_chip->ecc.bytes) || (i == 0))
+				ecclayout->eccpos[i] = oob_index;
+			else
+				ecclayout->eccpos[i] = ++oob_index;
+		}
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd,
 							nand_chip->ecc.size,
@@ -1954,7 +1971,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
 							nand_chip->ecc.size);
-		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		oob_index			= BADBLOCK_MARKER_LENGTH;
+		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
+			ecclayout->eccpos[i]	= oob_index;
 		break;
 #else
 		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
@@ -1968,8 +1987,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
-	for (i = 1; i < ecclayout->eccbytes; i++)
-		ecclayout->eccpos[i] = ecclayout->eccpos[0] + i;
 	/* check if NAND device's OOB is enough to store ECC signatures */
 	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
 		pr_err("not enough OOB bytes required = %d, available=%d\n",
-- 
1.8.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
