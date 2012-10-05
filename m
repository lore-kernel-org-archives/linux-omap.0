From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v8 2/6] ARM: OMAP2+: nand: remove redundant rounding
Date: Fri, 5 Oct 2012 21:09:12 +0530
Message-ID: <d42eafa8c80ce785d93fbcfd9d3b8b714eee531f.1349444936.git.afzal@ti.com>
References: <cover.1349444935.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40333 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab2JEPjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 11:39:20 -0400
In-Reply-To: <cover.1349444935.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

gpmc_cs_set_timings() calculate ticks to be programmed by
rounding time in ns to next tick value. Hence remove
redundant rounding of nanosecond timing.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 4acf497..4eceaca 100644
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

