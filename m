From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flash storage memory
Date: Wed,  4 Apr 2012 20:36:26 +0200
Message-ID: <1333564586-3259-2-git-send-email-javier@dowhile0.org>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57951 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2DDShP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 14:37:15 -0400
Received: by wgbdr13 with SMTP id dr13so549197wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 11:37:14 -0700 (PDT)
In-Reply-To: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Enric=20Balletb=C3=B2=20i=20Serra?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, Javier Martinez Canillas <javier@dowhile0.org>

IGEP-based boards can have two different flash memories, a OneNAND or
a NAND device. The boot configuration pins (sys_boot) are used to
specify which memory is available.

Also, this patch removes unnecesary code for registering the OneNAND.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/mach-omap2/board-igep0020.c |   75 ++++++++++++++--------------------
 1 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 930c0d3..4af615a 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -24,6 +24,8 @@
 #include <linux/i2c/twl.h>
 #include <linux/mmc/host.h>
 
+#include <linux/mtd/nand.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -39,6 +41,8 @@
 #include "hsmmc.h"
 #include "sdram-numonyx-m65kxxxxam.h"
 #include "common-board-devices.h"
+#include "board-flash.h"
+#include "control.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
@@ -60,6 +64,10 @@
 #define IGEP3_GPIO_LED1_RED	16
 #define IGEP3_GPIO_USBH_NRESET  183
 
+#define IGEP_SYSBOOT_MASK           0x1f
+#define IGEP_SYSBOOT_NAND           0x0f
+#define IGEP_SYSBOOT_ONENAND        0x10
+
 /*
  * IGEP2 Hardware Revision Table
  *
@@ -110,8 +118,10 @@ static void __init igep2_get_revision(void)
 	gpio_free(IGEP2_GPIO_LED1_RED);
 }
 
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
-	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+#if defined(CONFIG_MTD_ONENAND_OMAP2) ||		\
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE) ||	\
+	defined(CONFIG_MTD_NAND_OMAP2) ||		\
+	defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 
 #define ONENAND_MAP             0x20000000
 
@@ -123,7 +133,7 @@ static void __init igep2_get_revision(void)
  * So MTD regards it as 4KiB page size and 256KiB block size 64*(2*2048)
  */
 
-static struct mtd_partition igep_onenand_partitions[] = {
+static struct mtd_partition igep_flash_partitions[] = {
 	{
 		.name           = "X-Loader",
 		.offset         = 0,
@@ -151,50 +161,27 @@ static struct mtd_partition igep_onenand_partitions[] = {
 	},
 };
 
-static struct omap_onenand_platform_data igep_onenand_data = {
-	.parts = igep_onenand_partitions,
-	.nr_parts = ARRAY_SIZE(igep_onenand_partitions),
-	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
-};
-
-static struct platform_device igep_onenand_device = {
-	.name		= "omap2-onenand",
-	.id		= -1,
-	.dev = {
-		.platform_data = &igep_onenand_data,
-	},
-};
+static inline u32 igep_get_sysboot_value(void)
+{
+	return omap_ctrl_readl(OMAP343X_CONTROL_STATUS) & IGEP_SYSBOOT_MASK;
+}
 
 static void __init igep_flash_init(void)
 {
-	u8 cs = 0;
-	u8 onenandcs = GPMC_CS_NUM + 1;
-
-	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
-		u32 ret;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
-
-		/* Check if NAND/oneNAND is configured */
-		if ((ret & 0xC00) == 0x800)
-			/* NAND found */
-			pr_err("IGEP: Unsupported NAND found\n");
-		else {
-			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
-			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
-				/* ONENAND found */
-				onenandcs = cs;
-		}
-	}
-
-	if (onenandcs > GPMC_CS_NUM) {
-		pr_err("IGEP: Unable to find configuration in GPMC\n");
-		return;
-	}
-
-	igep_onenand_data.cs = onenandcs;
-
-	if (platform_device_register(&igep_onenand_device) < 0)
-		pr_err("IGEP: Unable to register OneNAND device\n");
+	u32 mux;
+	mux = igep_get_sysboot_value();
+
+	if (mux == IGEP_SYSBOOT_NAND) {
+		pr_info("IGEP: initializing NAND memory device\n");
+		board_nand_init(igep_flash_partitions,
+				ARRAY_SIZE(igep_flash_partitions),
+				0, NAND_BUSWIDTH_16);
+	} else if (mux == IGEP_SYSBOOT_ONENAND) {
+		pr_info("IGEP: initializing OneNAND memory device\n");
+		board_onenand_init(igep_flash_partitions,
+				   ARRAY_SIZE(igep_flash_partitions), 0);
+	} else
+		pr_err("IGEP: Flash: unsupported sysboot sequence found\n");
 }
 
 #else
-- 
1.7.7.6

