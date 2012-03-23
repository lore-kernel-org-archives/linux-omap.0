From: Afzal Mohammed <afzal@ti.com>
Subject: [TMP][PATCH 5/5] OMAP3EVM: Test gpmc-nand
Date: Fri, 23 Mar 2012 12:07:10 +0530
Message-ID: <1332484630-22181-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47821 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab2CWGzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 02:55:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a659e19..9ed48d4 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -23,6 +23,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/leds.h>
 #include <linux/interrupt.h>
+#include <linux/mtd/nand.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -41,6 +42,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/nand.h>
 #include <plat/board.h>
 #include <plat/usb.h>
 #include "common.h"
@@ -52,6 +54,7 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
+#include "board-flash.h"
 
 #define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
@@ -102,6 +105,9 @@ static void __init omap3_evm_get_revision(void)
 	}
 }
 
+#undef CONFIG_SMSC911X
+#undef CONFIG_SMSC911X_MODULE
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>
 
@@ -533,6 +539,41 @@ static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+/*
+ * NAND
+ */
+static struct mtd_partition omap3_evm_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 10 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1c0000 */
+		.size		= 6 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size		= 40 * (64 * 2048),
+	},
+	{
+		.name		= "File System - NAND",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x780000 */
+	},
+};
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux omap35x_board_mux[] __initdata = {
 	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
@@ -632,8 +673,30 @@ static void __init omap3_evm_wl12xx_init(void)
 #endif
 }
 
+static struct gpmc_pdata gpmc_data;
+
+static struct resource gpmc_resources[] = {
+	{
+		.start = OMAP34XX_GPMC_BASE,
+		.end   = OMAP34XX_GPMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device gpmc_device = {
+	.name		= "omap-gpmc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(gpmc_resources),
+	.resource	= gpmc_resources,
+	.dev	= {
+		.platform_data = &gpmc_data,
+	}
+};
+
 static void __init omap3_evm_init(void)
 {
+	struct omap_nand_platform_data *nand_data;
+
 	omap3_evm_get_revision();
 
 	if (cpu_is_omap3630())
@@ -684,6 +747,25 @@ static void __init omap3_evm_init(void)
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 	omap3_evm_wl12xx_init();
+	/* NAND */
+	nand_data = omap_nand_init(omap3_evm_nand_partitions,
+			ARRAY_SIZE(omap3_evm_nand_partitions),
+			0, NAND_BUSWIDTH_16, nand_default_timings);
+	if (nand_data == NULL) {
+		pr_err("omap_nand_init() failed\n");
+		return;
+	}
+
+	gpmc_data.device_pdata = gpmc_nand_init(nand_data);
+	if (gpmc_data.device_pdata == NULL) {
+		pr_err("gpmc_nand_init() failed\n");
+		return;
+	}
+
+	gpmc_data.num_device++;
+	gpmc_data.fclk_rate = gpmc_get_fclk_period();
+
+	platform_device_register(&gpmc_device);
 }
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
-- 
1.7.9.3

