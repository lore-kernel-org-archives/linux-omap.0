From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 14/14] ARM: OMAP2+: gpmc: writeprotect helper
Date: Mon, 11 Jun 2012 19:57:53 +0530
Message-ID: <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52440 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304Ab2FKOnf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:43:35 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

GPMC has a writeprotect pin that can be connected to
peripherals. If any CS wants to enable writeprotect,
writeprotect will be enabled, once CS configurations
are finished.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 98b52c3..eec011a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -159,6 +159,7 @@ struct gpmc_peripheral {
 static struct gpmc_peripheral gpmc_peripheral[GPMC_CS_NUM];
 static unsigned gpmc_num_peripheral;
 static unsigned gpmc_waitpin_map;
+static bool gpmc_writeprotect;
 
 static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
 static struct irq_chip gpmc_irq_chip;
@@ -976,6 +977,9 @@ static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
 	else if (conf & GPMC_CONFIG1_PAGE_LEN_16)
 		l |= GPMC_CONFIG1_PAGE_LEN_16;
 
+	if (conf & GPMC_CONFIG_WRITEPROTECT)
+		gpmc_writeprotect = true;
+
 	conf &= (GPMC_CONFIG1_MUXADDDATA |
 			GPMC_CONFIG1_WRITETYPE_SYNC |
 			GPMC_CONFIG1_WRITEMULTIPLE_SUPP |
@@ -1462,6 +1466,19 @@ int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *c)
 }
 EXPORT_SYMBOL_GPL(gpmc_cs_reconfigure);
 
+static inline void gpmc_setup_writeprotect(void)
+{
+	u32 l;
+
+	l = gpmc_read_reg(GPMC_CONFIG);
+	if (gpmc_writeprotect == true) {
+		l &= ~GPMC_CONFIG_WRITEPROTECT;
+		dev_info(gpmc_dev, "write protect enabled\n");
+	} else
+		l |= GPMC_CONFIG_WRITEPROTECT;
+	gpmc_write_reg(GPMC_CONFIG, l);
+}
+
 static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	u32 l;
@@ -1521,6 +1538,8 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 			dev_err(gpmc_dev, "device creation on %s failed\n",
 								g_per->name);
 
+	gpmc_setup_writeprotect();
+
 	return 0;
 }
 
@@ -1531,6 +1550,7 @@ static __exit int gpmc_remove(struct platform_device *pdev)
 	for (; gpmc_num_peripheral; g_per++, gpmc_num_peripheral--)
 		platform_device_unregister(g_per->pdev);
 
+	gpmc_writeprotect = false;
 	gpmc_waitpin_map = 0;
 	gpmc_free_irq();
 	gpmc_mem_exit();
-- 
1.7.10.2

