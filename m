From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 07/20] Move clock functions from core driver to dss driver
Date: Mon, 23 Aug 2010 21:27:56 +0530
Message-ID: <1282579089-10487-8-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38248 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab0HWP60 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:26 -0400
In-Reply-To: <1282579089-10487-7-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

dss clocks are moved to dss platform driver.  clk_get/put
APIs use dss device instead of core platform device.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |  372 +--------------------------------------
 drivers/video/omap2/dss/dss.c  |  378 +++++++++++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss.h  |   14 +-
 3 files changed, 392 insertions(+), 372 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index f01e8e6..24b93d5 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -34,20 +34,12 @@
 #include <linux/regulator/consumer.h>
 
 #include <plat/display.h>
-#include <plat/clock.h>
+
 
 #include "dss.h"
 
 static struct {
 	struct platform_device *pdev;
-	int		ctx_id;
-
-	struct clk      *dss_ick;
-	struct clk	*dss1_fck;
-	struct clk	*dss2_fck;
-	struct clk      *dss_54m_fck;
-	struct clk	*dss_96m_fck;
-	unsigned	num_clks_enabled;
 
 	struct regulator *vdds_dsi_reg;
 	struct regulator *vdds_sdi_reg;
@@ -55,10 +47,6 @@ static struct {
 	struct omap_dss_board_info *pdata;
 } core;
 
-static void dss_clk_enable_all_no_ctx(void);
-static void dss_clk_disable_all_no_ctx(void);
-static void dss_clk_enable_no_ctx(enum dss_clock clks);
-static void dss_clk_disable_no_ctx(enum dss_clock clks);
 
 static char *def_disp_name;
 module_param_named(def_disp, def_disp_name, charp, 0);
@@ -69,296 +57,8 @@ unsigned int dss_debug;
 module_param_named(debug, dss_debug, bool, 0644);
 #endif
 
-/* CONTEXT */
-static int dss_get_ctx_id(void)
-{
-	struct omap_dss_board_info *pdata = core.pdev->dev.platform_data;
-	int r;
-
-	if (!pdata->get_last_off_on_transaction_id)
-		return 0;
-	r = pdata->get_last_off_on_transaction_id(&core.pdev->dev);
-	if (r < 0) {
-		dev_err(&core.pdev->dev, "getting transaction ID failed, "
-				"will force context restore\n");
-		r = -1;
-	}
-	return r;
-}
-
-int dss_need_ctx_restore(void)
-{
-	int id = dss_get_ctx_id();
-
-	if (id < 0 || id != core.ctx_id) {
-		DSSDBG("ctx id %d -> id %d\n",
-				core.ctx_id, id);
-		core.ctx_id = id;
-		return 1;
-	} else {
-		return 0;
-	}
-}
-
-static void save_all_ctx(void)
-{
-	DSSDBG("save context\n");
-
-	dss_clk_enable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
-
-	dss_save_context();
-	dispc_save_context();
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_save_context();
-#endif
-
-	dss_clk_disable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
-}
-
-static void restore_all_ctx(void)
-{
-	DSSDBG("restore context\n");
-
-	dss_clk_enable_all_no_ctx();
-
-	dss_restore_context();
-	dispc_restore_context();
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_restore_context();
-#endif
-
-	dss_clk_disable_all_no_ctx();
-}
-
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
-/* CLOCKS */
-static void core_dump_clocks(struct seq_file *s)
-{
-	int i;
-	struct clk *clocks[5] = {
-		core.dss_ick,
-		core.dss1_fck,
-		core.dss2_fck,
-		core.dss_54m_fck,
-		core.dss_96m_fck
-	};
-
-	seq_printf(s, "- CORE -\n");
-
-	seq_printf(s, "internal clk count\t\t%u\n", core.num_clks_enabled);
-
-	for (i = 0; i < 5; i++) {
-		if (!clocks[i])
-			continue;
-		seq_printf(s, "%-15s\t%lu\t%d\n",
-				clocks[i]->name,
-				clk_get_rate(clocks[i]),
-				clocks[i]->usecount);
-	}
-}
-#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
-
-static int dss_get_clock(struct clk **clock, const char *clk_name)
-{
-	struct clk *clk;
-
-	clk = clk_get(&core.pdev->dev, clk_name);
-
-	if (IS_ERR(clk)) {
-		DSSERR("can't get clock %s", clk_name);
-		return PTR_ERR(clk);
-	}
-
-	*clock = clk;
-
-	DSSDBG("clk %s, rate %ld\n", clk_name, clk_get_rate(clk));
 
-	return 0;
-}
-
-static int dss_get_clocks(void)
-{
-	int r;
-
-	core.dss_ick = NULL;
-	core.dss1_fck = NULL;
-	core.dss2_fck = NULL;
-	core.dss_54m_fck = NULL;
-	core.dss_96m_fck = NULL;
-
-	r = dss_get_clock(&core.dss_ick, "ick");
-	if (r)
-		goto err;
 
-	r = dss_get_clock(&core.dss1_fck, "dss1_fck");
-	if (r)
-		goto err;
-
-	r = dss_get_clock(&core.dss2_fck, "dss2_fck");
-	if (r)
-		goto err;
-
-	r = dss_get_clock(&core.dss_54m_fck, "tv_fck");
-	if (r)
-		goto err;
-
-	r = dss_get_clock(&core.dss_96m_fck, "video_fck");
-	if (r)
-		goto err;
-
-	return 0;
-
-err:
-	if (core.dss_ick)
-		clk_put(core.dss_ick);
-	if (core.dss1_fck)
-		clk_put(core.dss1_fck);
-	if (core.dss2_fck)
-		clk_put(core.dss2_fck);
-	if (core.dss_54m_fck)
-		clk_put(core.dss_54m_fck);
-	if (core.dss_96m_fck)
-		clk_put(core.dss_96m_fck);
-
-	return r;
-}
-
-static void dss_put_clocks(void)
-{
-	if (core.dss_96m_fck)
-		clk_put(core.dss_96m_fck);
-	clk_put(core.dss_54m_fck);
-	clk_put(core.dss1_fck);
-	clk_put(core.dss2_fck);
-	clk_put(core.dss_ick);
-}
-
-unsigned long dss_clk_get_rate(enum dss_clock clk)
-{
-	switch (clk) {
-	case DSS_CLK_ICK:
-		return clk_get_rate(core.dss_ick);
-	case DSS_CLK_FCK1:
-		return clk_get_rate(core.dss1_fck);
-	case DSS_CLK_FCK2:
-		return clk_get_rate(core.dss2_fck);
-	case DSS_CLK_54M:
-		return clk_get_rate(core.dss_54m_fck);
-	case DSS_CLK_96M:
-		return clk_get_rate(core.dss_96m_fck);
-	}
-
-	BUG();
-	return 0;
-}
-
-static unsigned count_clk_bits(enum dss_clock clks)
-{
-	unsigned num_clks = 0;
-
-	if (clks & DSS_CLK_ICK)
-		++num_clks;
-	if (clks & DSS_CLK_FCK1)
-		++num_clks;
-	if (clks & DSS_CLK_FCK2)
-		++num_clks;
-	if (clks & DSS_CLK_54M)
-		++num_clks;
-	if (clks & DSS_CLK_96M)
-		++num_clks;
-
-	return num_clks;
-}
-
-static void dss_clk_enable_no_ctx(enum dss_clock clks)
-{
-	unsigned num_clks = count_clk_bits(clks);
-
-	if (clks & DSS_CLK_ICK)
-		clk_enable(core.dss_ick);
-	if (clks & DSS_CLK_FCK1)
-		clk_enable(core.dss1_fck);
-	if (clks & DSS_CLK_FCK2)
-		clk_enable(core.dss2_fck);
-	if (clks & DSS_CLK_54M)
-		clk_enable(core.dss_54m_fck);
-	if (clks & DSS_CLK_96M)
-		clk_enable(core.dss_96m_fck);
-
-	core.num_clks_enabled += num_clks;
-}
-
-void dss_clk_enable(enum dss_clock clks)
-{
-	bool check_ctx = core.num_clks_enabled == 0;
-
-	dss_clk_enable_no_ctx(clks);
-
-	if (check_ctx && cpu_is_omap34xx() && dss_need_ctx_restore())
-		restore_all_ctx();
-}
-
-static void dss_clk_disable_no_ctx(enum dss_clock clks)
-{
-	unsigned num_clks = count_clk_bits(clks);
-
-	if (clks & DSS_CLK_ICK)
-		clk_disable(core.dss_ick);
-	if (clks & DSS_CLK_FCK1)
-		clk_disable(core.dss1_fck);
-	if (clks & DSS_CLK_FCK2)
-		clk_disable(core.dss2_fck);
-	if (clks & DSS_CLK_54M)
-		clk_disable(core.dss_54m_fck);
-	if (clks & DSS_CLK_96M)
-		clk_disable(core.dss_96m_fck);
-
-	core.num_clks_enabled -= num_clks;
-}
-
-void dss_clk_disable(enum dss_clock clks)
-{
-	if (cpu_is_omap34xx()) {
-		unsigned num_clks = count_clk_bits(clks);
-
-		BUG_ON(core.num_clks_enabled < num_clks);
-
-		if (core.num_clks_enabled == num_clks)
-			save_all_ctx();
-	}
-
-	dss_clk_disable_no_ctx(clks);
-}
-
-static void dss_clk_enable_all_no_ctx(void)
-{
-	enum dss_clock clks;
-
-	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
-	if (cpu_is_omap34xx())
-		clks |= DSS_CLK_96M;
-	dss_clk_enable_no_ctx(clks);
-}
-
-static void dss_clk_disable_all_no_ctx(void)
-{
-	enum dss_clock clks;
-
-	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
-	if (cpu_is_omap34xx())
-		clks |= DSS_CLK_96M;
-	dss_clk_disable_no_ctx(clks);
-}
-
-static void dss_clk_disable_all(void)
-{
-	enum dss_clock clks;
-
-	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
-	if (cpu_is_omap34xx())
-		clks |= DSS_CLK_96M;
-	dss_clk_disable(clks);
-}
 
 /* REGULATORS */
 
@@ -404,18 +104,8 @@ struct regulator *dss_get_vdda_dac(void)
 	return reg;
 }
 
-/* DEBUGFS */
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
-static void dss_debug_dump_clocks(struct seq_file *s)
-{
-	core_dump_clocks(s);
-	dss_dump_clocks(s);
-	dispc_dump_clocks(s);
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_dump_clocks(s);
-#endif
-}
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 static int dss_debug_show(struct seq_file *s, void *unused)
 {
 	void (*func)(struct seq_file *) = s->private;
@@ -507,14 +197,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
 
-	r = dss_get_clocks();
-	if (r)
-		goto err_clocks;
-
-	dss_clk_enable_all_no_ctx();
-
-	core.ctx_id = dss_get_ctx_id();
-	DSSDBG("initial ctx id %u\n", core.ctx_id);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
 
 #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
 	/* DISPC_CONTROL */
@@ -588,7 +271,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 			pdata->default_device = dssdev;
 	}
 
-	dss_clk_disable_all();
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
 
 	return 0;
 
@@ -611,9 +294,7 @@ err_dpi:
 err_rfbi:
 	dss_exit();
 err_dss:
-	dss_clk_disable_all_no_ctx();
-	dss_put_clocks();
-err_clocks:
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
 
 	return r;
 }
@@ -622,7 +303,7 @@ static int omap_dss_remove(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int i;
-	int c;
+
 
 	dss_uninitialize_debugfs();
 
@@ -637,47 +318,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_exit();
 
-	/* these should be removed at some point */
-	c = core.dss_ick->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss_ick usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss_ick);
-	}
-
-	c = core.dss1_fck->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss1_fck usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss1_fck);
-	}
-
-	c = core.dss2_fck->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss2_fck usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss2_fck);
-	}
-
-	c = core.dss_54m_fck->usecount;
-	if (c > 0) {
-		DSSERR("warning: dss_54m_fck usecount %d, disabling\n", c);
-		while (c-- > 0)
-			clk_disable(core.dss_54m_fck);
-	}
-
-	if (core.dss_96m_fck) {
-		c = core.dss_96m_fck->usecount;
-		if (c > 0) {
-			DSSERR("warning: dss_96m_fck usecount %d, disabling\n",
-					c);
-			while (c-- > 0)
-				clk_disable(core.dss_96m_fck);
-		}
-	}
-
-	dss_put_clocks();
-
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 5f91e37..15d0399 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -31,6 +31,7 @@
 #include <linux/clk.h>
 
 #include <plat/display.h>
+#include <plat/clock.h>
 #include "dss.h"
 
 #define DSS_BASE			0x48050000
@@ -59,9 +60,18 @@ struct dss_reg {
 	dss_write_reg(idx, FLD_MOD(dss_read_reg(idx), val, start, end))
 
 static struct {
+	struct platform_device *pdev;
+
 	void __iomem    *base;
+	int		ctx_id;
 
 	struct clk	*dpll4_m4_ck;
+	struct clk      *dss_ick;
+	struct clk	*dss1_fck;
+	struct clk	*dss2_fck;
+	struct clk      *dss_54m_fck;
+	struct clk	*dss_96m_fck;
+	unsigned	num_clks_enabled;
 
 	unsigned long	cache_req_pck;
 	unsigned long	cache_prate;
@@ -74,6 +84,11 @@ static struct {
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 } dss;
 
+static void dss_clk_enable_all_no_ctx(void);
+static void dss_clk_disable_all_no_ctx(void);
+static void dss_clk_enable_no_ctx(enum dss_clock clks);
+static void dss_clk_disable_no_ctx(enum dss_clock clks);
+
 static int _omap_dss_wait_reset(void);
 
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
@@ -122,14 +137,375 @@ void dss_restore_context(void)
 #undef SR
 #undef RR
 
+/* CONTEXT */
+static int dss_get_ctx_id(void)
+{
+	struct omap_display_platform_data *pdata = dss.pdev->dev.platform_data;
+	int r;
+
+	if (!pdata->board_data->get_last_off_on_transaction_id)
+		return 0;
+	r = pdata->board_data->get_last_off_on_transaction_id(&dss.pdev->dev);
+	if (r < 0) {
+		dev_err(&dss.pdev->dev, "getting transaction ID failed, "
+				"will force context restore\n");
+		r = -1;
+	}
+	return r;
+}
+
+int dss_need_ctx_restore(void)
+{
+	int id = dss_get_ctx_id();
+
+	if (id < 0 || id != dss.ctx_id) {
+		DSSDBG("ctx id %d -> id %d\n",
+				dss.ctx_id, id);
+		dss.ctx_id = id;
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+static void save_all_ctx(void)
+{
+	DSSDBG("save context\n");
+
+	dss_clk_enable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
+
+	dss_save_context();
+	dispc_save_context();
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_save_context();
+#endif
+
+	dss_clk_disable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
+}
+
+static void restore_all_ctx(void)
+{
+	DSSDBG("restore context\n");
+
+	dss_clk_enable_all_no_ctx();
+
+	dss_restore_context();
+	dispc_restore_context();
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_restore_context();
+#endif
+
+	dss_clk_disable_all_no_ctx();
+}
+
+static int dss_get_clock(struct clk **clock, const char *clk_name)
+{
+	struct clk *clk;
+
+	clk = clk_get(&dss.pdev->dev, clk_name);
+
+	if (IS_ERR(clk)) {
+		DSSERR("can't get clock %s", clk_name);
+		return PTR_ERR(clk);
+	}
+
+	*clock = clk;
+
+	DSSDBG("clk %s, rate %ld\n", clk_name, clk_get_rate(clk));
+
+	return 0;
+}
+
+static int dss_get_clocks(void)
+{
+	int r;
+
+	dss.dss_ick = NULL;
+	dss.dss1_fck = NULL;
+	dss.dss2_fck = NULL;
+	dss.dss_54m_fck = NULL;
+	dss.dss_96m_fck = NULL;
+
+	r = dss_get_clock(&dss.dss_ick, "ick");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&dss.dss1_fck, "dss1_fck");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&dss.dss2_fck, "dss2_fck");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&dss.dss_54m_fck, "tv_fck");
+	if (r)
+		goto err;
+
+	r = dss_get_clock(&dss.dss_96m_fck, "video_fck");
+	if (r)
+		goto err;
+
+	return 0;
+
+err:
+	if (dss.dss_ick)
+		clk_put(dss.dss_ick);
+	if (dss.dss1_fck)
+		clk_put(dss.dss1_fck);
+	if (dss.dss2_fck)
+		clk_put(dss.dss2_fck);
+	if (dss.dss_54m_fck)
+		clk_put(dss.dss_54m_fck);
+	if (dss.dss_96m_fck)
+		clk_put(dss.dss_96m_fck);
+
+	return r;
+}
+
+static void dss_put_clocks(void)
+{
+	if (dss.dss_96m_fck)
+		clk_put(dss.dss_96m_fck);
+	clk_put(dss.dss_54m_fck);
+	clk_put(dss.dss1_fck);
+	clk_put(dss.dss2_fck);
+	clk_put(dss.dss_ick);
+}
+
+unsigned long dss_clk_get_rate(enum dss_clock clk)
+{
+	switch (clk) {
+	case DSS_CLK_ICK:
+		return clk_get_rate(dss.dss_ick);
+	case DSS_CLK_FCK1:
+		return clk_get_rate(dss.dss1_fck);
+	case DSS_CLK_FCK2:
+		return clk_get_rate(dss.dss2_fck);
+	case DSS_CLK_54M:
+		return clk_get_rate(dss.dss_54m_fck);
+	case DSS_CLK_96M:
+		return clk_get_rate(dss.dss_96m_fck);
+	}
+
+	BUG();
+	return 0;
+}
+
+static unsigned count_clk_bits(enum dss_clock clks)
+{
+	unsigned num_clks = 0;
+
+	if (clks & DSS_CLK_ICK)
+		++num_clks;
+	if (clks & DSS_CLK_FCK1)
+		++num_clks;
+	if (clks & DSS_CLK_FCK2)
+		++num_clks;
+	if (clks & DSS_CLK_54M)
+		++num_clks;
+	if (clks & DSS_CLK_96M)
+		++num_clks;
+
+	return num_clks;
+}
+
+static void dss_clk_enable_no_ctx(enum dss_clock clks)
+{
+	unsigned num_clks = count_clk_bits(clks);
+
+	if (clks & DSS_CLK_ICK)
+		clk_enable(dss.dss_ick);
+	if (clks & DSS_CLK_FCK1)
+		clk_enable(dss.dss1_fck);
+	if (clks & DSS_CLK_FCK2)
+		clk_enable(dss.dss2_fck);
+	if (clks & DSS_CLK_54M)
+		clk_enable(dss.dss_54m_fck);
+	if (clks & DSS_CLK_96M)
+		clk_enable(dss.dss_96m_fck);
+
+	dss.num_clks_enabled += num_clks;
+}
+
+void dss_clk_enable(enum dss_clock clks)
+{
+	bool check_ctx = dss.num_clks_enabled == 0;
+
+	dss_clk_enable_no_ctx(clks);
+
+	if (check_ctx && cpu_is_omap34xx() && dss_need_ctx_restore())
+		restore_all_ctx();
+}
+
+static void dss_clk_disable_no_ctx(enum dss_clock clks)
+{
+	unsigned num_clks = count_clk_bits(clks);
+
+	if (clks & DSS_CLK_ICK)
+		clk_disable(dss.dss_ick);
+	if (clks & DSS_CLK_FCK1)
+		clk_disable(dss.dss1_fck);
+	if (clks & DSS_CLK_FCK2)
+		clk_disable(dss.dss2_fck);
+	if (clks & DSS_CLK_54M)
+		clk_disable(dss.dss_54m_fck);
+	if (clks & DSS_CLK_96M)
+		clk_disable(dss.dss_96m_fck);
+
+	dss.num_clks_enabled -= num_clks;
+}
+
+void dss_clk_disable(enum dss_clock clks)
+{
+	if (cpu_is_omap34xx()) {
+		unsigned num_clks = count_clk_bits(clks);
+
+		BUG_ON(dss.num_clks_enabled < num_clks);
+
+		if (dss.num_clks_enabled == num_clks)
+			save_all_ctx();
+	}
+
+	dss_clk_disable_no_ctx(clks);
+}
+
+static void dss_clk_enable_all_no_ctx(void)
+{
+	enum dss_clock clks;
+
+	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	if (cpu_is_omap34xx())
+		clks |= DSS_CLK_96M;
+	dss_clk_enable_no_ctx(clks);
+}
+
+static void dss_clk_disable_all_no_ctx(void)
+{
+	enum dss_clock clks;
+
+	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	if (cpu_is_omap34xx())
+		clks |= DSS_CLK_96M;
+	dss_clk_disable_no_ctx(clks);
+}
+
+static void dss_clk_disable_all(void)
+{
+	enum dss_clock clks;
+
+	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	if (cpu_is_omap34xx())
+		clks |= DSS_CLK_96M;
+	dss_clk_disable(clks);
+}
+
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+/* CLOCKS */
+static void core_dump_clocks(struct seq_file *s)
+{
+	int i;
+	struct clk *clocks[5] = {
+		dss.dss_ick,
+		dss.dss1_fck,
+		dss.dss2_fck,
+		dss.dss_54m_fck,
+		dss.dss_96m_fck
+	};
+
+	seq_printf(s, "- CORE -\n");
+
+	seq_printf(s, "internal clk count\t\t%u\n", dss.num_clks_enabled);
+
+	for (i = 0; i < 5; i++) {
+		if (!clocks[i])
+			continue;
+		seq_printf(s, "%-15s\t%lu\t%d\n",
+				clocks[i]->name,
+				clk_get_rate(clocks[i]),
+				clocks[i]->usecount);
+	}
+}
+#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
+
+/* DEBUGFS */
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+void dss_debug_dump_clocks(struct seq_file *s)
+{
+	core_dump_clocks(s);
+	dss_dump_clocks(s);
+	dispc_dump_clocks(s);
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_dump_clocks(s);
+#endif
+}
+#endif
+
 /* DSS HW IP initialisation */
 static int omap_dsshw_probe(struct platform_device *pdev)
 {
-	return 0;
+	int r;
+
+	dss.pdev = pdev;
+
+	r = dss_get_clocks();
+	if (r)
+		goto err_clocks;
+
+	dss_clk_enable_all_no_ctx();
+
+	dss.ctx_id = dss_get_ctx_id();
+	DSSDBG("initial ctx id %u\n", dss.ctx_id);
+
+err_clocks:
+
+	return r;
 }
 
 static int omap_dsshw_remove(struct platform_device *pdev)
 {
+	int c;
+
+	/* these should be removed at some point */
+	c = dss.dss_ick->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss_ick usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(dss.dss_ick);
+	}
+
+	c = dss.dss1_fck->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss1_fck usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(dss.dss1_fck);
+	}
+
+	c = dss.dss2_fck->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss2_fck usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(dss.dss2_fck);
+	}
+
+	c = dss.dss_54m_fck->usecount;
+	if (c > 0) {
+		DSSERR("warning: dss_54m_fck usecount %d, disabling\n", c);
+		while (c-- > 0)
+			clk_disable(dss.dss_54m_fck);
+	}
+
+	if (dss.dss_96m_fck) {
+		c = dss.dss_96m_fck->usecount;
+		if (c > 0) {
+			DSSERR("warning: dss_96m_fck usecount %d, disabling\n",
+					c);
+			while (c-- > 0)
+				clk_disable(dss.dss_96m_fck);
+		}
+	}
+
+	dss_put_clocks();
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 786f433..3f79292 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -169,11 +169,6 @@ struct seq_file;
 struct platform_device;
 
 /* core */
-void dss_clk_enable(enum dss_clock clks);
-void dss_clk_disable(enum dss_clock clks);
-unsigned long dss_clk_get_rate(enum dss_clock clk);
-int dss_need_ctx_restore(void);
-void dss_dump_clocks(struct seq_file *s);
 struct bus_type *dss_get_bus(void);
 struct regulator *dss_get_vdds_dsi(void);
 struct regulator *dss_get_vdds_sdi(void);
@@ -219,7 +214,16 @@ void dss_exit(void);
 void dss_save_context(void);
 void dss_restore_context(void);
 
+void dss_clk_enable(enum dss_clock clks);
+void dss_clk_disable(enum dss_clock clks);
+unsigned long dss_clk_get_rate(enum dss_clock clk);
+int dss_need_ctx_restore(void);
+void dss_dump_clocks(struct seq_file *s);
+
 void dss_dump_regs(struct seq_file *s);
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+void dss_debug_dump_clocks(struct seq_file *s);
+#endif
 
 void dss_sdi_init(u8 datapairs);
 int dss_sdi_enable(void);
-- 
1.6.3.3

