From: Afzal Mohammed <afzal@ti.com>
Subject: [GIT PULL] ARM: OMAP: GPMC generic timing
Date: Fri, 9 Nov 2012 19:51:50 +0530
Message-ID: <1352470910-9630-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab2KIOWA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Nov 2012 09:22:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 6ba54ab4a49bbad736b0254aa6bdf0cb83013815:

  ARM: OMAP: Remove omap_init_consistent_dma_size() (2012-11-06 16:01:19 -0800)

are available in the git repository at:

  git://gitorious.org/x0148406-public/linux-kernel.git tags/gpmc-generic-timing

for you to fetch changes up to 47acde16726080e5157b602f23937d00a04cd2ed:

  ARM: OMAP2+: tusb6010: generic timing calculation (2012-11-09 18:07:23 +0530)

----------------------------------------------------------------
These changes provide a generic gpmc timing calculation method,
migrates existing peripherals that makes use of custom gpmc timing
calculation method to use the new generic one.

Generic routine has been verified for onenand async timing calculation
on omap3evm (with a local change to add onenand support). Generic
timing calculation method were verified for other peripherals by
simulation. Generic method has to be verified on peripherals supported
in mainline.

----------------------------------------------------------------
Afzal Mohammed (6):
      ARM: OMAP2+: nand: remove redundant rounding
      ARM: OMAP2+: gpmc: handle additional timings
      ARM: OMAP2+: gpmc: generic timing calculation
      ARM: OMAP2+: onenand: generic timing calculation
      ARM: OMAP2+: smc91x: generic timing calculation
      ARM: OMAP2+: tusb6010: generic timing calculation

 Documentation/bus-devices/ti-gpmc.txt | 122 +++++++++++
 arch/arm/mach-omap2/gpmc-nand.c       |  26 +--
 arch/arm/mach-omap2/gpmc-onenand.c    | 143 ++++---------
 arch/arm/mach-omap2/gpmc-smc91x.c     |  43 ++--
 arch/arm/mach-omap2/gpmc.c            | 373 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.h            | 113 ++++++++--
 arch/arm/mach-omap2/usb-tusb6010.c    | 181 ++++-------------
 7 files changed, 709 insertions(+), 292 deletions(-)
 create mode 100644 Documentation/bus-devices/ti-gpmc.txt
