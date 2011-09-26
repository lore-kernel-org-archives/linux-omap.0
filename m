From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH resend 00/13] McBSP cleanup and generalization
Date: Mon, 26 Sep 2011 10:45:36 +0300
Message-ID: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48995 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab1IZHqK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 03:46:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

This is just resend of patches 2-14/14 I posted earlier:

http://marc.info/?l=linux-omap&m=131480421332374&w=2

Patch 1/14 is already in linux-omap, Acked-by from Peter added and I
took freedom to thank Janusz by adding Tested-by line as he tested the
set on OMAP1.

Jarkko Nikula (13):
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
 arch/arm/plat-omap/mcbsp.c              |  358 ++++++++++++++-----------------
 5 files changed, 342 insertions(+), 418 deletions(-)

-- 
1.7.6.3

