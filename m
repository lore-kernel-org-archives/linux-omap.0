From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap cleanup part3 for v3.2 merge window
Date: Fri, 30 Sep 2011 12:56:42 -0700
Message-ID: <20110930195642.GL6324@atomide.com>
References: <20110923213735.GZ2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48473 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab1I3T4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 15:56:46 -0400
Content-Disposition: inline
In-Reply-To: <20110923213735.GZ2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull omap cleanup part3 into cleanup from:

git://github.com/tmlind/linux.git cleanup-part3

If you did not already pull the earlier updated
cleanup, pulling this is enough and will bring that
in too.

Regards,

Tony


The following changes since commit 48b48fc996ad98bc7b7cf133882e08cd2331ae11:
  Tony Lindgren (1):
        Merge branch 'for_3.2/pm-cleanup' of git://gitorious.org/khilman/linux-omap-pm into cleanup

are available in the git repository at:

  git://github.com/tmlind/linux.git cleanup-part3

Benoit Cousson (1):
      ARM: OMAP2+: Add SoC specific map_io functions

Jarkko Nikula (13):
      ARM: OMAP: mcbsp: Remove unused variables from platform data
      ARM: OMAP: mcbsp: Move out omap_mcbsp_register_board_cfg from plat-omap/devices.c
      ARM: OMAP: mcbsp: Implement generic register access
      ARM: OMAP: mcbsp: Make wakeup control generic
      ARM: OMAP: mcbsp: Make tranceiver configuration control register access generic
      ARM: OMAP: mcbsp: Make threshold based transfer code generic
      ARM: OMAP: mcbsp: Use per instance register cache size
      ARM: OMAP: mcbsp: Move sidetone clock management to mach-omap2/mcbsp.c
      ARM: OMAP: mcbsp: Cleanup sidetone control initialization and make it generic
      ARM: OMAP: mcbsp: Update mcbsp.h include dependencies
      ARM: OMAP: mcbsp: Move address definitions to arch/arm/mach-omap1/mcbsp.c
      ARM: OMAP: mcbsp: Start generalize omap2_mcbsp_set_clks_src
      ARM: OMAP: mcbsp: Start generalize signal muxing functions

Tony Lindgren (2):
      ARM: OMAP2+: Use SoC specifc map_io
      ARM: OMAP2+: Remove custom init_irq for remaining boards

 arch/arm/mach-omap1/mcbsp.c                |   45 ++++
 arch/arm/mach-omap2/board-2430sdp.c        |    8 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    8 +-
 arch/arm/mach-omap2/board-apollon.c        |    8 +-
 arch/arm/mach-omap2/board-devkit8000.c     |    7 +-
 arch/arm/mach-omap2/board-h4.c             |   15 +-
 arch/arm/mach-omap2/board-n8x0.c           |   12 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    7 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |    7 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    7 +-
 arch/arm/mach-omap2/board-omap4panda.c     |    8 +-
 arch/arm/mach-omap2/board-rm680.c          |    8 +-
 arch/arm/mach-omap2/board-rx51.c           |    8 +-
 arch/arm/mach-omap2/common.c               |   18 ++
 arch/arm/mach-omap2/mcbsp.c                |  103 ++++++---
 arch/arm/plat-omap/devices.c               |   46 ----
 arch/arm/plat-omap/include/plat/common.h   |    4 +
 arch/arm/plat-omap/include/plat/mcbsp.h    |  208 +++++-----------
 arch/arm/plat-omap/mcbsp.c                 |  358 +++++++++++++---------------
 19 files changed, 379 insertions(+), 506 deletions(-)
