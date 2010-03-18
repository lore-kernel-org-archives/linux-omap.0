From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH 0/4] few opp layer cleanups
Date: Thu, 18 Mar 2010 13:44:47 -0500
Message-ID: <1268937891-19445-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55079 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab0CRSpW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 14:45:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-Omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Benoit Cousson <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Thara Gopinath <thara@ti.com>

Opp layer cleanup series - tries the following:
a) remove the BUG_ON being used on functional statements
b) improve the voltage conversion routine a bit
c) introduce a per-opp data storage mechanism
d) remove the hardcoded vdd1-vdd2 thruput dependency using the generic
   opp data storage mechanism

Basic sanity tested on SDP3630

Nishanth Menon (3):
  omap3: pm: cpufreq: BUG_ON cleanup
  omap: pm: opp: add ability to store data per opp
  omap3: srf: remove hardcoded opp dependency

Phil Carmody (1):
  omap: pm: opp: twl: use DIV_ROUND_UP

 arch/arm/mach-omap2/cpufreq34xx.c     |   21 +++++++++-
 arch/arm/mach-omap2/resource34xx.c    |   17 ++++----
 arch/arm/plat-omap/include/plat/opp.h |   56 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/opp.c              |   66 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/opp_twl_tps.c      |    2 +-
 5 files changed, 150 insertions(+), 12 deletions(-)

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

