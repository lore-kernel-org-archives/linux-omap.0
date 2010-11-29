From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 04/17] OMAP2420,OMAP2430,OMAP3xx: change dss driver name in clock files
Date: Mon, 29 Nov 2010 17:21:30 +0530
Message-ID: <1291031503-21036-5-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48966 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab0K2Lv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 06:51:56 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

dss driver renamed to "omap_" is done to align all the omap device names
with the same convention.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c |    8 ++++----
 arch/arm/mach-omap2/clock2430_data.c |    8 ++++----
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 21f8562..316f6f6 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1786,10 +1786,10 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_242X),
 	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
 	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_242X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_242X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_242X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_242X),
+	CLK("omap_dss",	"ick",		&dss_ick,	CK_242X),
+	CLK("omap_dss",	"dss1_fck",	&dss1_fck,	CK_242X),
+	CLK("omap_dss",	"dss2_fck",	&dss2_fck,	CK_242X),
+	CLK("omap_dss",	"tv_fck",	&dss_54m_fck,	CK_242X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_242X),
 	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index e32afcb..b7fc6c6 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1890,10 +1890,10 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
 	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
 	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_243X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X),
+	CLK("omap_dss",	"ick",		&dss_ick,	CK_243X),
+	CLK("omap_dss",	"dss1_fck",	&dss1_fck,	CK_243X),
+	CLK("omap_dss",	"dss2_fck",	&dss2_fck,	CK_243X),
+	CLK("omap_dss",	"tv_fck",	&dss_54m_fck,	CK_243X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X),
 	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d85ecd5..98dc66e 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3347,13 +3347,13 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2 | CK_AM35XX),
-	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
-	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
-	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
-	CLK("omapdss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2 | CK_AM35XX),
+	CLK("omap_dss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
+	CLK("omap_dss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2 | CK_AM35XX),
+	CLK("omap_dss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
+	CLK("omap_dss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
+	CLK("omap_dss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
+	CLK("omap_dss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
+	CLK("omap_dss",	"ick",		&dss_ick_3430es2,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
-- 
1.6.3.3

