From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL]: linux-omap DSS
Date: Tue, 22 Feb 2011 12:09:39 +0200
Message-ID: <1298369379.2590.41.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44395 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078Ab1BVKJn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 05:09:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Tony,

The following mach-omap2 patches have been reviewed and are in DSS tree,
but cause easily conflicts with linux-omap tree.

Would it be possible for you to pull these into linux-omap? 

The patches are based on today's linux-omap/master.

 Tomi


The following changes since commit 35353452eb8b20c424ac4b88ad616f87fa8f5b1b:

  Linux-omap rebuilt: Changes merged for nand, onenand, boards (2011-02-17 16:25:12 -0800)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-tony

Senthilvadivu Guruswamy (5):
      OMAP2420: hwmod data: add DSS DISPC RFBI VENC
      OMAP2430: hwmod data: add DSS DISPC RFBI VENC
      OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
      OMAP2, 3: DSS2: Use Regulator init with driver name
      OMAP2, 3: DSS2: board files: replace platform_device_register with omap_display_init()

Sumit Semwal (1):
      OMAP2, 3: DSS2: Create new file display.c for central dss driver registration.

 arch/arm/mach-omap2/Makefile               |    3 +
 arch/arm/mach-omap2/board-3430sdp.c        |   14 +-
 arch/arm/mach-omap2/board-am3517evm.c      |   16 +-
 arch/arm/mach-omap2/board-cm-t35.c         |   22 +--
 arch/arm/mach-omap2/board-devkit8000.c     |   10 +-
 arch/arm/mach-omap2/board-igep0020.c       |   16 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |   10 +-
 arch/arm/mach-omap2/board-omap3evm.c       |   20 +--
 arch/arm/mach-omap2/board-omap3pandora.c   |   10 +-
 arch/arm/mach-omap2/board-omap3stalker.c   |   22 +--
 arch/arm/mach-omap2/board-rx51-video.c     |   15 +-
 arch/arm/mach-omap2/board-zoom-display.c   |   15 +-
 arch/arm/mach-omap2/display.c              |   45 +++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  310 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  284 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  433 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h  |   11 +
 arch/arm/plat-omap/include/plat/l3_2xxx.h  |   20 ++
 arch/arm/plat-omap/include/plat/l3_3xxx.h  |   20 ++
 arch/arm/plat-omap/include/plat/l4_2xxx.h  |   24 ++
 arch/arm/plat-omap/include/plat/l4_3xxx.h  |   10 +
 21 files changed, 1183 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/mach-omap2/display.c
 create mode 100644 arch/arm/plat-omap/include/plat/l3_2xxx.h
 create mode 100644 arch/arm/plat-omap/include/plat/l3_3xxx.h
 create mode 100644 arch/arm/plat-omap/include/plat/l4_2xxx.h


