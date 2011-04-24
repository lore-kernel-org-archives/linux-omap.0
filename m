From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/4] omap: cleanup board files
Date: Mon, 25 Apr 2011 01:09:04 +0300
Message-ID: <cover.1303682352.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:43904
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757876Ab1DXWCS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 24 Apr 2011 18:02:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

Hi Tony,

These patches cleanup some of the common code in the board files. The changes
are basically almost mechanically move the code shared among several boards
into some common place.
There are a lot of places for further improvement, especially DSS and TWL
initialization. I'll try to find some time to sort these out as well.

Special thanks to Igor Grinberg for the original idea :)

Mike Rapoport (4):
  omap: consolidate touch screen initialization among different boards
  omap: use common initialization for PMIC i2c bus
  omap: move detection of NAND CS to common-board-devices
  omap: musb: introduce default baord config

 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/board-2430sdp.c          |   20 +---
 arch/arm/mach-omap2/board-3430sdp.c          |   85 ++-------------
 arch/arm/mach-omap2/board-4430sdp.c          |   16 +---
 arch/arm/mach-omap2/board-cm-t35.c           |   78 +-------------
 arch/arm/mach-omap2/board-devkit8000.c       |  119 +--------------------
 arch/arm/mach-omap2/board-igep0020.c         |   23 +----
 arch/arm/mach-omap2/board-igep0030.c         |   21 +---
 arch/arm/mach-omap2/board-ldp.c              |   77 +-------------
 arch/arm/mach-omap2/board-omap3beagle.c      |   66 +-----------
 arch/arm/mach-omap2/board-omap3evm.c         |   72 +------------
 arch/arm/mach-omap2/board-omap3logic.c       |   13 +--
 arch/arm/mach-omap2/board-omap3pandora.c     |   69 +-----------
 arch/arm/mach-omap2/board-omap3stalker.c     |   78 +-------------
 arch/arm/mach-omap2/board-omap3touchbook.c   |  101 ++----------------
 arch/arm/mach-omap2/board-omap4panda.c       |   17 +---
 arch/arm/mach-omap2/board-overo.c            |  108 +------------------
 arch/arm/mach-omap2/board-rm680.c            |   21 +---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   13 +--
 arch/arm/mach-omap2/board-zoom-peripherals.c |   21 +---
 arch/arm/mach-omap2/common-board-devices.c   |  148 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/common-board-devices.h   |   52 +++++++++
 arch/arm/mach-omap2/usb-musb.c               |   14 +++-
 23 files changed, 293 insertions(+), 941 deletions(-)
 create mode 100644 arch/arm/mach-omap2/common-board-devices.c
 create mode 100644 arch/arm/mach-omap2/common-board-devices.h

-- 
1.7.3.1

