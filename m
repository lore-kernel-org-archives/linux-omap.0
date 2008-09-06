From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [RESEND][PATCH 2/2] CLK: Use virtual clock register for mcbsp
Date: Sat,  6 Sep 2008 05:58:24 +0300
Message-ID: <1220669904-3247-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1220669904-3247-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48604 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYIFC6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 22:58:36 -0400
In-Reply-To: <1220669904-3247-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, eduardo.valentin@indt.org.br, felipe.balbi@nokia.com, tony@atomide.com, daniel.stone@nokia.com, ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap1/mcbsp.c             |   74 +++--------------------------
 arch/arm/mach-omap2/mcbsp.c             |   79 +++----------------------------
 arch/arm/plat-omap/devices.c            |   34 +++++++++++++
 arch/arm/plat-omap/include/mach/mcbsp.h |    2 +
 4 files changed, 50 insertions(+), 139 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 7de7c69..96366f5 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -26,81 +26,23 @@
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
 
-struct mcbsp_internal_clk {
-	struct clk clk;
-	struct clk **childs;
-	int n_childs;
-};
-
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
-{
-	const char *clk_names[] = { "dsp_ck", "api_ck", "dspxor_ck" };
-	int i;
-
-	mclk->n_childs = ARRAY_SIZE(clk_names);
-	mclk->childs = kzalloc(mclk->n_childs * sizeof(struct clk *),
-				GFP_KERNEL);
-
-	for (i = 0; i < mclk->n_childs; i++) {
-		/* We fake a platform device to get correct device id */
-		struct platform_device pdev;
-
-		pdev.dev.bus = &platform_bus_type;
-		pdev.id = mclk->clk.id;
-		mclk->childs[i] = clk_get(&pdev.dev, clk_names[i]);
-		if (IS_ERR(mclk->childs[i]))
-			printk(KERN_ERR "Could not get clock %s (%d).\n",
-				clk_names[i], mclk->clk.id);
-	}
-}
-
-static int omap_mcbsp_clk_enable(struct clk *clk)
-{
-	struct mcbsp_internal_clk *mclk = container_of(clk,
-					struct mcbsp_internal_clk, clk);
-	int i;
-
-	for (i = 0; i < mclk->n_childs; i++)
-		clk_enable(mclk->childs[i]);
-	return 0;
-}
-
-static void omap_mcbsp_clk_disable(struct clk *clk)
-{
-	struct mcbsp_internal_clk *mclk = container_of(clk,
-					struct mcbsp_internal_clk, clk);
-	int i;
-
-	for (i = 0; i < mclk->n_childs; i++)
-		clk_disable(mclk->childs[i]);
-}
-
-static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
+static struct vclk omap_mcbsp_clks[] = {
 	{
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 1,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 3,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 };
-
-#define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
 #else
-#define omap_mcbsp_clks_size	0
-static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
-static inline void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
-{ }
+static struct vclk __initdata *omap_mcbsp_clks;
 #endif
 
 static void omap1_mcbsp_request(unsigned int id)
@@ -228,14 +170,12 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 
 int __init omap1_mcbsp_init(void)
 {
-	int i;
+	int err;
 
-	for (i = 0; i < omap_mcbsp_clks_size; i++) {
-		if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
-			omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
-			clk_register(&omap_mcbsp_clks[i].clk);
-		}
-	}
+	err = omap_mcbsp_register_clk(omap_mcbsp_clks,
+				      ARRAY_SIZE(omap_mcbsp_clks));
+	if (err)
+		return err;
 
 	if (cpu_is_omap730())
 		omap_mcbsp_count = OMAP730_MCBSP_PDATA_SZ;
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 7addc5a..2744a6d 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -22,105 +22,41 @@
 #include <mach/cpu.h>
 #include <mach/mcbsp.h>
 
-struct mcbsp_internal_clk {
-	struct clk clk;
-	struct clk **childs;
-	int n_childs;
-};
-
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
-{
-	const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
-	int i;
-
-	mclk->n_childs = ARRAY_SIZE(clk_names);
-	mclk->childs = kzalloc(mclk->n_childs * sizeof(struct clk *),
-				GFP_KERNEL);
-
-	for (i = 0; i < mclk->n_childs; i++) {
-		/* We fake a platform device to get correct device id */
-		struct platform_device pdev;
-
-		pdev.dev.bus = &platform_bus_type;
-		pdev.id = mclk->clk.id;
-		mclk->childs[i] = clk_get(&pdev.dev, clk_names[i]);
-		if (IS_ERR(mclk->childs[i]))
-			printk(KERN_ERR "Could not get clock %s (%d).\n",
-				clk_names[i], mclk->clk.id);
-	}
-}
-
-static int omap_mcbsp_clk_enable(struct clk *clk)
-{
-	struct mcbsp_internal_clk *mclk = container_of(clk,
-					struct mcbsp_internal_clk, clk);
-	int i;
-
-	for (i = 0; i < mclk->n_childs; i++)
-		clk_enable(mclk->childs[i]);
-	return 0;
-}
-
-static void omap_mcbsp_clk_disable(struct clk *clk)
-{
-	struct mcbsp_internal_clk *mclk = container_of(clk,
-					struct mcbsp_internal_clk, clk);
-	int i;
-
-	for (i = 0; i < mclk->n_childs; i++)
-		clk_disable(mclk->childs[i]);
-}
-
-static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
+static struct vclk omap_mcbsp_clks[] = {
 	{
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 1,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name 		= "mcbsp_clk",
 			.id		= 2,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 3,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 4,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 	{
 		.clk = {
 			.name		= "mcbsp_clk",
 			.id		= 5,
-			.enable		= omap_mcbsp_clk_enable,
-			.disable	= omap_mcbsp_clk_disable,
 		},
 	},
 };
-
-#define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
 #else
-#define omap_mcbsp_clks_size	0
-static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
-static inline void omap_mcbsp_clk_init(struct clk *clk)
-{ }
+static struct vclk __initdata *omap_mcbsp_clks;
 #endif
 
 static void omap2_mcbsp2_mux_setup(void)
@@ -222,13 +158,12 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 
 static int __init omap2_mcbsp_init(void)
 {
-	int i;
+	int err;
 
-	for (i = 0; i < omap_mcbsp_clks_size; i++) {
-		/* Once we call clk_get inside init, we do not register it */
-		omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
-		clk_register(&omap_mcbsp_clks[i].clk);
-	}
+	err = omap_mcbsp_register_clk(omap_mcbsp_clks,
+				      ARRAY_SIZE(omap_mcbsp_clks));
+	if (err)
+		return err;
 
 	if (cpu_is_omap24xx())
 		omap_mcbsp_count = OMAP24XX_MCBSP_PDATA_SZ;
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 3bd1da2..4468d16 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -155,6 +155,40 @@ static inline void omap_init_kp(void) {}
 
 static struct platform_device **omap_mcbsp_devices;
 
+/* Machine dependent virtual clock registration */
+int omap_mcbsp_register_clk(struct vclk *vclks, int n)
+{
+	int i, err;
+	struct vclk *p;
+	struct vclk_cci cci[] = {
+		{
+			.name = "mcbsp_ick",
+		},
+		{
+			.name = "mcbsp_fck",
+		},
+	};
+
+	if (!vclks)
+		return 0;
+
+	p = vclks;
+	for (i = 0; i < n; i++, p++) {
+		int j;
+		for (j = 0; j < ARRAY_SIZE(cci); j++)
+			cci[j].id = p->clk.id;
+		err = vclk_register(p, cci, ARRAY_SIZE(cci));
+		if (err)
+			goto err_out;
+	}
+	return 0;
+err_out:
+	while (--i >= 0)
+		vclk_unregister(&vclks[i]);
+	return err;
+}
+EXPORT_SYMBOL(omap_mcbsp_register_clk);
+
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size)
 {
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index f4e7980..7b690bb 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -370,6 +370,8 @@ extern int omap_mcbsp_count;
 int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size);
+int omap_mcbsp_register_clk(struct vclk *vclks, int n);
+
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
-- 
1.5.5.1.357.g1af8b

