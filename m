From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 2/7] ARM: OMAP2xxx: hwmod: Add DMA information for SHAM module
Date: Fri, 19 Oct 2012 14:53:55 -0700
Message-ID: <1350683640-15044-3-git-send-email-mgreer@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:45797 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972Ab2JSVyk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 17:54:40 -0400
In-Reply-To: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, Paul Walmsley <paul@pwsan.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Add the DMA information for the OMAP2 SHA module.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c | 2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index bb314c5..4b4fd5f 100644
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
index a041670..703b269 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -873,9 +873,15 @@ struct omap_hwmod_irq_info omap2_sham_mpu_irqs[] = {
 	{ .irq = -1 }
 };
 
+struct omap_hwmod_dma_info omap2_sham_sdma_chs[] = {
+	{ .name = "rx", .dma_req = OMAP24XX_DMA_SHA1MD5_RX },
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

