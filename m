From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 12/13] ARM: OMAP2+: gpmc: update nand register info
Date: Fri, 22 Jun 2012 18:27:41 +0530
Message-ID: <e2da4dc3eb4f167b3d87498f9269c9f1fe5afb98.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40048 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932779Ab2FVNNC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:13:02 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index 3729136..c8e967f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -28,6 +28,7 @@
 
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
+#include <plat/nand.h>
 #include <plat/omap_device.h>
 
 #include <plat/sdrc.h>
@@ -1497,12 +1498,18 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 		gpmc_waitpin_nr = gp->waitpin_nr;
 
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
index 7909867..0085a01 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -196,6 +196,7 @@ struct gpmc_device_pdata {
 	unsigned		per_res_cnt;
 	struct gpmc_cs_data	*cs_data;
 	unsigned		num_cs;
+	bool			is_nand;
 };
 
 struct gpmc_pdata {
-- 
1.7.10.2

