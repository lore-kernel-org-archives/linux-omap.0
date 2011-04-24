From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 3/4] omap: move detection of NAND CS to common-board-devices
Date: Mon, 25 Apr 2011 01:09:07 +0300
Message-ID: <e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:43915
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757890Ab1DXWCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 24 Apr 2011 18:02:22 -0400
In-Reply-To: <cover.1303682352.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

and reduce amount of copy/paste

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-devkit8000.c     |   43 +-------------------------
 arch/arm/mach-omap2/board-omap3beagle.c    |   45 +--------------------------
 arch/arm/mach-omap2/board-omap3touchbook.c |   45 +--------------------------
 arch/arm/mach-omap2/board-overo.c          |   42 +------------------------
 arch/arm/mach-omap2/common-board-devices.c |   42 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/common-board-devices.h |   10 ++++++
 6 files changed, 60 insertions(+), 167 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 983f44b..e7dc057 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -97,13 +97,6 @@ static struct mtd_partition devkit8000_nand_partitions[] = {
 	},
 };
 
-static struct omap_nand_platform_data devkit8000_nand_data = {
-	.options	= NAND_BUSWIDTH_16,
-	.parts		= devkit8000_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(devkit8000_nand_partitions),
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
-};
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -516,39 +509,6 @@ static struct platform_device *devkit8000_devices[] __initdata = {
 	&omap_dm9000_dev,
 };
 
-static void __init devkit8000_flash_init(void)
-{
-	u8 cs = 0;
-	u8 nandcs = GPMC_CS_NUM + 1;
-
-	/* find out the chip-select on which NAND exists */
-	while (cs < GPMC_CS_NUM) {
-		u32 ret = 0;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-
-		if ((ret & 0xC00) == 0x800) {
-			printk(KERN_INFO "Found NAND on CS%d\n", cs);
-			if (nandcs > GPMC_CS_NUM)
-				nandcs = cs;
-		}
-		cs++;
-	}
-
-	if (nandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				 "in GPMC\n ");
-		return;
-	}
-
-	if (nandcs < GPMC_CS_NUM) {
-		devkit8000_nand_data.cs = nandcs;
-
-		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (gpmc_nand_init(&devkit8000_nand_data) < 0)
-			printk(KERN_ERR "Unable to register NAND device\n");
-	}
-}
-
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
 	.mode			= MUSB_OTG,
@@ -740,7 +700,8 @@ static void __init devkit8000_init(void)
 
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
-	devkit8000_flash_init();
+	omap_nand_flash_init(NAND_BUSWIDTH_16, devkit8000_nand_partitions,
+			     ARRAY_SIZE(devkit8000_nand_partitions));
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 13a1664..ce3bc2d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -174,15 +174,6 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 	},
 };
 
-static struct omap_nand_platform_data omap3beagle_nand_data = {
-	.options	= NAND_BUSWIDTH_16,
-	.parts		= omap3beagle_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(omap3beagle_nand_partitions),
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
-	.nand_setup	= NULL,
-	.dev_ready	= NULL,
-};
-
 /* DSS */
 
 static int beagle_enable_dvi(struct omap_dss_device *dssdev)
@@ -542,39 +533,6 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&keys_gpio,
 };
 
-static void __init omap3beagle_flash_init(void)
-{
-	u8 cs = 0;
-	u8 nandcs = GPMC_CS_NUM + 1;
-
-	/* find out the chip-select on which NAND exists */
-	while (cs < GPMC_CS_NUM) {
-		u32 ret = 0;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-
-		if ((ret & 0xC00) == 0x800) {
-			printk(KERN_INFO "Found NAND on CS%d\n", cs);
-			if (nandcs > GPMC_CS_NUM)
-				nandcs = cs;
-		}
-		cs++;
-	}
-
-	if (nandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				 "in GPMC\n ");
-		return;
-	}
-
-	if (nandcs < GPMC_CS_NUM) {
-		omap3beagle_nand_data.cs = nandcs;
-
-		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (gpmc_nand_init(&omap3beagle_nand_data) < 0)
-			printk(KERN_ERR "Unable to register NAND device\n");
-	}
-}
-
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
@@ -662,7 +620,8 @@ static void __init omap3_beagle_init(void)
 
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
-	omap3beagle_flash_init();
+	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
+			     ARRAY_SIZE(omap3beagle_nand_partitions));
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 0a9b329..d770802 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -96,15 +96,6 @@ static struct mtd_partition omap3touchbook_nand_partitions[] = {
 	},
 };
 
-static struct omap_nand_platform_data omap3touchbook_nand_data = {
-	.options	= NAND_BUSWIDTH_16,
-	.parts		= omap3touchbook_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(omap3touchbook_nand_partitions),
-	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
-	.nand_setup	= NULL,
-	.dev_ready	= NULL,
-};
-
 #include "sdram-micron-mt46h32m32lf-6.h"
 
 static struct omap2_hsmmc_info mmc[] = {
@@ -396,39 +387,6 @@ static struct platform_device *omap3_touchbook_devices[] __initdata = {
 	&keys_gpio,
 };
 
-static void __init omap3touchbook_flash_init(void)
-{
-	u8 cs = 0;
-	u8 nandcs = GPMC_CS_NUM + 1;
-
-	/* find out the chip-select on which NAND exists */
-	while (cs < GPMC_CS_NUM) {
-		u32 ret = 0;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-
-		if ((ret & 0xC00) == 0x800) {
-			printk(KERN_INFO "Found NAND on CS%d\n", cs);
-			if (nandcs > GPMC_CS_NUM)
-				nandcs = cs;
-		}
-		cs++;
-	}
-
-	if (nandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				 "in GPMC\n ");
-		return;
-	}
-
-	if (nandcs < GPMC_CS_NUM) {
-		omap3touchbook_nand_data.cs = nandcs;
-
-		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (gpmc_nand_init(&omap3touchbook_nand_data) < 0)
-			printk(KERN_ERR "Unable to register NAND device\n");
-	}
-}
-
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
@@ -491,7 +449,8 @@ static void __init omap3_touchbook_init(void)
 	omap_ads7846_init(4, OMAP3_TS_GPIO, 310, &ads7846_pdata);
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
-	omap3touchbook_flash_init();
+	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3touchbook_nand_partitions,
+			     ARRAY_SIZE(omap3touchbook_nand_partitions));
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d0621dc..9212442 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -302,45 +302,6 @@ static struct mtd_partition overo_nand_partitions[] = {
 	},
 };
 
-static struct omap_nand_platform_data overo_nand_data = {
-	.parts = overo_nand_partitions,
-	.nr_parts = ARRAY_SIZE(overo_nand_partitions),
-	.dma_channel = -1,	/* disable DMA in OMAP NAND driver */
-};
-
-static void __init overo_flash_init(void)
-{
-	u8 cs = 0;
-	u8 nandcs = GPMC_CS_NUM + 1;
-
-	/* find out the chip-select on which NAND exists */
-	while (cs < GPMC_CS_NUM) {
-		u32 ret = 0;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-
-		if ((ret & 0xC00) == 0x800) {
-			printk(KERN_INFO "Found NAND on CS%d\n", cs);
-			if (nandcs > GPMC_CS_NUM)
-				nandcs = cs;
-		}
-		cs++;
-	}
-
-	if (nandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "NAND: Unable to find configuration "
-				 "in GPMC\n ");
-		return;
-	}
-
-	if (nandcs < GPMC_CS_NUM) {
-		overo_nand_data.cs = nandcs;
-
-		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
-		if (gpmc_nand_init(&overo_nand_data) < 0)
-			printk(KERN_ERR "Unable to register NAND device\n");
-	}
-}
-
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -602,7 +563,8 @@ static void __init overo_init(void)
 	overo_i2c_init();
 	omap_display_init(&overo_dss_data);
 	omap_serial_init();
-	overo_flash_init();
+	omap_nand_flash_init(0, overo_nand_partitions,
+			     ARRAY_SIZE(overo_nand_partitions));
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index cea31dd..d57c71d 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -29,6 +29,7 @@
 
 #include <plat/i2c.h>
 #include <plat/mcspi.h>
+#include <plat/nand.h>
 
 #include "common-board-devices.h"
 
@@ -104,3 +105,44 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
+
+static struct omap_nand_platform_data nand_data = {
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+};
+
+void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
+				 int nr_parts)
+{
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+
+	/* find out the chip-select on which NAND exists */
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		if ((ret & 0xC00) == 0x800) {
+			printk(KERN_INFO "Found NAND on CS%d\n", cs);
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		}
+		cs++;
+	}
+
+	if (nandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				 "in GPMC\n ");
+		return;
+	}
+
+	if (nandcs < GPMC_CS_NUM) {
+		nand_data.cs = nandcs;
+		nand_data.parts = parts;
+		nand_data.nr_parts = nr_parts;
+		nand_data.options = options;
+
+		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
+		if (gpmc_nand_init(&nand_data) < 0)
+			printk(KERN_ERR "Unable to register NAND device\n");
+	}
+}
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index 0ec3e07..ca03abf 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -2,6 +2,7 @@
 #define __OMAP_COMMON_BOARD_DEVICES__
 
 struct twl4030_platform_data;
+struct mtd_partition;
 
 void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
 		    struct twl4030_platform_data *pmic_data);
@@ -39,4 +40,13 @@ static inline void omap_ads7846_init(int bus_num,
 }
 #endif
 
+#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
+void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
+#else
+static inline void omap_nand_flash_init(int opts, struct mtd_partition *parts,
+					int nr_parts)
+{
+}
+#endif
+
 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
-- 
1.7.3.1

