From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 11/12] ARM: OMAP2+: Move dmtimer clock set function to dmtimer driver
Date: Mon, 4 Jun 2012 14:41:48 -0500
Message-ID: <1338838909-25356-12-git-send-email-jon-hunter@ti.com>
References: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60000 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab2FDTma (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 15:42:30 -0400
In-Reply-To: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

OMAP1 uses an architecture specific function for setting the dmtimer clock
source, where as the OMAP2+ devices use the clock framework. Eventually OMAP1
device should also use the clock framework and hence we should not any
architecture specific functions.

For now move the OMAP2+ function for configuring the clock source into the
dmtimer driver. Therefore, we do no longer need to specify an architecture
specific function for setting the clock source for OMAP2+ devices. This will
simplify device tree migration of the dmtimers for OMAP2+ devices.

>From now on, only OMAP1 devices should specify an architecture specific
function for setting the clock source via the platform data set_dmtimer_src()
function pointer.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   56 -----------------------------
 arch/arm/plat-omap/dmtimer.c              |   46 +++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
 3 files changed, 46 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 9963b56..8fe75a8 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -390,60 +390,6 @@ OMAP_SYS_TIMER(4)
 #endif
 
 /**
- * omap2_dm_timer_set_src - change the timer input clock source
- * @pdev:	timer platform device pointer
- * @source:	array index of parent clock source
- */
-static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
-{
-	int ret;
-	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
-	struct clk *fclk, *parent;
-	char *parent_name = NULL;
-
-	fclk = clk_get(&pdev->dev, "fck");
-	if (IS_ERR_OR_NULL(fclk)) {
-		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
-				__func__, __LINE__);
-		return -EINVAL;
-	}
-
-	switch (source) {
-	case OMAP_TIMER_SRC_SYS_CLK:
-		parent_name = "sys_ck";
-		break;
-
-	case OMAP_TIMER_SRC_32_KHZ:
-		parent_name = "32k_ck";
-		break;
-
-	case OMAP_TIMER_SRC_EXT_CLK:
-		parent_name = "alt_ck";
-		break;
-	}
-
-	parent = clk_get(&pdev->dev, parent_name);
-	if (IS_ERR_OR_NULL(parent)) {
-		dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
-			__func__, __LINE__, parent_name);
-		clk_put(fclk);
-		return -EINVAL;
-	}
-
-	ret = clk_set_parent(fclk, parent);
-	if (IS_ERR_VALUE(ret)) {
-		dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
-			__func__, parent_name);
-		ret = -EINVAL;
-	}
-
-	clk_put(parent);
-	clk_put(fclk);
-
-	return ret;
-}
-
-/**
  * omap_timer_init - build and register timer device with an
  * associated timer hwmod
  * @oh:	timer hwmod pointer to be used to build timer device
@@ -490,8 +436,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	 */
 	sscanf(oh->name, "timer%2d", &id);
 
-	pdata->set_timer_src = omap2_dm_timer_set_src;
-
 	if (timer_dev_attr)
 		pdata->timer_capability = timer_dev_attr->timer_capability;
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 6510e5e..6a70889 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -397,6 +397,8 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
+	char *parent_name = NULL;
+	struct clk *fclk, *parent;
 	struct dmtimer_platform_data *pdata;
 
 	if (unlikely(!timer))
@@ -407,7 +409,49 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
-	ret = pdata->set_timer_src(timer->pdev, source);
+	/*
+	 * FIXME: Used for OMAP1 devices only because they do not currently
+	 * use the clock framework to set the parent clock. To be removed
+	 * once OMAP1 migrated to using clock framework for dmtimers
+	 */
+	if (pdata->set_timer_src)
+		return pdata->set_timer_src(timer->pdev, source);
+
+	fclk = clk_get(&timer->pdev->dev, "fck");
+	if (IS_ERR_OR_NULL(fclk)) {
+		pr_err("%s: fck not found\n", __func__);
+		return -EINVAL;
+	}
+
+	switch (source) {
+	case OMAP_TIMER_SRC_SYS_CLK:
+		parent_name = "sys_ck";
+		break;
+
+	case OMAP_TIMER_SRC_32_KHZ:
+		parent_name = "32k_ck";
+		break;
+
+	case OMAP_TIMER_SRC_EXT_CLK:
+		parent_name = "alt_ck";
+		break;
+	}
+
+	parent = clk_get(&timer->pdev->dev, parent_name);
+	if (IS_ERR_OR_NULL(parent)) {
+		pr_err("%s: %s not found\n", __func__, parent_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = clk_set_parent(fclk, parent);
+	if (IS_ERR_VALUE(ret))
+		pr_err("%s: failed to set %s as parent\n", __func__,
+			parent_name);
+
+	clk_put(parent);
+out:
+	clk_put(fclk);
 
 	return ret;
 }
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 4a35b23..e41e55b 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -90,6 +90,7 @@ struct timer_regs {
 };
 
 struct dmtimer_platform_data {
+	/* set_timer_src - Only used for OMAP1 devices */
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	u32 needs_manual_reset:1;
 	u32 timer_capability;
-- 
1.7.9.5

