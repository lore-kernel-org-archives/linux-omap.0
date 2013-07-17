From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 3/4] mtd: nand: omap: add support for BCH16_ECC - GPMC driver updates
Date: Thu, 18 Jul 2013 01:22:05 +0530
Message-ID: <1374090726-9393-4-git-send-email-pekon@ti.com>
References: <1374090726-9393-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38186 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218Ab3GQTyc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 15:54:32 -0400
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
 arch/arm/mach-omap2/gpmc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index e19de21..0d5639e 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -68,6 +68,9 @@
 #define	GPMC_ECC_BCH_RESULT_1	0x244	/* not available on OMAP2 */
 #define	GPMC_ECC_BCH_RESULT_2	0x248	/* not available on OMAP2 */
 #define	GPMC_ECC_BCH_RESULT_3	0x24c	/* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_4	0x300	/* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_5	0x304	/* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_6	0x308	/* not available on OMAP2 */
 
 /* GPMC ECC control settings */
 #define GPMC_ECC_CTRL_ECCCLEAR		0x100
@@ -659,13 +662,19 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 
 	for (i = 0; i < GPMC_BCH_NUM_REMAINDER; i++) {
 		reg->gpmc_bch_result0[i] = gpmc_base + GPMC_ECC_BCH_RESULT_0 +
-					   GPMC_BCH_SIZE * i;
+					   (GPMC_BCH_SIZE * i);
 		reg->gpmc_bch_result1[i] = gpmc_base + GPMC_ECC_BCH_RESULT_1 +
-					   GPMC_BCH_SIZE * i;
+					   (GPMC_BCH_SIZE * i);
 		reg->gpmc_bch_result2[i] = gpmc_base + GPMC_ECC_BCH_RESULT_2 +
-					   GPMC_BCH_SIZE * i;
+					   (GPMC_BCH_SIZE * i);
 		reg->gpmc_bch_result3[i] = gpmc_base + GPMC_ECC_BCH_RESULT_3 +
-					   GPMC_BCH_SIZE * i;
+					   (GPMC_BCH_SIZE * i);
+		reg->gpmc_bch_result4[i] = gpmc_base + GPMC_ECC_BCH_RESULT_4 +
+					   (GPMC_BCH_SIZE * i);
+		reg->gpmc_bch_result5[i] = gpmc_base + GPMC_ECC_BCH_RESULT_5 +
+					   (GPMC_BCH_SIZE * i);
+		reg->gpmc_bch_result6[i] = gpmc_base + GPMC_ECC_BCH_RESULT_6 +
+					   (GPMC_BCH_SIZE * i);
 	}
 }
 
@@ -1348,7 +1357,8 @@ static const char * const nand_ecc_opts[] = {
 	[OMAP_ECC_BCH4_CODE_HW]			= "bch4_code_hw",
 	[OMAP_ECC_BCH4_CODE_HW_DETECTION_SW]	= "bch4_code_hw_detection_sw",
 	[OMAP_ECC_BCH8_CODE_HW]			= "bch8_code_hw",
-	[OMAP_ECC_BCH8_CODE_HW_DETECTION_SW]	= "bch8_code_hw_detection_sw"
+	[OMAP_ECC_BCH8_CODE_HW_DETECTION_SW]	= "bch8_code_hw_detection_sw",
+	[OMAP_ECC_BCH16_CODE_HW]		= "bch16_code_hw"
 };
 
 static const char * const nand_xfer_types[] = {
@@ -1389,7 +1399,7 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 
 	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
 		for (val = 0; val < ARRAY_SIZE(nand_xfer_types); val++)
-			if (!strcasecmp(s, nand_xfer_types[val])) {
+			if (!strcmp(s, nand_xfer_types[val])) {
 				gpmc_nand_data->xfer_type = val;
 				break;
 			}
-- 
1.8.1

