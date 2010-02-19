From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/6] OMAP2: hwmod: Fix MMC hwmod structs for 2430
Date: Fri, 19 Feb 2010 17:57:12 +0530
Message-ID: <1266582437-22398-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37305 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab0BSM1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 07:27:25 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1JCRMOd013468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 06:27:24 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>

The existing MMC hwmod structs for 2430 are fixed based
on the changes in hwmod framework structurs.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430.h |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430.h b/arch/arm/mach-omap2/omap_hwmod_2430.h
index 0b6ca6f..2898749 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -21,7 +21,7 @@
 #include <plat/cpu.h>
 #include <plat/dma.h>
 
-#include <mach/mmc.h>
+#include <plat/mmc.h>
 
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
@@ -87,7 +87,8 @@ static struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
 	.master		= &omap2430_l4_core_hwmod,
 	.slave		= &omap2430_mmc1_hwmod,
-	.interface_clk	= { .name = "mmchs1_ick" },
+	.clkdev_dev_id	= "mmci-omap-hs.0",
+	.clkdev_con_id	= "ick",
 	.addr		= omap2430_mmc1_addr_space,
 	.addr_cnt	= ARRAY_SIZE(omap2430_mmc1_addr_space),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -105,7 +106,8 @@ static struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
 	.master		= &omap2430_l4_core_hwmod,
 	.slave		= &omap2430_mmc2_hwmod,
-	.interface_clk	= { .name = "mmchs2_ick" },
+	.clkdev_dev_id	= "mmci-omap-hs.1",
+	.clkdev_con_id	= "ick",
 	.addr		= omap2430_mmc2_addr_space,
 	.addr_cnt	= ARRAY_SIZE(omap2430_mmc2_addr_space),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -185,8 +187,8 @@ static struct mmc_dev_attr mmc1_dev_attr = {
 	.flags = MMC_INTERNAL_XCVR,
 };
 
-static u8 mmc1_mpu_irqs[] = {
-	INT_24XX_MMC_IRQ,
+static struct omap_hwmod_irq_info mmc1_mpu_irqs[] = {
+	{ .irq = INT_24XX_MMC_IRQ, },
 };
 
 static struct omap_hwmod_dma_info mmc1_sdma_chs[] = {
@@ -195,7 +197,7 @@ static struct omap_hwmod_dma_info mmc1_sdma_chs[] = {
 };
 
 static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .role = "dbck", .clk = { .name = "mmchsdb1_fck" } },
+	{ .clkdev_dev_id = "mmci-omap-hs.0", .clkdev_con_id = "mmchsdb_fck" },
 };
 
 static struct omap_hwmod_ocp_if *omap2430_mmc1_slaves[] = {
@@ -210,7 +212,8 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.sdma_chs_cnt	= ARRAY_SIZE(mmc1_sdma_chs),
 	.opt_clks	= mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
-	.main_clk	= { .name = "mmchs1_fck" },
+	.clkdev_dev_id	= "mmci-omap-hs.0",
+	.clkdev_con_id	= "fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 2,
@@ -230,8 +233,8 @@ static struct mmc_dev_attr mmc2_dev_attr = {
 	.flags = MMC_SUPPORTS_EXTERNAL_XCVR,
 };
 
-static u8 mmc2_mpu_irqs[] = {
-	INT_24XX_MMC2_IRQ,
+static struct omap_hwmod_irq_info mmc2_mpu_irqs[] = {
+	{ .irq = INT_24XX_MMC2_IRQ, },
 };
 
 static struct omap_hwmod_dma_info mmc2_sdma_chs[] = {
@@ -240,7 +243,7 @@ static struct omap_hwmod_dma_info mmc2_sdma_chs[] = {
 };
 
 static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
-	{ .role = "dbck", .clk = { .name = "mmchsdb2_fck" } },
+	{ .clkdev_dev_id = "mmci-omap-hs.1", .clkdev_con_id = "mmchsdb_fck" },
 };
 
 static struct omap_hwmod_ocp_if *omap2430_mmc2_slaves[] = {
@@ -255,7 +258,8 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.sdma_chs_cnt	= ARRAY_SIZE(mmc2_sdma_chs),
 	.opt_clks	= mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
-	.main_clk	= { .name = "mmchs2_fck" },
+	.clkdev_dev_id	= "mmci-omap-hs.1",
+	.clkdev_con_id	= "fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 2,
-- 
1.5.4.7

