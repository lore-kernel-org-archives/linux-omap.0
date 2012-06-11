From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 09/14] ARM: OMAP2+: gpmc: holler if no configuration
Date: Mon, 11 Jun 2012 19:57:14 +0530
Message-ID: <66dd8cb20cd46e68e43f4a56f49d040ad993e976.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52394 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754083Ab2FKOm5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:42:57 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Some of the GPMC peripherals depend on bootloader to do the
configuration. This facility is deprecated, notify user
about the present GPMC settings & inform that that relying
on bootloader for GPMC setting is deprecated.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |  104 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 65052f8..5a6f708 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1058,6 +1058,110 @@ static void gpmc_cs_set_register_timings(int cs, const struct gpmc_timings *t)
 	}
 }
 
+static void gpmc_print_cs_config(int cs)
+{
+	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+	dev_warn(gpmc_dev, "GPMC CS%d depends on bootloader for config\n", cs);
+	dev_warn(gpmc_dev, "Please update it in Kernel ASAP to prevent losing support for this peripheral\n");
+	dev_warn(gpmc_dev, "Bootloader dependency for GPMC configuration is deprecated\n");
+
+	dev_warn(gpmc_dev, "muxadddata: %s\n",
+			l & GPMC_CONFIG1_MUXADDDATA ? "yes" : "no");
+	dev_warn(gpmc_dev, "writetypesync: %s\n",
+			l & GPMC_CONFIG1_WRITETYPE_SYNC ? "yes" : "no");
+	dev_warn(gpmc_dev, "writemultiple: %s\n",
+			l & GPMC_CONFIG1_WRITEMULTIPLE_SUPP ? "yes" : "no");
+	dev_warn(gpmc_dev, "readtypesync: %s\n",
+			l & GPMC_CONFIG1_READTYPE_SYNC ? "yes" : "no");
+	dev_warn(gpmc_dev, "readmultiple: %s\n",
+			l & GPMC_CONFIG1_READMULTIPLE_SUPP ? "yes" : "no");
+	dev_warn(gpmc_dev, "wrapburst: %s\n",
+			l & GPMC_CONFIG1_WRAPBURST_SUPP ? "yes" : "no");
+	dev_warn(gpmc_dev, "devicetype: %s\n",
+			l & GPMC_CONFIG1_DEVICETYPE_NAND ? "nand" : "nor");
+	dev_warn(gpmc_dev, "devicesize: %d\n",
+			l & GPMC_CONFIG1_DEVICESIZE_16 ? 16 : 8);
+	dev_warn(gpmc_dev, "pagelength: %d\n",
+			l & GPMC_CONFIG1_PAGE_LEN(~0) ?
+			(l & GPMC_CONFIG1_PAGE_LEN_16 ? 16 : 8) : 4);
+}
+static inline unsigned gpmc_get_one_timing(int cs, int reg, int start, int end)
+{
+	u32 l = gpmc_cs_read_reg(cs, reg);
+	unsigned mask;
+
+	mask = (1 << (end - start + 1)) - 1;
+	l &= (mask << start);
+	return l >>= start;
+}
+
+static void gpmc_print_cs_timings(int cs)
+{
+	dev_warn(gpmc_dev, "GPMC CS%d depends on bootloader for timing\n", cs);
+	dev_warn(gpmc_dev, "Please update it in Kernel ASAP to prevent losing support for this peripheral\n");
+	dev_warn(gpmc_dev, "Bootloader dependency for GPMC configuration is deprecated\n");
+
+	dev_warn(gpmc_dev, "fclk period: %lups\n", gpmc_get_fclk_period());
+	dev_warn(gpmc_dev, "sync_clk: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG1, 0, 1));
+	dev_warn(gpmc_dev, "wait_monitoring: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG1, 18, 19));
+	dev_warn(gpmc_dev, "clk_activation: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG1, 25, 26));
+	dev_warn(gpmc_dev, "cs_on: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG2, 0, 3));
+	dev_warn(gpmc_dev, "cs_rd_off: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG2, 8, 12));
+	dev_warn(gpmc_dev, "cs_wr_off: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG2, 16, 20));
+	dev_warn(gpmc_dev, "adv_on: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG3, 0, 3));
+	dev_warn(gpmc_dev, "adv_rd_off: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG3, 8, 12));
+	dev_warn(gpmc_dev, "adv_wr_off: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG3, 16, 20));
+	dev_warn(gpmc_dev, "oe_on: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG4, 0, 3));
+	dev_warn(gpmc_dev, "oe_off: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG4, 8, 12));
+	dev_warn(gpmc_dev, "we_on: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG4, 16, 19));
+	dev_warn(gpmc_dev, "we_off: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG4, 24, 28));
+	dev_warn(gpmc_dev, "rd_cycle: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG5, 0, 4));
+	dev_warn(gpmc_dev, "wr_cycle: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG5, 8, 12));
+	dev_warn(gpmc_dev, "acess: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG5, 16, 20));
+	dev_warn(gpmc_dev, "page_burst_access: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG5, 24, 27));
+	dev_warn(gpmc_dev, "bus_turnaround: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 0, 3));
+	dev_warn(gpmc_dev, "cycle2cycle_delay: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 8, 11));
+	dev_warn(gpmc_dev, "wr_data_mux_bus: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 16, 19));
+	dev_warn(gpmc_dev, "wr_access: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 24, 28));
+
+	dev_warn(gpmc_dev, "time_para_granularity: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG1, 4, 4));
+	dev_warn(gpmc_dev, "cs_extra_delay: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG2, 7, 7));
+	dev_warn(gpmc_dev, "adv_extra_delay: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG3, 7, 7));
+	dev_warn(gpmc_dev, "oe_extra_delay: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG4, 7, 7));
+	dev_warn(gpmc_dev, "we_extra_delay: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG4, 23, 23));
+	dev_warn(gpmc_dev, "cycle2cyclediffcsen: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 6, 6));
+	dev_warn(gpmc_dev, "cycle2cyclesamecsen: %u\n",
+			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 7, 7));
+}
+
 static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
 {
 	return bitmask;
-- 
1.7.10.2

