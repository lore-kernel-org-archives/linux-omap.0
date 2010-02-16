From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP] [PATCH 0/2] cleanups for pointer handling
Date: Tue, 16 Feb 2010 02:27:15 -0600
Message-ID: <1266308837-23262-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59426 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238Ab0BPI10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:27:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ambresh K <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Few pointer handling related cleanup patches

Nishanth Menon (2):
  omap3:pm:srf: check if pointer results with IS_ERR
  omap:pm: return error pointers if inactive opp layer

 arch/arm/mach-omap2/resource34xx.c    |    2 +-
 arch/arm/plat-omap/include/plat/opp.h |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

Cc: Ambresh K <ambresh@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Regards,
Nishanth Menon
