From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 39/39] ARM: OMAP2+: board igep0020: gpmc driver adaptation
Date: Tue, 1 May 2012 17:53:58 +0530
Message-ID: <12d7c132864777da63e4f18f5070278275331750.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60564 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757998Ab2EAMlF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:41:05 -0400
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 6d171ca..91de8ce 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -36,6 +36,7 @@
 #include <video/omapdss.h>
 #include <video/omap-panel-dvi.h>
 #include <plat/onenand.h>
+#include <plat/nand.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -118,6 +119,13 @@ static void __init igep2_get_revision(void)
 	gpio_free(IGEP2_GPIO_LED1_RED);
 }
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_MTD_ONENAND_OMAP2) ||		\
 	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE) ||	\
 	defined(CONFIG_MTD_NAND_OMAP2) ||		\
@@ -172,14 +180,26 @@ static void __init igep_flash_init(void)
 	mux = igep_get_sysboot_value();
 
 	if (mux == IGEP_SYSBOOT_NAND) {
+		struct omap_nand_platform_data *nand_data;
+
 		pr_info("IGEP: initializing NAND memory device\n");
-		board_nand_init(igep_flash_partitions,
+		nand_data = board_nand_init(igep_flash_partitions,
 				ARRAY_SIZE(igep_flash_partitions),
-				0, NAND_BUSWIDTH_16, NULL);
+				0, NAND_BUSWIDTH_16, nand_default_timings);
+		if (nand_data != NULL) {
+			*gpmc_cur++ = gpmc_nand_init(nand_data);
+			gpmc_data.num_device++;
+		}
 	} else if (mux == IGEP_SYSBOOT_ONENAND) {
+		struct omap_onenand_platform_data *onenand_data;
+
 		pr_info("IGEP: initializing OneNAND memory device\n");
-		board_onenand_init(igep_flash_partitions,
+		onenand_data = board_onenand_init(igep_flash_partitions,
 				   ARRAY_SIZE(igep_flash_partitions), 0);
+		if (onenand_data != NULL) {
+			*gpmc_cur++ = gpmc_onenand_init(onenand_data);
+			gpmc_data.num_device++;
+		}
 	} else
 		pr_err("IGEP: Flash: unsupported sysboot sequence found\n");
 }
@@ -202,7 +222,11 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
 
 static inline void __init igep2_init_smsc911x(void)
 {
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	*gpmc_cur = gpmc_smsc911x_init(&smsc911x_cfg);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: gpmc smsc911x setup\n");
 }
 
 #else
-- 
1.7.10

