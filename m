From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 4/4] mtd: nand: omap: add support for BCH16_ECC - NAND driver updates
Date: Thu, 18 Jul 2013 01:22:06 +0530
Message-ID: <1374090726-9393-5-git-send-email-pekon@ti.com>
References: <1374090726-9393-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55998 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218Ab3GQTyf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 15:54:35 -0400
In-Reply-To: <1374090726-9393-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, Pekon Gupta <pekon@ti.com>

With increase in NAND flash densities occurence of bit-flips has increased.
Thus stronger ECC schemes are required for detecting and correcting multiple
simultaneous bit-flips in same NAND page. But stronger ECC schemes have large
ECC syndrome which require more space in OOB/Spare.
This patch add support for BCH16_ECC:
(a) BCH16_ECC can correct 16 bit-flips per 512Bytes of data.
(b) BCH16_ECC generates 26-bytes of ECC syndrome / 512B.

Due to (b) this scheme can only be used with NAND devices which have enough
OOB to satisfy following equation:
OOBsize per page >= 26 * (page-size / 512)

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 104 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index c2c3c6bb..a0cf487 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -130,9 +130,13 @@
 #define BADBLOCK_MARKER_LENGTH		0x2
 
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
-static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
-	0xac, 0x6b, 0xff, 0x99, 0x7b};
-static u_char bch4_vector[] = {0x00, 0x6b, 0x31, 0xdd, 0x41, 0xbc, 0x10};
+static u_char bch4_vector[]  = {0x00, 0x6b, 0x31, 0xdd, 0x41, 0xbc, 0x10};
+static u_char bch8_vector[]  = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
+				0xac, 0x6b, 0xff, 0x99, 0x7b};
+static u_char bch16_vector[] = {0xf5, 0x24, 0x1c, 0xd0, 0x61, 0xb3, 0xf1, 0x55,
+				0x2e, 0x2c, 0x86, 0xa3, 0xed, 0x36, 0x1b, 0x78,
+				0x48, 0x76, 0xa9, 0x3b, 0x97, 0xd1, 0x7a, 0x93,
+				0x07, 0x0e};
 #endif
 static u8  bch4_polynomial[] = {0x28, 0x13, 0xcc, 0x39, 0x96, 0xac, 0x7f};
 static u8  bch8_polynomial[] = {0xef, 0x51, 0x2e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
@@ -1066,6 +1070,19 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 			eccsize1 = 28; /* OOB bits in nibbles per sector */
 		}
 		break;
+	case OMAP_ECC_BCH16_CODE_HW:
+		ecc_algo = 0x1;
+		bch_type = 0x2;
+		if (mode == GPMC_ECC_READ) {
+			bch_wrapmode = 0x01;
+			eccsize0 = 52; /* ECC bits in nibbles per sector */
+			eccsize1 = 0;  /* non-ECC bits in nibbles per sector */
+		} else if (mode == GPMC_ECC_WRITE) {
+			bch_wrapmode = 0x01;
+			eccsize0 = 0;  /* extra bits in nibbles per sector */
+			eccsize1 = 52; /* OOB bits in nibbles per sector */
+		}
+		break;
 	default:
 		pr_err("selected ECC scheme not supported or not enabled\n");
 	}
@@ -1159,6 +1176,41 @@ static int omap_calculate_ecc_bch(struct mtd_info *mtd, const u_char *dat,
 			*(ecc_ptr++) = ((val >>  8) & 0xFF);
 			*(ecc_ptr++) = ((val >>  0) & 0xFF);
 			break;
+		case OMAP_ECC_BCH16_CODE_HW:
+			val = readl(gpmc_regs->gpmc_bch_result6[i]);
+			*(ecc_ptr++) = ((val >>  8) & 0xFF);
+			*(ecc_ptr++) = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result5[i]);
+			*(ecc_ptr++) = ((val >> 24) & 0xFF);
+			*(ecc_ptr++) = ((val >> 16) & 0xFF);
+			*(ecc_ptr++) = ((val >>  8) & 0xFF);
+			*(ecc_ptr++) = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result4[i]);
+			*(ecc_ptr++) = ((val >> 24) & 0xFF);
+			*(ecc_ptr++) = ((val >> 16) & 0xFF);
+			*(ecc_ptr++) = ((val >>  8) & 0xFF);
+			*(ecc_ptr++) = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result3[i]);
+			*(ecc_ptr++) = ((val >> 24) & 0xFF);
+			*(ecc_ptr++) = ((val >> 16) & 0xFF);
+			*(ecc_ptr++) = ((val >>  8) & 0xFF);
+			*(ecc_ptr++) = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result2[i]);
+			*(ecc_ptr++) = ((val >> 24) & 0xFF);
+			*(ecc_ptr++) = ((val >> 16) & 0xFF);
+			*(ecc_ptr++) = ((val >>  8) & 0xFF);
+			*(ecc_ptr++) = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result1[i]);
+			*(ecc_ptr++) = ((val >> 24) & 0xFF);
+			*(ecc_ptr++) = ((val >> 16) & 0xFF);
+			*(ecc_ptr++) = ((val >>  8) & 0xFF);
+			*(ecc_ptr++) = ((val >>  0) & 0xFF);
+			val = readl(gpmc_regs->gpmc_bch_result0[i]);
+			*(ecc_ptr++) = ((val >> 24) & 0xFF);
+			*(ecc_ptr++) = ((val >> 16) & 0xFF);
+			*(ecc_ptr++) = ((val >>  8) & 0xFF);
+			*(ecc_ptr++) = ((val >>  0) & 0xFF);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1184,6 +1236,8 @@ static int omap_calculate_ecc_bch(struct mtd_info *mtd, const u_char *dat,
 		case OMAP_ECC_BCH8_CODE_HW:
 			*(ecc_ptr++) = 0x00;
 			break;
+		case OMAP_ECC_BCH16_CODE_HW:
+			break;
 		}
 		/* update pointer to next sector */
 		ecc_calc += eccbytes;
@@ -1225,7 +1279,6 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 
 	/* Initialize elm error vector to zero */
 	memset(err_vec, 0, sizeof(err_vec));
-
 	for (i = 0; i < eccsteps ; i++) {
 		flag_read_ecc = 0;
 		ecc = calc_ecc + (i * eccbytes);
@@ -1239,12 +1292,16 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 		/* check if its a erased-page */
 		if (flag_read_ecc) {
 			switch (ecc_opt) {
+			case OMAP_ECC_BCH4_CODE_HW:
+				if (memcmp(ecc, bch4_vector, eccbytes))
+					err_vec[i].error_reported = true;
+				break;
 			case OMAP_ECC_BCH8_CODE_HW:
 				if (memcmp(ecc, bch8_vector, eccbytes))
 					err_vec[i].error_reported = true;
 				break;
-			case OMAP_ECC_BCH4_CODE_HW:
-				if (memcmp(ecc, bch4_vector, eccbytes))
+			case OMAP_ECC_BCH16_CODE_HW:
+				if (memcmp(ecc, bch16_vector, eccbytes))
 					err_vec[i].error_reported = true;
 				break;
 			default:
@@ -1282,6 +1339,10 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 							(eccbytes - 1);
 					pos = err_vec[i].error_loc[j];
 					break;
+				case OMAP_ECC_BCH16_CODE_HW:
+					error_max = SECTOR_BYTES + eccbytes;
+					pos = err_vec[i].error_loc[j];
+					break;
 				default:
 					return -EINVAL;
 				}
@@ -1757,6 +1818,33 @@ static int omap_nand_probe(struct platform_device *pdev)
 						omap_oobinfo.eccbytes;
 		goto custom_ecc_layout;
 #endif
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	case OMAP_ECC_BCH16_CODE_HW:
+		pr_info("using OMAP_ECC_BCH16_CODE_HW ECC scheme\n");
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		/* 14th bit is kept reserved for ROM-code compatibility */
+		chip->ecc.bytes		= 26;
+		chip->ecc.strength	= 16;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= omap_elm_correct_data;
+		chip->ecc.calculate	= omap_calculate_ecc_bch;
+		chip->ecc.read_page	= omap_read_page_bch;
+		chip->ecc.write_page	= omap_write_page_bch;
+		/* ELM H/W engine is used for locating errors */
+		if (is_elm_present(info, BCH16_ECC) < 0) {
+			pr_err("ELM module not detected, required for ECC\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
+		/* define custom ECC layout */
+		omap_oobinfo.eccbytes	= chip->ecc.bytes *
+					   (mtd->writesize / chip->ecc.size);
+		omap_oobinfo.eccpos[0]	= BADBLOCK_MARKER_LENGTH;
+		omap_oobinfo.oobfree->offset = omap_oobinfo.eccpos[0] +
+						omap_oobinfo.eccbytes;
+		goto custom_ecc_layout;
+#endif
 	default:
 		pr_err("%s: selected ECC scheme not supported or not enabled",
 				DRIVER_NAME);
@@ -1777,8 +1865,8 @@ custom_ecc_layout:
 	/* check if NAND OOBSIZE meets ECC scheme requirement */
 	if (mtd->oobsize < (omap_oobinfo.eccbytes +
 					BADBLOCK_MARKER_LENGTH)) {
-		pr_err("not enough OOB bytes required = %d, available=%d\n",
-		       mtd->oobsize, omap_oobinfo.eccbytes);
+		pr_err("%s: not enough OOB bytes available=%d, required=%d\n",
+			DRIVER_NAME, mtd->oobsize, omap_oobinfo.eccbytes);
 		err = -EINVAL;
 		goto out_release_mem_region;
 	}
-- 
1.8.1

