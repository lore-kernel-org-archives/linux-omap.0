From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH 0/2 v2] opp layer cleanups
Date: Tue, 20 Apr 2010 14:49:52 -0500
Message-ID: <1271792994-31816-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab0DTTuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 15:50:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Thara Gopinath <thara@ti.com>

Opp layer cleanup series - tries the following:
a) Remove the BUG_ON being used on functional statements
	(included comments from https://patchwork.kernel.org/patch/86793/)
b) Improve the voltage conversion routine a bit (unchanged)

Nishanth Menon (1):
  omap3: pm: cpufreq: BUG_ON cleanup

Phil Carmody (1):
  omap: pm: opp: twl: use DIV_ROUND_UP

 arch/arm/mach-omap2/cpufreq34xx.c |   36 ++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/omap3-opp.h   |    5 +++--
 arch/arm/plat-omap/opp_twl_tps.c  |    2 +-
 3 files changed, 36 insertions(+), 7 deletions(-)

Note:
I have dropped ability to store data per opp and srf hardcoded opp
depedency from this series to help the opp layer cleanups for mainline

Patches Tested on:
	SDP3430 and SDP3630

Cc: Ambresh K <ambresh@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Thara Gopinath <thara@ti.com>

Regards,
Nishanth Menon
