From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 12/35] ARM: OMAP2+: dma: change DMA iomap to use hwmod pointers instead of pdata
Date: Wed, 15 Apr 2015 15:52:59 +0300
Message-ID: <1429102402-5276-13-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47040 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbbDOMwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:52:53 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

This makes it possible to do the iomapping before driver probe. Driver
probe requires access to the DMA IO mapping already, so if it is
allocated after omap_device_build, it is too late and causes a crash.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/dma.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index e1a56d8..3ff450b 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -225,13 +225,24 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	struct platform_device			*pdev;
 	struct omap_system_dma_plat_info	p;
 	struct omap_dma_dev_attr		*d;
-	struct resource				*mem;
+	struct resource				mem;
 	char					*name = "omap_dma_system";
+	int					r;
 
 	p = dma_plat_info;
 	p.dma_attr = (struct omap_dma_dev_attr *)oh->dev_attr;
 	p.errata = configure_dma_errata();
 
+	r = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM, NULL, &mem);
+	if (r)
+		return -ENXIO;
+
+	dma_base = ioremap(mem.start, mem.end - mem.start);
+	if (!dma_base) {
+		pr_err("%s: ioremap fail\n", __func__);
+		return -ENOMEM;
+	}
+
 	pdev = omap_device_build(name, 0, oh, &p, sizeof(p));
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s:%s.\n",
@@ -242,18 +253,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	omap_dma_dev_info.res = pdev->resource;
 	omap_dma_dev_info.num_res = pdev->num_resources;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
-		return -EINVAL;
-	}
-
-	dma_base = ioremap(mem->start, resource_size(mem));
-	if (!dma_base) {
-		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
-		return -ENOMEM;
-	}
-
 	d = oh->dev_attr;
 
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
-- 
1.7.9.5

