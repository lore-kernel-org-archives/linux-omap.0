From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/6] ARM: OMAP3/4: iommu: migrate to hwmod framework
Date: Fri, 15 Jun 2012 20:56:02 -0500
Message-ID: <1339811764-5337-5-git-send-email-omar.luna@linaro.org>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1339811764-5337-1-git-send-email-omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use hwmod data and device attributes to build and register an
omap device for iommu driver.

 - Update the naming convention in isp module.
 - Remove unneeded check for number of resources, as this is now
   handled by omap_device and prevents driver from loading.
 - Now unused, remove platform device and resource data, handling
   of sysconfig register for softreset purposes, use default
   latency structure.

Signed-off-by: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-omap2/devices.c           |    2 +-
 arch/arm/mach-omap2/iommu2.c            |   19 ----
 arch/arm/mach-omap2/omap-iommu.c        |  159 ++++++-------------------------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +-
 drivers/iommu/omap-iommu.c              |    3 -
 5 files changed, 33 insertions(+), 152 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2a4fc0d..5b66efa 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -216,7 +216,7 @@ static struct platform_device omap3isp_device = {
 };
 
 static struct omap_iommu_arch_data omap3_isp_iommu = {
-	.name = "isp",
+	.name = "isp_mmu",
 };
 
 struct isp_platform_data {
diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index eefc379..35cab47 100644
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
@@ -88,7 +84,6 @@ static void __iommu_set_twl(struct omap_iommu *obj, bool on)
 static int omap2_iommu_enable(struct omap_iommu *obj)
 {
 	u32 l, pa;
-	unsigned long timeout;
 
 	if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
 		return -EINVAL;
@@ -97,20 +92,6 @@ static int omap2_iommu_enable(struct omap_iommu *obj)
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
index ac49384..02d98ce 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -12,153 +12,56 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/slab.h>
 
 #include <plat/iommu.h>
 #include <plat/irqs.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
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
-	},
-#endif
-};
-#define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
-static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
-#else
-#define omap3_devices		NULL
-#define NR_OMAP3_IOMMU_DEVICES	0
-#define omap3_iommu_pdev	NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-static struct iommu_device omap4_devices[] = {
-	{
-		.base = OMAP4_MMU1_BASE,
-		.irq = OMAP44XX_IRQ_DUCATI_MMU,
-		.pdata = {
-			.name = "ducati",
-			.nr_tlb_entries = 32,
-			.clk_name = "ipu_fck",
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
+static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 {
-	int i, err;
-	struct resource res[] = {
-		{ .flags = IORESOURCE_MEM },
-		{ .flags = IORESOURCE_IRQ },
-	};
+	struct platform_device *pdev;
+	struct iommu_platform_data *pdata;
+	struct omap_mmu_dev_attr *a = (struct omap_mmu_dev_attr *)oh->dev_attr;
+	static int i;
 
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
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
-	for (i = 0; i < num_iommu_devices; i++) {
-		struct platform_device *pdev;
-		const struct iommu_device *d = &devices[i];
+	pdata->name = oh->name;
+	pdata->clk_name = oh->main_clk;
+	pdata->nr_tlb_entries = a->nr_tlb_entries;
+	pdata->da_start = a->da_start;
+	pdata->da_end = a->da_end;
 
-		pdev = platform_device_alloc("omap-iommu", i);
-		if (!pdev) {
-			err = -ENOMEM;
-			goto err_out;
-		}
+	pdev = omap_device_build("omap-iommu", i, oh, pdata, sizeof(*pdata),
+				NULL, 0, 0);
 
-		res[0].start = d->base;
-		res[0].end = d->base + MMU_REG_SIZE - 1;
-		res[1].start = res[1].end = d->irq;
+	kfree(pdata);
 
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
+	if (IS_ERR(pdev)) {
+		pr_err("%s: device build err: %ld\n", __func__, PTR_ERR(pdev));
+		return PTR_ERR(pdev);
 	}
+
+	i++;
+
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
 /* must be ready before omap3isp is probed */
 subsys_initcall(omap_iommu_init);
 
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
index 44518cc..ed56424 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -119,7 +119,7 @@ struct omap_mmu_dev_attr {
 struct iommu_platform_data {
 	const char *name;
 	const char *clk_name;
-	const int nr_tlb_entries;
+	int nr_tlb_entries;
 	u32 da_start;
 	u32 da_end;
 };
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 9bdbf2f..93d7d84 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -906,9 +906,6 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	if (pdev->num_resources != 2)
-		return -EINVAL;
-
 	obj = kzalloc(sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
 	if (!obj)
 		return -ENOMEM;
-- 
1.7.4.1
