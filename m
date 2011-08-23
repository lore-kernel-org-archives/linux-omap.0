From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/9] OMAP2xxx: HWMOD: fix DSS clock data
Date: Tue, 23 Aug 2011 15:28:12 +0300
Message-ID: <1314102499-30407-3-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41408 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656Ab1HWM2l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:41 -0400
Received: by bkbzv3 with SMTP id zv3so51146bkb.4
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:38 -0700 (PDT)
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The OMAP2xxx HWMOD data currently contains two errors with DSS clocks:

- dss_rfbi is missing ick opt-clock, which is needed for RFBI to
  calculate timings

- dss_venc's interface and main clocks are wrong, causing VENC to fail
  to start

These problems were temporarily fixed with a DSS patch
9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack
for OMAP2/3"), which can be reverted after this patch (and the similar
patches for other OMAPs).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   10 ++++++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 8fe373d..09d9395 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -967,6 +967,10 @@ static struct omap_hwmod_ocp_if *omap2420_dss_rfbi_slaves[] = {
 	&omap2420_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -978,6 +982,8 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap2420_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -988,7 +994,7 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
 	.master		= &omap2420_l4_core_hwmod,
 	.slave		= &omap2420_dss_venc_hwmod,
-	.clk		= "dss_54m_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
@@ -1008,7 +1014,7 @@ static struct omap_hwmod_ocp_if *omap2420_dss_venc_slaves[] = {
 static struct omap_hwmod omap2420_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_fck",
+	.main_clk	= "dss_54m_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 7a5e7f5..67aff19 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1021,6 +1021,10 @@ static struct omap_hwmod_ocp_if *omap2430_dss_rfbi_slaves[] = {
 	&omap2430_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -1032,6 +1036,8 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap2430_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
@@ -1042,7 +1048,7 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
 	.master		= &omap2430_l4_core_hwmod,
 	.slave		= &omap2430_dss_venc_hwmod,
-	.clk		= "dss_54m_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1056,7 +1062,7 @@ static struct omap_hwmod_ocp_if *omap2430_dss_venc_slaves[] = {
 static struct omap_hwmod omap2430_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_fck",
+	.main_clk	= "dss_54m_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
-- 
1.7.4.1

