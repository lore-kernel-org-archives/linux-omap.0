From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 02/13] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Fri, 22 Jun 2012 18:26:41 +0530
Message-ID: <e0aee8fdaa363f86b256a2f62451e1c754f8e9e0.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60304 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762062Ab2FVNMB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:01 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Create API for platforms to adapt gpmc to HWMOD

gpmc clk is stored as timing calculation for
platform code require its rate so that GPMC
timing values (platform data for gpmc driver)
can be calculated.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   31 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    2 ++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8b0978f..f8131f8 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -27,6 +27,7 @@
 
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
+#include <plat/omap_device.h>
 
 #include <plat/sdrc.h>
 
@@ -937,6 +938,36 @@ static int __init gpmc_init(void)
 }
 postcore_initcall(gpmc_init);
 
+__init int omap_gpmc_init(struct gpmc_pdata *pdata)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	char *name = "omap-gpmc";
+	char *oh_name = "gpmc";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -ENODEV;
+	}
+
+	gpmc_l3_clk = oh->_clk;
+	if (!gpmc_l3_clk) {
+		pr_err("Could not get GPMC clock\n");
+		return -EINVAL;
+	}
+
+	pdev = omap_device_build(name, -1, oh, pdata,
+					sizeof(*pdata), NULL, 0, 0);
+	if (IS_ERR(pdev)) {
+		WARN(1, "Can't build omap_device for %s:%s.\n",
+						name, oh->name);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
 	int i;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 4e799b1..157753ab 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -208,6 +208,8 @@ struct gpmc_nand_regs {
 extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
 extern int gpmc_get_client_irq(unsigned irq_config);
 
+extern int omap_gpmc_init(struct gpmc_pdata *pdata);
+
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
 extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
 extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
-- 
1.7.10.2

