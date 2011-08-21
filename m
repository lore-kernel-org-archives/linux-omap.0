From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv3 0/5] OMAP DSS HWMOD fixes
Date: Sat, 20 Aug 2011 23:42:27 -0600
Message-ID: <20110821053355.20198.23847.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49111 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1HUFnu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Aug 2011 01:43:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Just ensuring that this series is copied to lakml.  The fifth patch has
been revised slightly from Tomi's original posting.  This series is targeted
for 3.1-rc.


- Paul

Date: Mon, 8 Aug 2011 12:15:09 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: paul@pwsan.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 0/5] OMAP DSS HWMOD fixes

Second try with the DSS HWMODs

This set fixes the DSS clocks in HWMOD data, and implements a new reset
mechanism for dss_core.

The new dss_reset function doesn't actually do a reset, it just enables all DSS
clocks and waits for the reset to complete. This should be better approach than
actually doing a reset, because:

OMAP4 - dss_core HW doesn't contain a SW reset bit so doing a reset is
impossible. But after power-on we need to enable all DSS clocks and wait for
the power-on reset to complete.

OMAP2/3 - dss_core does have a SW reset bit, but resetting dss_core also resets
all the other DSS modules. This means that the other modules could be left
uninitialized, as the hwmod code handles all modules independently, and in this
case initializes only dss_core's registers. Thus dss_core's reset shouldn't be
used, and we should only verify that the power-on reset has completed.

Tested on OMAP4 and OMAP3.

The first two HWMOD patches (for OMAP2/3) are not changed since v1.

 Tomi

---

Tomi Valkeinen (5):
      OMAP2xxx: HWMOD: fix DSS opt clocks
      OMAP3: HWMOD: fix DSS opt clocks
      OMAP4: HWMOD: fix DSS opt clocks
      OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
      OMAP: HWMOD: Unify DSS resets for all OMAPs


 arch/arm/mach-omap2/Makefile                       |    5 +--
 arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   15 +++++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 +++++++--
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   35 ++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   18 +++-------
 arch/arm/plat-omap/include/plat/common.h           |    3 ++
 include/video/omapdss.h                            |    7 ----
 9 files changed, 106 insertions(+), 32 deletions(-)

