From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2 2/3] omap: gpmc-nand: introduce omap2_nand_gpmc_round_timings helper
Date: Thu, 29 Apr 2010 11:48:11 +0300
Message-ID: <c624317e03c137ba4d6f1dd74c7b50f5addaf4b1.1272530653.git.mike@compulab.co.il>
References: <cover.1272530653.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:38483 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155Ab0D3VC6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 17:02:58 -0400
In-Reply-To: <cover.1272530653.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, vimal.newwork@gmail.com, s-ghorai@ti.com, Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/gpmc-nand.c |   56 +++++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index e57fb29..9434c80 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -34,6 +34,35 @@ static struct platform_device gpmc_nand_device = {
 	.resource	= &gpmc_nand_resource,
 };
 
+static void omap2_nand_gpmc_round_timings(struct gpmc_timings *src,
+					  struct gpmc_timings *dst)
+{
+	dst->sync_clk = gpmc_round_ns_to_ticks(src->sync_clk);
+	dst->cs_on = gpmc_round_ns_to_ticks(src->cs_on);
+	dst->adv_on = gpmc_round_ns_to_ticks(src->adv_on);
+
+	/* Read */
+	dst->adv_rd_off = gpmc_round_ns_to_ticks(src->adv_rd_off);
+	dst->oe_on  = dst->adv_on;
+	dst->access = gpmc_round_ns_to_ticks(src->access);
+	dst->oe_off = gpmc_round_ns_to_ticks(src->oe_off);
+	dst->cs_rd_off = gpmc_round_ns_to_ticks(src->cs_rd_off);
+	dst->rd_cycle  = gpmc_round_ns_to_ticks(src->rd_cycle);
+
+	/* Write */
+	dst->adv_wr_off = gpmc_round_ns_to_ticks(src->adv_wr_off);
+	dst->we_on  = dst->oe_on;
+	if (cpu_is_omap34xx()) {
+		dst->wr_data_mux_bus =	gpmc_round_ns_to_ticks(
+				src->wr_data_mux_bus);
+		dst->wr_access = gpmc_round_ns_to_ticks(
+				src->wr_access);
+	}
+	dst->we_off = gpmc_round_ns_to_ticks(src->we_off);
+	dst->cs_wr_off = gpmc_round_ns_to_ticks(src->cs_wr_off);
+	dst->wr_cycle  = gpmc_round_ns_to_ticks(src->wr_cycle);
+}
+
 static int omap2_nand_gpmc_retime(void)
 {
 	struct gpmc_timings t;
@@ -43,32 +72,7 @@ static int omap2_nand_gpmc_retime(void)
 		return 0;
 
 	memset(&t, 0, sizeof(t));
-	t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
-	t.cs_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_on);
-	t.adv_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->adv_on);
-
-	/* Read */
-	t.adv_rd_off = gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->adv_rd_off);
-	t.oe_on  = t.adv_on;
-	t.access = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->access);
-	t.oe_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->oe_off);
-	t.cs_rd_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_rd_off);
-	t.rd_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->rd_cycle);
-
-	/* Write */
-	t.adv_wr_off = gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->adv_wr_off);
-	t.we_on  = t.oe_on;
-	if (cpu_is_omap34xx()) {
-	    t.wr_data_mux_bus =	gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->wr_data_mux_bus);
-	    t.wr_access = gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->wr_access);
-	}
-	t.we_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->we_off);
-	t.cs_wr_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_wr_off);
-	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
+	omap2_nand_gpmc_round_timings(gpmc_nand_data->gpmc_t, &t);
 
 	/* Configure GPMC */
 	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG1,
-- 
1.6.6.2

