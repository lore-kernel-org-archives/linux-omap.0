From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 11/14] ARM: OMAP2+: gpmc: nand register helper bch update
Date: Mon, 8 Oct 2012 11:07:52 +0530
Message-ID: <1b75c64a6f2674faa9dce3b3a7ff5793b1f65d0c.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55282 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab2JHFiD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Oct 2012 01:38:03 -0400
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Update helper function that provides gpmc-nand register
details for nand driver with bch register information.
Using this nand driver can be made self sufficient to
handle remaining gpmc-nand operations by itself instead
of relying on gpmc exported nand functions.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c                   | 18 +++++++++++++++++-
 include/linux/platform_data/mtd-nand-omap2.h |  7 ++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 3a73196..eb577c5 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -61,6 +61,9 @@
 #define GPMC_ECC_SIZE_CONFIG	0x1fc
 #define GPMC_ECC1_RESULT        0x200
 #define GPMC_ECC_BCH_RESULT_0   0x240   /* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_1	0x244	/* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_2	0x248	/* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_3	0x24c	/* not available on OMAP2 */
 
 /* GPMC ECC control settings */
 #define GPMC_ECC_CTRL_ECCCLEAR		0x100
@@ -84,6 +87,7 @@
 
 #define GPMC_CS0_OFFSET		0x60
 #define GPMC_CS_SIZE		0x30
+#define	GPMC_BCH_SIZE		0x10
 
 #define GPMC_MEM_START		0x00000000
 #define GPMC_MEM_END		0x3FFFFFFF
@@ -779,6 +783,8 @@ EXPORT_SYMBOL(gpmc_prefetch_reset);
 
 void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 {
+	int i;
+
 	reg->gpmc_status = gpmc_base + GPMC_STATUS;
 	reg->gpmc_nand_command = gpmc_base + GPMC_CS0_OFFSET +
 				GPMC_CS_NAND_COMMAND + GPMC_CS_SIZE * cs;
@@ -794,7 +800,17 @@ void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
 	reg->gpmc_ecc_control = gpmc_base + GPMC_ECC_CONTROL;
 	reg->gpmc_ecc_size_config = gpmc_base + GPMC_ECC_SIZE_CONFIG;
 	reg->gpmc_ecc1_result = gpmc_base + GPMC_ECC1_RESULT;
-	reg->gpmc_bch_result0 = gpmc_base + GPMC_ECC_BCH_RESULT_0;
+
+	for (i = 0; i < GPMC_BCH_NUM_REMAINDER; i++) {
+		reg->gpmc_bch_result0[i] = gpmc_base + GPMC_ECC_BCH_RESULT_0 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result1[i] = gpmc_base + GPMC_ECC_BCH_RESULT_1 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result2[i] = gpmc_base + GPMC_ECC_BCH_RESULT_2 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result3[i] = gpmc_base + GPMC_ECC_BCH_RESULT_3 +
+					   GPMC_BCH_SIZE * i;
+	}
 }
 
 int gpmc_get_client_irq(unsigned irq_config)
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index e1965fe..24d32ca 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -13,6 +13,8 @@
 
 #include <linux/mtd/partitions.h>
 
+#define	GPMC_BCH_NUM_REMAINDER	8
+
 enum nand_io {
 	NAND_OMAP_PREFETCH_POLLED = 0,	/* prefetch polled mode, default */
 	NAND_OMAP_POLLED,		/* polled mode, without prefetch */
@@ -43,7 +45,10 @@ struct gpmc_nand_regs {
 	void __iomem	*gpmc_ecc_control;
 	void __iomem	*gpmc_ecc_size_config;
 	void __iomem	*gpmc_ecc1_result;
-	void __iomem	*gpmc_bch_result0;
+	void __iomem	*gpmc_bch_result0[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result1[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result2[GPMC_BCH_NUM_REMAINDER];
+	void __iomem	*gpmc_bch_result3[GPMC_BCH_NUM_REMAINDER];
 };
 
 struct omap_nand_platform_data {
-- 
1.7.12

