From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 03/13] ARM: OMAP2+: gpmc: driver migration helper
Date: Fri, 22 Jun 2012 18:26:46 +0530
Message-ID: <1acda4c555da7018950b27202380f408143407fb.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39984 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762062Ab2FVNMF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:05 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

A driver is being created out of GPMC code. This is being
attempted to acheive by not breaking existing interface,
necessitating requirement of GPMC peripherals being able
to work with using new interface as well as with the old
existing interface. To not break existing, initcall is
required as in old interface GPMC is configured at arch
initcall and GPMC should be ready to handle old interface
by that time

Note: This commit has to be reverted once all boards have
been converted to work with gpmc driver interface

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f8131f8..f64f55a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -941,7 +941,7 @@ postcore_initcall(gpmc_init);
 __init int omap_gpmc_init(struct gpmc_pdata *pdata)
 {
 	struct omap_hwmod *oh;
-	struct platform_device *pdev;
+	static struct platform_device *pdev;
 	char *name = "omap-gpmc";
 	char *oh_name = "gpmc";
 
@@ -951,6 +951,11 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
 		return -ENODEV;
 	}
 
+	if (pdev != NULL) {
+		omap_device_delete(pdev->archdata.od);
+		platform_device_unregister(pdev);
+	}
+
 	gpmc_l3_clk = oh->_clk;
 	if (!gpmc_l3_clk) {
 		pr_err("Could not get GPMC clock\n");
@@ -968,6 +973,17 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
 	return 0;
 }
 
+static int __init gpmc_pre_init(void)
+{
+	static struct gpmc_device_pdata *gpmc_device_data[1];
+	struct gpmc_pdata gpmc_data = {
+		.device_pdata	= gpmc_device_data,
+	};
+
+	return omap_gpmc_init(&gpmc_data);
+}
+postcore_initcall(gpmc_pre_init);
+
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
 	int i;
-- 
1.7.10.2

