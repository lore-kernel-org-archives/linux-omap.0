From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 38/39] OMAP3: igep0020: Add support for Micron NAND Flash storage memory
Date: Tue, 1 May 2012 17:40:37 +0530
Message-ID: <0f754cf7506640a0dc02f1a1e07d7b9b5c4c7769.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335873032.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>

IGEP-based boards can have two different flash memories, a OneNAND or
a NAND device. The boot configuration pins (sys_boot) are used to
specify which memory is available.

Also, this patch removes unnecesary code for registering the OneNAND.

afzal-l0cyMroinI0@public.gmane.org: Update to use modified board_nand_init

Signed-off-by: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>

fixup: igep
---
 arch/arm/mach-omap2/board-igep0020.c |   75 ++++++++++++++--------------------
 1 file changed, 31 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 930c0d3..6d171ca 100644
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
