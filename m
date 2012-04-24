From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] ARM: OMAP2: Add MMC hwmod data for 2420
Date: Mon, 23 Apr 2012 17:08:32 -0700
Message-ID: <20120424000832.17783.21327.stgit@muffinssi.local>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64264 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2DXAIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 20:08:34 -0400
In-Reply-To: <20120424000607.17783.81686.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Add MMC for 2420 so we can pass the DMA request lines the same
way as we already do on omap2430 and later.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a6bde34..10f04a8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1512,6 +1512,66 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_mcbsp2_slaves),
 };
 
+static struct omap_hwmod omap2420_mmc_hwmod;
+
+struct omap_hwmod_addr_space omap2420_mmc_addrs[] = {
+	{
+		.pa_start	= 0x4809c000,
+		.pa_end		= 0x4809c000 + SZ_128 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+static struct omap_hwmod_class omap2420_mmc_hwmod_class = {
+	.name = "mmci",
+};
+
+/* mmc */
+static struct omap_hwmod_irq_info omap2420_mmc_irqs[] = {
+	{ .irq = 83 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap2420_mmc_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 61 }, /* OMAP24XX_DMA_MMC1_TX */
+	{ .name = "rx", .dma_req = 62 }, /* OMAP24XX_DMA_MMC1_RX */
+	{ .dma_req = -1 }
+};
+
+/* l4_core -> mmc */
+static struct omap_hwmod_ocp_if omap2420_l4_core__mmc = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mmc_hwmod,
+	.clk		= "mmc_ick",
+	.addr		= omap2420_mmc_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mmc slave ports */
+static struct omap_hwmod_ocp_if *omap2420_mmc_slaves[] = {
+	&omap2420_l4_core__mmc,
+};
+
+static struct omap_hwmod omap2420_mmc_hwmod = {
+	.name		= "mmci",
+	.class		= &omap2420_mmc_hwmod_class,
+	.mpu_irqs	= omap2420_mmc_irqs,
+	.sdma_reqs	= omap2420_mmc_sdma_reqs,
+	.main_clk	= "mmc_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2420_EN_MMC_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP2420_ST_MMC_SHIFT,
+		},
+	},
+	.slaves		= omap2420_mmc_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mmc_slaves),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -1564,6 +1624,9 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	/* mcspi class */
 	&omap2420_mcspi1_hwmod,
 	&omap2420_mcspi2_hwmod,
+
+	&omap2420_mmc_hwmod,
+
 	NULL,
 };
 

