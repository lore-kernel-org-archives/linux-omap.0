From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v3 1/4] mtd: nand: omap: add support for BCH16_ECC - GPMC driver updates
Date: Fri, 9 May 2014 14:29:12 +0530
Message-ID: <1399625955-20882-2-git-send-email-pekon@ti.com>
References: <1399625955-20882-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47992 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbaEIJAw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 05:00:52 -0400
In-Reply-To: <1399625955-20882-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Felipe Balbi <balbi@ti.com>, Pekon Gupta <pekon@ti.com>

This patch add support for BCH16_ECC in GPMC (controller) driver:
 - extend configuration space to include BCH16 registers
 - extend parsing of DT binding for selecting BCH16 ecc-scheme

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc.c                   | 15 +++++++++++++++
 include/linux/platform_data/mtd-nand-omap2.h |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ab43755..9b27773 100644
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
@@ -666,6 +669,12 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 					   GPMC_BCH_SIZE * i;
 		reg->gpmc_bch_result3[i] = gpmc_base + GPMC_ECC_BCH_RESULT_3 +
 					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result4[i] = gpmc_base + GPMC_ECC_BCH_RESULT_4 +
+					   i * GPMC_BCH_SIZE;
+		reg->gpmc_bch_result5[i] = gpmc_base + GPMC_ECC_BCH_RESULT_5 +
+					   i * GPMC_BCH_SIZE;
+		reg->gpmc_bch_result6[i] = gpmc_base + GPMC_ECC_BCH_RESULT_6 +
+					   i * GPMC_BCH_SIZE;
 	}
 }
 
@@ -1401,6 +1410,12 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
 		else
 			gpmc_nand_data->ecc_opt =
 				OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
+	else if (!strcmp(s, "bch16"))
+		if (gpmc_nand_data->elm_of_node)
+			gpmc_nand_data->ecc_opt =
+				OMAP_ECC_BCH16_CODE_HW;
+		else
+			pr_err("%s: BCH16 requires ELM support\n", __func__);
 	else
 		pr_err("%s: ti,nand-ecc-opt invalid value\n", __func__);
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 3e9dd66..c2172e8 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -31,6 +31,8 @@ enum omap_ecc {
 	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW,
 	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
 	OMAP_ECC_BCH8_CODE_HW,
+	/* 16-bit ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH16_CODE_HW
 };
 
 struct gpmc_nand_regs {
@@ -50,6 +52,9 @@ struct gpmc_nand_regs {
 	void __iomem	*gpmc_bch_result1[GPMC_BCH_NUM_REMAINDER];
 	void __iomem	*gpmc_bch_result2[GPMC_BCH_NUM_REMAINDER];
 	void __iomem	*gpmc_bch_result3[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result4[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
 };
 
 struct omap_nand_platform_data {
-- 
1.8.5.1.163.gd7aced9

