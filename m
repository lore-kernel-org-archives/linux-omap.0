From: Charulatha V <charu@ti.com>
Subject: [PATCH] OMAP:GPIO:hwmod: Fix mmc compile errors
Date: Thu, 22 Apr 2010 21:24:54 +0530
Message-ID: <1271951694-18556-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54845 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322Ab0DVPyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 11:54:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

In origin/pm-wip/runtime branch, compilation errors are
observed for OMAP2430. The compilation errors are due to
usage of clkdev_dev_id, clkdev_con_id and sysconfig fields
in mmc hwmod structures. This patch fixes the same.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index ffc5222..d9c92aa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -93,8 +93,7 @@ static struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
 	.master		= &omap2430_l4_core_hwmod,
 	.slave		= &omap2430_mmc1_hwmod,
-	.clkdev_dev_id	= "mmci-omap-hs.0",
-	.clkdev_con_id	= "ick",
+	.clk		= "mmchs1_ick",
 	.addr		= omap2430_mmc1_addr_space,
 	.addr_cnt	= ARRAY_SIZE(omap2430_mmc1_addr_space),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -112,9 +111,8 @@ static struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
 	.master		= &omap2430_l4_core_hwmod,
 	.slave		= &omap2430_mmc2_hwmod,
-	.clkdev_dev_id	= "mmci-omap-hs.1",
-	.clkdev_con_id	= "ick",
 	.addr		= omap2430_mmc2_addr_space,
+	.clk		= "mmchs1_ick",
 	.addr_cnt	= ARRAY_SIZE(omap2430_mmc2_addr_space),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -180,13 +178,19 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 
 /* MMC/SD/SDIO common */
 
-static struct omap_hwmod_sysconfig mmc_if_ctrl = {
+static struct omap_hwmod_class_sysconfig mmc_sysc = {
 	.rev_offs	= 0x10,
 	.sysc_offs	= 0x14,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSS_MISSING),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class mmc_class = {
+	.name = "mmc",
+	.sysc = &mmc_sysc,
 };
 
 /* MMC/SD/SDIO1 */
@@ -205,7 +209,7 @@ static struct omap_hwmod_dma_info mmc1_sdma_chs[] = {
 };
 
 static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .clkdev_dev_id = "mmci-omap-hs.0", .clkdev_con_id = "mmchsdb_fck" },
+	{ .role = "dbck", .clk = "mmchsdb_fck" },
 };
 
 static struct omap_hwmod_ocp_if *omap2430_mmc1_slaves[] = {
@@ -220,8 +224,7 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.sdma_chs_cnt	= ARRAY_SIZE(mmc1_sdma_chs),
 	.opt_clks	= mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
-	.clkdev_dev_id	= "mmci-omap-hs.0",
-	.clkdev_con_id	= "fck",
+	.main_clk	= "mmchs1_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 2,
@@ -230,7 +233,7 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 	},
 	.slaves		= omap2430_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
-	.sysconfig	= &mmc_if_ctrl,
+	.class		= &mmc_class,
 	.dev_attr	= &mmc1_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -251,7 +254,7 @@ static struct omap_hwmod_dma_info mmc2_sdma_chs[] = {
 };
 
 static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
-	{ .clkdev_dev_id = "mmci-omap-hs.1", .clkdev_con_id = "mmchsdb_fck" },
+	{ .role = "dbck", .clk = "mmchsdb_fck" },
 };
 
 static struct omap_hwmod_ocp_if *omap2430_mmc2_slaves[] = {
@@ -266,8 +269,7 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.sdma_chs_cnt	= ARRAY_SIZE(mmc2_sdma_chs),
 	.opt_clks	= mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
-	.clkdev_dev_id	= "mmci-omap-hs.1",
-	.clkdev_con_id	= "fck",
+	.main_clk	= "mmchs2_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 2,
@@ -276,7 +278,7 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	},
 	.slaves		= omap2430_mmc2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc2_slaves),
-	.sysconfig	= &mmc_if_ctrl,
+	.class		= &mmc_class,
 	.dev_attr	= &mmc2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
-- 
1.6.3.3

