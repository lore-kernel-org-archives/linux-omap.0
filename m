From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 07/14] ARM: OMAP2+: gpmc: time setting (register#) helper
Date: Mon, 11 Jun 2012 19:57:01 +0530
Message-ID: <aafc6bc498e303be0bc86ce1ae395148fdca5c3d.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59023 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab2FKOmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:42:42 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Helper for setting GPMC timing by taking input as register values.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 4e19010..e60076e3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -960,6 +960,49 @@ static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
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
+	if (gpmc_revision >= 4) {
+		gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 16, 19,
+						t->wr_data_mux_bus);
+		gpmc_set_one_timing(cs, GPMC_CS_CONFIG6, 24, 28, t->wr_access);
+	}
+}
+
 static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
 {
 	return bitmask;
-- 
1.7.10.2

