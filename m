From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix gpmc regression for omap 2430sdp smc91x
Date: Thu, 4 Dec 2014 13:04:49 -0800
Message-ID: <20141204210449.GJ2757@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18105 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752093AbaLDVG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 16:06:57 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Commit f4d809ec55b6 ("ARM: dts: Fix gpmc timings for omap 2430sdp")
added GPMC timings for 2430sdp. This however broke the Ethernet
for some versions of u-boot using a different L3 clock frequency:

set_gpmc_timing_reg: GPMC error! CS5: cs_rd_off: 233 ns, 39 ticks > 31
omap-gpmc 6e000000.gpmc: failed to set gpmc timings for: ethernet

This is because the smsc91x timings from 1.1.4 u-boot overflow the
GPMC registers when booted with 1.1.3 version of u-boot.

Let's fix this issue by using the better timings from u-boot 1.1.3
as they also work on 1.1.4 and are faster.

Note that so far the attempts over the years to calculate the GPMC
timings on the SDP boards have failed probably because of the
unknown latencies added by the FPGA on the debug boards.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap2430-sdp.dts
+++ b/arch/arm/boot/dts/omap2430-sdp.dts
@@ -48,22 +48,22 @@
 		gpmc,device-width = <1>;
 		gpmc,cycle2cycle-samecsen = <1>;
 		gpmc,cycle2cycle-diffcsen = <1>;
-		gpmc,cs-on-ns = <7>;
-		gpmc,cs-rd-off-ns = <233>;
-		gpmc,cs-wr-off-ns = <233>;
-		gpmc,adv-on-ns = <22>;
-		gpmc,adv-rd-off-ns = <60>;
-		gpmc,adv-wr-off-ns = <60>;
-		gpmc,oe-on-ns = <67>;
-		gpmc,oe-off-ns = <210>;
-		gpmc,we-on-ns = <67>;
-		gpmc,we-off-ns = <210>;
-		gpmc,rd-cycle-ns = <233>;
-		gpmc,wr-cycle-ns = <233>;
-		gpmc,access-ns = <233>;
-		gpmc,page-burst-access-ns = <30>;
-		gpmc,bus-turnaround-ns = <30>;
-		gpmc,cycle2cycle-delay-ns = <30>;
+		gpmc,cs-on-ns = <6>;
+		gpmc,cs-rd-off-ns = <187>;
+		gpmc,cs-wr-off-ns = <187>;
+		gpmc,adv-on-ns = <18>;
+		gpmc,adv-rd-off-ns = <48>;
+		gpmc,adv-wr-off-ns = <48>;
+		gpmc,oe-on-ns = <60>;
+		gpmc,oe-off-ns = <169>;
+		gpmc,we-on-ns = <66>;
+		gpmc,we-off-ns = <169>;
+		gpmc,rd-cycle-ns = <187>;
+		gpmc,wr-cycle-ns = <187>;
+		gpmc,access-ns = <187>;
+		gpmc,page-burst-access-ns = <24>;
+		gpmc,bus-turnaround-ns = <24>;
+		gpmc,cycle2cycle-delay-ns = <24>;
 		gpmc,wait-monitoring-ns = <0>;
 		gpmc,clk-activation-ns = <0>;
 		gpmc,wr-data-mux-bus-ns = <0>;
