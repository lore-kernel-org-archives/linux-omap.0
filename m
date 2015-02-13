From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 21/33] ARM: OMAP4+: PRM: get rid of cpu_is_omap44xx calls from interrupt init
Date: Fri, 13 Feb 2015 18:12:40 +0200
Message-ID: <1423843973-6050-19-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46923 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbbBMQOQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:16 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

The compatible DT node is now passed with the prm init, so there is no
need to do node matching here again. Added a new flag to the init data
also, to detect default IRQ support for OMAP4. Also, any booting omap4
DT setup always has a PRM node, so there is no need to check against
the special case where it would be missing.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h        |    2 ++
 arch/arm/mach-omap2/prm44xx.c    |   50 +++++++++++++++-----------------------
 arch/arm/mach-omap2/prm_common.c |    2 +-
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 3936e6c..6312cc3 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -29,9 +29,11 @@ int omap2_prcm_base_init(void);
  *
  * PRM_HAS_IO_WAKEUP: has IO wakeup capability
  * PRM_HAS_VOLTAGE: has voltage domains
+ * PRM_IRQ_DEFAULT: use default irq number for PRM irq
  */
 #define PRM_HAS_IO_WAKEUP	(1 << 0)
 #define PRM_HAS_VOLTAGE		(1 << 1)
+#define PRM_IRQ_DEFAULT		BIT(2)
 
 /*
  * MAX_MODULE_SOFTRESET_WAIT: Maximum microseconds to wait for OMAP
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index af12302b..ce16f2f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -702,10 +702,14 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.vp_clear_txdone	= omap4_prm_vp_clear_txdone,
 };
 
+static const struct omap_prcm_init_data *prm_init_data;
+
 int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 {
 	omap_prm_base_init();
 
+	prm_init_data = data;
+
 	if (data->flags & PRM_HAS_IO_WAKEUP)
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
@@ -717,16 +721,8 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
-static struct of_device_id omap_prm_dt_match_table[] = {
-	{ .compatible = "ti,omap4-prm" },
-	{ .compatible = "ti,omap5-prm" },
-	{ .compatible = "ti,dra7-prm" },
-	{ }
-};
-
 static int omap44xx_prm_late_init(void)
 {
-	struct device_node *np;
 	int irq_num;
 
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
@@ -736,31 +732,23 @@ static int omap44xx_prm_late_init(void)
 	if (!of_have_populated_dt())
 		return 0;
 
-	np = of_find_matching_node(NULL, omap_prm_dt_match_table);
-
-	if (!np) {
-		/* Default loaded up with OMAP4 values */
-		if (!cpu_is_omap44xx())
-			return 0;
-	} else {
-		irq_num = of_irq_get(np, 0);
-		/*
-		 * Already have OMAP4 IRQ num. For all other platforms, we need
-		 * IRQ numbers from DT
-		 */
-		if (irq_num < 0 && !cpu_is_omap44xx()) {
-			if (irq_num == -EPROBE_DEFER)
-				return irq_num;
-
-			/* Have nothing to do */
-			return 0;
-		}
-
-		/* Once OMAP4 DT is filled as well */
-		if (irq_num >= 0)
-			omap4_prcm_irq_setup.irq = irq_num;
+	irq_num = of_irq_get(prm_init_data->np, 0);
+	/*
+	 * Already have OMAP4 IRQ num. For all other platforms, we need
+	 * IRQ numbers from DT
+	 */
+	if (irq_num < 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
+		if (irq_num == -EPROBE_DEFER)
+			return irq_num;
+
+		/* Have nothing to do */
+		return 0;
 	}
 
+	/* Once OMAP4 DT is filled as well */
+	if (irq_num >= 0)
+		omap4_prcm_irq_setup.irq = irq_num;
+
 	omap44xx_prm_enable_io_wakeup();
 
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index d5bb649..3f26df6 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -651,7 +651,7 @@ static struct omap_prcm_init_data omap4_prm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = OMAP4430_PRM_DEVICE_INST,
-	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE,
+	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE | PRM_IRQ_DEFAULT,
 };
 
 static struct omap_prcm_init_data omap5_prm_data __initdata = {
-- 
1.7.9.5

