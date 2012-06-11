From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 6/9] ARM: OMAP2+: gpmc-smsc911x: Adapt to use gpmc driver
Date: Mon, 11 Jun 2012 20:29:46 +0530
Message-ID: <fa4fd074305f914d38603443b857422f95680725.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab2FKPP5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 11:15:57 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for smsc911x. As
gpmc driver is now present, populate details needed for the
driver to configure gpmc, gpmc driver would configure based
on this information. Old interface has been left as is so
that platforms can continue configuring gpmc using old
interface too. This is done so that driver conversion can
be done gradually without breaking any.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   66 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |   11 ++--
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index b6c77be..93a534e 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -99,3 +99,69 @@ free1:
 
 	pr_err("Could not initialize smsc911x device\n");
 }
+
+struct gpmc_device_pdata *
+__init gpmc_smsc911x_update(struct omap_smsc911x_platform_data *gpmc_cfg)
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
+	gpmc_pdev->per_res = gpmc_smsc911x_resources + 1;
+	gpmc_pdev->per_res_cnt = 1;
+
+	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "smsc911x irq")) {
+		pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio_irq);
+		goto free1;
+	}
+
+	gpmc_smsc911x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
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
index ea6c9c8..50af49e 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -22,14 +22,17 @@ struct omap_smsc911x_platform_data {
 };
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-
 extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
-
+extern struct gpmc_device_pdata *
+gpmc_smsc911x_update(struct omap_smsc911x_platform_data *gpmc_cfg);
 #else
-
 static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
 {
 }
-
+static inline struct gpmc_device_pdata *
+gpmc_smsc911x_update(struct omap_smsc911x_platform_data *gpmc_cfg)
+{
+	return NULL;
+}
 #endif
 #endif
-- 
1.7.10.2

