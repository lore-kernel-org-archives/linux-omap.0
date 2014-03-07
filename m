From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v2 3/4] mtd: nand: omap: add support for BCH16_ECC - NAND driver updates
Date: Fri, 7 Mar 2014 18:54:52 +0530
Message-ID: <1394198693-8003-4-git-send-email-pekon@ti.com>
References: <1394198693-8003-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59834 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbaCGN0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Mar 2014 08:26:31 -0500
In-Reply-To: <1394198693-8003-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Jon Cormier <jcormier@criticallink.com>, Daniel Mack <zonque@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

This patch add support for BCH16 ecc-scheme in OMAP NAND driver, by extending
following functions:
 - omap_enable_hwecc (nand_chip->ecc.hwctl): configure GPMC controller
 - omap_calculate_ecc_bch (nand_chip->ecc.calculate): fetch ECC signature from GPMC controller
 - omap_elm_correct_data (nand_chip->ecc.correct): detect and correct ECC errors using ELM

(a) BCH16 ecc-scheme can detect and correct 16 bit-flips per 512Bytes of data.
(b) BCH16 ecc-scheme generates 26-bytes of ECC syndrome / 512B.
Due to (b) this scheme can only be used with NAND devices which have enough
OOB to satisfy the relation: "OOBsize per page >= 26 * (page-size / 512)"

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 369aee7..dd48b94 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1110,6 +1110,19 @@ static void __maybe_unused omap_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 			ecc_size1 = BCH_ECC_SIZE1;
 		}
 		break;
+	case OMAP_ECC_BCH16_CODE_HW:
+		bch_type = 0x2;
+		nsectors = chip->ecc.steps;
+		if (mode == NAND_ECC_READ) {
+			wr_mode	  = 0x01;
+			ecc_size0 = 52; /* ECC bits in nibbles per sector */
+			ecc_size1 = 0;  /* non-ECC bits in nibbles per sector */
+		} else {
+			wr_mode	  = 0x01;
+			ecc_size0 = 0;  /* extra bits in nibbles per sector */
+			ecc_size1 = 52; /* OOB bits in nibbles per sector */
+		}
+		break;
 	default:
 		return;
 	}
@@ -1158,6 +1171,7 @@ static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
 	struct gpmc_nand_regs	*gpmc_regs = &info->reg;
 	u8 *ecc_code;
 	unsigned long nsectors, bch_val1, bch_val2, bch_val3, bch_val4;
+	u32 val;
 	int i;
 
 	nsectors = ((readl(info->reg.gpmc_ecc_config) >> 4) & 0x7) + 1;
@@ -1197,6 +1211,41 @@ static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
 			*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
 			*ecc_code++ = ((bch_val1 & 0xF) << 4);
 			break;
+		case OMAP_ECC_BCH16_CODE_HW:
+			val = readl(gpmc_regs->gpmc_bch_result6[i]);
+			ecc_code[0]  = ((val >>  8) & 0xFF);
+			ecc_code[1]  = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result5[i]);
+			ecc_code[2]  = ((val >> 24) & 0xFF);
+			ecc_code[3]  = ((val >> 16) & 0xFF);
+			ecc_code[4]  = ((val >>  8) & 0xFF);
+			ecc_code[5]  = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result4[i]);
+			ecc_code[6]  = ((val >> 24) & 0xFF);
+			ecc_code[7]  = ((val >> 16) & 0xFF);
+			ecc_code[8]  = ((val >>  8) & 0xFF);
+			ecc_code[9]  = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result3[i]);
+			ecc_code[10] = ((val >> 24) & 0xFF);
+			ecc_code[11] = ((val >> 16) & 0xFF);
+			ecc_code[12] = ((val >>  8) & 0xFF);
+			ecc_code[13] = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result2[i]);
+			ecc_code[14] = ((val >> 24) & 0xFF);
+			ecc_code[15] = ((val >> 16) & 0xFF);
+			ecc_code[16] = ((val >>  8) & 0xFF);
+			ecc_code[17] = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result1[i]);
+			ecc_code[18] = ((val >> 24) & 0xFF);
+			ecc_code[19] = ((val >> 16) & 0xFF);
+			ecc_code[20] = ((val >>  8) & 0xFF);
+			ecc_code[21] = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result0[i]);
+			ecc_code[22] = ((val >> 24) & 0xFF);
+			ecc_code[23] = ((val >> 16) & 0xFF);
+			ecc_code[24] = ((val >>  8) & 0xFF);
+			ecc_code[25] = ((val >>  0) & 0xFF);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1223,6 +1272,8 @@ static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
 			/* Set 14th ECC byte as 0x0 for ROM compatibility */
 			ecc_calc[eccbytes - 1] = 0x0;
 			break;
+		case OMAP_ECC_BCH16_CODE_HW:
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1296,6 +1347,9 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 		/* omit 14th ECC byte reserved for ROM code compatibility */
 		actual_eccbytes = ecc->bytes - 1;
 		break;
+	case OMAP_ECC_BCH16_CODE_HW:
+		actual_eccbytes = ecc->bytes;
+		break;
 	default:
 		pr_err("invalid driver configuration\n");
 		return -EINVAL;
@@ -1408,6 +1462,7 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 						BCH4_BIT_PAD;
 					break;
 				case OMAP_ECC_BCH8_CODE_HW:
+				case OMAP_ECC_BCH16_CODE_HW:
 					pos = err_vec[i].error_loc[j];
 					break;
 				default:
@@ -1935,6 +1990,40 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 #endif
 
+	case OMAP_ECC_BCH16_CODE_HW:
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+		pr_info("using OMAP_ECC_BCH16_CODE_HW ECC scheme\n");
+		nand_chip->ecc.mode		= NAND_ECC_HW;
+		nand_chip->ecc.size		= 512;
+		nand_chip->ecc.bytes		= 26;
+		nand_chip->ecc.strength		= 16;
+		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
+		nand_chip->ecc.correct		= omap_elm_correct_data;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
+		nand_chip->ecc.read_page	= omap_read_page_bch;
+		nand_chip->ecc.write_page	= omap_write_page_bch;
+		/* This ECC scheme requires ELM H/W block */
+		err = is_elm_present(info, pdata->elm_of_node, BCH16_ECC);
+		if (err < 0) {
+			pr_err("ELM is required for this ECC scheme\n");
+			goto return_error;
+		}
+		/* define ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		oob_index			= BADBLOCK_MARKER_LENGTH;
+		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
+			ecclayout->eccpos[i]	= oob_index;
+		/* reserved marker already included in ecclayout->eccbytes */
+		ecclayout->oobfree->offset	=
+				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		break;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
+		err = -EINVAL;
+		goto return_error;
+#endif
 	default:
 		pr_err("nand: error: invalid or unsupported ECC scheme\n");
 		err = -EINVAL;
-- 
1.8.5.1.163.gd7aced9

