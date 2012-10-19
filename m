From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] omap plat/usb.h removal for v3.8 merge window
Date: Thu, 18 Oct 2012 19:20:01 -0700
Message-ID: <20121019021816.6693.65985.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53792 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751028Ab2JSCUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 22:20:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are two patches against v3.7-rc1 to remove
plat/usb.h.

Once people are happy with these, I'll apply these
into omap-for-v3.8/cleanup-headers-usb branch so
usb and mfd trees can also pull these in if needed.

Regards,

Tony

---

Felipe Balbi (1):
      ARM: OMAP: move OMAP USB platform data to <linux/platform_data/omap-usb.h>

Tony Lindgren (1):
      ARM: OMAP2+: Introduce local usb.h


 arch/arm/mach-omap1/clock.c                  |    1 
 arch/arm/mach-omap2/board-2430sdp.c          |    1 
 arch/arm/mach-omap2/board-3430sdp.c          |    1 
 arch/arm/mach-omap2/board-3630sdp.c          |    1 
 arch/arm/mach-omap2/board-4430sdp.c          |    2 
 arch/arm/mach-omap2/board-am3517crane.c      |    1 
 arch/arm/mach-omap2/board-am3517evm.c        |    2 
 arch/arm/mach-omap2/board-cm-t35.c           |    1 
 arch/arm/mach-omap2/board-cm-t3517.c         |    1 
 arch/arm/mach-omap2/board-devkit8000.c       |    1 
 arch/arm/mach-omap2/board-igep0020.c         |    1 
 arch/arm/mach-omap2/board-ldp.c              |    1 
 arch/arm/mach-omap2/board-omap3beagle.c      |    1 
 arch/arm/mach-omap2/board-omap3evm.c         |    2 
 arch/arm/mach-omap2/board-omap3logic.c       |    1 
 arch/arm/mach-omap2/board-omap3pandora.c     |    1 
 arch/arm/mach-omap2/board-omap3stalker.c     |    1 
 arch/arm/mach-omap2/board-omap3touchbook.c   |    1 
 arch/arm/mach-omap2/board-omap4panda.c       |    2 
 arch/arm/mach-omap2/board-overo.c            |    1 
 arch/arm/mach-omap2/board-rm680.c            |    1 
 arch/arm/mach-omap2/board-rx51.c             |    2 
 arch/arm/mach-omap2/board-ti8168evm.c        |    3 
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 
 arch/arm/mach-omap2/board-zoom.c             |    1 
 arch/arm/mach-omap2/common.h                 |    2 
 arch/arm/mach-omap2/omap_phy_internal.c      |    4 -
 arch/arm/mach-omap2/twl-common.c             |    1 
 arch/arm/mach-omap2/usb-host.c               |    2 
 arch/arm/mach-omap2/usb-musb.c               |    2 
 arch/arm/mach-omap2/usb-tusb6010.c           |    1 
 arch/arm/mach-omap2/usb.h                    |   82 ++++++++++++
 arch/arm/plat-omap/include/plat/usb.h        |  179 --------------------------
 drivers/mfd/omap-usb-host.c                  |    5 +
 drivers/mfd/omap-usb-tll.c                   |    2 
 drivers/mfd/omap-usb.h                       |    2 
 drivers/usb/host/ehci-omap.c                 |    3 
 drivers/usb/host/ohci-omap3.c                |    1 
 drivers/usb/musb/am35x.c                     |    3 
 drivers/usb/musb/musb_dsps.c                 |    3 
 drivers/usb/musb/omap2430.h                  |    2 
 include/linux/platform_data/usb-omap.h       |   80 ++++++++++++
 42 files changed, 188 insertions(+), 218 deletions(-)
 create mode 100644 arch/arm/mach-omap2/usb.h
 delete mode 100644 arch/arm/plat-omap/include/plat/usb.h
 create mode 100644 drivers/mfd/omap-usb.h
 create mode 100644 include/linux/platform_data/usb-omap.h

-- 
