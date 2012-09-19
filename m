From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v7 02/11] ARM: OMAP2+: nand: remove redundant rounding
Date: Wed, 19 Sep 2012 18:52:14 +0530
Message-ID: <72255d13b1c355da36eb299bd397733d04b74690.1348058726.git.afzal@ti.com>
References: <cover.1348058726.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37163 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872Ab2ISNWV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 09:22:21 -0400
In-Reply-To: <cover.1348058726.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc_cs_set_timings() calculate ticks to be programmed by
rounding time in ns to next tick value. Hence remove
redundant rounding of nanosecond timing.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 9e9f47a..cd1dc41 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -50,31 +50,27 @@ static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data
 
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = gpmc_nand_data->gpmc_t->sync_clk;
-	t.cs_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_on);
-	t.adv_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->adv_on);
+	t.cs_on = gpmc_nand_data->gpmc_t->cs_on;
+	t.adv_on = gpmc_nand_data->gpmc_t->adv_on;
 
 	/* Read */
-	t.adv_rd_off = gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->adv_rd_off);
+	t.adv_rd_off = gpmc_nand_data->gpmc_t->adv_rd_off;
 	t.oe_on  = t.adv_on;
-	t.access = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->access);
-	t.oe_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->oe_off);
-	t.cs_rd_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_rd_off);
-	t.rd_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->rd_cycle);
+	t.access = gpmc_nand_data->gpmc_t->access;
+	t.oe_off = gpmc_nand_data->gpmc_t->oe_off;
+	t.cs_rd_off = gpmc_nand_data->gpmc_t->cs_rd_off;
+	t.rd_cycle = gpmc_nand_data->gpmc_t->rd_cycle;
 
 	/* Write */
-	t.adv_wr_off = gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->adv_wr_off);
+	t.adv_wr_off = gpmc_nand_data->gpmc_t->adv_wr_off;
 	t.we_on  = t.oe_on;
 	if (cpu_is_omap34xx()) {
-	    t.wr_data_mux_bus =	gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->wr_data_mux_bus);
-	    t.wr_access = gpmc_round_ns_to_ticks(
-				gpmc_nand_data->gpmc_t->wr_access);
+		t.wr_data_mux_bus = gpmc_nand_data->gpmc_t->wr_data_mux_bus;
+		t.wr_access = gpmc_nand_data->gpmc_t->wr_access;
 	}
-	t.we_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->we_off);
-	t.cs_wr_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_wr_off);
-	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
+	t.we_off = gpmc_nand_data->gpmc_t->we_off;
+	t.cs_wr_off = gpmc_nand_data->gpmc_t->cs_wr_off;
+	t.wr_cycle = gpmc_nand_data->gpmc_t->wr_cycle;
 
 	/* Configure GPMC */
 	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
-- 
1.7.12

