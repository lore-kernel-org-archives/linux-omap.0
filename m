From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 00/14] McBSP cleanup and generalization
Date: Wed, 31 Aug 2011 18:22:47 +0300
Message-ID: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:53062 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756571Ab1HaPX1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:23:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi

Updates and continuation to my McBSP cleanup RFC set I sent before vacation
period. Motivation here is to get rid off all is_omap and CONFIG_ARCH stuff
and to make code a step more generic (and for preparing to move code out
under arch/arm/).

I hope this version doesn't break OMAP1. I suppose it should work now as
the register and dma addresses are calculated from common register numbers
and not by mangling from OMAP2+ register offsets (Thanks for
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> for the idea).

Also MCBSP_CONFIG_TYPEx defines are not used to replace is_omap tests in
plat/mcbsp.c in this version but by using a feature flags (Thanks for
Charulatha V <charu@ti.com> for the idea).

Note that patch 01/14 has from address to my disabled google account. This
is since the patch is already committed in to
for_3.2/omap_device branch of Kevin's git tree.

Jarkko Nikula (14):
  omap: mcbsp: Remove omap device API
  omap: mcbsp: Remove unused variables from platform data
  omap: mcbsp: Move out omap_mcbsp_register_board_cfg from
    plat-omap/devices.c
  omap: mcbsp: Implement generic register access
  omap: mcbsp: Make wakeup control generic
  omap: mcbsp: Make tranceiver configuration control register access
    generic
  omap: mcbsp: Make threshold based transfer code generic
  omap: mcbsp: Use per instance register cache size
  omap: mcbsp: Move sidetone clock management to mach-omap2/mcbsp.c
  omap: mcbsp: Cleanup sidetone control initialization and make it
    generic
  omap: mcbsp: Update mcbsp.h include dependencies
  omap: mcbsp: Move address definitions to arch/arm/mach-omap1/mcbsp.c
  omap: mcbsp: Start generalize omap2_mcbsp_set_clks_src
  omap: mcbsp: Start generalize signal muxing functions

 arch/arm/mach-omap1/mcbsp.c             |   45 ++++
 arch/arm/mach-omap2/mcbsp.c             |  103 ++++++---
 arch/arm/plat-omap/devices.c            |   46 ----
 arch/arm/plat-omap/include/plat/mcbsp.h |  208 ++++++------------
 arch/arm/plat-omap/mcbsp.c              |  385 +++++++++++++------------------
 5 files changed, 342 insertions(+), 445 deletions(-)

-- 
1.7.5.4

