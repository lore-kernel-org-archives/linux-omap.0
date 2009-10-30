From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 3/3] NAND: OMAP: Simplifying HWECC and removing
	unnecessary macros
Date: Fri, 30 Oct 2009 14:12:40 +0530
Message-ID: <ce9ab5790910300142k66a00c7ctebdbaa157ddd2ac1@mail.gmail.com>
References: <ce9ab5790910292321g4eba8becrf6dc81b071698059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53316 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500AbZJ3Imz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 04:42:55 -0400
Received: by mail-bw0-f227.google.com with SMTP id 27so3265936bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 01:43:00 -0700 (PDT)
In-Reply-To: <ce9ab5790910292321g4eba8becrf6dc81b071698059@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

Looping Linunx-omap mailing list.


From: Vimal Singh <vimalsingh@ti.com>
Date: Fri, 30 Oct 2009 11:33:34 +0530
Subject: [PATCH] NAND: OMAP: Simplifying HWECC and removing unnecessary macros

Removing number of macros from the top, which were being used
for generating ture ECC earlier. And simplifying the hwecc
correction methode. The idea is taken from:
<http://git.denx.de/?p=u-boot/u-boot-arm.git;a=blob;f=drivers/mtd/nand/omap_gpmc.c;h=99b9cef17c29ecf73ef3b844474a5b196f29eeff;hb=4bc3d2afb380e78fdbb9c501d9a8da6d59eb178e>

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 drivers/mtd/nand/omap2.c |  304 +++++++++++++++-------------------------------
 1 files changed, 100 insertions(+), 204 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index ecc4d32..595926b 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -40,73 +40,6 @@
 #define	GPMC_BUF_FULL	0x00000001
 #define	GPMC_BUF_EMPTY	0x00000000

-#define NAND_Ecc_P1e		(1 << 0)
-#define NAND_Ecc_P2e		(1 << 1)
-#define NAND_Ecc_P4e		(1 << 2)
-#define NAND_Ecc_P8e		(1 << 3)
-#define NAND_Ecc_P16e		(1 << 4)
-#define NAND_Ecc_P32e		(1 << 5)
-#define NAND_Ecc_P64e		(1 << 6)
-#define NAND_Ecc_P128e		(1 << 7)
-#define NAND_Ecc_P256e		(1 << 8)
-#define NAND_Ecc_P512e		(1 << 9)
-#define NAND_Ecc_P1024e		(1 << 10)
-#define NAND_Ecc_P2048e		(1 << 11)
-
-#define NAND_Ecc_P1o		(1 << 16)
-#define NAND_Ecc_P2o		(1 << 17)
-#define NAND_Ecc_P4o		(1 << 18)
-#define NAND_Ecc_P8o		(1 << 19)
-#define NAND_Ecc_P16o		(1 << 20)
-#define NAND_Ecc_P32o		(1 << 21)
-#define NAND_Ecc_P64o		(1 << 22)
-#define NAND_Ecc_P128o		(1 << 23)
-#define NAND_Ecc_P256o		(1 << 24)
-#define NAND_Ecc_P512o		(1 << 25)
-#define NAND_Ecc_P1024o		(1 << 26)
-#define NAND_Ecc_P2048o		(1 << 27)
-
-#define TF(value)	(value ? 1 : 0)
-
-#define P2048e(a)	(TF(a & NAND_Ecc_P2048e)	<< 0)
-#define P2048o(a)	(TF(a & NAND_Ecc_P2048o)	<< 1)
-#define P1e(a)		(TF(a & NAND_Ecc_P1e)		<< 2)
-#define P1o(a)		(TF(a & NAND_Ecc_P1o)		<< 3)
-#define P2e(a)		(TF(a & NAND_Ecc_P2e)		<< 4)
-#define P2o(a)		(TF(a & NAND_Ecc_P2o)		<< 5)
-#define P4e(a)		(TF(a & NAND_Ecc_P4e)		<< 6)
-#define P4o(a)		(TF(a & NAND_Ecc_P4o)		<< 7)
-
-#define P8e(a)		(TF(a & NAND_Ecc_P8e)		<< 0)
-#define P8o(a)		(TF(a & NAND_Ecc_P8o)		<< 1)
-#define P16e(a)		(TF(a & NAND_Ecc_P16e)		<< 2)
-#define P16o(a)		(TF(a & NAND_Ecc_P16o)		<< 3)
-#define P32e(a)		(TF(a & NAND_Ecc_P32e)		<< 4)
-#define P32o(a)		(TF(a & NAND_Ecc_P32o)		<< 5)
-#define P64e(a)		(TF(a & NAND_Ecc_P64e)		<< 6)
-#define P64o(a)		(TF(a & NAND_Ecc_P64o)		<< 7)
-
-#define P128e(a)	(TF(a & NAND_Ecc_P128e)		<< 0)
-#define P128o(a)	(TF(a & NAND_Ecc_P128o)		<< 1)
-#define P256e(a)	(TF(a & NAND_Ecc_P256e)		<< 2)
-#define P256o(a)	(TF(a & NAND_Ecc_P256o)		<< 3)
-#define P512e(a)	(TF(a & NAND_Ecc_P512e)		<< 4)
-#define P512o(a)	(TF(a & NAND_Ecc_P512o)		<< 5)
-#define P1024e(a)	(TF(a & NAND_Ecc_P1024e)	<< 6)
-#define P1024o(a)	(TF(a & NAND_Ecc_P1024o)	<< 7)
-
-#define P8e_s(a)	(TF(a & NAND_Ecc_P8e)		<< 0)
-#define P8o_s(a)	(TF(a & NAND_Ecc_P8o)		<< 1)
-#define P16e_s(a)	(TF(a & NAND_Ecc_P16e)		<< 2)
-#define P16o_s(a)	(TF(a & NAND_Ecc_P16o)		<< 3)
-#define P1e_s(a)	(TF(a & NAND_Ecc_P1e)		<< 4)
-#define P1o_s(a)	(TF(a & NAND_Ecc_P1o)		<< 5)
-#define P2e_s(a)	(TF(a & NAND_Ecc_P2e)		<< 6)
-#define P2o_s(a)	(TF(a & NAND_Ecc_P2o)		<< 7)
-
-#define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0)
-#define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1)
-
 #ifdef CONFIG_MTD_PARTITIONS
 static const char *part_probes[] = { "cmdlinepart", NULL };
 #endif
@@ -558,161 +491,124 @@ static void omap_hwecc_init(struct mtd_info *mtd)

 /**
  * gen_true_ecc - This function will generate true ECC value
- * @ecc_buf: buffer to store ecc code
+ * @ecc_buf:	buffer to store ecc code
+ * @return:	re-formatted ECC value
  *
- * This generated true ECC value can be used when correcting
- * data read from NAND flash memory core
+ * This function will generate true ECC value, which
+ * can be used when correcting data read from NAND flash memory core
  */
-static void gen_true_ecc(u8 *ecc_buf)
+static uint32_t gen_true_ecc(uint8_t *ecc_buf)
 {
-	u32 tmp = ecc_buf[0] | (ecc_buf[1] << 16) |
-		((ecc_buf[2] & 0xF0) << 20) | ((ecc_buf[2] & 0x0F) << 8);
-
-	ecc_buf[0] = ~(P64o(tmp) | P64e(tmp) | P32o(tmp) | P32e(tmp) |
-			P16o(tmp) | P16e(tmp) | P8o(tmp) | P8e(tmp));
-	ecc_buf[1] = ~(P1024o(tmp) | P1024e(tmp) | P512o(tmp) | P512e(tmp) |
-			P256o(tmp) | P256e(tmp) | P128o(tmp) | P128e(tmp));
-	ecc_buf[2] = ~(P4o(tmp) | P4e(tmp) | P2o(tmp) | P2e(tmp) | P1o(tmp) |
-			P1e(tmp) | P2048o(tmp) | P2048e(tmp));
+	return ecc_buf[0] | (ecc_buf[1] << 16) | ((ecc_buf[2] & 0xF0) << 20) |
+		((ecc_buf[2] & 0x0F) << 8);
 }

 /**
- * omap_compare_ecc - Detect (2 bits) and correct (1 bit) error in data
- * @ecc_data1:  ecc code from nand spare area
- * @ecc_data2:  ecc code from hardware register obtained from hardware ecc
- * @page_data:  page data
+ * omap_compare_ecc - Compares ECCs and corrects one bit error
+ * @mtd:		 MTD device structure
+ * @dat:		 page data
+ * @read_ecc:		 ecc read from nand flash
+ * @calc_ecc:		 ecc read from ECC registers
+ *
+ * @return 0 if data is OK or corrected, else returns -1
  *
- * This function compares two ECC's and indicates if there is an error.
- * If the error can be corrected it will be corrected to the buffer.
+ * Compares the ecc read from nand spare area with ECC registers values and
+ * corrects one bit error if it has occured. Further details can be had from
+ * OMAP TRM and the following selected links:
+ * http://en.wikipedia.org/wiki/Hamming_code
+ * http://www.cs.utexas.edu/users/plaxton/c/337/05f/slides/ErrorCorrection-4.pdf
  */
-static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
-			    u8 *ecc_data2,	/* read from register */
-			    u8 *page_data)
+static int omap_compare_ecc(u_char *read_ecc, u_char *calc_ecc, u_char *dat)
 {
-	uint	i;
-	u8	tmp0_bit[8], tmp1_bit[8], tmp2_bit[8];
-	u8	comp0_bit[8], comp1_bit[8], comp2_bit[8];
-	u8	ecc_bit[24];
-	u8	ecc_sum = 0;
-	u8	find_bit = 0;
-	uint	find_byte = 0;
-	int	isEccFF;
-
-	isEccFF = ((*(u32 *)ecc_data1 & 0xFFFFFF) == 0xFFFFFF);
-
-	gen_true_ecc(ecc_data1);
-	gen_true_ecc(ecc_data2);
-
-	for (i = 0; i <= 2; i++) {
-		*(ecc_data1 + i) = ~(*(ecc_data1 + i));
-		*(ecc_data2 + i) = ~(*(ecc_data2 + i));
-	}
-
-	for (i = 0; i < 8; i++) {
-		tmp0_bit[i]     = *ecc_data1 % 2;
-		*ecc_data1	= *ecc_data1 / 2;
-	}
-
-	for (i = 0; i < 8; i++) {
-		tmp1_bit[i]	 = *(ecc_data1 + 1) % 2;
-		*(ecc_data1 + 1) = *(ecc_data1 + 1) / 2;
-	}
-
-	for (i = 0; i < 8; i++) {
-		tmp2_bit[i]	 = *(ecc_data1 + 2) % 2;
-		*(ecc_data1 + 2) = *(ecc_data1 + 2) / 2;
-	}
-
-	for (i = 0; i < 8; i++) {
-		comp0_bit[i]     = *ecc_data2 % 2;
-		*ecc_data2       = *ecc_data2 / 2;
-	}
-
-	for (i = 0; i < 8; i++) {
-		comp1_bit[i]     = *(ecc_data2 + 1) % 2;
-		*(ecc_data2 + 1) = *(ecc_data2 + 1) / 2;
-	}
+	uint32_t orig_ecc, new_ecc, res, hm;
+	uint16_t parity_bits, byte;
+	uint8_t bit;
+
+	/* Regenerate the orginal ECC */
+	orig_ecc = gen_true_ecc(read_ecc);
+	new_ecc = gen_true_ecc(calc_ecc);
+	/* Get the XOR of real ecc */
+	res = orig_ecc ^ new_ecc;
+	if (res) {
+		/* Get the hamming width */
+		hm = hweight32(res);
+		/* Single bit errors can be corrected! */
+		if (hm == 12) {
+			/* Correctable data! */
+			parity_bits = res >> 16;
+			bit = (parity_bits & 0x7);
+			byte = (parity_bits >> 3) & 0x1FF;
+			/* Flip the bit to correct */
+			dat[byte] ^= (0x1 << bit);
+			return 1;
+		} else if (hm == 1) {
+			/* ECC itself is corrupted, no action needed */
+			return 1;
+		} else {
+			/*
+			 * hm distance != parity pairs OR one, could mean 2 bit
+			 * error OR potentially be on a blank page..
+			 * orig_ecc: contains spare area data from nand flash.
+			 * new_ecc: generated ecc while reading data area.
+			 * Note: if the ecc = 0, all data bits from which it was
+			 * generated are 0xFF.
+			 * The 3 byte(24 bits) ecc is generated per 512byte
+			 * chunk of a page. If orig_ecc(from spare area)
+			 * is 0xFF && new_ecc(computed now from data area)=0x0,
+			 * this means that data area is 0xFF and spare area is
+			 * 0xFF. A sure sign of a erased page!
+			 */
+			if ((orig_ecc == 0x0FFF0FFF) && (new_ecc == 0x00000000))
+				return 0;

-	for (i = 0; i < 8; i++) {
-		comp2_bit[i]     = *(ecc_data2 + 2) % 2;
-		*(ecc_data2 + 2) = *(ecc_data2 + 2) / 2;
+			/* detected 2 or more bit errors */
+			printk(KER_ERR"Error: Bad compare! failed\n");
+			return -1;
+		}
 	}
+	return 0;
+}

-	for (i = 0; i < 6; i++)
-		ecc_bit[i] = tmp2_bit[i + 2] ^ comp2_bit[i + 2];
-
-	for (i = 0; i < 8; i++)
-		ecc_bit[i + 6] = tmp0_bit[i] ^ comp0_bit[i];
-
-	for (i = 0; i < 8; i++)
-		ecc_bit[i + 14] = tmp1_bit[i] ^ comp1_bit[i];
-
-	ecc_bit[22] = tmp2_bit[0] ^ comp2_bit[0];
-	ecc_bit[23] = tmp2_bit[1] ^ comp2_bit[1];
-
-	for (i = 0; i < 24; i++)
-		ecc_sum += ecc_bit[i];
-
-	switch (ecc_sum) {
-	case 0:
-		/* Not reached because this function is not called if
-		 *  ECC values are equal
-		 */
-		return 0;
-
-	case 1:
-		/* Uncorrectable error */
-		DEBUG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR 1\n");
-		return -1;
-
-	case 11:
-		/* UN-Correctable error */
-		DEBUG(MTD_DEBUG_LEVEL0, "ECC UNCORRECTED_ERROR B\n");
-		return -1;
-
-	case 12:
-		/* Correctable error */
-		find_byte = (ecc_bit[23] << 8) +
-			    (ecc_bit[21] << 7) +
-			    (ecc_bit[19] << 6) +
-			    (ecc_bit[17] << 5) +
-			    (ecc_bit[15] << 4) +
-			    (ecc_bit[13] << 3) +
-			    (ecc_bit[11] << 2) +
-			    (ecc_bit[9]  << 1) +
-			    ecc_bit[7];
+/**
+ *  omap_calculate_ecc - Generate non-inverted ECC bytes.
+ *  @mtd:	MTD structure
+ *  @dat:	unused
+ *  @ecc_code:	ecc_code buffer
+ *
+ *  Using noninverted ECC can be considered ugly since writing a blank
+ *  page ie. padding will clear the ECC bytes. This is no problem as
+ *  long nobody is trying to write data on the seemingly unused page.
+ *  Reading an erased page will produce an ECC mismatch between
+ *  generated and read ECC bytes that has to be dealt with separately.
+ *  E.g. if page is 0xFF (fresh erased), and if HW ECC engine within GPMC
+ *  is used, the result of read will be 0x0 while the ECC offsets of the
+ *  spare area will be 0xFF which will result in an ECC mismatch.
+ */
+static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
+					u_char *ecc_code)
+{
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+							mtd);
+	unsigned long val = 0x0;
+	unsigned long reg;

-		find_bit = (ecc_bit[5] << 2) + (ecc_bit[3] << 1) + ecc_bit[1];
+	/* Start Reading from HW ECC1_Result = 0x200 */
+	reg = (unsigned long)(info->gpmc_baseaddr + GPMC_ECC1_RESULT);
+	val = __raw_readl(reg);

-		DEBUG(MTD_DEBUG_LEVEL0, "Correcting single bit ECC error at "
-				"offset: %d, bit: %d\n", find_byte, find_bit);
+	ecc_code[0] = val & 0xFF;
+	ecc_code[1] = (val >> 16) & 0xFF;
+	ecc_code[2] = ((val >> 8) & 0x0F) | ((val >> 20) & 0xF0);

-		page_data[find_byte] ^= (1 << find_bit);
+	/*
+	 * Stop reading anymore ECC vals and clear old results
+	 * enable will be called if more reads are required
+	 */
+	__raw_writel(0x100, info->gpmc_baseaddr + GPMC_ECC_CONTROL);

-		return 0;
-	default:
-		if (isEccFF) {
-			if (ecc_data2[0] == 0 &&
-			    ecc_data2[1] == 0 &&
-			    ecc_data2[2] == 0)
-				return 0;
-		}
-		DEBUG(MTD_DEBUG_LEVEL0, "UNCORRECTED_ERROR default\n");
-		return -1;
-	}
+	return 0;
 }

-/**
- * omap_correct_data - Compares the ECC read with HW generated ECC
- * @mtd: MTD device structure
- * @dat: page data
- * @read_ecc: ecc read from nand flash
- * @calc_ecc: ecc read from HW ECC registers
- *
- * Compares the ecc read from nand spare area with ECC registers values
- * and if ECC's mismached, it will call 'omap_compare_ecc' for error detection
- * and correction.
- */
 static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
 				u_char *read_ecc, u_char *calc_ecc)
 {
-- 
1.5.5
