From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 16/28] OMAP3: HWMOD: Add DSS opt clocks
Date: Mon, 1 Aug 2011 19:27:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108011914280.28427@utopia.booyaka.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com> <1307627810-3768-17-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.00.1107150048530.16606@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51319 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1HBB16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 21:27:58 -0400
In-Reply-To: <alpine.DEB.2.00.1107150048530.16606@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

Hello Tomi,

On Fri, 15 Jul 2011, Paul Walmsley wrote:

> On Thu, 9 Jun 2011, Tomi Valkeinen wrote:
> 
> > Add DSS optional clocks to HWMOD data for OMAP3xxx.
> 
> Thanks; queued for 3.1-rc fixes at git://git.pwsan.com/linux-2.6 in the 
> branch 'omap2_3_hwmod_dss_fixes_3.1rc'.  

This patch has been updated to remove the temporary hack added to the DSS 
driver.  Care to review it before it's sent to Tony?


- Paul

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 15 Jul 2011 00:54:34 -0600
Subject: [PATCH 2/2] OMAP3: HWMOD: Add DSS opt clocks

Add DSS optional clocks to HWMOD data for OMAP3xxx.

Revert OMAP3 portion of commit
9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack
for OMAP2/3").

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[paul@pwsan.com: remove temporary DSS driver hack; update changelog]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   32 ++++++++++++++++++++++++---
 drivers/video/omap2/dss/dsi.c              |    2 +-
 drivers/video/omap2/dss/dss.h              |    2 -
 drivers/video/omap2/dss/rfbi.c             |    5 +---
 drivers/video/omap2/dss/venc.c             |    5 +---
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 25bf43b..38ee033 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1365,9 +1365,14 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "tv_clk", .clk = "dss_tv_fck" },
-	{ .role = "video_clk", .clk = "dss_96m_fck" },
+	/*
+	 * The rest of the clocks are not needed by the driver,
+	 * but are needed by the hwmod to reset DSS properly.
+	 */
 	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+	{ .role = "tv_clk", .clk = "dss_tv_fck" },
+	/* required only on OMAP3430 */
+	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
 };
 
 static struct omap_hwmod omap3430es1_dss_core_hwmod = {
@@ -1504,6 +1509,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
 	&omap3xxx_l4_core__dss_dsi1,
 };
 
+static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap3xxx_dsi_hwmod_class,
@@ -1516,6 +1525,8 @@ static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_dsi1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_opt_clks),
 	.slaves		= omap3xxx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1545,6 +1556,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_rfbi_slaves[] = {
 	&omap3xxx_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -1556,6 +1571,8 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap3xxx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1568,7 +1585,7 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_venc_hwmod,
-	.clk		= "dss_tv_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
@@ -1586,10 +1603,15 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_venc_slaves[] = {
 	&omap3xxx_l4_core__dss_venc,
 };
 
+static struct omap_hwmod_opt_clk dss_venc_opt_clks[] = {
+	/* required only on OMAP3430 */
+	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_alwon_fck",
+	.main_clk	= "dss_tv_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1597,6 +1619,8 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_venc_opt_clks),
 	.slaves		= omap3xxx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 7adbbeb..0645170 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4427,7 +4427,7 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct clk *clk;
 
-	clk = clk_get(&dsidev->dev, "fck");
+	clk = clk_get(&dsidev->dev, "sys_clk");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get fck\n");
 		return PTR_ERR(clk);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9c94b11..adeff04 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -209,8 +209,6 @@ void dss_uninit_platform_driver(void);
 int dss_runtime_get(void);
 void dss_runtime_put(void);
 
-struct clk *dss_get_ick(void);
-
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 457f1ac..2d31cc1 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -952,10 +952,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 
 	msleep(10);
 
-	if (cpu_is_omap34xx() || cpu_is_omap3630())
-		clk = dss_get_ick();
-	else
-		clk = clk_get(&pdev->dev, "ick");
+	clk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get ick\n");
 		r = PTR_ERR(clk);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 173c664..71e005d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -741,10 +741,7 @@ static int venc_get_clocks(struct platform_device *pdev)
 	venc.tv_clk = clk;
 
 	if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK)) {
-		if (cpu_is_omap34xx() || cpu_is_omap3630())
-			clk = clk_get(&pdev->dev, "dss_96m_fck");
-		else
-			clk = clk_get(&pdev->dev, "tv_dac_clk");
+		clk = clk_get(&pdev->dev, "tv_dac_clk");
 		if (IS_ERR(clk)) {
 			DSSERR("can't get tv_dac_clk\n");
 			clk_put(venc.tv_clk);
-- 
1.7.5.4

