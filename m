From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
Date: Mon, 11 Jun 2012 19:56:32 +0530
Message-ID: <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52338 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab2FKOmM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:42:12 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

A driver is being created out of GPMC code. This is being
attempted to acheive by not breaking existing interface,
necessitating requirement of GPMC peripherals being able
to work with as well as without the help of driver. To not
break existing, initcall is required as in old interface
GPMC is configured at arch initcall and GPMC should be
ready to handle old interface by that time

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index b471c2f..6dbddb9 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -902,7 +902,7 @@ postcore_initcall(gpmc_init);
 __init int omap_gpmc_init(struct gpmc_pdata *pdata)
 {
 	struct omap_hwmod *oh;
-	struct platform_device *pdev;
+	static struct platform_device *pdev;
 	char *name = "omap-gpmc";
 	char *oh_name = "gpmc";
 
@@ -912,6 +912,12 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
 		return -ENODEV;
 	}
 
+	if (pdev != NULL) {
+		clk_put(gpmc_l3_clk);
+		omap_device_delete(pdev->archdata.od);
+		platform_device_unregister(pdev);
+	}
+
 	pdev = omap_device_build(name, -1, oh, pdata,
 					sizeof(*pdata), NULL, 0, 0);
 	if (IS_ERR(pdev)) {
@@ -929,6 +935,17 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
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

