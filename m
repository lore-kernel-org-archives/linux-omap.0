From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 13/14] omap: mcbsp: Start generalize omap2_mcbsp_set_clks_src
Date: Wed, 31 Aug 2011 18:23:00 +0300
Message-ID: <1314804181-17260-14-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:36928 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618Ab1HaPlq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:41:46 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

This generalizes the omap2_mcbsp_set_clks_src implementation between generic
McBSP and OMAP2 specific McBSP code. Currently this function is used to
select either internal fclk or clks pin as a McBSP CLKS source on OMAP2+.

Implement generalization by having an optional set_clk_src function pointer
in platform data that is used to select parent for a given clock. Idea is to
pass higher level source clock name (later coming from client driver) that
platform specific code will map to platform specific clock name.

API cleanup between McBSP and client code comes later.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   25 ++++++++---------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    5 +---
 arch/arm/plat-omap/mcbsp.c              |   33 +++++++++++++++++++++++-------
 3 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index bc51424..8a534b9 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -63,37 +63,30 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
 
 /* McBSP CLKS source switching function */
-
-int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
+static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
+				   const char *src)
 {
-	struct omap_mcbsp *mcbsp;
 	struct clk *fck_src;
 	char *fck_src_name;
 	int r;
 
-	if (!omap_mcbsp_check_valid_id(id)) {
-		pr_err("%s: Invalid id (%d)\n", __func__, id + 1);
-		return -EINVAL;
-	}
-	mcbsp = id_to_mcbsp_ptr(id);
-
-	if (fck_src_id == MCBSP_CLKS_PAD_SRC)
+	if (!strcmp(src, "clks_ext"))
 		fck_src_name = "pad_fck";
-	else if (fck_src_id == MCBSP_CLKS_PRCM_SRC)
+	else if (!strcmp(src, "clks_fclk"))
 		fck_src_name = "prcm_fck";
 	else
 		return -EINVAL;
 
-	fck_src = clk_get(mcbsp->dev, fck_src_name);
+	fck_src = clk_get(dev, fck_src_name);
 	if (IS_ERR_OR_NULL(fck_src)) {
 		pr_err("omap-mcbsp: %s: could not clk_get() %s\n", "clks",
 		       fck_src_name);
 		return -EINVAL;
 	}
 
-	pm_runtime_put_sync(mcbsp->dev);
+	pm_runtime_put_sync(dev);
 
-	r = clk_set_parent(mcbsp->fclk, fck_src);
+	r = clk_set_parent(clk, fck_src);
 	if (IS_ERR_VALUE(r)) {
 		pr_err("omap-mcbsp: %s: could not clk_set_parent() to %s\n",
 		       "clks", fck_src_name);
@@ -101,13 +94,12 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(mcbsp->dev);
+	pm_runtime_get_sync(dev);
 
 	clk_put(fck_src);
 
 	return 0;
 }
-EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
 static int omap3_enable_st_clock(unsigned int id, bool enable)
 {
@@ -188,6 +180,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 					name, oh->name);
 		return PTR_ERR(od);
 	}
+	pdata->set_clk_src = omap2_mcbsp_set_clk_src;
 	omap_mcbsp_count++;
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index af5824a..c8ebfc9 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -296,7 +296,6 @@ typedef enum {
 struct omap_mcbsp_ops {
 	void (*request)(unsigned int);
 	void (*free)(unsigned int);
-	int (*set_clks_src)(u8, u8);
 };
 
 struct omap_mcbsp_platform_data {
@@ -309,6 +308,7 @@ struct omap_mcbsp_platform_data {
 	bool has_wakeup; /* Wakeup capability */
 	bool has_ccr; /* Transceiver has configuration control registers */
 	int (*enable_st_clock)(unsigned int, bool);
+	int (*set_clk_src)(struct device *dev, struct clk *clk, const char *src);
 };
 
 struct omap_mcbsp_st_data {
@@ -359,9 +359,6 @@ struct omap_mcbsp_dev_attr {
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
 
-#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
-#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
-
 int omap_mcbsp_init(void);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
 void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index f92227f..38b67d9 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -29,6 +29,9 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
 
+#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
+#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
+
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	void __iomem *addr = mcbsp->io_base + reg * mcbsp->pdata->reg_step;
@@ -894,18 +897,32 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
-/*
- * The following functions are only required on an OMAP1-only build.
- * mach-omap2/mcbsp.c contains the real functions
- */
-#ifndef CONFIG_ARCH_OMAP2PLUS
 int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 {
-	WARN(1, "%s: should never be called on an OMAP1-only kernel\n",
-	     __func__);
-	return -EINVAL;
+	struct omap_mcbsp *mcbsp;
+	const char *src;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		pr_err("%s: Invalid id (%d)\n", __func__, id + 1);
+		return -EINVAL;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	if (fck_src_id == MCBSP_CLKS_PAD_SRC)
+		src = "clks_ext";
+	else if (fck_src_id == MCBSP_CLKS_PRCM_SRC)
+		src = "clks_fclk";
+	else
+		return -EINVAL;
+
+	if (mcbsp->pdata->set_clk_src)
+		return mcbsp->pdata->set_clk_src(mcbsp->dev, mcbsp->fclk, src);
+	else
+		return -EINVAL;
 }
+EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
+#ifndef CONFIG_ARCH_OMAP2PLUS
 void omap2_mcbsp1_mux_clkr_src(u8 mux)
 {
 	WARN(1, "%s: should never be called on an OMAP1-only kernel\n",
-- 
1.7.5.4

