From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4-alt 5/6] ARM: OMAP2+: gpmc-smsc911x: Add helper for driver conversion
Date: Wed, 2 May 2012 14:16:31 +0530
Message-ID: <634923a1c4fb2bf0d909191a6b3425249df4b535.1335941444.git.afzal@ti.com>
References: <cover.1335941443.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34157 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755843Ab2EBJDQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:03:16 -0400
In-Reply-To: <cover.1335941443.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

New interface for working with gpmc driver has been added
without modifying the existing interface. Latter has been kept
for migrating boards one by one, once all boards are migrated
to use the new interace, old interface to be deleted along with
renaming of new interface to old one

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   70 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    9 +++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index b6c77be..3b33b48 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -99,3 +99,73 @@ free1:
 
 	pr_err("Could not initialize smsc911x device\n");
 }
+
+static struct resource gpmc_smsc911x_resources_new = {
+	.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+};
+
+__init struct gpmc_device_pdata *
+gpmc_smsc911x_init_new(struct omap_smsc911x_platform_data *gpmc_cfg)
+{
+	int ret;
+	struct gpmc_device_pdata *gpmc_pdev;
+	struct gpmc_cs_data *gpmc_cs;
+
+	gpmc_pdev = kzalloc(sizeof(*gpmc_pdev), GFP_KERNEL);
+	if (gpmc_pdev == NULL)
+		return gpmc_pdev;
+
+	gpmc_cs = kzalloc(sizeof(*gpmc_cs), GFP_KERNEL);
+	if (gpmc_pdev == NULL) {
+		kfree(gpmc_pdev);
+		return NULL;
+	}
+
+	gpmc_pdev->cs_data = gpmc_cs;
+	gpmc_pdev->num_cs = 1;
+	gpmc_pdev->name = "smsc911x";
+	gpmc_pdev->id = gpmc_cfg->id;
+	gpmc_pdev->pdata = &gpmc_smsc911x_config;
+	gpmc_pdev->pdata_size = sizeof(gpmc_smsc911x_config);
+
+	gpmc_cs->cs = gpmc_cfg->cs;
+	gpmc_cs->mem_size = 0x100;
+
+	gpmc_pdev->per_res = &gpmc_smsc911x_resources_new;
+	gpmc_pdev->per_res_cnt = 1;
+
+	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "smsc911x irq")) {
+		pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio_irq);
+		goto free1;
+	}
+
+	gpmc_smsc911x_resources_new.start = gpio_to_irq(gpmc_cfg->gpio_irq);
+
+	if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
+		ret = gpio_request_one(gpmc_cfg->gpio_reset,
+				       GPIOF_OUT_INIT_HIGH, "smsc911x reset");
+		if (ret) {
+			pr_err("Failed to request reset GPIO%d\n",
+			       gpmc_cfg->gpio_reset);
+			goto free2;
+		}
+
+		gpio_set_value(gpmc_cfg->gpio_reset, 0);
+		msleep(100);
+		gpio_set_value(gpmc_cfg->gpio_reset, 1);
+	}
+
+	gpmc_smsc911x_config.flags = gpmc_cfg->flags ? : SMSC911X_USE_16BIT;
+
+	return gpmc_pdev;
+
+free2:
+	gpio_free(gpmc_cfg->gpio_irq);
+free1:
+	kfree(gpmc_cs);
+	kfree(gpmc_pdev);
+
+	pr_err("Could not initialize smsc911x device\n");
+
+	return NULL;
+}
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
index ea6c9c8..2e28e52 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -25,11 +25,20 @@ struct omap_smsc911x_platform_data {
 
 extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
 
+extern struct gpmc_device_pdata *
+gpmc_smsc911x_init_new(struct omap_smsc911x_platform_data *d);
+
 #else
 
 static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
 {
 }
 
+static inline struct gpmc_device_pdata *
+gpmc_smsc911x_init_new(struct omap_smsc911x_platform_data *d)
+{
+	return NULL;
+}
+
 #endif
 #endif
-- 
1.7.10

