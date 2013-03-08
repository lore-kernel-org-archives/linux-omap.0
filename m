From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 12/17] ARM: OMAP2+: Add additional GPMC timing parameters
Date: Fri, 8 Mar 2013 10:58:33 -0600
Message-ID: <1362761918-8696-13-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933812Ab3CHQ7t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 11:59:49 -0500
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

Some of the GPMC timings parameters are currently missing from the GPMC
device-tree binding. Add these parameters to the binding documentation
as well as code to read them.

The existing code in gpmc_read_timings_dt() is checking the value of
of_property_read_u32() and only is successful storing the value read
in the gpmc_timings structure. Checking the return value in this case
is not necessary and we can simply read the value, if present, and
store directly in the gpmc_timings structure. Therefore, simplify the
code by removing these checks.

The comment in the gpmc_read_timings_dt() function, "only for OMAP3430"
is also incorrect as it is applicable to all OMAP3+ devices. So correct
this too.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt |   25 +++++-
 arch/arm/mach-omap2/gpmc.c                        |   93 ++++++++++-----------
 2 files changed, 66 insertions(+), 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
index 6fde1cf..a63bd93 100644
--- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
@@ -56,10 +56,27 @@ Timing properties for child nodes. All are optional and default to 0.
  - gpmc,oe-off:		Deassertion time
 
  Access time and cycle time timings corresponding to GPMC_CONFIG5:
- - gpmc,page-burst-access: Multiple access word delay
- - gpmc,access:		Start-cycle to first data valid delay
- - gpmc,rd-cycle:	Total read cycle time
- - gpmc,wr-cycle:	Total write cycle time
+ - gpmc,page-burst-access: 	Multiple access word delay
+ - gpmc,access:			Start-cycle to first data valid delay
+ - gpmc,rd-cycle:		Total read cycle time
+ - gpmc,wr-cycle:		Total write cycle time
+ - gpmc,bus-turnaround:		Turn-around time between successive accesses
+ - gpmc,cycle2cycle-delay:	Delay between chip-select pulses
+ - gpmc,clk-activation: 	GPMC clock activation time
+ - gpmc,wait-monitoring:	Start of wait monitoring with regard to valid
+				data
+
+Boolean timing parameters. If property is present parameter enabled and
+disabled if omitted:
+ - gpmc,adv-extra-delay:	ADV signal is delayed by half GPMC clock
+ - gpmc,cs-extra-delay:		CS signal is delayed by half GPMC clock
+ - gpmc,cycle2cycle-diffcsen:	Add "cycle2cycle-delay" between successive
+				accesses to a different CS
+ - gpmc,cycle2cycle-samecsen:	Add "cycle2cycle-delay" between successive
+				accesses to the same CS
+ - gpmc,oe-extra-delay:		OE signal is delayed by half GPMC clock
+ - gpmc,we-extra-delay:		WE signal is delayed by half GPMC clock
+ - gpmc,time-para-granularity:	Multiply all access times by 2
 
 The following are only applicable to OMAP3+ and AM335x:
  - gpmc,wr-access
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 05ca0af..6dd110e 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1274,67 +1274,64 @@ void gpmc_read_settings_dt(struct device_node *np, struct gpmc_settings *p)
 static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 						struct gpmc_timings *gpmc_t)
 {
-	u32 val;
-
 	memset(gpmc_t, 0, sizeof(*gpmc_t));
 
 	/* minimum clock period for syncronous mode */
-	if (!of_property_read_u32(np, "gpmc,sync-clk", &val))
-		gpmc_t->sync_clk = val;
+	of_property_read_u32(np, "gpmc,sync-clk", &gpmc_t->sync_clk);
 
 	/* chip select timtings */
-	if (!of_property_read_u32(np, "gpmc,cs-on", &val))
-		gpmc_t->cs_on = val;
-
-	if (!of_property_read_u32(np, "gpmc,cs-rd-off", &val))
-		gpmc_t->cs_rd_off = val;
-
-	if (!of_property_read_u32(np, "gpmc,cs-wr-off", &val))
-		gpmc_t->cs_wr_off = val;
+	of_property_read_u32(np, "gpmc,cs-on", &gpmc_t->cs_on);
+	of_property_read_u32(np, "gpmc,cs-rd-off", &gpmc_t->cs_rd_off);
+	of_property_read_u32(np, "gpmc,cs-wr-off", &gpmc_t->cs_wr_off);
 
 	/* ADV signal timings */
-	if (!of_property_read_u32(np, "gpmc,adv-on", &val))
-		gpmc_t->adv_on = val;
-
-	if (!of_property_read_u32(np, "gpmc,adv-rd-off", &val))
-		gpmc_t->adv_rd_off = val;
-
-	if (!of_property_read_u32(np, "gpmc,adv-wr-off", &val))
-		gpmc_t->adv_wr_off = val;
+	of_property_read_u32(np, "gpmc,adv-on", &gpmc_t->adv_on);
+	of_property_read_u32(np, "gpmc,adv-rd-off", &gpmc_t->adv_rd_off);
+	of_property_read_u32(np, "gpmc,adv-wr-off", &gpmc_t->adv_wr_off);
 
 	/* WE signal timings */
-	if (!of_property_read_u32(np, "gpmc,we-on", &val))
-		gpmc_t->we_on = val;
-
-	if (!of_property_read_u32(np, "gpmc,we-off", &val))
-		gpmc_t->we_off = val;
+	of_property_read_u32(np, "gpmc,we-on", &gpmc_t->we_on);
+	of_property_read_u32(np, "gpmc,we-off", &gpmc_t->we_off);
 
 	/* OE signal timings */
-	if (!of_property_read_u32(np, "gpmc,oe-on", &val))
-		gpmc_t->oe_on = val;
-
-	if (!of_property_read_u32(np, "gpmc,oe-off", &val))
-		gpmc_t->oe_off = val;
+	of_property_read_u32(np, "gpmc,oe-on", &gpmc_t->oe_on);
+	of_property_read_u32(np, "gpmc,oe-off", &gpmc_t->oe_off);
 
 	/* access and cycle timings */
-	if (!of_property_read_u32(np, "gpmc,page-burst-access", &val))
-		gpmc_t->page_burst_access = val;
-
-	if (!of_property_read_u32(np, "gpmc,access", &val))
-		gpmc_t->access = val;
-
-	if (!of_property_read_u32(np, "gpmc,rd-cycle", &val))
-		gpmc_t->rd_cycle = val;
-
-	if (!of_property_read_u32(np, "gpmc,wr-cycle", &val))
-		gpmc_t->wr_cycle = val;
-
-	/* only for OMAP3430 */
-	if (!of_property_read_u32(np, "gpmc,wr-access", &val))
-		gpmc_t->wr_access = val;
-
-	if (!of_property_read_u32(np, "gpmc,wr-data-mux-bus", &val))
-		gpmc_t->wr_data_mux_bus = val;
+	of_property_read_u32(np, "gpmc,page-burst-access",
+			     &gpmc_t->page_burst_access);
+	of_property_read_u32(np, "gpmc,access", &gpmc_t->access);
+	of_property_read_u32(np, "gpmc,rd-cycle", &gpmc_t->rd_cycle);
+	of_property_read_u32(np, "gpmc,wr-cycle", &gpmc_t->wr_cycle);
+	of_property_read_u32(np, "gpmc,bus-turnaround",
+			     &gpmc_t->bus_turnaround);
+	of_property_read_u32(np, "gpmc,cycle2cycle-delay",
+			     &gpmc_t->cycle2cycle_delay);
+	of_property_read_u32(np, "gpmc,wait-monitoring",
+			     &gpmc_t->wait_monitoring);
+	of_property_read_u32(np, "gpmc,clk-activation",
+			     &gpmc_t->clk_activation);
+
+	/* only applicable to OMAP3+ */
+	of_property_read_u32(np, "gpmc,wr-access", &gpmc_t->wr_access);
+	of_property_read_u32(np, "gpmc,wr-data-mux-bus",
+			     &gpmc_t->wr_data_mux_bus);
+
+	/* bool timing parameters */
+	if (of_find_property(np, "gpmc,cycle2cycle-diffcsen", NULL))
+		gpmc_t->bool_timings.cycle2cyclediffcsen = true;
+	if (of_find_property(np, "gpmc,cycle2cycle-samecsen", NULL))
+		gpmc_t->bool_timings.cycle2cyclesamecsen = true;
+	if (of_find_property(np, "gpmc,we-extra-delay", NULL))
+		gpmc_t->bool_timings.we_extra_delay = true;
+	if (of_find_property(np, "gpmc,oe-extra-delay", NULL))
+		gpmc_t->bool_timings.oe_extra_delay = true;
+	if (of_find_property(np, "gpmc,adv-extra-delay", NULL))
+		gpmc_t->bool_timings.adv_extra_delay = true;
+	if (of_find_property(np, "gpmc,cs-extra-delay", NULL))
+		gpmc_t->bool_timings.cs_extra_delay = true;
+	if (of_find_property(np, "gpmc,time-para-granularity", NULL))
+		gpmc_t->bool_timings.time_para_granularity = true;
 }
 
 #ifdef CONFIG_MTD_NAND
-- 
1.7.10.4

