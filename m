From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/9] OMAP3: HWMOD: fix DSS clock data
Date: Tue, 23 Aug 2011 15:28:14 +0300
Message-ID: <1314102499-30407-5-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:56194 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752636Ab1HWM2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:45 -0400
Received: by mail-bw0-f53.google.com with SMTP id 1so48357bkd.40
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:42 -0700 (PDT)
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The OMAP3 HWMOD data currently contains these errors with DSS clocks:

- dss_rfbi is missing ick opt-clock, which is needed for RFBI to
  calculate timings

- dss_dsi is missing ick and sys_clk

- dss_venc is missing dss_96m_fck opt-clock, which is required on
  OMAP3430

- dss_venc's interface and main clocks are wrong, causing VENC to fail
  to start

These problems were temporarily fixed with a DSS patch
9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack
for OMAP2/3"), which can be reverted after this patch (and the similar
patches for other OMAPs).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 484eda3..4a02cc3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1495,6 +1495,7 @@ static struct omap_hwmod_addr_space omap3xxx_dss_dsi1_addrs[] = {
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dsi1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_dsi1_hwmod,
+	.clk		= "dss_ick",
 	.addr		= omap3xxx_dss_dsi1_addrs,
 	.fw = {
 		.omap2 = {
@@ -1511,6 +1512,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
 	&omap3xxx_l4_core__dss_dsi1,
 };
 
+static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap3xxx_dsi_hwmod_class,
@@ -1523,6 +1528,8 @@ static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_dsi1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_opt_clks),
 	.slaves		= omap3xxx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1552,6 +1559,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_rfbi_slaves[] = {
 	&omap3xxx_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -1563,6 +1574,8 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap3xxx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1575,7 +1588,7 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_venc_hwmod,
-	.clk		= "dss_tv_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
@@ -1593,10 +1606,15 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_venc_slaves[] = {
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
@@ -1604,6 +1622,8 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_venc_opt_clks),
 	.slaves		= omap3xxx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-- 
1.7.4.1

