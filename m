From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 13/14] ARM: OMAP2+: gpmc: update nand register info
Date: Mon, 11 Jun 2012 19:57:46 +0530
Message-ID: <f45e3bfd400865a8171cbcc2fe196458aa7ea7a2.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab2FKOn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:43:27 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

GPMC has dedicated NAND handling blocks and have a few
registers exclusively meant for NAND operations. These
registers can be handled by OMAP NAND driver as it is
meant for handling NAND on GPMC. Update OMAP NAND
platform data with GPMC-NAND register details so that
OMAP NAND driver can handle by itself instead of
relying on GPMC exported symbols.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |    9 ++++++++-
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d493a4c..98b52c3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -28,6 +28,7 @@
 
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
+#include <plat/nand.h>
 #include <plat/omap_device.h>
 
 #include <plat/sdrc.h>
@@ -1500,12 +1501,18 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
 	/* Traverse NULL terminated array of peripheral pointers and setup */
-	for (gdq = gp->device_pdata, g_per = gpmc_peripheral; *gdq; gdq++)
+	for (gdq = gp->device_pdata, g_per = gpmc_peripheral; *gdq; gdq++) {
+		if ((*gdq)->is_nand) {
+			struct omap_nand_platform_data *p = (*gdq)->pdata;
+
+			gpmc_update_nand_reg(&p->reg, p->cs);
+		}
 		if (IS_ERR_VALUE(gpmc_setup_device(g_per, *gdq)))
 			dev_err(gpmc_dev, "gpmc setup on %s failed\n",
 								(*gdq)->name);
 		else
 			g_per++;
+	}
 	gpmc_num_peripheral = g_per - gpmc_peripheral;
 
 	for (l = 0, g_per = gpmc_peripheral;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 32017a1..32d7f3d 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -195,6 +195,7 @@ struct gpmc_device_pdata {
 	unsigned		per_res_cnt;
 	struct gpmc_cs_data	*cs_data;
 	unsigned		num_cs;
+	bool			is_nand;
 };
 
 struct gpmc_pdata {
-- 
1.7.10.2

