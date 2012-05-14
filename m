From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2+: gpmc-nand: update resource with memory
Date: Mon, 14 May 2012 15:09:09 +0530
Message-ID: <b3303f634963c9a797350e6164f22df8aa657a96.1336985941.git.afzal@ti.com>
References: <cover.1336985941.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43638 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab2ENJzo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 05:55:44 -0400
In-Reply-To: <cover.1336985941.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com, dedekind1@gmail.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Currently omap nand driver uses a field in platform data - phys_base
for passing the address space allocated by gpmc for nand. Use struct
resource instead. With this change omap nand driver has to get
address space from memory resource.

This helps in smooth migration of gpmc to driver.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index d4e803c..c0320d2 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -90,12 +90,14 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
 	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
 
 	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
-				&gpmc_nand_data->phys_base);
+				(unsigned long *)&gpmc_nand_resource.start);
 	if (err < 0) {
 		dev_err(dev, "Cannot request GPMC CS\n");
 		return err;
 	}
 
+	gpmc_nand_resource.end = gpmc_nand_resource.start + NAND_IO_SIZE - 1;
+
 	 /* Set timings in GPMC */
 	err = omap2_nand_gpmc_retime(gpmc_nand_data);
 	if (err < 0) {
-- 
1.7.10

