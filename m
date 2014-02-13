From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 16/16] ARM: OMAP2+: Remove legacy omap-iommu.c
Date: Thu, 13 Feb 2014 12:15:47 -0600
Message-ID: <1392315347-32967-17-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

With full DT boot, the legacy mode of platform device creation
for OMAP IOMMUs is not needed anymore.

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
---
 arch/arm/mach-omap2/Makefile     |  3 --
 arch/arm/mach-omap2/omap-iommu.c | 79 ----------------------------------------
 2 files changed, 82 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap-iommu.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e6eec6f..242933f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -226,9 +226,6 @@ obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 obj-$(CONFIG_HW_PERF_EVENTS)		+= pmu.o
 
-iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
-obj-y					+= $(iommu-m) $(iommu-y)
-
 ifneq ($(CONFIG_TIDSPBRIDGE),)
 obj-y					+= dsp.o
 endif
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
deleted file mode 100644
index f1fab56..0000000
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * omap iommu: omap device registration
- *
- * Copyright (C) 2008-2009 Nokia Corporation
- *
- * Written by Hiroshi DOYU <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/of.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-
-#include <linux/platform_data/iommu-omap.h>
-#include "soc.h"
-#include "omap_hwmod.h"
-#include "omap_device.h"
-
-static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
-{
-	struct platform_device *pdev;
-	struct iommu_platform_data *pdata;
-	struct omap_mmu_dev_attr *a = (struct omap_mmu_dev_attr *)oh->dev_attr;
-	static int i;
-
-	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-
-	pdata->name = oh->name;
-	pdata->nr_tlb_entries = a->nr_tlb_entries;
-	pdata->da_start = a->da_start;
-	pdata->da_end = a->da_end;
-
-	if (oh->rst_lines_cnt == 1) {
-		pdata->reset_name = oh->rst_lines->name;
-		pdata->assert_reset = omap_device_assert_hardreset;
-		pdata->deassert_reset = omap_device_deassert_hardreset;
-	}
-
-	pdev = omap_device_build("omap-iommu", i, oh, pdata, sizeof(*pdata));
-
-	kfree(pdata);
-
-	if (IS_ERR(pdev)) {
-		pr_err("%s: device build err: %ld\n", __func__, PTR_ERR(pdev));
-		return PTR_ERR(pdev);
-	}
-
-	i++;
-
-	return 0;
-}
-
-static int __init omap_iommu_init(void)
-{
-	/* If dtb is there, the devices will be created dynamically */
-	if (of_have_populated_dt())
-		return -ENODEV;
-
-	return omap_hwmod_for_each_by_class("mmu", omap_iommu_dev_init, NULL);
-}
-/* must be ready before omap3isp is probed */
-omap_subsys_initcall(omap_iommu_init);
-
-static void __exit omap_iommu_exit(void)
-{
-	/* Do nothing */
-}
-module_exit(omap_iommu_exit);
-
-MODULE_AUTHOR("Hiroshi DOYU");
-MODULE_DESCRIPTION("omap iommu: omap device registration");
-MODULE_LICENSE("GPL v2");
-- 
1.8.5.3
