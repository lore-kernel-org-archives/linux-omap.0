From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 17/28] OMAP2420: HWMOD: Add DSS opt clocks
Date: Mon, 1 Aug 2011 19:14:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108011910410.28427@utopia.booyaka.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com> <1307627810-3768-18-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.00.1107150047160.16606@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48766 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab1HBBOP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 21:14:15 -0400
In-Reply-To: <alpine.DEB.2.00.1107150047160.16606@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

Hello Tomi

On Fri, 15 Jul 2011, Paul Walmsley wrote:

> On Thu, 9 Jun 2011, Tomi Valkeinen wrote:
> 
> > Add DSS optional clocks to HWMOD data for OMAP2420.

This patch has been combined with the 2430 patch and the OMAP2xxx portion 
of the temporary hack in the DSS driver has been removed.  Care to review 
the new changes before it's sent to Tony?


- Paul


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 1 Aug 2011 19:02:23 -0600
Subject: [PATCH 1/2] OMAP2xxx: HWMOD: Add DSS opt clocks

Add DSS optional clocks to HWMOD data for OMAP2420 and OMAP2430.

Revert OMAP2xxx portion of commit
9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack
for OMAP2/3").

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[paul@pwsan.com: merge 2420 and 2430 patches; remove temporary DSS driver hack;
 update changelog]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   17 ++++++++---------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   17 ++++++++---------
 drivers/video/omap2/dss/rfbi.c             |    2 +-
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a015c69..b075188 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -873,11 +873,6 @@ static struct omap_hwmod_ocp_if *omap2420_dss_slaves[] = {
 	&omap2420_l4_core__dss,
 };
 
-static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "tv_clk", .clk = "dss_54m_fck" },
-	{ .role = "sys_clk", .clk = "dss2_fck" },
-};
-
 static struct omap_hwmod omap2420_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap2_dss_hwmod_class,
@@ -892,8 +887,6 @@ static struct omap_hwmod omap2420_dss_core_hwmod = {
 			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
 		},
 	},
-	.opt_clks	= dss_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
 	.slaves		= omap2420_dss_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_slaves),
 	.masters	= omap2420_dss_masters,
@@ -962,6 +955,10 @@ static struct omap_hwmod_ocp_if *omap2420_dss_rfbi_slaves[] = {
 	&omap2420_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -973,6 +970,8 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap2420_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -983,7 +982,7 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
 	.master		= &omap2420_l4_core_hwmod,
 	.slave		= &omap2420_dss_venc_hwmod,
-	.clk		= "dss_54m_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
@@ -1003,7 +1002,7 @@ static struct omap_hwmod_ocp_if *omap2420_dss_venc_slaves[] = {
 static struct omap_hwmod omap2420_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_fck",
+	.main_clk	= "dss_54m_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 16743c7..3569084 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -939,11 +939,6 @@ static struct omap_hwmod_ocp_if *omap2430_dss_slaves[] = {
 	&omap2430_l4_core__dss,
 };
 
-static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "tv_clk", .clk = "dss_54m_fck" },
-	{ .role = "sys_clk", .clk = "dss2_fck" },
-};
-
 static struct omap_hwmod omap2430_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap2_dss_hwmod_class,
@@ -958,8 +953,6 @@ static struct omap_hwmod omap2430_dss_core_hwmod = {
 			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
 		},
 	},
-	.opt_clks	= dss_opt_clks,
-	.opt_clks_cnt = ARRAY_SIZE(dss_opt_clks),
 	.slaves		= omap2430_dss_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_slaves),
 	.masters	= omap2430_dss_masters,
@@ -1016,6 +1009,10 @@ static struct omap_hwmod_ocp_if *omap2430_dss_rfbi_slaves[] = {
 	&omap2430_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -1027,6 +1024,8 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap2430_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
@@ -1037,7 +1036,7 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
 	.master		= &omap2430_l4_core_hwmod,
 	.slave		= &omap2430_dss_venc_hwmod,
-	.clk		= "dss_54m_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1051,7 +1050,7 @@ static struct omap_hwmod_ocp_if *omap2430_dss_venc_slaves[] = {
 static struct omap_hwmod omap2430_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_fck",
+	.main_clk	= "dss_54m_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 39f4c59..457f1ac 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -952,7 +952,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 
 	msleep(10);
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap3630())
+	if (cpu_is_omap34xx() || cpu_is_omap3630())
 		clk = dss_get_ick();
 	else
 		clk = clk_get(&pdev->dev, "ick");
-- 
1.7.5.4

