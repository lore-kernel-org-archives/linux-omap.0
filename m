From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 3/4] OMAP3/4: iommu: migrate to hwmod framework
Date: Mon,  7 Mar 2011 01:53:07 -0600
Message-ID: <1299484388-16205-4-git-send-email-omar.ramirez@ti.com>
References: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57007 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab1CGIEu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 03:04:50 -0500
In-Reply-To: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@eeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Use hwmod data and device attributes to build and register an
omap device for iommu driver.

Now unused, remove platform device and resource data, handling
of sysconfig register for softreset purposes; and add device
latency in preparation for runtime PM.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/iommu2.c            |   19 ----
 arch/arm/mach-omap2/omap-iommu.c        |  162 ++++++-------------------------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +-
 3 files changed, 33 insertions(+), 150 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index adb083e..a22d812 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -32,12 +32,8 @@
 #define MMU_SYS_IDLE_SMART	(2 << MMU_SYS_IDLE_SHIFT)
 #define MMU_SYS_IDLE_MASK	(3 << MMU_SYS_IDLE_SHIFT)
 
-#define MMU_SYS_SOFTRESET	(1 << 1)
 #define MMU_SYS_AUTOIDLE	1
 
-/* SYSSTATUS */
-#define MMU_SYS_RESETDONE	1
-
 /* IRQSTATUS & IRQENABLE */
 #define MMU_IRQ_MULTIHITFAULT	(1 << 4)
 #define MMU_IRQ_TABLEWALKFAULT	(1 << 3)
@@ -88,7 +84,6 @@ static void __iommu_set_twl(struct iommu *obj, bool on)
 static int omap2_iommu_enable(struct iommu *obj)
 {
 	u32 l, pa;
-	unsigned long timeout;
 
 	if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
 		return -EINVAL;
@@ -97,20 +92,6 @@ static int omap2_iommu_enable(struct iommu *obj)
 	if (!IS_ALIGNED(pa, SZ_16K))
 		return -EINVAL;
 
-	iommu_write_reg(obj, MMU_SYS_SOFTRESET, MMU_SYSCONFIG);
-
-	timeout = jiffies + msecs_to_jiffies(20);
-	do {
-		l = iommu_read_reg(obj, MMU_SYSSTATUS);
-		if (l & MMU_SYS_RESETDONE)
-			break;
-	} while (!time_after(jiffies, timeout));
-
-	if (!(l & MMU_SYS_RESETDONE)) {
-		dev_err(obj->dev, "can't take mmu out of reset\n");
-		return -ENODEV;
-	}
-
 	l = iommu_read_reg(obj, MMU_REVISION);
 	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
 		 (l >> 4) & 0xf, l & 0xf);
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 3fc5dc7..564a078 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -14,149 +14,51 @@
 
 #include <plat/iommu.h>
 #include <plat/irqs.h>
-
-struct iommu_device {
-	resource_size_t base;
-	int irq;
-	struct iommu_platform_data pdata;
-	struct resource res[2];
-};
-static struct iommu_device *devices;
-static int num_iommu_devices;
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct iommu_device omap3_devices[] = {
-	{
-		.base = 0x480bd400,
-		.irq = 24,
-		.pdata = {
-			.name = "isp",
-			.nr_tlb_entries = 8,
-			.clk_name = "cam_ick",
-			.da_start = 0x0,
-			.da_end = 0xFFFFF000,
-		},
-	},
-#if defined(CONFIG_OMAP_IOMMU_IVA2)
-	{
-		.base = 0x5d000000,
-		.irq = 28,
-		.pdata = {
-			.name = "iva2",
-			.nr_tlb_entries = 32,
-			.clk_name = "iva2_ck",
-			.da_start = 0x11000000,
-			.da_end = 0xFFFFF000,
-		},
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
+static struct omap_device_pm_latency iommu_latencies[] = {
+	[0] = {
+		.activate_func = omap_device_enable_hwmods,
+		.deactivate_func = omap_device_idle_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST
 	},
-#endif
 };
-#define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
-static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
-#else
-#define omap3_devices		NULL
-#define NR_OMAP3_IOMMU_DEVICES	0
-#define omap3_iommu_pdev	NULL
-#endif
 
-#ifdef CONFIG_ARCH_OMAP4
-static struct iommu_device omap4_devices[] = {
-	{
-		.base = OMAP4_MMU1_BASE,
-		.irq = OMAP44XX_IRQ_DUCATI_MMU,
-		.pdata = {
-			.name = "ducati",
-			.nr_tlb_entries = 32,
-			.clk_name = "ducati_ick",
-			.da_start = 0x0,
-			.da_end = 0xFFFFF000,
-		},
-	},
-#if defined(CONFIG_MPU_TESLA_IOMMU)
-	{
-		.base = OMAP4_MMU2_BASE,
-		.irq = INT_44XX_DSP_MMU,
-		.pdata = {
-			.name = "tesla",
-			.nr_tlb_entries = 32,
-			.clk_name = "tesla_ick",
-			.da_start = 0x0,
-			.da_end = 0xFFFFF000,
-		},
-	},
-#endif
-};
-#define NR_OMAP4_IOMMU_DEVICES ARRAY_SIZE(omap4_devices)
-static struct platform_device *omap4_iommu_pdev[NR_OMAP4_IOMMU_DEVICES];
-#else
-#define omap4_devices		NULL
-#define NR_OMAP4_IOMMU_DEVICES	0
-#define omap4_iommu_pdev	NULL
-#endif
-
-static struct platform_device **omap_iommu_pdev;
-
-static int __init omap_iommu_init(void)
+static int omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 {
-	int i, err;
-	struct resource res[] = {
-		{ .flags = IORESOURCE_MEM },
-		{ .flags = IORESOURCE_IRQ },
-	};
-
-	if (cpu_is_omap34xx()) {
-		devices = omap3_devices;
-		omap_iommu_pdev = omap3_iommu_pdev;
-		num_iommu_devices = NR_OMAP3_IOMMU_DEVICES;
-	} else if (cpu_is_omap44xx()) {
-		devices = omap4_devices;
-		omap_iommu_pdev = omap4_iommu_pdev;
-		num_iommu_devices = NR_OMAP4_IOMMU_DEVICES;
-	} else
-		return -ENODEV;
-
-	for (i = 0; i < num_iommu_devices; i++) {
-		struct platform_device *pdev;
-		const struct iommu_device *d = &devices[i];
-
-		pdev = platform_device_alloc("omap-iommu", i);
-		if (!pdev) {
-			err = -ENOMEM;
-			goto err_out;
-		}
+	struct omap_device *od;
+	struct iommu_platform_data pdata;
+	struct omap_mmu_dev_attr *a = (struct omap_mmu_dev_attr *)oh->dev_attr;
+	static int i;
+
+	pdata.name = oh->name;
+	pdata.clk_name = oh->main_clk;
+	pdata.nr_tlb_entries = a->nr_tlb_entries;
+	pdata.da_start = a->da_start;
+	pdata.da_end = a->da_end;
+
+	od = omap_device_build("omap-iommu", i, oh, &pdata, sizeof(pdata),
+			iommu_latencies, ARRAY_SIZE(iommu_latencies), 0);
+	if (IS_ERR(od)) {
+		pr_err("%s: device build error: %ld\n", __func__, PTR_ERR(od));
+		return PTR_ERR(od);
+	}
 
-		res[0].start = d->base;
-		res[0].end = d->base + MMU_REG_SIZE - 1;
-		res[1].start = res[1].end = d->irq;
+	i++;
 
-		err = platform_device_add_resources(pdev, res,
-						    ARRAY_SIZE(res));
-		if (err)
-			goto err_out;
-		err = platform_device_add_data(pdev, &d->pdata,
-					       sizeof(d->pdata));
-		if (err)
-			goto err_out;
-		err = platform_device_add(pdev);
-		if (err)
-			goto err_out;
-		omap_iommu_pdev[i] = pdev;
-	}
 	return 0;
+}
 
-err_out:
-	while (i--)
-		platform_device_put(omap_iommu_pdev[i]);
-	return err;
+static int __init omap_iommu_init(void)
+{
+	return omap_hwmod_for_each_by_class("mmu", omap_iommu_dev_init, NULL);
 }
 module_init(omap_iommu_init);
 
 static void __exit omap_iommu_exit(void)
 {
-	int i;
-
-	for (i = 0; i < num_iommu_devices; i++)
-		platform_device_unregister(omap_iommu_pdev[i]);
+	/* Do nothing */
 }
 module_exit(omap_iommu_exit);
 
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index b0d43ce..60f7c77 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -115,7 +115,7 @@ struct omap_mmu_dev_attr {
 struct iommu_platform_data {
 	const char *name;
 	const char *clk_name;
-	const int nr_tlb_entries;
+	int nr_tlb_entries;
 	u32 da_start;
 	u32 da_end;
 };
-- 
1.7.1

