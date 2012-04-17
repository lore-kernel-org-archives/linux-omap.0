From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: [PATCH] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Tue, 17 Apr 2012 10:48:56 +0200
Message-ID: <1334652536-4442-1-git-send-email-ivan.djelic@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61484 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab2DQIty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 04:49:54 -0400
Received: by wibhq7 with SMTP id hq7so393894wib.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 01:49:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ivan.djelic@parrot.com, linux-mtd@lists.infradead.org

This patch adds a simple BCH ecc computation api, similar to the
existing Hamming ecc api. It is intended to be used by the MTD layer.
It implements the following features:

- support 4-bit and 8-bit ecc computation
- do not protect user bytes in spare area, only data area is protected
- ecc for an erased NAND page (0xFFs) is also a sequence of 0xFFs

This last feature is obtained by adding a constant polynomial to
the hardware computed ecc. It allows to correct bitflips in blank pages
and is extremely useful to support filesystems such as UBIFS, which expect
erased pages to contain only 0xFFs.

This api has been tested on an OMAP3630 board.

Signed-off-by: Ivan Djelic <ivan.djelic@parrot.com>
---
 arch/arm/mach-omap2/gpmc.c             |  148 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |   10 +++
 2 files changed, 158 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 00d5108..dc9a9a4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -49,6 +49,7 @@
 #define GPMC_ECC_CONTROL	0x1f8
 #define GPMC_ECC_SIZE_CONFIG	0x1fc
 #define GPMC_ECC1_RESULT        0x200
+#define GPMC_ECC_BCH_RESULT_0   0x240
 
 #define GPMC_CS0_OFFSET		0x60
 #define GPMC_CS_SIZE		0x30
@@ -920,3 +921,150 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpmc_calculate_ecc);
+
+#ifdef CONFIG_ARCH_OMAP3
+
+/**
+ * gpmc_enable_hwecc_bch - enable hardware BCH ecc functionality
+ * @cs: chip select number
+ * @mode: read/write mode
+ * @dev_width: device bus width(1 for x16, 0 for x8)
+ * @nsectors: how many 512-byte sectors to process
+ * @nerrors: how many errors to correct per sector (4 or 8)
+ */
+int gpmc_enable_hwecc_bch(int cs, int mode, int dev_width, int nsectors,
+			  int nerrors)
+{
+	unsigned int val;
+
+	/* check if ecc module is in use */
+	if (gpmc_ecc_used != -EINVAL)
+		return -EINVAL;
+
+	/*
+	 * FIXME: some OMAP3 revisions have a hardware bug which prevents
+	 * the 4-bit BCH mode to work properly. Such revisions should be
+	 * detected and rejected here.
+	 */
+
+	gpmc_ecc_used = cs;
+
+	/* clear ecc and enable bits */
+	gpmc_write_reg(GPMC_ECC_CONTROL, 0x101);
+
+	/*
+	 * When using BCH, sector size is hardcoded to 512 bytes.
+	 * Here we are using wrapping mode 6 both for reading and writing, with:
+	 *  size0 = 0  (no additional protected byte in spare area)
+	 *  size1 = 32 (skip 32 nibbles = 16 bytes per sector in spare area)
+	 */
+	gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, (32 << 22) | (0 << 12));
+
+	/* BCH configuration */
+	val = ((1                        << 16) | /* enable BCH */
+	       (((nerrors == 8) ? 1 : 0) << 12) | /* 8 or 4 bits */
+	       (0x06                     <<  8) | /* wrap mode = 6 */
+	       (dev_width                <<  7) | /* bus width */
+	       (((nsectors-1) & 0x7)     <<  4) | /* number of sectors */
+	       (cs                       <<  1) | /* ECC CS */
+	       (0x1));                            /* enable ECC */
+
+	gpmc_write_reg(GPMC_ECC_CONFIG, val);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpmc_enable_hwecc_bch);
+
+/**
+ * gpmc_calculate_ecc_bch4 - Generate 7 ecc bytes per sector of 512 data bytes
+ * @cs:  chip select number
+ * @dat: The pointer to data on which ecc is computed
+ * @ecc: The ecc output buffer
+ */
+int gpmc_calculate_ecc_bch4(int cs, const u_char *dat, u_char *ecc)
+{
+	int i;
+	unsigned long nsectors, reg, val1, val2;
+
+	if (gpmc_ecc_used != cs)
+		return -EINVAL;
+
+	nsectors = ((gpmc_read_reg(GPMC_ECC_CONFIG) >> 4) & 0x7) + 1;
+
+	for (i = 0; i < nsectors; i++) {
+
+		reg = GPMC_ECC_BCH_RESULT_0 + 16*i;
+
+		/* Read hw-computed remainder */
+		val1 = gpmc_read_reg(reg + 0);
+		val2 = gpmc_read_reg(reg + 4);
+
+		/*
+		 * Add constant polynomial to remainder, in order to get an ecc
+		 * sequence of 0xFFs for a buffer filled with 0xFFs; and
+		 * left-justify the resulting polynomial.
+		 */
+		*ecc++ = 0x28 ^ ((val2 >> 12) & 0xFF);
+		*ecc++ = 0x13 ^ ((val2 >>  4) & 0xFF);
+		*ecc++ = 0xcc ^ (((val2 & 0xF) << 4)|((val1 >> 28) & 0xF));
+		*ecc++ = 0x39 ^ ((val1 >> 20) & 0xFF);
+		*ecc++ = 0x96 ^ ((val1 >> 12) & 0xFF);
+		*ecc++ = 0xac ^ ((val1 >> 4) & 0xFF);
+		*ecc++ = 0x7f ^ ((val1 & 0xF) << 4);
+	}
+
+	gpmc_ecc_used = -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpmc_calculate_ecc_bch4);
+
+/**
+ * gpmc_calculate_ecc_bch8 - Generate 13 ecc bytes per block of 512 data bytes
+ * @cs:  chip select number
+ * @dat: The pointer to data on which ecc is computed
+ * @ecc: The ecc output buffer
+ */
+int gpmc_calculate_ecc_bch8(int cs, const u_char *dat, u_char *ecc)
+{
+	int i;
+	unsigned long nsectors, reg, val1, val2, val3, val4;
+
+	if (gpmc_ecc_used != cs)
+		return -EINVAL;
+
+	nsectors = ((gpmc_read_reg(GPMC_ECC_CONFIG) >> 4) & 0x7) + 1;
+
+	for (i = 0; i < nsectors; i++) {
+
+		reg = GPMC_ECC_BCH_RESULT_0 + 16*i;
+
+		/* Read hw-computed remainder */
+		val1 = gpmc_read_reg(reg + 0);
+		val2 = gpmc_read_reg(reg + 4);
+		val3 = gpmc_read_reg(reg + 8);
+		val4 = gpmc_read_reg(reg + 12);
+
+		/*
+		 * Add constant polynomial to remainder, in order to get an ecc
+		 * sequence of 0xFFs for a buffer filled with 0xFFs.
+		 */
+		*ecc++ = 0xef ^ (val4 & 0xFF);
+		*ecc++ = 0x51 ^ ((val3 >> 24) & 0xFF);
+		*ecc++ = 0x2e ^ ((val3 >> 16) & 0xFF);
+		*ecc++ = 0x09 ^ ((val3 >> 8) & 0xFF);
+		*ecc++ = 0xed ^ (val3 & 0xFF);
+		*ecc++ = 0x93 ^ ((val2 >> 24) & 0xFF);
+		*ecc++ = 0x9a ^ ((val2 >> 16) & 0xFF);
+		*ecc++ = 0xc2 ^ ((val2 >> 8) & 0xFF);
+		*ecc++ = 0x97 ^ (val2 & 0xFF);
+		*ecc++ = 0x79 ^ ((val1 >> 24) & 0xFF);
+		*ecc++ = 0xe5 ^ ((val1 >> 16) & 0xFF);
+		*ecc++ = 0x24 ^ ((val1 >> 8) & 0xFF);
+		*ecc++ = 0xb5 ^ (val1 & 0xFF);
+	}
+
+	gpmc_ecc_used = -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpmc_calculate_ecc_bch8);
+
+#endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 1527929..23791ca 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -92,6 +92,8 @@ enum omap_ecc {
 	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
 		/* 1-bit ecc: stored at beginning of spare area as romcode */
 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
+	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
+	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
 };
 
 /*
@@ -157,4 +159,12 @@ extern int gpmc_nand_write(int cs, int cmd, int wval);
 
 int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size);
 int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
+
+#ifdef CONFIG_ARCH_OMAP3
+int gpmc_enable_hwecc_bch(int cs, int mode, int dev_width, int nsectors,
+			  int nerrors);
+int gpmc_calculate_ecc_bch4(int cs, const u_char *dat, u_char *ecc);
+int gpmc_calculate_ecc_bch8(int cs, const u_char *dat, u_char *ecc);
+#endif /* CONFIG_ARCH_OMAP3 */
+
 #endif
-- 
1.7.10

