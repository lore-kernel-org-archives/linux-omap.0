From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 02/15] ARM: OMAP2xxx: hwmod: Add DMA support for SHAM module
Date: Fri, 21 Dec 2012 09:28:02 -0700
Message-ID: <1356107295-11121-3-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38729 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab2LUQ2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 11:28:32 -0500
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The current OMAP2 SHAM support doesn't enable DMA
so add that support so it can use DMA just like OMAP3.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 8a9b67a..510f584 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -405,5 +405,5 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__sham = {
 	.slave		= &omap2xxx_sham_hwmod,
 	.clk		= "sha_ick",
 	.addr		= omap2xxx_sham_addrs,
-	.user		= OCP_USER_MPU,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index e72132d..ab3305b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -886,9 +886,15 @@ struct omap_hwmod_irq_info omap2_sham_mpu_irqs[] = {
 	{ .irq = -1 }
 };
 
+struct omap_hwmod_dma_info omap2_sham_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 13 },
+	{ .dma_req = -1 }
+};
+
 struct omap_hwmod omap2xxx_sham_hwmod = {
 	.name		= "sham",
 	.mpu_irqs	= omap2_sham_mpu_irqs,
+	.sdma_reqs	= omap2_sham_sdma_chs,
 	.main_clk	= "l4_ck",
 	.prcm		= {
 		.omap2 = {
-- 
1.7.12

