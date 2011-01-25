From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v2 1/4] OMAP2PLUS: opt-clocks: align dss clock roles and names
Date: Tue, 25 Jan 2011 18:29:55 +0530
Message-ID: <1295960398-25329-2-git-send-email-sumit.semwal@ti.com>
References: <1295960398-25329-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45802 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724Ab1AYNAQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 08:00:16 -0500
In-Reply-To: <1295960398-25329-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Sumit Semwal <sumit.semwal@ti.com>

opt clocks require (NULL, act-clock-name) as entries in clock database,
so that hwmod can replace it with (dev, role) tuple during hwmod data init.

These role names are aligned to be same across OMAP2420, 2430, 3xxx, 44xx
platforms, and also with dss clk handling code, so clk_get/put/enable/disable
APIs in dss can use uniform role names.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c       |   10 +++++++---
 arch/arm/mach-omap2/clock2430_data.c       |   10 +++++++---
 arch/arm/mach-omap2/clock3xxx_data.c       |   22 +++++++++++++++-------
 arch/arm/mach-omap2/clock44xx_data.c       |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 drivers/video/omap2/dss/dss.c              |    8 ++++----
 6 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index d2abc2f..72a1872 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1787,9 +1787,13 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
 	/* DSS domain clocks */
 	CLK("omap_dss",	"ick",		&dss_ick,	CK_242X),
-	CLK("omap_dss",	"dss1_fck",	&dss1_fck,	CK_242X),
-	CLK("omap_dss",	"dss2_fck",	&dss2_fck,	CK_242X),
-	CLK("omap_dss",	"tv_fck",	&dss_54m_fck,	CK_242X),
+	CLK("omap_dss",	"fck",		&dss1_fck,	CK_242X),
+	/*
+	 * clocks handled via hwmod opt_clk mechanism need dev=NULL,
+	 * con=clock name as per actual clk structure, NOT role
+	 */
+	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_242X),
+	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_242X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_242X),
 	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 663f298..b99f881 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1891,9 +1891,13 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
 	/* DSS domain clocks */
 	CLK("omap_dss",	"ick",		&dss_ick,	CK_243X),
-	CLK("omap_dss",	"dss1_fck",	&dss1_fck,	CK_243X),
-	CLK("omap_dss",	"dss2_fck",	&dss2_fck,	CK_243X),
-	CLK("omap_dss",	"tv_fck",	&dss_54m_fck,	CK_243X),
+	CLK("omap_dss",	"fck",		&dss1_fck,	CK_243X),
+	/*
+	 * clocks handled via hwmod opt_clk mechanism need dev=NULL,
+	 * con=clock name as per actual clk structure, NOT role
+	 */
+	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_243X),
+	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_243X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X),
 	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 5c97b93..c32df5d 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3357,13 +3357,21 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_34XX | CK_36XX),
-	CLK("omap_dss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK("omap_dss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("omap_dss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
-	CLK("omap_dss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
-	CLK("omap_dss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
-	CLK("omap_dss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omap_dss",	"ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	/* DSS clocks */
+	CLK("omap_dss",	"fck",		&dss1_alwon_fck_3430es1, CK_3430ES1),
+	CLK("omap_dss",	"fck",		&dss1_alwon_fck_3430es2, CK_3430ES2PLUS
+								| CK_AM35XX),
+	CLK("omap_dss",	"ick",		&dss_ick_3430es1, CK_3430ES1),
+	CLK("omap_dss",	"ick",		&dss_ick_3430es2, CK_3430ES2PLUS
+								| CK_AM35XX),
+	/*
+	 * clocks handled via hwmod opt_clk mechanism need dev=NULL,
+	 * con=clock name as per actual clk structure, NOT role
+	 */
+	CLK(NULL,       "dss_tv_fck",   &dss_tv_fck,    CK_3XXX),
+	CLK(NULL,       "dss_96m_fck",  &dss_96m_fck,   CK_3XXX),
+	CLK(NULL,       "dss2_alwon_fck",       &dss2_alwon_fck,  CK_3XXX),
+
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_34XX | CK_36XX),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_34XX | CK_36XX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e8cb32f..74db324 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3107,11 +3107,16 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
+	/* dss clocks */
+	CLK(NULL,	"fck",				&dss_fck,	CK_443X),
+	/*
+	 * clocks handled via hwmod opt_clk mechanism need dev=NULL,
+	 * con=clock name as per actual clk structure, NOT role
+	 */
 	CLK(NULL,	"dss_sys_clk",			&dss_sys_clk,	CK_443X),
 	CLK(NULL,	"dss_tv_clk",			&dss_tv_clk,	CK_443X),
 	CLK(NULL,	"dss_dss_clk",			&dss_dss_clk,	CK_443X),
 	CLK(NULL,	"dss_48mhz_clk",		&dss_48mhz_clk,	CK_443X),
-	CLK(NULL,	"dss_fck",			&dss_fck,	CK_443X),
 	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
 	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
 	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 713165d..cb0c624 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -770,7 +770,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	{ .role = "tv_clk", .clk = "dss_tv_fck" },
-	{ .role = "dssclk", .clk = "dss_96m_fck" },
+	{ .role = "video_clk", .clk = "dss_96m_fck" },
 	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
 };
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index f9390b4..91f8cf7 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -758,19 +758,19 @@ static int dss_get_clocks(void)
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss1_fck, "dss1_fck");
+	r = dss_get_clock(&dss.dss1_fck, "fck");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss2_fck, "dss2_fck");
+	r = dss_get_clock(&dss.dss2_fck, "sys_clk");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_54m_fck, "tv_fck");
+	r = dss_get_clock(&dss.dss_54m_fck, "tv_clk");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_96m_fck, "video_fck");
+	r = dss_get_clock(&dss.dss_96m_fck, "video_clk");
 	if (r)
 		goto err;
 
-- 
1.7.1

