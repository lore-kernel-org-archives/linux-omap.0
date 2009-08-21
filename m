From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 0/5] Cleanup DEBUG_LL infrastructure
Date: Fri, 21 Aug 2009 12:55:09 -0500
Message-ID: <1250877309-10220-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932441AbZHURzp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Aug 2009 13:55:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Vikram Pandita <vikram.pandita@ti.com>

Patch1/2: clean up the DEBUG_LL infrastructure.
Patch3: add DEBUG_LL support for Zoom2 board
Patch4/5: some Zoom2 fixes

Vikram Pandita (5):
  OMAP1/2/3/4: DEBUG_LL: cleanup
  OMAP1/2/3/4: Adapt board files for cleand DEBUG_LL interface
  OMAP: Zoom2: Add DEBUG_LL interface using external Quart
  OMAP: Zoom2: Fix serial break
  OMAP: Zoom2: Release Dbg board detect gpio

 arch/arm/mach-omap2/board-2430sdp.c           |    4 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    4 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    4 +-
 arch/arm/mach-omap2/board-apollon.c           |    4 +-
 arch/arm/mach-omap2/board-generic.c           |    4 +-
 arch/arm/mach-omap2/board-h4.c                |    4 +-
 arch/arm/mach-omap2/board-ldp.c               |    4 +-
 arch/arm/mach-omap2/board-n8x0.c              |   12 +++---
 arch/arm/mach-omap2/board-omap3beagle.c       |    4 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    4 +-
 arch/arm/mach-omap2/board-overo.c             |    4 +-
 arch/arm/mach-omap2/board-rx51.c              |    4 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c   |   14 ++++---
 arch/arm/mach-omap2/board-zoom2.c             |   19 ++++++++-
 arch/arm/plat-omap/Kconfig                    |   50 +++++++++++++++++-------
 arch/arm/plat-omap/include/mach/common.h      |    7 +++
 arch/arm/plat-omap/include/mach/debug-macro.S |   52 +++++++++----------------
 arch/arm/plat-omap/include/mach/io.h          |    6 +++
 arch/arm/plat-omap/include/mach/uncompress.h  |   17 ++++----
 20 files changed, 132 insertions(+), 93 deletions(-)

