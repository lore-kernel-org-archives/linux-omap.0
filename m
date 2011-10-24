From: ming.lei@canonical.com
Subject: [PATCH v5 7/7] arm: omap4: pmu: support runtime pm
Date: Mon, 24 Oct 2011 22:45:59 +0800
Message-ID: <1319467559-5518-8-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46958 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589Ab1JXOtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Oct 2011 10:49:00 -0400
Received: by ggnb1 with SMTP id b1so5801249ggn.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Oct 2011 07:48:59 -0700 (PDT)
In-Reply-To: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, Ming Lei <ming.lei@canonical.com>

From: Ming Lei <ming.lei@canonical.com>

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/devices.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index bc791e0..ab4de0d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -395,9 +396,11 @@ static struct omap_device_pm_latency omap_pmu_latency[] = {
 };
 
 static struct cti omap4_cti[2];
+static struct platform_device *pmu_dev;
 
 static void omap4_enable_cti(int irq)
 {
+	pm_runtime_get_sync(&pmu_dev->dev);
 	if (irq == OMAP44XX_IRQ_CTI0)
 		cti_enable(&omap4_cti[0]);
 	else if (irq == OMAP44XX_IRQ_CTI1)
@@ -410,6 +413,7 @@ static void omap4_disable_cti(int irq)
 		cti_disable(&omap4_cti[0]);
 	else if (irq == OMAP44XX_IRQ_CTI1)
 		cti_disable(&omap4_cti[1]);
+	pm_runtime_put(&pmu_dev->dev);
 }
 
 static irqreturn_t omap4_pmu_handler(int irq, void *dev, irq_handler_t handler)
@@ -497,8 +501,11 @@ static void __init omap_init_pmu(void)
 		if (!pd)
 			return;
 
-		omap_device_enable(&od->pdev);
+		pmu_dev= pd;
+		pm_runtime_enable(&pd->dev);
+		pm_runtime_get_sync(&pd->dev);
 		omap4_configure_pmu_irq();
+		pm_runtime_put(&pd->dev);
 		return;
 	} else {
 		return;
-- 
1.7.5.4

