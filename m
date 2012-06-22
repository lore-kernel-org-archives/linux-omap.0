From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 05/13] ARM: OMAP2+: gpmc: resource creation helpers
Date: Fri, 22 Jun 2012 18:26:59 +0530
Message-ID: <1e0922e87a54c68c33647af3cafee5b941a44629.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37161 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659Ab2FVNMR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:17 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Helpers for populating given resource structure
with memory & interrupt information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 08fc5df..e427ff4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -950,6 +950,51 @@ static void __devinit gpmc_mem_init(void)
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
+	return 0;
+}
+
+static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
+						struct resource *res)
+{
+	int i, n;
+
+	if (!gpmc_irq || !gpmc_irq_start) {
+		if (cs->irq_config)
+			dev_err(gpmc_dev, "gpmc not able to configure irq\n");
+		return 0;
+	}
+
+	for (i = 0, n = 0; i < GPMC_NR_IRQ; i++)
+		if (gpmc_client_irq[i].bitmask & cs->irq_config) {
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

