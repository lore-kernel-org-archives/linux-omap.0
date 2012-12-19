From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/8] ARM: OMAP: Fix dmaengine init for multiplatform
Date: Wed, 19 Dec 2012 11:26:23 -0800
Message-ID: <20121219192622.22098.55369.stgit@muffinssi.local>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:62121 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753699Ab2LST0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:25 -0500
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vinod Koul <vinod.koul@intel.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Dan Williams <djbw@fb.com>

Otherwise omap dmaengine will initialized when booted
on other SoCs. Fix this by initializing the platform
device in arch/arm/*omap*/dma.c instead.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Dan Williams <djbw@fb.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/dma.c |   18 ++++++++++++++++--
 arch/arm/mach-omap2/dma.c |   21 +++++++++++++++++++--
 drivers/dma/omap-dma.c    |   20 +-------------------
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index e190611..1a4e887 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -24,7 +24,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/io.h>
-
+#include <linux/dma-mapping.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
 
@@ -270,11 +270,17 @@ static u32 configure_dma_errata(void)
 	return errata;
 }
 
+static const struct platform_device_info omap_dma_dev_info = {
+	.name = "omap-dma-engine",
+	.id = -1,
+	.dma_mask = DMA_BIT_MASK(32),
+};
+
 static int __init omap1_system_dma_init(void)
 {
 	struct omap_system_dma_plat_info	*p;
 	struct omap_dma_dev_attr		*d;
-	struct platform_device			*pdev;
+	struct platform_device			*pdev, *dma_pdev;
 	int ret;
 
 	pdev = platform_device_alloc("omap_dma_system", 0);
@@ -380,8 +386,16 @@ static int __init omap1_system_dma_init(void)
 	dma_common_ch_start	= CPC;
 	dma_common_ch_end	= COLOR;
 
+	dma_pdev = platform_device_register_full(&omap_dma_dev_info);
+	if (IS_ERR(dma_pdev)) {
+		ret = PTR_ERR(dma_pdev);
+		goto exit_release_pdev;
+	}
+
 	return ret;
 
+exit_release_pdev:
+	platform_device_del(pdev);
 exit_release_chan:
 	kfree(d->chan);
 exit_release_d:
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index e034ab6..5cd8d76 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
-
+#include <linux/dma-mapping.h>
 #include <linux/omap-dma.h>
 
 #include "soc.h"
@@ -288,9 +288,26 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	return 0;
 }
 
+static const struct platform_device_info omap_dma_dev_info = {
+	.name = "omap-dma-engine",
+	.id = -1,
+	.dma_mask = DMA_BIT_MASK(32),
+};
+
 static int __init omap2_system_dma_init(void)
 {
-	return omap_hwmod_for_each_by_class("dma",
+	struct platform_device *pdev;
+	int res;
+
+	res = omap_hwmod_for_each_by_class("dma",
 			omap2_system_dma_init_dev, NULL);
+	if (res)
+		return res;
+
+	pdev = platform_device_register_full(&omap_dma_dev_info);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return res;
 }
 omap_arch_initcall(omap2_system_dma_init);
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 5a31264..c4b4fd2 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -661,32 +661,14 @@ bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(omap_dma_filter_fn);
 
-static struct platform_device *pdev;
-
-static const struct platform_device_info omap_dma_dev_info = {
-	.name = "omap-dma-engine",
-	.id = -1,
-	.dma_mask = DMA_BIT_MASK(32),
-};
-
 static int omap_dma_init(void)
 {
-	int rc = platform_driver_register(&omap_dma_driver);
-
-	if (rc == 0) {
-		pdev = platform_device_register_full(&omap_dma_dev_info);
-		if (IS_ERR(pdev)) {
-			platform_driver_unregister(&omap_dma_driver);
-			rc = PTR_ERR(pdev);
-		}
-	}
-	return rc;
+	return platform_driver_register(&omap_dma_driver);
 }
 subsys_initcall(omap_dma_init);
 
 static void __exit omap_dma_exit(void)
 {
-	platform_device_unregister(pdev);
 	platform_driver_unregister(&omap_dma_driver);
 }
 module_exit(omap_dma_exit);

