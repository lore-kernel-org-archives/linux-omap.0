From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 3/3] omap3 nand : use NAND_BUSWIDTH_AUTO
Date: Tue,  6 Nov 2012 11:51:45 +0100
Message-ID: <1352199105-30215-3-git-send-email-matthieu.castet@parrot.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45208 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab2KFKv7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 05:51:59 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so118907bkc.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 02:51:59 -0800 (PST)
In-Reply-To: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, Matthieu CASTET <matthieu.castet@parrot.com>

This allow to clean the omap nand driver that were trying in x8 and x16 bits mode.

This also make work onfi detection on beagleboard :

Before :
[    1.954803] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB 1,8V 16-bit), page size: 2048, OOB size: 64

After :
[    1.914825] ONFI param page 0 valid
[    1.919158] ONFI flash detected
[    1.922515] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron MT29F2G16ABD), page size: 2048, OOB size: 64

platform data devsize is renamed bussize. It now indicate the maximun size of the nand bus.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 arch/arm/mach-omap2/board-3630sdp.c          |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-flash.c            |    8 ++---
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-zoom.c             |    2 +-
 arch/arm/mach-omap2/common-board-devices.c   |    2 +-
 arch/arm/mach-omap2/gpmc-nand.c              |    5 ---
 drivers/mtd/nand/omap2.c                     |   42 ++++++++++++++------------
 include/linux/platform_data/mtd-nand-omap2.h |    7 ++++-
 13 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index fc224ad..d7b981b 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -198,7 +198,7 @@ static void __init omap_sdp_init(void)
 				  h8mbx00u0mer0em_sdrc_params);
 	zoom_display_init();
 	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_sdp, NAND_BUSWIDTH_16);
+	board_flash_init(sdp_flash_partitions, chip_sel_sdp, NAND_OMAP_BUS_16);
 	enable_board_wakeup_source();
 	usbhs_init(&usbhs_bdata);
 }
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 1fd161e..b3487e1 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -621,7 +621,7 @@ static void __init devkit8000_init(void)
 
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
-	omap_nand_flash_init(NAND_BUSWIDTH_16, devkit8000_nand_partitions,
+	omap_nand_flash_init(NAND_OMAP_BUS_16, devkit8000_nand_partitions,
 			     ARRAY_SIZE(devkit8000_nand_partitions));
 	omap_twl4030_audio_init("omap3beagle");
 
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 0cabe61..488a1fa 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -133,12 +133,12 @@ static struct omap_nand_platform_data board_nand_data = {
 
 void
 __init board_nand_init(struct mtd_partition *nand_parts,
-			u8 nr_parts, u8 cs, int nand_type)
+			u8 nr_parts, u8 cs, int bus_type)
 {
 	board_nand_data.cs		= cs;
 	board_nand_data.parts		= nand_parts;
 	board_nand_data.nr_parts	= nr_parts;
-	board_nand_data.devsize		= nand_type;
+	board_nand_data.bussize		= bus_type;
 
 	board_nand_data.ecc_opt = OMAP_ECC_HAMMING_CODE_DEFAULT;
 	gpmc_nand_init(&board_nand_data);
@@ -185,7 +185,7 @@ unmap:
  * @return - void.
  */
 void __init board_flash_init(struct flash_partitions partition_info[],
-			char chip_sel_board[][GPMC_CS_NUM], int nand_type)
+			char chip_sel_board[][GPMC_CS_NUM], int bus_type)
 {
 	u8		cs = 0;
 	u8		norcs = GPMC_CS_NUM + 1;
@@ -238,5 +238,5 @@ void __init board_flash_init(struct flash_partitions partition_info[],
 		pr_err("NAND: Unable to find configuration in GPMC\n");
 	else
 		board_nand_init(partition_info[2].parts,
-			partition_info[2].nr_parts, nandcs, nand_type);
+			partition_info[2].nr_parts, nandcs, bus_type);
 }
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 48d5e41..732f183 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -175,7 +175,7 @@ static void __init igep_flash_init(void)
 		pr_info("IGEP: initializing NAND memory device\n");
 		board_nand_init(igep_flash_partitions,
 				ARRAY_SIZE(igep_flash_partitions),
-				0, NAND_BUSWIDTH_16);
+				0, NAND_OMAP_BUS_16);
 	} else if (mux == IGEP_SYSBOOT_ONENAND) {
 		pr_info("IGEP: initializing OneNAND memory device\n");
 		board_onenand_init(igep_flash_partitions,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a08bebc..152b659 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -512,7 +512,7 @@ static void __init omap3_beagle_init(void)
 
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
-	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
+	omap_nand_flash_init(NAND_OMAP_BUS_16, omap3beagle_nand_partitions,
 			     ARRAY_SIZE(omap3beagle_nand_partitions));
 	omap_twl4030_audio_init("omap3beagle");
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a3959de..830e71b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -732,7 +732,7 @@ static void __init omap3_evm_init(void)
 	}
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
-	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
+	omap_nand_flash_init(NAND_OMAP_BUS_16, omap3evm_nand_partitions,
 			     ARRAY_SIZE(omap3evm_nand_partitions));
 
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 00a1f4a..592fa5d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -82,7 +82,7 @@ static struct mtd_partition omap3pandora_nand_partitions[] = {
 
 static struct omap_nand_platform_data pandora_nand_data = {
 	.cs		= 0,
-	.devsize	= NAND_BUSWIDTH_16,
+	.bussize	= NAND_OMAP_BUS_16,
 	.xfer_type	= NAND_OMAP_PREFETCH_DMA,
 	.parts		= omap3pandora_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(omap3pandora_nand_partitions),
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 944ffc4..7cef1e3 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -365,7 +365,7 @@ static void __init omap3_touchbook_init(void)
 	omap_ads7846_init(4, OMAP3_TS_GPIO, 310, &ads7846_pdata);
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
-	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3touchbook_nand_partitions,
+	omap_nand_flash_init(NAND_OMAP_BUS_16, omap3touchbook_nand_partitions,
 			     ARRAY_SIZE(omap3touchbook_nand_partitions));
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 4994438..49349e7 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -114,7 +114,7 @@ static void __init omap_zoom_init(void)
 	}
 
 	board_nand_init(zoom_nand_partitions, ARRAY_SIZE(zoom_nand_partitions),
-						ZOOM_NAND_CS, NAND_BUSWIDTH_16);
+						ZOOM_NAND_CS, NAND_OMAP_BUS_16);
 	zoom_debugboard_init();
 	zoom_peripherals_init();
 
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 48daac2..2189f40 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -128,7 +128,7 @@ void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
 		nand_data.cs = nandcs;
 		nand_data.parts = parts;
 		nand_data.nr_parts = nr_parts;
-		nand_data.devsize = options;
+		nand_data.bussize = options;
 
 		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
 		if (gpmc_nand_init(&nand_data) < 0)
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 4acf497..94f622e 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -76,11 +76,6 @@ static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data
 	t.cs_wr_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_wr_off);
 	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
 
-	/* Configure GPMC */
-	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 1);
-	else
-		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 0);
 	gpmc_cs_configure(gpmc_nand_data->cs,
 			GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NAND);
 	gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_WP, 0);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5b31386..618cf42 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1273,7 +1273,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->mtd.name		= dev_name(&pdev->dev);
 	info->mtd.owner		= THIS_MODULE;
 
-	info->nand.options	= pdata->devsize;
+	info->nand.options	= NAND_BUSWIDTH_AUTO;
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1325,13 +1325,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		break;
 
 	case NAND_OMAP_POLLED:
-		if (info->nand.options & NAND_BUSWIDTH_16) {
-			info->nand.read_buf   = omap_read_buf16;
-			info->nand.write_buf  = omap_write_buf16;
-		} else {
-			info->nand.read_buf   = omap_read_buf8;
-			info->nand.write_buf  = omap_write_buf8;
-		}
+		info->nand.read_buf   = omap_read_buf8;
+		info->nand.write_buf  = omap_write_buf8;
 		break;
 
 	case NAND_OMAP_PREFETCH_DMA:
@@ -1407,6 +1402,26 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
+	gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_DEV_SIZE, 0);
+	if (nand_scan_ident(&info->mtd, 1, NULL)) {
+		err = -ENXIO;
+		goto out_release_mem_region;
+	}
+
+	/* update for 16 bits device */
+	if (info->nand.options & NAND_BUSWIDTH_16) {
+		if (!(pdata->bussize & NAND_OMAP_BUS_16)) {
+			dev_err(&pdev->dev, "detected x16 flash, but board only support x8 flash\n");
+			err = -ENXIO;
+			goto out_release_mem_region;
+		}
+		gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_DEV_SIZE, 1);
+		if (pdata->xfer_type == NAND_OMAP_POLLED) {
+			info->nand.read_buf   = omap_read_buf16;
+			info->nand.write_buf  = omap_write_buf16;
+		}
+	}
+
 	/* select the ecc type */
 	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_DEFAULT)
 		info->nand.ecc.mode = NAND_ECC_SOFT;
@@ -1428,17 +1443,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* DIP switches on some boards change between 8 and 16 bit
-	 * bus widths for flash.  Try the other width if the first try fails.
-	 */
-	if (nand_scan_ident(&info->mtd, 1, NULL)) {
-		info->nand.options ^= NAND_BUSWIDTH_16;
-		if (nand_scan_ident(&info->mtd, 1, NULL)) {
-			err = -ENXIO;
-			goto out_release_mem_region;
-		}
-	}
-
 	/* rom code layout */
 	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW_ROMCODE) {
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 1a68c1e..766815e 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -18,6 +18,11 @@ enum nand_io {
 	NAND_OMAP_PREFETCH_IRQ		/* prefetch enabled irq mode */
 };
 
+enum nand_bussize {
+	NAND_OMAP_BUS_8,
+	NAND_OMAP_BUS_16,
+};
+
 struct omap_nand_platform_data {
 	int			cs;
 	struct mtd_partition	*parts;
@@ -25,7 +30,7 @@ struct omap_nand_platform_data {
 	int			nr_parts;
 	bool			dev_ready;
 	enum nand_io		xfer_type;
-	int			devsize;
+	enum nand_bussize		bussize;
 	enum omap_ecc           ecc_opt;
 	struct gpmc_nand_regs	reg;
 };
-- 
1.7.10.4

