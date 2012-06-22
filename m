From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 08/13] ARM: OMAP2+: gpmc: holler if no configuration
Date: Fri, 22 Jun 2012 18:27:17 +0530
Message-ID: <0c48341ab1fff2b84ed1c0773d57b7b00472177e.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40017 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659Ab2FVNMh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:37 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Some of the GPMC peripherals depend on bootloader to do the
configuration. This facility is deprecated, notify user
about the present GPMC settings & inform that that relying
on bootloader for GPMC setting is deprecated.

Note: This has to be reverted once Kernel is updated with
sufficient details so that all the gpmc periherals can be
configured in Kernel for all boards instead of relying on
bootloader.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |  104 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1998285..9e3960e 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1056,6 +1056,110 @@ static void gpmc_cs_set_register_timings(int cs, const struct gpmc_timings *t)
 	gpmc_cs_bool_timings(cs, &t->bool_timings);
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
 static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
 						struct resource *res)
 {
-- 
1.7.10.2

