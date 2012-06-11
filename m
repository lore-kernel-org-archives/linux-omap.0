From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
Date: Mon, 11 Jun 2012 19:56:49 +0530
Message-ID: <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50082 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab2FKOm2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:42:28 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Helpers for propulating given resource structure
with memory & interrupt information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index a91f40f..652b245 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -905,6 +905,51 @@ static void __devinit gpmc_mem_init(void)
 	}
 }
 
+static __devinit int gpmc_setup_cs_mem(struct gpmc_cs_data *cs,
+						struct resource *res)
+{
+	unsigned long start;
+	int ret;
+
+	ret = gpmc_cs_request(cs->cs, cs->mem_size, &start);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(gpmc_dev, "error: gpmc request on CS: %d\n", cs->cs);
+		return ret;
+	}
+
+	res->start = start + cs->mem_offset;
+	res->end = res->start + cs->mem_size - 1;
+	res->flags = IORESOURCE_MEM;
+
+	dev_info(gpmc_dev, "memory 0x%x-0x%x on CS %d\n", res->start,
+							res->end, cs->cs);
+
+	return 1;
+}
+
+static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
+{
+	return bitmask;
+}
+
+static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
+						struct resource *res)
+{
+	int i, n;
+
+	for (i = 0, n = 0; i < GPMC_NR_IRQ; i++)
+		if (gpmc_bit_to_irq(gpmc_client_irq[i].bitmask)
+						& cs->irq_config) {
+			res[n].start = res[n].end = gpmc_client_irq[i].irq;
+			res[n].flags = IORESOURCE_IRQ;
+			dev_info(gpmc_dev, "irq %u on CS %d\n",
+						res[n].start, cs->cs);
+			n++;
+		}
+
+	return n;
+}
+
 static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	u32 l;
-- 
1.7.10.2

