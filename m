From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 12/14] ARM: OMAP2+: Add additional GPMC timing parameters
Date: Tue, 26 Feb 2013 11:30:39 -0600
Message-ID: <1361899842-30303-13-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36758 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758022Ab3BZRbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Feb 2013 12:31:23 -0500
In-Reply-To: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Jon Hunter <jon-hunter@ti.com>

Some of the GPMC timings parameters are currently missing from the GPMC
device-tree binding. Add these parameters to the binding documentation
as well as code to read them.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 Documentation/devicetree/bindings/bus/ti-gpmc.txt |   25 +++++++++++++++---
 arch/arm/mach-omap2/gpmc.c                        |   28 +++++++++++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
index a31c32a..53338cf 100644
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
index eb167b3..78d6c51 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1328,12 +1328,40 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 	if (!of_property_read_u32(np, "gpmc,wr-cycle", &val))
 		gpmc_t->wr_cycle = val;
 
+	if (!of_property_read_u32(np, "gpmc,bus-turnaround", &val))
+		gpmc_t->bus_turnaround = val;
+
+	if (!of_property_read_u32(np, "gpmc,cycle2cycle-delay", &val))
+		gpmc_t->cycle2cycle_delay = val;
+
+	if (!of_property_read_u32(np, "gpmc,wait-monitoring", &val))
+		gpmc_t->wait_monitoring = val;
+
+	if (!of_property_read_u32(np, "gpmc,clk-activation", &val))
+		gpmc_t->clk_activation = val;
+
 	/* only for OMAP3430 */
 	if (!of_property_read_u32(np, "gpmc,wr-access", &val))
 		gpmc_t->wr_access = val;
 
 	if (!of_property_read_u32(np, "gpmc,wr-data-mux-bus", &val))
 		gpmc_t->wr_data_mux_bus = val;
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

