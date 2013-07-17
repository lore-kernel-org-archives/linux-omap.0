From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 1/4] mtd: nand: omap: add support for BCH16_ECC - DT updates
Date: Thu, 18 Jul 2013 01:22:03 +0530
Message-ID: <1374090726-9393-2-git-send-email-pekon@ti.com>
References: <1374090726-9393-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38177 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab3GQTy0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 15:54:26 -0400
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
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 7 +++++++
 include/linux/platform_data/mtd-nand-omap2.h        | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index d307c67..017d818 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -66,6 +66,13 @@ Optional properties:
 					* depends on CONFIG_MTD_NAND_OMAP_BCH
 					* requires <elm_id> to be specified
 
+	"bch16_code_hw"             	16-bit BCH ECC
+					- ECC calculation in hardware
+					- Error detection in hardware
+					- ECC layout compatible with ROM code
+					* depends on CONFIG_MTD_NAND_OMAP_BCH
+					* requires <elm_id> to be specified
+
 
  - elm_id:			Specifies elm device node. This is required to
 				support some BCH ECC schemes mentioned above.
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 9fcee61..50a6413 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -37,7 +37,9 @@ enum omap_ecc {
 	/* 8-bit  ECC calculation by GPMC, Error detection by Software */
 	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW,
 	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
-	OMAP_ECC_BCH8_CODE_HW
+	OMAP_ECC_BCH8_CODE_HW,
+	/* 16-bit ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH16_CODE_HW
 };
 
 struct gpmc_nand_regs {
@@ -57,6 +59,9 @@ struct gpmc_nand_regs {
 	void __iomem	*gpmc_bch_result1[GPMC_BCH_NUM_REMAINDER];
 	void __iomem	*gpmc_bch_result2[GPMC_BCH_NUM_REMAINDER];
 	void __iomem	*gpmc_bch_result3[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result4[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
 };
 
 struct omap_nand_platform_data {
-- 
1.8.1

