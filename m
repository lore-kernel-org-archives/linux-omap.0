From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] CLK: Introduce virtual clock registration
Date: Wed, 20 Aug 2008 12:51:51 +0300
Message-ID: <1219225912-347-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63178 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbYHTJwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 05:52:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, eduardo.valentin@indt.org.br, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This patch provides the interface to register and unregister a virtual
clock which groups multiple clocks in it in order to handle this group
of clocks at once. Presently just clk_enable and clk_disable is
overwritten and other operation can be done as well.

This is just a refactor of MCBSP clock registration.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/clock.c              |   73 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/clock.h |   19 ++++++++
 2 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 23a0705..401de98 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -374,6 +374,79 @@ EXPORT_SYMBOL(clk_init_cpufreq_table);
 #endif
 
 /*-------------------------------------------------------------------------*/
+/*
+ *	Virtual clock/Clock aggregation
+ */
+int vclk_enable(struct clk *clk)
+{
+	int i;
+	struct vclk *vc = container_of(clk, struct vclk, clk);
+
+	for (i = 0; i < vc->n_childs; i++)
+		clk_enable(vc->childs[i]);
+	return 0;
+}
+
+void vclk_disable(struct clk *clk)
+{
+	int i;
+	struct vclk *vc = container_of(clk, struct vclk, clk);
+
+	for (i = 0; i < vc->n_childs; i++)
+		clk_disable(vc->childs[i]);
+}
+
+int vclk_register(struct vclk *vc, struct vclk_cci *cci, int num_child)
+{
+	int i, err;
+
+	vc->n_childs = num_child;
+	vc->childs = kzalloc(num_child * sizeof(struct clk *), GFP_KERNEL);
+	if (!vc->childs)
+		return -ENOMEM;
+
+	vc->clk.enable = vclk_enable;
+	vc->clk.disable = vclk_disable;
+
+	for (i = 0; i < num_child; i++, cci++) {
+		struct clk *c;
+		/* fake a platform device to get correct device ID */
+		struct platform_device pdev;
+
+		c = vc->childs[i];
+		pdev.dev.bus = &platform_bus_type;
+		pdev.id = cci->id;
+		c = clk_get(&pdev.dev, cci->name);
+		if (IS_ERR(c)) {
+			pr_err("Could not get clock %s (%d).\n",
+			       cci->name, cci->id);
+			err = PTR_ERR(c);
+			goto err_out;
+		}
+		vc->childs[i] = c;
+	}
+	err = clk_register(&vc->clk);
+	if (err)
+		goto err_out;
+	return 0;
+err_out:
+	while (--i >= 0)
+		clk_put(vc->childs[i]);
+	kfree(vc->childs);
+	return err;
+}
+EXPORT_SYMBOL(vclk_register);
+
+void vclk_unregister(struct vclk *vc)
+{
+	int i = vc->n_childs;
+
+	clk_unregister(&vc->clk);
+	while (--i >= 0)
+		clk_put(vc->childs[i]);
+	kfree(vc->childs);
+}
+EXPORT_SYMBOL(vclk_unregister);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 /*
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index c6762e9..45144f5 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -94,6 +94,25 @@ struct clk {
 #endif
 };
 
+/*
+ * Virtual Clock which holds multiple clocks in it and does some
+ * operations (enable/disable) against these child clocks at once
+ */
+struct vclk {
+	struct clk clk;
+	struct clk **childs;
+	int n_childs;
+};
+
+/* Child Clock Info for virtual clock registration */
+struct vclk_cci {
+	const char *name;
+	int id;
+};
+
+extern int vclk_register(struct vclk *vclk, struct vclk_cci *cci, int n_child);
+extern void vclk_unregister(struct vclk *vclk);
+
 struct cpufreq_frequency_table;
 
 struct clk_functions {
-- 
1.5.5.1.357.g1af8b

