From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2 v3] OMAP3: PM: refactor Smart Reflex
Date: Sat, 24 Oct 2009 00:15:50 -0500
Message-ID: <1256361352-9968-1-git-send-email-nm@ti.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35060 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZJXFQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Oct 2009 01:16:11 -0400
In-Reply-To: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap <linux-omap"@vger.kernel.org
Cc: Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, Rajendra Nayak <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Teerth Reddy <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Hogander Jouni <jouni.hogander@nokia.com>, Nishanth Menon <nm@ti.com>

Hi,

Based on linux-omap PM branch(kevin's tree) commit
25c7b64bf80176463aa741407318e0e6b21cfd71

V4 - More changes:
     * Guilhem's review comments for timeout return value
     * Changes to make sr_list and OPP table dynamic selection
       based on cpu_type
     * vsel dbgfs entry added for folks who like to see voltage
       decisions made by OMAP Voltage processor
       (e.g. without a scope)
     * nvalue_opp is a variable array
     * omapsr_list introduced, initialized runtime based on type
       of omap - currently omap3430 only- but makes 3630 possible
     * all opp searches are isolated to opp accessor functions
V3 - Bunch of changes:
     * Introduce debugfs entries for SR - since these
       are variable updates, you can essentially do what we do
       with test values, change things but without a rebuild!
     * Removed the test values altogether
     * srid is standardised to u8 and it is not a bit field
     * Guilhem's changes for non-twl5030 PMIC incorporated
     * uses ioremap
V2 - made possible to work with non twl5030 PMICs
V1 - original rewrite

Requesting as much testing as possible and all comments welcome.

Nishanth Menon (2):
  OMAP3: PM: SR: prepare: remove old SR code
  OMAP3: PM: SR: SmartReflex Refactor Rev4.0

 arch/arm/mach-omap2/pm-debug.c     |    3 +
 arch/arm/mach-omap2/resource34xx.c |    8 +-
 arch/arm/mach-omap2/smartreflex.c  | 2180 +++++++++++++++++++++++-------------
 arch/arm/mach-omap2/smartreflex.h  |  280 +++---
 arch/arm/plat-omap/Kconfig         |   15 +-
 5 files changed, 1544 insertions(+), 942 deletions(-)

Regards,
Nishanth Menon
