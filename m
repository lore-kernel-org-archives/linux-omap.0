From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 0/2] omap: pm: opp: misc cleanups
Date: Mon, 17 May 2010 15:11:20 -0500
Message-ID: <1274127082-16288-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab0EQULi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 May 2010 16:11:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Sanjeev Premi <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Tony Lindgren <tony@atomide.com>, Vishwanath BS <vishwanath.bs@ti.com>

The following cleanups are done for upstreaming OPP layer on top of the
current OPP layer in PM branch

Nishanth Menon (2):
  omap: opp: make opp_get_opp_id robust
  omap: opp: documentation update

 Documentation/arm/OMAP/omap_pm        |   66 +++++++++++++
 arch/arm/plat-omap/include/plat/opp.h |  143 +---------------------------
 arch/arm/plat-omap/opp.c              |  168 +++++++++++++++++++++++++++++---
 3 files changed, 220 insertions(+), 157 deletions(-)

Regards,
Nishanth Menon
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>
