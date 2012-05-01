From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 26/39] ARM: OMAP2+: board cm-t3517: gpmc driver adaptation
Date: Tue, 1 May 2012 17:39:10 +0530
Message-ID: <7f80bf399fddaadda68f6d6a4f521f9ba25d7f88.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33204 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756630Ab2EAM0S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:26:18 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 9e66e16..6aa6b4a 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -234,6 +234,11 @@ static struct mtd_partition cm_t3517_nand_partitions[] = {
 	},
 };
 
+static struct gpmc_device_pdata *gpmc_device_data[1];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
 static struct omap_nand_platform_data cm_t3517_nand_data = {
 	.parts			= cm_t3517_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(cm_t3517_nand_partitions),
@@ -242,8 +247,8 @@ static struct omap_nand_platform_data cm_t3517_nand_data = {
 
 static void __init cm_t3517_init_nand(void)
 {
-	if (gpmc_nand_init(&cm_t3517_nand_data) < 0)
-		pr_err("CM-T3517: NAND initialization failed\n");
+	*gpmc_device_data = gpmc_nand_init(&cm_t3517_nand_data);
+	gpmc_data.num_device++;
 }
 #else
 static inline void cm_t3517_init_nand(void) {}
@@ -289,6 +294,7 @@ static void __init cm_t3517_init(void)
 	omap_board_config_size = ARRAY_SIZE(cm_t3517_config);
 	cm_t3517_init_leds();
 	cm_t3517_init_nand();
+	omap_init_gpmc(&gpmc_data);
 	cm_t3517_init_rtc();
 	cm_t3517_init_usbh();
 	cm_t3517_init_hecc();
-- 
1.7.10

