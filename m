From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 3/6] OMAP1: runtime PM: drop platform bus implementation
Date: Wed,  6 Apr 2011 17:02:46 -0700
Message-ID: <1302134569-22825-4-git-send-email-khilman@ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1302134569-22825-1-git-send-email-khilman@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@suse.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Current runtime PM implementation on OMAP1 is is based on a deprecated
interface: platform_bus_set_pm_ops().  Subsequent patch will convert
OMAP1 runtime PM to an implementation shared with SH-mobile, and based
on the new device power domain infrastructure in the common PM core.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/Makefile |    2 +-
 arch/arm/mach-omap1/pm_bus.c |  100 ------------------------------------------
 2 files changed, 1 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/pm_bus.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index af98117..1913c2d 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
 # Power Management
-obj-$(CONFIG_PM) += pm.o sleep.o pm_bus.o
+obj-$(CONFIG_PM) += pm.o sleep.o
 
 # DSP
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
deleted file mode 100644
index 6588c22..0000000
--- a/arch/arm/mach-omap1/pm_bus.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * Runtime PM support code for OMAP1
- *
- * Author: Kevin Hilman, Deep Root Systems, LLC
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/pm_runtime.h>
-#include <linux/platform_device.h>
-#include <linux/mutex.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-
-#include <plat/omap_device.h>
-#include <plat/omap-pm.h>
-
-#ifdef CONFIG_PM_RUNTIME
-static int omap1_pm_runtime_suspend(struct device *dev)
-{
-	struct clk *iclk, *fclk;
-	int ret = 0;
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	ret = pm_generic_runtime_suspend(dev);
-
-	fclk = clk_get(dev, "fck");
-	if (!IS_ERR(fclk)) {
-		clk_disable(fclk);
-		clk_put(fclk);
-	}
-
-	iclk = clk_get(dev, "ick");
-	if (!IS_ERR(iclk)) {
-		clk_disable(iclk);
-		clk_put(iclk);
-	}
-
-	return 0;
-};
-
-static int omap1_pm_runtime_resume(struct device *dev)
-{
-	struct clk *iclk, *fclk;
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	iclk = clk_get(dev, "ick");
-	if (!IS_ERR(iclk)) {
-		clk_enable(iclk);
-		clk_put(iclk);
-	}
-
-	fclk = clk_get(dev, "fck");
-	if (!IS_ERR(fclk)) {
-		clk_enable(fclk);
-		clk_put(fclk);
-	}
-
-	return pm_generic_runtime_resume(dev);
-};
-
-static int __init omap1_pm_runtime_init(void)
-{
-	const struct dev_pm_ops *pm;
-	struct dev_pm_ops *omap_pm;
-
-	if (!cpu_class_is_omap1())
-		return -ENODEV;
-
-	pm = platform_bus_get_pm_ops();
-	if (!pm) {
-		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
-			__func__);
-		return -ENODEV;
-	}
-
-	omap_pm = kmemdup(pm, sizeof(struct dev_pm_ops), GFP_KERNEL);
-	if (!omap_pm) {
-		pr_err("%s: unable to alloc memory for new dev_pm_ops\n",
-			__func__);
-		return -ENOMEM;
-	}
-
-	omap_pm->runtime_suspend = omap1_pm_runtime_suspend;
-	omap_pm->runtime_resume = omap1_pm_runtime_resume;
-
-	platform_bus_set_pm_ops(omap_pm);
-
-	return 0;
-}
-core_initcall(omap1_pm_runtime_init);
-#endif /* CONFIG_PM_RUNTIME */
-- 
1.7.4
