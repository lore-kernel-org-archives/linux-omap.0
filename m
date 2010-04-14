From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 06/12] AM3517: Add nand platform data for am3517evm
Date: Wed, 14 Apr 2010 16:30:19 +0800
Message-ID: <1271233822-27286-7-git-send-email-stanley.miao@windriver.com>
References: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34903 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab0DNIVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 04:21:52 -0400
In-Reply-To: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

Add nand flash init code for am3517evm.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   84 +++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 879c13f..a76ff11 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -23,6 +23,9 @@
 #include <linux/davinci_emac.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/regulator/machine.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
 
 #include <mach/hardware.h>
 #include <mach/am35xx.h>
@@ -35,6 +38,8 @@
 #include <plat/control.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/nand.h>
+#include <plat/gpmc.h>
 
 #include "mux.h"
 
@@ -42,6 +47,84 @@
 #define LCD_PANEL_BKLIGHT_PWR	182
 #define LCD_PANEL_PWM		181
 
+#define GPMC_CS0_BASE  0x60
+#define GPMC_CS_SIZE   0x30
+
+#define NAND_BLOCK_SIZE        SZ_128K
+
+static struct mtd_partition am3517evm_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name           = "xloader",
+		.offset         = 0,
+		.size           = 4 * (SZ_128K),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 14 * (SZ_128K),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot-params",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 2 * (SZ_128K)
+	},
+	{
+		.name           = "linux-kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 40 * (SZ_128K)
+	},
+	{
+		.name           = "rootfs",
+		.size           = MTDPART_SIZ_FULL,
+		.offset         = MTDPART_OFS_APPEND,
+	},
+};
+
+static struct omap_nand_platform_data am3517evm_nand_data = {
+	.parts          = am3517evm_nand_partitions,
+	.nr_parts       = ARRAY_SIZE(am3517evm_nand_partitions),
+	.nand_setup     = NULL,
+	.dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
+	.devsize        = 1,
+	.dev_ready      = NULL,
+};
+
+void __init am3517evm_flash_init(void)
+{
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		if ((ret & 0xC00) == 0x800) {
+			/* Found it!! */
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		}
+		cs++;
+	}
+	if (nandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				" in GPMC\n ");
+		return;
+	}
+
+	if (nandcs < GPMC_CS_NUM) {
+		am3517evm_nand_data.cs   = nandcs;
+		am3517evm_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+				GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
+		am3517evm_nand_data.gpmc_baseaddr   = (void *) (gpmc_base_add);
+		gpmc_nand_init(&am3517evm_nand_data);
+	}
+}
+
+
 #define AM35XX_EVM_PHY_MASK          (0xF)
 #define AM35XX_EVM_MDIO_FREQUENCY    (1000000) /*PHY bus frequency */
 
@@ -539,6 +622,7 @@ static void __init am3517_evm_init(void)
 				ARRAY_SIZE(am3517_evm_devices));
 
 	omap_serial_init();
+	am3517evm_flash_init();
 
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
-- 
1.5.4.3

