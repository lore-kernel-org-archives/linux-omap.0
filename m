From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v3 5/9] ARM: OMAP2+: gpmc-smsc911x: gpmc driver information
Date: Thu, 5 Apr 2012 21:16:46 +0530
Message-ID: <90d8bfc447f4d9173f6ffee93ff8b56c473161ea.1333640054.git.afzal@ti.com>
References: <cover.1333640054.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1333640054.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, khilman@ti.com, linux@arm.linux.org.uk, dwmw2@infradead.org, sameo@linux.intel.com, grinberg@compulab.co.il, mike@compulab.co.il, nm@ti.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

gpmc has been converted to driver. And all gpmc related
configuration would be done by gpmc driver. Provide
gpmc driver with sufficient information so that it can
configure.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   59 ++++++++++++-----------
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    9 +++-
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index b6c77be..52192a9 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -24,13 +24,8 @@
 #include <plat/gpmc.h>
 #include <plat/gpmc-smsc911x.h>
 
-static struct resource gpmc_smsc911x_resources[] = {
-	[0] = {
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
+static struct resource gpmc_smsc911x_resources = {
+	.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 };
 
 static struct smsc911x_platform_config gpmc_smsc911x_config = {
@@ -44,26 +39,42 @@ static struct smsc911x_platform_config gpmc_smsc911x_config = {
  * assume that pin multiplexing is done in the board-*.c file,
  * or in the bootloader.
  */
-void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
+__init struct gpmc_device_pdata *
+gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 {
-	struct platform_device *pdev;
-	unsigned long cs_mem_base;
 	int ret;
+	struct gpmc_device_pdata *gpmc_pdev;
+	struct gpmc_cs_data *gpmc_cs;
 
-	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-		pr_err("Failed to request GPMC mem region\n");
-		return;
+	gpmc_pdev = kzalloc(sizeof(*gpmc_pdev), GFP_KERNEL);
+	if (gpmc_pdev == NULL)
+		return gpmc_pdev;
+
+	gpmc_cs = kzalloc(sizeof(*gpmc_cs), GFP_KERNEL);
+	if (gpmc_pdev == NULL) {
+		kfree(gpmc_pdev);
+		return NULL;
 	}
 
-	gpmc_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	gpmc_smsc911x_resources[0].end = cs_mem_base + 0xff;
+	gpmc_pdev->cs_data = gpmc_cs;
+	gpmc_pdev->num_cs = 1;
+	gpmc_pdev->name = "smsc911x";
+	gpmc_pdev->id = gpmc_cfg->id;
+	gpmc_pdev->pdata = &gpmc_smsc911x_config;
+	gpmc_pdev->pdata_size = sizeof(gpmc_smsc911x_config);
+
+	gpmc_cs->cs = gpmc_cfg->cs;
+	gpmc_cs->mem_size = 0xff;
+
+	gpmc_pdev->per_res = &gpmc_smsc911x_resources;
+	gpmc_pdev->num_per_res = 1;
 
 	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "smsc911x irq")) {
 		pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio_irq);
 		goto free1;
 	}
 
-	gpmc_smsc911x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
+	gpmc_smsc911x_resources.start = gpio_to_irq(gpmc_cfg->gpio_irq);
 
 	if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
 		ret = gpio_request_one(gpmc_cfg->gpio_reset,
@@ -81,21 +92,15 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 
 	gpmc_smsc911x_config.flags = gpmc_cfg->flags ? : SMSC911X_USE_16BIT;
 
-	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
-		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
-		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
-	if (!pdev) {
-		pr_err("Unable to register platform device\n");
-		gpio_free(gpmc_cfg->gpio_reset);
-		goto free2;
-	}
-
-	return;
+	return gpmc_pdev;
 
 free2:
 	gpio_free(gpmc_cfg->gpio_irq);
 free1:
-	gpmc_cs_free(gpmc_cfg->cs);
+	kfree(gpmc_cs);
+	kfree(gpmc_pdev);
 
 	pr_err("Could not initialize smsc911x device\n");
+
+	return NULL;
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
index ea6c9c8..66dc7f1 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -11,6 +11,8 @@
  * published by the Free Software Foundation.
  */
 
+#include<plat/gpmc.h>
+
 #ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
 
 struct omap_smsc911x_platform_data {
@@ -23,12 +25,15 @@ struct omap_smsc911x_platform_data {
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
-extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
+extern struct gpmc_device_pdata *
+gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
 
 #else
 
-static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
+static inline struct gpmc_device_pdata *
+gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
 {
+	return NULL;
 }
 
 #endif
-- 
1.7.9.3
