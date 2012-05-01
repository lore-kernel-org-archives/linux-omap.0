From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 09/39] ARM: OMAP2+: flash: Adapt to gpmc driver
Date: Tue, 1 May 2012 17:37:10 +0530
Message-ID: <4ced8b708a263c7f50f6f684b47ab130bb773ba0.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab2EAMYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 08:24:18 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc driver has been converted to driver. Modify board_flash_init
so that it can setup gpmc driver platform details for boards

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c |    3 +-
 arch/arm/mach-omap2/board-flash.c   |   89 +++++++++++++++++++----------------
 arch/arm/mach-omap2/board-flash.h   |   11 +++--
 4 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index da75f23..ac2e398 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -620,7 +620,7 @@ static void __init omap_3430sdp_init(void)
 	omap_sdrc_init(hyb18m512160af6_sdrc_params, NULL);
 	usb_musb_init(NULL);
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
+	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0, NULL);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
 	usbhs_init(&usbhs_bdata);
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 6ef350d..74195b7 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -204,7 +204,8 @@ static void __init omap_sdp_init(void)
 				  h8mbx00u0mer0em_sdrc_params);
 	zoom_display_init();
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_sdp, NAND_BUSWIDTH_16);
+	board_flash_init(sdp_flash_partitions, chip_sel_sdp,
+		NAND_BUSWIDTH_16, NULL);
 	enable_board_wakeup_source();
 	usbhs_init(&usbhs_bdata);
 }
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 8727c05..8deead9 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -39,46 +39,33 @@ static struct physmap_flash_data board_nor_data = {
 	.width		= 2,
 };
 
-static struct resource board_nor_resource = {
-	.flags		= IORESOURCE_MEM,
+static struct gpmc_cs_data gpmc_nor_cs_data = {
 };
 
-static struct platform_device board_nor_device = {
+static struct gpmc_device_pdata gpmc_nor_data = {
 	.name		= "physmap-flash",
 	.id		= 0,
-	.dev		= {
-			.platform_data = &board_nor_data,
-	},
-	.num_resources	= 1,
-	.resource	= &board_nor_resource,
+	.cs_data	= &gpmc_nor_cs_data,
+	.num_cs		= 1,
 };
 
-static void
-__init board_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
+static __init struct gpmc_device_pdata *
+gpmc_nor_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
 {
-	int err;
-
 	board_nor_data.parts	= nor_parts;
 	board_nor_data.nr_parts	= nr_parts;
 
-	/* Configure start address and size of NOR device */
-	if (omap_rev() >= OMAP3430_REV_ES1_0) {
-		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV2 - 1,
-				(unsigned long *)&board_nor_resource.start);
-		board_nor_resource.end = board_nor_resource.start
-					+ FLASH_SIZE_SDPV2 - 1;
-	} else {
-		err = gpmc_cs_request(cs, FLASH_SIZE_SDPV1 - 1,
-				(unsigned long *)&board_nor_resource.start);
-		board_nor_resource.end = board_nor_resource.start
-					+ FLASH_SIZE_SDPV1 - 1;
-	}
-	if (err < 0) {
-		pr_err("NOR: Can't request GPMC CS\n");
-		return;
-	}
-	if (platform_device_register(&board_nor_device) < 0)
-		pr_err("Unable to register NOR device\n");
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
 }
 
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
@@ -183,8 +170,11 @@ unmap:
  *
  * @return - void.
  */
-void __init board_flash_init(struct flash_partitions partition_info[],
-			char chip_sel_board[][GPMC_CS_NUM], int nand_type)
+__init struct gpmc_device_pdata **board_flash_init(
+				struct flash_partitions partition_info[],
+				char chip_sel_board[][GPMC_CS_NUM],
+				int nand_type,
+				struct gpmc_device_pdata **gpmc_data)
 {
 	u8		cs = 0;
 	u8		norcs = GPMC_CS_NUM + 1;
@@ -193,13 +183,18 @@ void __init board_flash_init(struct flash_partitions partition_info[],
 	u8		idx;
 	unsigned char	*config_sel = NULL;
 
+	if (gpmc_data == NULL) {
+		pr_err("%s: NULL arguement passed\n", __func__);
+		return NULL;
+	}
+
 	/* REVISIT: Is this return correct idx for 2430 SDP?
 	 * for which cs configuration matches for 2430 SDP?
 	 */
 	idx = get_gpmc0_type();
 	if (idx >= MAX_SUPPORTED_GPMC_CONFIG) {
 		pr_err("%s: Invalid chip select: %d\n", __func__, cs);
-		return;
+		return gpmc_data;
 	}
 	config_sel = (unsigned char *)(chip_sel_board[idx]);
 
@@ -224,19 +219,31 @@ void __init board_flash_init(struct flash_partitions partition_info[],
 	if (norcs > GPMC_CS_NUM)
 		pr_err("NOR: Unable to find configuration in GPMC\n");
 	else
-		board_nor_init(partition_info[0].parts,
+		*gpmc_data++ = gpmc_nor_init(partition_info[0].parts,
 				partition_info[0].nr_parts, norcs);
 
 	if (onenandcs > GPMC_CS_NUM)
 		pr_err("OneNAND: Unable to find configuration in GPMC\n");
-	else
-		board_onenand_init(partition_info[1].parts,
-					partition_info[1].nr_parts, onenandcs);
+	else {
+		struct omap_onenand_platform_data *onenand_data;
+
+		onenand_data = board_onenand_init(partition_info[1].parts,
+				partition_info[1].nr_parts, onenandcs);
+		if (onenand_data != NULL)
+			*gpmc_data++ = gpmc_onenand_init(onenand_data);
+	}
 
 	if (nandcs > GPMC_CS_NUM)
 		pr_err("NAND: Unable to find configuration in GPMC\n");
-	else
-		board_nand_init(partition_info[2].parts,
-			partition_info[2].nr_parts, nandcs,
-			nand_type, nand_default_timings);
+	else {
+		struct omap_nand_platform_data *nand_data;
+
+		nand_data = board_nand_init(partition_info[2].parts,
+				partition_info[2].nr_parts, nandcs,
+				nand_type, nand_default_timings);
+		if (nand_data != NULL)
+			*gpmc_data++ = gpmc_nand_init(nand_data);
+	}
+
+	return gpmc_data;
 }
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index 75ba49f..4dd733d 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -28,12 +28,15 @@ struct flash_partitions {
 		defined(CONFIG_MTD_NAND_OMAP2_MODULE) || \
 		defined(CONFIG_MTD_ONENAND_OMAP2) || \
 		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-extern void board_flash_init(struct flash_partitions [],
-				char chip_sel[][GPMC_CS_NUM], int nand_type);
+extern struct gpmc_device_pdata **board_flash_init(
+		struct flash_partitions [], char chip_sel[][GPMC_CS_NUM],
+		int nand_type, struct gpmc_device_pdata **gpmc_data);
 #else
-static inline void board_flash_init(struct flash_partitions part[],
-				char chip_sel[][GPMC_CS_NUM], int nand_type)
+static inline struct gpmc_device_pdata **board_flash_init(
+	struct flash_partitions part[], char chip_sel[][GPMC_CS_NUM],
+	int nand_type, struct gpmc_device_pdata **gpmc_data)
 {
+	return NULL;
 }
 #endif
 
-- 
1.7.10

