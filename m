From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/5] omap2+: pm_bus: make functions used as pointers as static
Date: Tue,  4 Jan 2011 14:07:14 -0600
Message-ID: <1294171634-13943-6-git-send-email-nm@ti.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40665 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab1ADUIT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 15:08:19 -0500
In-Reply-To: <1294171634-13943-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

omap_pm_runtime_suspend and omap_pm_runtime_resume are used
as function pointers and does not really need to be exposed
to the world.

Fixes sparse warnings:
arch/arm/mach-omap2/pm_bus.c:23:5: warning: symbol 'omap_pm_runtime_suspend' was not declared. Should it be static?
arch/arm/mach-omap2/pm_bus.c:40:5: warning: symbol 'omap_pm_runtime_resume' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm_bus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
index 784989f..5acd2ab 100644
--- a/arch/arm/mach-omap2/pm_bus.c
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -20,7 +20,7 @@
 #include <plat/omap-pm.h>
 
 #ifdef CONFIG_PM_RUNTIME
-int omap_pm_runtime_suspend(struct device *dev)
+static int omap_pm_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	int r, ret = 0;
@@ -37,7 +37,7 @@ int omap_pm_runtime_suspend(struct device *dev)
 	return ret;
 };
 
-int omap_pm_runtime_resume(struct device *dev)
+static int omap_pm_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	int r;
-- 
1.6.3.3

