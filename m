From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP1: PM: Fix OMAP1610 build
Date: Wed, 14 Jul 2010 16:52:25 +0530
Message-ID: <1279106545-3018-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41766 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565Ab0GNLZB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jul 2010 07:25:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

OMAP1610 build fails with following error on the branch pm-wip/hwmods-omap4.

This patch fixes the build error.
arch/arm/mach-omap1/pm_bus.c: In function 'platform_pm_runtime_suspend':
arch/arm/mach-omap1/pm_bus.c:30: error: 'ret' undeclared (first use in this function)
arch/arm/mach-omap1/pm_bus.c:30: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap1/pm_bus.c:30: error: for each function it appears in.)
arch/arm/mach-omap1/pm_bus.c:32: error: implicit declaration of function 'clk_get'
arch/arm/mach-omap1/pm_bus.c:32: warning: assignment makes pointer from integer without a cast
arch/arm/mach-omap1/pm_bus.c:33: error: implicit declaration of function 'IS_ERR'
arch/arm/mach-omap1/pm_bus.c:34: error: implicit declaration of function 'clk_disable'
arch/arm/mach-omap1/pm_bus.c:35: error: implicit declaration of function 'clk_put'
arch/arm/mach-omap1/pm_bus.c:38: warning: assignment makes pointer from integer without a cast
arch/arm/mach-omap1/pm_bus.c: In function 'platform_pm_runtime_resume':
arch/arm/mach-omap1/pm_bus.c:52: warning: assignment makes pointer from integer without a cast
arch/arm/mach-omap1/pm_bus.c:54: error: implicit declaration of function 'clk_enable'
arch/arm/mach-omap1/pm_bus.c:58: warning: assignment makes pointer from integer without a cast
arch/arm/mach-omap1/pm_bus.c:49: warning: unused variable 'r'
arch/arm/mach-omap1/pm_bus.c: In function 'platform_pm_runtime_idle':
arch/arm/mach-omap1/pm_bus.c:72: error: 'ret' undeclared (first use in this function)
make[1]: *** [arch/arm/mach-omap1/pm_bus.o] Error 1
make: *** [arch/arm/mach-omap1] Error 2

This patch fixes build issues and same has been tested for omap_h2_1610_defconfig.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap1/pm_bus.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 29d651a..6c5ab40 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -15,6 +15,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
@@ -23,6 +25,7 @@
 int platform_pm_runtime_suspend(struct device *dev)
 {
 	struct clk *iclk, *fclk;
+	int ret = 0;
 
 	dev_dbg(dev, "%s\n", __func__);
 
@@ -46,7 +49,7 @@ int platform_pm_runtime_suspend(struct device *dev)
 
 int platform_pm_runtime_resume(struct device *dev)
 {
-	int r, ret = 0;
+	int ret = 0;
 	struct clk *iclk, *fclk;
 
 	iclk = clk_get(dev, "ick");
@@ -69,6 +72,7 @@ int platform_pm_runtime_resume(struct device *dev)
 
 int platform_pm_runtime_idle(struct device *dev)
 {
+	int ret = 0;
 	ret = pm_runtime_suspend(dev);
 	dev_dbg(dev, "%s [%d]\n", __func__, ret);
 
-- 
1.7.0.4

