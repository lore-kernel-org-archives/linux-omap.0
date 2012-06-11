From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 3/9] ARM: OMAP2+: flash: Adapt to use gpmc driver
Date: Mon, 11 Jun 2012 20:29:27 +0530
Message-ID: <7dcf88bffa08b85c066aad96e813ee448330bfe6.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33359 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab2FKPPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 11:15:06 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for various flash
devices. As gpmc driver is now present, populate details
needed for the driver to configure gpmc, gpmc driver would
configure based on this information. Old interface has been
left as is so that platforms can continue configuring gpmc
using old interface too. This is done so that driver
conversion can be done gradually without breaking any.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |  126 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-flash.h |   29 +++++++++
 2 files changed, 155 insertions(+)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 0ee820b..f3be964 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -53,6 +53,15 @@ static struct platform_device board_nor_device = {
 	.resource	= &board_nor_resource,
 };
 
+static struct gpmc_cs_data gpmc_nor_cs_data;
+
+static struct gpmc_device_pdata gpmc_nor_data = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.cs_data	= &gpmc_nor_cs_data,
+	.num_cs		= 1,
+};
+
 static void
 __init board_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
 {
@@ -81,6 +90,25 @@ __init board_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
 		pr_err("Unable to register NOR device\n");
 }
 
+static __init struct gpmc_device_pdata *
+gpmc_nor_update(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
+{
+	board_nor_data.parts	= nor_parts;
+	board_nor_data.nr_parts	= nr_parts;
+
+	gpmc_nor_cs_data.cs	= cs;
+
+	if (omap_rev() >= OMAP3430_REV_ES1_0)
+		gpmc_nor_cs_data.mem_size = FLASH_SIZE_SDPV2;
+	else
+		gpmc_nor_cs_data.mem_size = FLASH_SIZE_SDPV1;
+
+	gpmc_nor_data.pdata = &board_nor_data;
+	gpmc_nor_data.pdata_size = sizeof(board_nor_data);
+
+	return &gpmc_nor_data;
+}
+
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
 		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 static struct omap_onenand_platform_data board_onenand_data = {
@@ -97,6 +125,16 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
 
 	gpmc_onenand_init(&board_onenand_data);
 }
+
+struct omap_onenand_platform_data * __init
+board_onenand_update(struct mtd_partition *onenand_parts, u8 nr_parts, u8 cs)
+{
+	board_onenand_data.cs		= cs;
+	board_onenand_data.parts	= onenand_parts;
+	board_onenand_data.nr_parts	= nr_parts;
+
+	return &board_onenand_data;
+}
 #else
 void
 __init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
@@ -148,6 +186,19 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs,
 	board_nand_data.gpmc_irq = OMAP_GPMC_IRQ_BASE + cs;
 	gpmc_nand_init(&board_nand_data);
 }
+
+struct omap_nand_platform_data *
+__init board_nand_update(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs,
+				int nand_type, struct gpmc_timings *gpmc_t)
+{
+	board_nand_data.cs		= cs;
+	board_nand_data.parts		= nand_parts;
+	board_nand_data.nr_parts	= nr_parts;
+	board_nand_data.devsize		= nand_type;
+	board_nand_data.gpmc_t		= gpmc_t;
+
+	return &board_nand_data;
+}
 #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
 
 /**
@@ -246,3 +297,78 @@ void __init board_flash_init(struct flash_partitions partition_info[],
 			partition_info[2].nr_parts, nandcs,
 			nand_type, nand_default_timings);
 }
+
+struct gpmc_device_pdata __init **board_flash_update(
+				struct flash_partitions partition_info[],
+				char chip_sel_board[][GPMC_CS_NUM],
+				int nand_type,
+				struct gpmc_device_pdata **gpmc_data)
+{
+	u8		cs = 0;
+	u8		norcs = GPMC_CS_NUM + 1;
+	u8		nandcs = GPMC_CS_NUM + 1;
+	u8		onenandcs = GPMC_CS_NUM + 1;
+	u8		idx;
+	unsigned char	*config_sel = NULL;
+
+	if (gpmc_data == NULL) {
+		pr_err("%s: NULL arguement passed\n", __func__);
+		return NULL;
+	}
+
+	idx = get_gpmc0_type();
+	if (idx >= MAX_SUPPORTED_GPMC_CONFIG) {
+		pr_err("%s: Invalid chip select: %d\n", __func__, cs);
+		return gpmc_data;
+	}
+	config_sel = (unsigned char *)(chip_sel_board[idx]);
+
+	while (cs < GPMC_CS_NUM) {
+		switch (config_sel[cs]) {
+		case PDC_NOR:
+			if (norcs > GPMC_CS_NUM)
+				norcs = cs;
+			break;
+		case PDC_NAND:
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+			break;
+		case PDC_ONENAND:
+			if (onenandcs > GPMC_CS_NUM)
+				onenandcs = cs;
+			break;
+		};
+		cs++;
+	}
+
+	if (norcs > GPMC_CS_NUM)
+		pr_err("NOR: Unable to find configuration in GPMC\n");
+	else
+		*gpmc_data++ = gpmc_nor_update(partition_info[0].parts,
+				partition_info[0].nr_parts, norcs);
+
+	if (onenandcs > GPMC_CS_NUM)
+		pr_err("OneNAND: Unable to find configuration in GPMC\n");
+	else {
+		struct omap_onenand_platform_data *onenand_data;
+
+		onenand_data = board_onenand_update(partition_info[1].parts,
+				partition_info[1].nr_parts, onenandcs);
+		if (onenand_data != NULL)
+			*gpmc_data++ = gpmc_onenand_update(onenand_data);
+	}
+
+	if (nandcs > GPMC_CS_NUM)
+		pr_err("NAND: Unable to find configuration in GPMC\n");
+	else {
+		struct omap_nand_platform_data *nand_data;
+
+		nand_data = board_nand_update(partition_info[2].parts,
+				partition_info[2].nr_parts, nandcs,
+				nand_type, nand_default_timings);
+		if (nand_data != NULL)
+			*gpmc_data++ = gpmc_nand_update(nand_data);
+	}
+
+	return gpmc_data;
+}
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index a3aa5fc..534afe2 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -30,11 +30,24 @@ struct flash_partitions {
 		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 extern void board_flash_init(struct flash_partitions [],
 				char chip_sel[][GPMC_CS_NUM], int nand_type);
+extern struct gpmc_device_pdata **board_flash_update(
+				struct flash_partitions partition_info[],
+				char chip_sel_board[][GPMC_CS_NUM],
+				int nand_type,
+				struct gpmc_device_pdata **gpmc_data);
 #else
 static inline void board_flash_init(struct flash_partitions part[],
 				char chip_sel[][GPMC_CS_NUM], int nand_type)
 {
 }
+static inline struct gpmc_device_pdata **board_flash_update(
+				struct flash_partitions partition_info[],
+				char chip_sel_board[][GPMC_CS_NUM],
+				int nand_type,
+				struct gpmc_device_pdata **gpmc_data)
+{
+	return NULL;
+}
 #endif
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || \
@@ -42,11 +55,20 @@ static inline void board_flash_init(struct flash_partitions part[],
 extern void board_nand_init(struct mtd_partition *nand_parts,
 		u8 nr_parts, u8 cs, int nand_type, struct gpmc_timings *gpmc_t);
 extern struct gpmc_timings nand_default_timings[];
+extern struct omap_nand_platform_data *
+board_nand_update(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs,
+				int nand_type, struct gpmc_timings *gpmc_t);
 #else
 static inline void board_nand_init(struct mtd_partition *nand_parts,
 		u8 nr_parts, u8 cs, int nand_type, struct gpmc_timings *gpmc_t)
 {
 }
+static inline struct omap_nand_platform_data *
+board_nand_update(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs,
+				int nand_type, struct gpmc_timings *gpmc_t)
+{
+	return NULL;
+}
 #define	nand_default_timings	NULL
 #endif
 
@@ -54,9 +76,16 @@ static inline void board_nand_init(struct mtd_partition *nand_parts,
 		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 extern void board_onenand_init(struct mtd_partition *nand_parts,
 					u8 nr_parts, u8 cs);
+extern struct omap_onenand_platform_data *
+board_onenand_update(struct mtd_partition *onenand_parts, u8 nr_parts, u8 cs);
 #else
 static inline void board_onenand_init(struct mtd_partition *nand_parts,
 					u8 nr_parts, u8 cs)
 {
 }
+static inline struct omap_onenand_platform_data *
+board_onenand_update(struct mtd_partition *onenand_parts, u8 nr_parts, u8 cs)
+{
+	return NULL;
+}
 #endif
-- 
1.7.10.2

