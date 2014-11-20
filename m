From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Prepare to move GPMC to drivers by platform data header
Date: Thu, 20 Nov 2014 14:28:19 -0800
Message-ID: <1416522501-14999-2-git-send-email-tony@atomide.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47923 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911AbaKTW25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 17:28:57 -0500
In-Reply-To: <1416522501-14999-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>

We still need to support platform data for omap3 until it's booting
in device tree only mode. So let's add platform_data/omap-gpmc.h for
that, and a minimal linux/omap-gpmc.h for the save and restore used
by the PM code.

Once omap3 boots in device tree only mode, we can make the data
structures in platform_data/omap-gpmc.h private to the GPMC driver.

Note that we can now also remove gpmc-nand.h and gpmc-onenand.h.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-cm-t35.c                 |   1 -
 arch/arm/mach-omap2/board-cm-t3517.c               |   1 -
 arch/arm/mach-omap2/board-flash.c                  |   4 +-
 arch/arm/mach-omap2/board-flash.h                  |   1 -
 arch/arm/mach-omap2/board-n8x0.c                   |   2 -
 arch/arm/mach-omap2/board-omap3pandora.c           |   2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   1 -
 arch/arm/mach-omap2/gpmc-nand.c                    |   1 -
 arch/arm/mach-omap2/gpmc-onenand.c                 |   1 -
 arch/arm/mach-omap2/gpmc-onenand.h                 |  24 ---
 arch/arm/mach-omap2/gpmc.c                         |  64 +++++-
 arch/arm/mach-omap2/gpmc.h                         | 224 +--------------------
 arch/arm/mach-omap2/pm34xx.c                       |   2 +-
 .../gpmc-nand.h => include/linux/omap-gpmc.h       |  18 +-
 include/linux/platform_data/omap-gpmc.h            | 177 ++++++++++++++++
 15 files changed, 255 insertions(+), 268 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 rename arch/arm/mach-omap2/gpmc-nand.h => include/linux/omap-gpmc.h (54%)
 create mode 100644 include/linux/platform_data/omap-gpmc.h

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index c6df8ee..2dbf4ce 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -52,7 +52,6 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 #include "gpmc.h"
-#include "gpmc-nand.h"
 
 #define CM_T35_GPIO_PENDOWN		57
 #define SB_T35_USB_HUB_RESET_GPIO	167
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 8a2c167..56621a5 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -50,7 +50,6 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 #include "am35xx-emac.h"
-#include "gpmc-nand.h"
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led cm_t3517_leds[] = {
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 2d245c2..b536b5a6 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -13,18 +13,18 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/omap-gpmc.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
 
+#include <linux/platform_data/omap-gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 
 #include "soc.h"
 #include "common.h"
 #include "board-flash.h"
-#include "gpmc-onenand.h"
-#include "gpmc-nand.h"
 
 #define REG_FPGA_REV			0x10
 #define REG_FPGA_DIP_SWITCH_INPUT2	0x60
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index 2fb5d41..ea9aaeb 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -12,7 +12,6 @@
  */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include "gpmc.h"
 
 #define PDC_NOR		1
 #define PDC_NAND	2
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 97767a2..49c3c25 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -22,7 +22,6 @@
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
 #include <linux/mfd/menelaus.h>
 #include <sound/tlv320aic3x.h>
 
@@ -32,7 +31,6 @@
 #include "common.h"
 #include "mmc.h"
 #include "soc.h"
-#include "gpmc-onenand.h"
 #include "common-board-devices.h"
 
 #define TUSB6010_ASYNC_CS	1
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index f322016..adab2c2e 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -51,7 +51,7 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
-#include "gpmc-nand.h"
+#include "gpmc.h"
 
 #define PANDORA_WIFI_IRQ_GPIO		21
 #define PANDORA_WIFI_NRESET_GPIO	23
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 30e7d4c..acd754f 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -55,7 +55,6 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 #include "gpmc.h"
-#include "gpmc-onenand.h"
 #include "soc.h"
 #include "omap-secure.h"
 
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index cb776431..3c21a9b 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -19,7 +19,6 @@
 
 #include "gpmc.h"
 #include "soc.h"
-#include "gpmc-nand.h"
 
 /* minimum size for IO mapping */
 #define	NAND_IO_SIZE	4
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 8b6876c..ebea151 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -22,7 +22,6 @@
 
 #include "gpmc.h"
 #include "soc.h"
-#include "gpmc-onenand.h"
 
 #define	ONENAND_IO_SIZE	SZ_128K
 
diff --git a/arch/arm/mach-omap2/gpmc-onenand.h b/arch/arm/mach-omap2/gpmc-onenand.h
deleted file mode 100644
index 216f23a..0000000
--- a/arch/arm/mach-omap2/gpmc-onenand.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *  arch/arm/mach-omap2/gpmc-onenand.h
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef	__OMAP2_GPMC_ONENAND_H
-#define	__OMAP2_GPMC_ONENAND_H
-
-#include <linux/platform_data/mtd-onenand-omap2.h>
-
-#if IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2)
-extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
-#else
-#define board_onenand_data	NULL
-static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
-{
-}
-#endif
-
-#endif
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9ea92b6..bc14f25 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -29,18 +29,18 @@
 #include <linux/of_address.h>
 #include <linux/of_mtd.h>
 #include <linux/of_device.h>
+#include <linux/omap-gpmc.h>
 #include <linux/mtd/nand.h>
 #include <linux/pm_runtime.h>
 
+#include <linux/platform_data/omap-gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
-
-#include <asm/mach-types.h>
+#include <linux/platform_data/mtd-onenand-omap2.h>
 
 #include "soc.h"
 #include "omap_device.h"
-#include "gpmc.h"
-#include "gpmc-nand.h"
-#include "gpmc-onenand.h"
+
+#include <asm/mach-types.h>
 
 #define	DEVICE_NAME		"omap-gpmc"
 
@@ -115,6 +115,60 @@
 
 #define GPMC_NR_WAITPINS		4
 
+#define GPMC_CS_CONFIG1		0x00
+#define GPMC_CS_CONFIG2		0x04
+#define GPMC_CS_CONFIG3		0x08
+#define GPMC_CS_CONFIG4		0x0c
+#define GPMC_CS_CONFIG5		0x10
+#define GPMC_CS_CONFIG6		0x14
+#define GPMC_CS_CONFIG7		0x18
+#define GPMC_CS_NAND_COMMAND	0x1c
+#define GPMC_CS_NAND_ADDRESS	0x20
+#define GPMC_CS_NAND_DATA	0x24
+
+/* Control Commands */
+#define GPMC_CONFIG_RDY_BSY	0x00000001
+#define GPMC_CONFIG_DEV_SIZE	0x00000002
+#define GPMC_CONFIG_DEV_TYPE	0x00000003
+#define GPMC_SET_IRQ_STATUS	0x00000004
+
+#define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
+#define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
+#define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
+#define GPMC_CONFIG1_READTYPE_SYNC      (1 << 29)
+#define GPMC_CONFIG1_WRITEMULTIPLE_SUPP (1 << 28)
+#define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
+#define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
+#define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
+#define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
+#define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
+#define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
+#define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
+#define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
+#define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
+#define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
+#define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
+#define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
+#define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
+#define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
+#define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
+#define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
+#define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
+#define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
+#define GPMC_CONFIG7_CSVALID		(1 << 6)
+
+#define GPMC_DEVICETYPE_NOR		0
+#define GPMC_DEVICETYPE_NAND		2
+#define GPMC_CONFIG_WRITEPROTECT	0x00000010
+#define WR_RD_PIN_MONITORING		0x00600000
+
+#define GPMC_ENABLE_IRQ		0x0000000d
+
+/* ECC commands */
+#define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
+#define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
+#define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
+
 /* XXX: Only NAND irq has been considered,currently these are the only ones used
  */
 #define	GPMC_NR_IRQ		2
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index 707f6d5..4dfb889 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -7,225 +7,5 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
-#ifndef __OMAP2_GPMC_H
-#define __OMAP2_GPMC_H
-
-#include <linux/platform_data/mtd-nand-omap2.h>
-
-/* Maximum Number of Chip Selects */
-#define GPMC_CS_NUM		8
-
-#define GPMC_CS_CONFIG1		0x00
-#define GPMC_CS_CONFIG2		0x04
-#define GPMC_CS_CONFIG3		0x08
-#define GPMC_CS_CONFIG4		0x0c
-#define GPMC_CS_CONFIG5		0x10
-#define GPMC_CS_CONFIG6		0x14
-#define GPMC_CS_CONFIG7		0x18
-#define GPMC_CS_NAND_COMMAND	0x1c
-#define GPMC_CS_NAND_ADDRESS	0x20
-#define GPMC_CS_NAND_DATA	0x24
-
-/* Control Commands */
-#define GPMC_CONFIG_RDY_BSY	0x00000001
-#define GPMC_CONFIG_DEV_SIZE	0x00000002
-#define GPMC_CONFIG_DEV_TYPE	0x00000003
-#define GPMC_SET_IRQ_STATUS	0x00000004
-#define GPMC_CONFIG_WP		0x00000005
-
-#define GPMC_ENABLE_IRQ		0x0000000d
-
-/* ECC commands */
-#define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
-#define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
-#define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
-
-#define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
-#define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
-#define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
-#define GPMC_CONFIG1_READTYPE_SYNC      (1 << 29)
-#define GPMC_CONFIG1_WRITEMULTIPLE_SUPP (1 << 28)
-#define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
-#define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
-#define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
-#define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
-#define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
-#define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
-#define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
-#define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
-#define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
-#define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
-#define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
-#define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
-#define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
-#define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
-#define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
-#define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
-#define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
-#define GPMC_CONFIG7_CSVALID		(1 << 6)
-
-#define GPMC_DEVICETYPE_NOR		0
-#define GPMC_DEVICETYPE_NAND		2
-#define GPMC_CONFIG_WRITEPROTECT	0x00000010
-#define WR_RD_PIN_MONITORING		0x00600000
-#define GPMC_IRQ_FIFOEVENTENABLE	0x01
-#define GPMC_IRQ_COUNT_EVENT		0x02
-
-#define GPMC_BURST_4			4	/* 4 word burst */
-#define GPMC_BURST_8			8	/* 8 word burst */
-#define GPMC_BURST_16			16	/* 16 word burst */
-#define GPMC_DEVWIDTH_8BIT		1	/* 8-bit device width */
-#define GPMC_DEVWIDTH_16BIT		2	/* 16-bit device width */
-#define GPMC_MUX_AAD			1	/* Addr-Addr-Data multiplex */
-#define GPMC_MUX_AD			2	/* Addr-Data multiplex */
-
-/* bool type time settings */
-struct gpmc_bool_timings {
-	bool cycle2cyclediffcsen;
-	bool cycle2cyclesamecsen;
-	bool we_extra_delay;
-	bool oe_extra_delay;
-	bool adv_extra_delay;
-	bool cs_extra_delay;
-	bool time_para_granularity;
-};
-
-/*
- * Note that all values in this struct are in nanoseconds except sync_clk
- * (which is in picoseconds), while the register values are in gpmc_fck cycles.
- */
-struct gpmc_timings {
-	/* Minimum clock period for synchronous mode (in picoseconds) */
-	u32 sync_clk;
-
-	/* Chip-select signal timings corresponding to GPMC_CS_CONFIG2 */
-	u32 cs_on;		/* Assertion time */
-	u32 cs_rd_off;		/* Read deassertion time */
-	u32 cs_wr_off;		/* Write deassertion time */
-
-	/* ADV signal timings corresponding to GPMC_CONFIG3 */
-	u32 adv_on;		/* Assertion time */
-	u32 adv_rd_off;		/* Read deassertion time */
-	u32 adv_wr_off;		/* Write deassertion time */
-
-	/* WE signals timings corresponding to GPMC_CONFIG4 */
-	u32 we_on;		/* WE assertion time */
-	u32 we_off;		/* WE deassertion time */
-
-	/* OE signals timings corresponding to GPMC_CONFIG4 */
-	u32 oe_on;		/* OE assertion time */
-	u32 oe_off;		/* OE deassertion time */
-
-	/* Access time and cycle time timings corresponding to GPMC_CONFIG5 */
-	u32 page_burst_access;	/* Multiple access word delay */
-	u32 access;		/* Start-cycle to first data valid delay */
-	u32 rd_cycle;		/* Total read cycle time */
-	u32 wr_cycle;		/* Total write cycle time */
-
-	u32 bus_turnaround;
-	u32 cycle2cycle_delay;
-
-	u32 wait_monitoring;
-	u32 clk_activation;
-
-	/* The following are only on OMAP3430 */
-	u32 wr_access;		/* WRACCESSTIME */
-	u32 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
-
-	struct gpmc_bool_timings bool_timings;
-};
-
-/* Device timings in picoseconds */
-struct gpmc_device_timings {
-	u32 t_ceasu;	/* address setup to CS valid */
-	u32 t_avdasu;	/* address setup to ADV valid */
-	/* XXX: try to combine t_avdp_r & t_avdp_w. Issue is
-	 * of tusb using these timings even for sync whilst
-	 * ideally for adv_rd/(wr)_off it should have considered
-	 * t_avdh instead. This indirectly necessitates r/w
-	 * variations of t_avdp as it is possible to have one
-	 * sync & other async
-	 */
-	u32 t_avdp_r;	/* ADV low time (what about t_cer ?) */
-	u32 t_avdp_w;
-	u32 t_aavdh;	/* address hold time */
-	u32 t_oeasu;	/* address setup to OE valid */
-	u32 t_aa;	/* access time from ADV assertion */
-	u32 t_iaa;	/* initial access time */
-	u32 t_oe;	/* access time from OE assertion */
-	u32 t_ce;	/* access time from CS asertion */
-	u32 t_rd_cycle;	/* read cycle time */
-	u32 t_cez_r;	/* read CS deassertion to high Z */
-	u32 t_cez_w;	/* write CS deassertion to high Z */
-	u32 t_oez;	/* OE deassertion to high Z */
-	u32 t_weasu;	/* address setup to WE valid */
-	u32 t_wpl;	/* write assertion time */
-	u32 t_wph;	/* write deassertion time */
-	u32 t_wr_cycle;	/* write cycle time */
-
-	u32 clk;
-	u32 t_bacc;	/* burst access valid clock to output delay */
-	u32 t_ces;	/* CS setup time to clk */
-	u32 t_avds;	/* ADV setup time to clk */
-	u32 t_avdh;	/* ADV hold time from clk */
-	u32 t_ach;	/* address hold time from clk */
-	u32 t_rdyo;	/* clk to ready valid */
-
-	u32 t_ce_rdyz;	/* XXX: description ?, or use t_cez instead */
-	u32 t_ce_avd;	/* CS on to ADV on delay */
-
-	/* XXX: check the possibility of combining
-	 * cyc_aavhd_oe & cyc_aavdh_we
-	 */
-	u8 cyc_aavdh_oe;/* read address hold time in cycles */
-	u8 cyc_aavdh_we;/* write address hold time in cycles */
-	u8 cyc_oe;	/* access time from OE assertion in cycles */
-	u8 cyc_wpl;	/* write deassertion time in cycles */
-	u32 cyc_iaa;	/* initial access time in cycles */
-
-	/* extra delays */
-	bool ce_xdelay;
-	bool avd_xdelay;
-	bool oe_xdelay;
-	bool we_xdelay;
-};
-
-struct gpmc_settings {
-	bool burst_wrap;	/* enables wrap bursting */
-	bool burst_read;	/* enables read page/burst mode */
-	bool burst_write;	/* enables write page/burst mode */
-	bool device_nand;	/* device is NAND */
-	bool sync_read;		/* enables synchronous reads */
-	bool sync_write;	/* enables synchronous writes */
-	bool wait_on_read;	/* monitor wait on reads */
-	bool wait_on_write;	/* monitor wait on writes */
-	u32 burst_len;		/* page/burst length */
-	u32 device_width;	/* device bus width (8 or 16 bit) */
-	u32 mux_add_data;	/* multiplex address & data */
-	u32 wait_pin;		/* wait-pin to be used */
-};
-
-extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
-			     struct gpmc_settings *gpmc_s,
-			     struct gpmc_device_timings *dev_t);
-
-extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
-extern int gpmc_get_client_irq(unsigned irq_config);
-
-extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
-
-extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
-extern int gpmc_calc_divider(unsigned int sync_clk);
-extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
-extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
-extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
-extern void gpmc_cs_free(int cs);
-extern void omap3_gpmc_save_context(void);
-extern void omap3_gpmc_restore_context(void);
-extern int gpmc_configure(int cmd, int wval);
-extern void gpmc_read_settings_dt(struct device_node *np,
-				  struct gpmc_settings *p);
-
-#endif
+#include <linux/omap-gpmc.h>
+#include <linux/platform_data/omap-gpmc.h>
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 175564c..88721df 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/omap-dma.h>
+#include <linux/omap-gpmc.h>
 #include <linux/platform_data/gpio-omap.h>
 
 #include <trace/events/power.h>
@@ -43,7 +44,6 @@
 #include "common.h"
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
-#include "gpmc.h"
 #include "prm-regbits-34xx.h"
 #include "prm3xxx.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/gpmc-nand.h b/include/linux/omap-gpmc.h
similarity index 54%
rename from arch/arm/mach-omap2/gpmc-nand.h
rename to include/linux/omap-gpmc.h
index d59e128..375caaa 100644
--- a/arch/arm/mach-omap2/gpmc-nand.h
+++ b/include/linux/omap-gpmc.h
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/mach-omap2/gpmc-nand.h
+ *  OMAP GPMC (General Purpose Memory Controller) defines
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -7,11 +7,12 @@
  *  option) any later version.
  */
 
-#ifndef	__OMAP2_GPMC_NAND_H
-#define	__OMAP2_GPMC_NAND_H
+extern void omap3_gpmc_save_context(void);
+extern void omap3_gpmc_restore_context(void);
 
-#include "gpmc.h"
-#include <linux/platform_data/mtd-nand-omap2.h>
+struct gpmc_timings;
+struct omap_nand_platform_data;
+struct omap_onenand_platform_data;
 
 #if IS_ENABLED(CONFIG_MTD_NAND_OMAP2)
 extern int gpmc_nand_init(struct omap_nand_platform_data *d,
@@ -24,4 +25,11 @@ static inline int gpmc_nand_init(struct omap_nand_platform_data *d,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2)
+extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
+#else
+#define board_onenand_data	NULL
+static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
+{
+}
 #endif
diff --git a/include/linux/platform_data/omap-gpmc.h b/include/linux/platform_data/omap-gpmc.h
new file mode 100644
index 0000000..8bc3ca3
--- /dev/null
+++ b/include/linux/platform_data/omap-gpmc.h
@@ -0,0 +1,177 @@
+/*
+ * General-Purpose Memory Controller for OMAP2
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP2_GPMC_H
+#define __OMAP2_GPMC_H
+
+#include <linux/platform_data/mtd-nand-omap2.h>
+
+/* Maximum Number of Chip Selects */
+#define GPMC_CS_NUM		8
+
+#define GPMC_CONFIG_WP		0x00000005
+
+#define GPMC_IRQ_FIFOEVENTENABLE	0x01
+#define GPMC_IRQ_COUNT_EVENT		0x02
+
+#define GPMC_BURST_4			4	/* 4 word burst */
+#define GPMC_BURST_8			8	/* 8 word burst */
+#define GPMC_BURST_16			16	/* 16 word burst */
+#define GPMC_DEVWIDTH_8BIT		1	/* 8-bit device width */
+#define GPMC_DEVWIDTH_16BIT		2	/* 16-bit device width */
+#define GPMC_MUX_AAD			1	/* Addr-Addr-Data multiplex */
+#define GPMC_MUX_AD			2	/* Addr-Data multiplex */
+
+/* bool type time settings */
+struct gpmc_bool_timings {
+	bool cycle2cyclediffcsen;
+	bool cycle2cyclesamecsen;
+	bool we_extra_delay;
+	bool oe_extra_delay;
+	bool adv_extra_delay;
+	bool cs_extra_delay;
+	bool time_para_granularity;
+};
+
+/*
+ * Note that all values in this struct are in nanoseconds except sync_clk
+ * (which is in picoseconds), while the register values are in gpmc_fck cycles.
+ */
+struct gpmc_timings {
+	/* Minimum clock period for synchronous mode (in picoseconds) */
+	u32 sync_clk;
+
+	/* Chip-select signal timings corresponding to GPMC_CS_CONFIG2 */
+	u32 cs_on;		/* Assertion time */
+	u32 cs_rd_off;		/* Read deassertion time */
+	u32 cs_wr_off;		/* Write deassertion time */
+
+	/* ADV signal timings corresponding to GPMC_CONFIG3 */
+	u32 adv_on;		/* Assertion time */
+	u32 adv_rd_off;		/* Read deassertion time */
+	u32 adv_wr_off;		/* Write deassertion time */
+
+	/* WE signals timings corresponding to GPMC_CONFIG4 */
+	u32 we_on;		/* WE assertion time */
+	u32 we_off;		/* WE deassertion time */
+
+	/* OE signals timings corresponding to GPMC_CONFIG4 */
+	u32 oe_on;		/* OE assertion time */
+	u32 oe_off;		/* OE deassertion time */
+
+	/* Access time and cycle time timings corresponding to GPMC_CONFIG5 */
+	u32 page_burst_access;	/* Multiple access word delay */
+	u32 access;		/* Start-cycle to first data valid delay */
+	u32 rd_cycle;		/* Total read cycle time */
+	u32 wr_cycle;		/* Total write cycle time */
+
+	u32 bus_turnaround;
+	u32 cycle2cycle_delay;
+
+	u32 wait_monitoring;
+	u32 clk_activation;
+
+	/* The following are only on OMAP3430 */
+	u32 wr_access;		/* WRACCESSTIME */
+	u32 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
+
+	struct gpmc_bool_timings bool_timings;
+};
+
+/* Device timings in picoseconds */
+struct gpmc_device_timings {
+	u32 t_ceasu;	/* address setup to CS valid */
+	u32 t_avdasu;	/* address setup to ADV valid */
+	/* XXX: try to combine t_avdp_r & t_avdp_w. Issue is
+	 * of tusb using these timings even for sync whilst
+	 * ideally for adv_rd/(wr)_off it should have considered
+	 * t_avdh instead. This indirectly necessitates r/w
+	 * variations of t_avdp as it is possible to have one
+	 * sync & other async
+	 */
+	u32 t_avdp_r;	/* ADV low time (what about t_cer ?) */
+	u32 t_avdp_w;
+	u32 t_aavdh;	/* address hold time */
+	u32 t_oeasu;	/* address setup to OE valid */
+	u32 t_aa;	/* access time from ADV assertion */
+	u32 t_iaa;	/* initial access time */
+	u32 t_oe;	/* access time from OE assertion */
+	u32 t_ce;	/* access time from CS asertion */
+	u32 t_rd_cycle;	/* read cycle time */
+	u32 t_cez_r;	/* read CS deassertion to high Z */
+	u32 t_cez_w;	/* write CS deassertion to high Z */
+	u32 t_oez;	/* OE deassertion to high Z */
+	u32 t_weasu;	/* address setup to WE valid */
+	u32 t_wpl;	/* write assertion time */
+	u32 t_wph;	/* write deassertion time */
+	u32 t_wr_cycle;	/* write cycle time */
+
+	u32 clk;
+	u32 t_bacc;	/* burst access valid clock to output delay */
+	u32 t_ces;	/* CS setup time to clk */
+	u32 t_avds;	/* ADV setup time to clk */
+	u32 t_avdh;	/* ADV hold time from clk */
+	u32 t_ach;	/* address hold time from clk */
+	u32 t_rdyo;	/* clk to ready valid */
+
+	u32 t_ce_rdyz;	/* XXX: description ?, or use t_cez instead */
+	u32 t_ce_avd;	/* CS on to ADV on delay */
+
+	/* XXX: check the possibility of combining
+	 * cyc_aavhd_oe & cyc_aavdh_we
+	 */
+	u8 cyc_aavdh_oe;/* read address hold time in cycles */
+	u8 cyc_aavdh_we;/* write address hold time in cycles */
+	u8 cyc_oe;	/* access time from OE assertion in cycles */
+	u8 cyc_wpl;	/* write deassertion time in cycles */
+	u32 cyc_iaa;	/* initial access time in cycles */
+
+	/* extra delays */
+	bool ce_xdelay;
+	bool avd_xdelay;
+	bool oe_xdelay;
+	bool we_xdelay;
+};
+
+struct gpmc_settings {
+	bool burst_wrap;	/* enables wrap bursting */
+	bool burst_read;	/* enables read page/burst mode */
+	bool burst_write;	/* enables write page/burst mode */
+	bool device_nand;	/* device is NAND */
+	bool sync_read;		/* enables synchronous reads */
+	bool sync_write;	/* enables synchronous writes */
+	bool wait_on_read;	/* monitor wait on reads */
+	bool wait_on_write;	/* monitor wait on writes */
+	u32 burst_len;		/* page/burst length */
+	u32 device_width;	/* device bus width (8 or 16 bit) */
+	u32 mux_add_data;	/* multiplex address & data */
+	u32 wait_pin;		/* wait-pin to be used */
+};
+
+extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
+			     struct gpmc_settings *gpmc_s,
+			     struct gpmc_device_timings *dev_t);
+
+extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
+extern int gpmc_get_client_irq(unsigned irq_config);
+
+extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
+
+extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
+extern int gpmc_calc_divider(unsigned int sync_clk);
+extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
+extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
+extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
+extern void gpmc_cs_free(int cs);
+extern int gpmc_configure(int cmd, int wval);
+extern void gpmc_read_settings_dt(struct device_node *np,
+				  struct gpmc_settings *p);
+
+#endif
-- 
2.1.3

