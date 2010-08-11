From: Nishanth Menon <nm@ti.com>
Subject: [PM-OPP][PATCH 0/2] OMAP: pm: opp: few additional cleanups
Date: Tue, 10 Aug 2010 21:16:56 -0500
Message-ID: <1281493018-29294-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37510 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758146Ab0HKCRI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Aug 2010 22:17:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Sanjeev Premi <premi@ti.com>, Thara Gopinath <thara@ti.com>, Tony Lindgren <tony@atomide.com>

Cleanup opp layer on pending topics:
SRF is dead, so remove the opp_id concept from opp layer, no more
deprecated functions for us.. (series is based on khilman's pm branch)

There are two things pending with opp layer as pointed in the discussion
with Sanjeev:
a) we need to make the opp data definition a little more CPUFREQ independent
 - i have taken this up in patch 2/2
b) The thing pending: how do we fit in mpurate?
Problem that Sanjeev pointed out in the thread[1] was this:
lets say a bootloader running at freq x, runs kernel at freq y, should'nt the
kernel verify if this is a valid freq for that board before setting it?	
	The call sequence currently is:
	(1) arch/arm/plat-omap/clock.c omap_clk_setup
	(2) arch/arm/mach-omap2/clock.c omap2_clk_switch_mpurate_at_boot
	(3) arch/arm/mach-omap2/opp3xxx_data.c omap3_pm_init_opp_table
mpurate is populated at (1), used at (2) and the opp table against which
it can be verified is at (3). here in lies the chicken-or-egg problem :(.
since the operating frequencies are decided based on board behavior as well,
we cant really set the frequency at (2) as we do now, and we may want to
consider the option of moving it down beyond (3).

Note: we will also have to consider the fact that we may need a higher/different
voltage for that mpu frequency as well.. which may mean this handling be
moved out of the clock.c to pm.c instead..

Does anyone have a suggestion as to how we'd want to proceed?
	
Nishanth Menon (2):
  omap: pm: opp: remove opp_id
  omap3: opp: make independent of cpufreq

 arch/arm/mach-omap2/Makefile                       |    5 +--
 .../mach-omap2/{cpufreq34xx.c => opp3xxx_data.c}   |    0
 arch/arm/plat-omap/include/plat/opp.h              |   15 ------
 arch/arm/plat-omap/opp.c                           |   47 --------------------
 4 files changed, 1 insertions(+), 66 deletions(-)
 rename arch/arm/mach-omap2/{cpufreq34xx.c => opp3xxx_data.c} (100%)


Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

Regards,
Nishanth Menon
Ref:
[1]: http://marc.info/?t=127495972700003&r=1&w=2
