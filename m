From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 07/13] ARM: OMAP2+: gpmc: register time setting helper
Date: Fri, 22 Jun 2012 18:27:11 +0530
Message-ID: <380b06b354fa76dc4ed82e398219f1e4ccf387c5.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659Ab2FVNMa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:30 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Helper for setting GPMC timing by taking input as register values.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8f596ce..1998285 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1011,6 +1011,51 @@ static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 }
 
+static inline void gpmc_set_one_timing(int cs, int reg, int start,
+							int end, u32 val)
+{
+	u32 l;
+	unsigned mask;
+
+	mask = (1 << (end - start + 1)) - 1;
+	l = gpmc_cs_read_reg(cs, reg);
+	l &= ~(mask << start);
+	l |= val << start;
+	gpmc_cs_write_reg(cs, reg, l);
+}
+
+static void gpmc_cs_set_register_timings(int cs, const struct gpmc_timings *t)
+{
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG1, 0, 1, t->sync_clk);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG1, 18, 19, t->wait_monitoring);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG1, 25, 26, t->clk_activation);
+
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG2, 0, 3, t->cs_on);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG2, 8, 12, t->cs_rd_off);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG2, 16, 20, t->cs_wr_off);
+
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG3, 0, 3, t->adv_on);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG3, 8, 12, t->adv_rd_off);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG3, 16, 20, t->adv_wr_off);
+
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 0, 3, t->oe_on);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 8, 12, t->oe_off);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 16, 19, t->we_on);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG4, 24, 28, t->we_off);
+
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG5, 24, 27, t->page_burst_access);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 0, 3, t->bus_turnaround);
+	gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 8, 11,	t->cycle2cycle_delay);
+
+	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
+		gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 24, 28, t->wr_access);
+	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
+		gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 16, 19,
+						t->wr_data_mux_bus);
+
+	gpmc_cs_bool_timings(cs, &t->bool_timings);
+}
+
 static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
 						struct resource *res)
 {
-- 
1.7.10.2

